@customTag01
Feature: API Test Karate

  Background: Precondicion para test
    Given url 'https://dummyjson.com'
    And path 'auth/login'
    When request {username: "emilys", password: "emilyspass", expiresInMins: 30 }
    And method post
    Then status 200
    And print response.accessToken
    And print response.refreshToken
    And def accessToken = response.accessToken
    And def refreshToken = response.refreshToken



  Scenario: Health check 2
    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users'
    When method get
    Then status 200
    And match response == '#[10]'
    And match each response contains { id: '#number', name: '#string' }
