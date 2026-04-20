Feature: Kushki Card Payments - Token, Charge and Void

  Background:
    * def baseUrl = 'https://api-uat.kushkipagos.com'
    * def System = Java.type('java.lang.System')
    # leer las variable de entorno
    * def publicKey = System.getenv('publicKeyKushkiTest')
    * print publicKey
    * def privateKey = System.getenv('privateKeyKushkiTest')
    * print privateKey

    * def cardPayload =
    """
    {
      card: {
        name: 'QA AUTOMATION',
        number: '4111111111111111',
        expiryMonth: '12',
        expiryYear: '30',
        cvv: '123'
      },
      totalAmount: 1000,
      currency: 'MXN'
    }
    """

    * def amountPayload =
    """
    {
      subtotalIva: 0,
      subtotalIva0: 1000,
      ice: 0,
      iva: 0,
      currency: 'MXN'
    }
    """

  @flujo1
  Scenario: Flujo 1 - Venta exitosa (Token + Charge)
    Given url baseUrl
    And path 'card', 'v1', 'tokens'
    And header Public-Merchant-Id = publicKey
    And request cardPayload
    When method post
    Then status 201
    And match response contains { token: '#string' }
    * def token = response.token

    Given url baseUrl
    And path 'card', 'v1', 'charges'
    And header Private-Merchant-Id = privateKey
    And request { token: '#(token)', amount: '#(amountPayload)', fullResponse: true }
    When method post
    Then status 201
    And match response contains { ticketNumber: '#string' }

  @flujo2
  Scenario: Flujo 2 - Ciclo completo (Token + Charge + Void)
    Given url baseUrl
    And path 'card', 'v1', 'tokens'
    And header Public-Merchant-Id = publicKey
    And request cardPayload
    When method post
    Then status 201
    And match response contains { token: '#string' }
    * def token = response.token

    Given url baseUrl
    And path 'card', 'v1', 'charges'
    And header Private-Merchant-Id = privateKey
    And request { token: '#(token)', amount: '#(amountPayload)', fullResponse: true }
    When method post
    Then status 201
    And match response contains { ticketNumber: '#string' }
    * def ticketNumber = response.ticketNumber

    Given url baseUrl
    And path 'v1', 'charges', ticketNumber
    And header Private-Merchant-Id = privateKey
    And request { fullResponse: false }
    When method delete
    Then status 201

