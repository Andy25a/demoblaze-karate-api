Feature: Validacion de servicios signup y login en Demoblaze

  Background:
    * url 'https://api.demoblaze.com'
    * def baseUser = 'qa_api_' + java.util.UUID.randomUUID().toString().replace('-', '').substring(0, 10)
    * def validPassword = 'DemoPwd#2026'
    * def invalidPassword = 'WrongPwd#2026'
    * configure headers = { Content-Type: 'application/json', Accept: 'application/json' }

  Scenario: Crear un nuevo usuario en signup
    * def username = baseUser + '_new'
    Given path 'signup'
    And request { username: '#(username)', password: '#(validPassword)' }
    When method post
    Then status 200
    # La API retorna una cadena vacia serializada y puede incluir salto de linea.
    And match response contains '""'
    * print 'Caso signup nuevo - request:', { username: username, password: validPassword }
    * print 'Caso signup nuevo - response:', response

  Scenario: Intentar crear un usuario ya existente
    * def username = baseUser + '_dup'
    Given path 'signup'
    And request { username: '#(username)', password: '#(validPassword)' }
    When method post
    Then status 200
    # La API retorna una cadena vacia serializada y puede incluir salto de linea.
    And match response contains '""'
    Given path 'signup'
    And request { username: '#(username)', password: '#(validPassword)' }
    When method post
    Then status 200
    And match response contains { errorMessage: '#string' }
    * print 'Caso signup duplicado - request:', { username: username, password: validPassword }
    * print 'Caso signup duplicado - response:', response

  Scenario: Usuario y password correcto en login
    * def username = baseUser + '_ok'
    Given path 'signup'
    And request { username: '#(username)', password: '#(validPassword)' }
    When method post
    Then status 200
    Given path 'login'
    And request { username: '#(username)', password: '#(validPassword)' }
    When method post
    Then status 200
    And match response contains 'Auth_token:'
    * print 'Caso login correcto - request:', { username: username, password: validPassword }
    * print 'Caso login correcto - response:', response

  Scenario: Usuario y password incorrecto en login
    * def username = baseUser + '_bad'
    Given path 'signup'
    And request { username: '#(username)', password: '#(validPassword)' }
    When method post
    Then status 200
    Given path 'login'
    And request { username: '#(username)', password: '#(invalidPassword)' }
    When method post
    Then status 200
    And match response contains { errorMessage: '#string' }
    * print 'Caso login incorrecto - request:', { username: username, password: invalidPassword }
    * print 'Caso login incorrecto - response:', response
