Feature: Users
  Scenario: User Signs Up
    Given I am on the root path
    When I follow "Sign In"
    And I follow "Not registered? Create an account."
    And I fill in "Email" with "email@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I fill in "Username" with "username"
    And I press "Register"
    Then I should see "Created and signed in!"
  Scenario: User Signs In
    Given the following user:
      | username | username          |
      | password | password          |
      | email	 | email@example.com |
    And I am on the root path
    When I follow "Sign In"
    And I fill in "sign_in_email" with "email@example.com"
    And I fill in "sign_in_password" with "password"
    And I press "Sign In"
    Then I should see "Signed in successfully!"

