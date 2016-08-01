Feature: Rotating API keys

  Background:
    Given a new user "alice"

  Scenario: Password can be used to rotate API key
    Given I set the password for "alice" to "my-password"
    Then I can PUT "/authn/:account/api_key" with username "alice@:user_namespace" and password "my-password"
    Then the result is the API key for user "alice"

  @logged-in
  Scenario: API key cannot be rotated by foreign login without 'update' privilege
    Given a new user "bob"
    When I PUT "/authn/:account/api_key?role=user:bob@:user_namespace"
    Then it's not authenticated

  @logged-in
  Scenario: API key can be rotated by foreign login having 'update' privilege
    Given a new user "bob"
    And I permit user "alice" to "update" user "bob"
    When I PUT "/authn/:account/api_key?role=user:bob@:user_namespace"
    Then the result is the API key for user "bob"