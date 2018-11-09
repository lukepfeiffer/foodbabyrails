Feature: Events
  Scenario: User views events
    Given 1 user
    And that user has 1 event
    And I am on the root path
    Then I should see "Org"
    And I should see "E2120"

  Scenario: User does not see past events
    Given 1 user
    And that user has 1 past_event
    And I am on the root path
    And I should not see "E2120"

   Scenario: User filters
     Given I am on the root path
     And 1 user
     And that user has 1 event
     And that user has 1 wings_event
     When I select "Pizza" from "food"
     And I press "search"
     Then I should see "Pizza"
     And I should see "E2120"
     And I should not see "E1111"
