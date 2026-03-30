@customTag01
Feature: Hello Karate

  Scenario: Health check
    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users'
    When method get
    Then status 200
    And match response == '#[10]'
    And match each response contains { id: '#number', name: '#string' }
