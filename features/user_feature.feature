Feature: Users
  Scenario: User Signs Up
    Given I am on the root path
    When I follow "Sign In"
    And I follow "Not registered? Create an account."
    And I fill in "Email" with "lukerpfeiffer@ufl.edu"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I fill in "Username" with "username"
    And I press "Register"
    Then I should see "You have created an account, an email was sent to confirm your status."

  Scenario: User Signs In
    Given the following user:
      | username | username          |
      | password | password          |
      | email	 | email@ufl.edu     |
    And I am on the root path
    When I follow "Sign In"
    And I fill in "sign_in_email" with "email@ufl.edu"
    And I fill in "sign_in_password" with "password"
    And I press "Sign In"
    Then I should see "Signed in successfully!"

  Scenario: User deletes event
    Given the following user:
    	| username | username          |
	| password | password 	       |
	| email    | email@ufl.edu     |
    And that user has 1 event
    And I am signed in as an admin
    When I follow "Delete"
    Then I should see "Deleted Event!"
    And I should not see "E2120"

  Scenario: User creates event
    Given the following user:
    	| username | username          |
	| password | password 	       |
	| email    | email@ufl.edu     |
    And I am signed in as an admin
    And I follow "Create Event"
    When I fill in "event_org_name" with "org"
    And I fill in "searchTextField" with "Reitz Union Hotel, Museum Road, Gainesville, FL, USA"
    And I fill in "event_building_name" with "build"
    And I press "Save"
    Then I should see "Created event!"
    And I should see "org"
    And I should see "build"
	
  Scenario: User edits event
    Given the following user:
    	| username | username          |
	| password | password 	       |
	| email    | email@ufl.edu     |
    And that user has 1 event
    And I am signed in as an admin
    And I am on the root path
    When I follow "Edit"
    And I fill in "event_org_name" with "something_else"
    And I press "Save"
    Then I should see "Update event!"
    And I should see "something_else"

  Scenario: User views their events
    Given the following user:
    	| username | username          |
	| password | password 	       |
	| email    | email@ufl.edu     |
    And that user has 1 event
    And the following user:
    	| username | username2          |
	| password | password 	        |
	| email    | email2@ufl.edu     |
    And that user has 1 wings_event
    And I am signed in as an admin
    When I follow "username"
    Then I should see "Pizza"
    And I should see "E2120"
    And I should not see "Wings"
    And I should not see "E1111"
