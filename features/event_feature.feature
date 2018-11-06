Feature: Events
  Scenario: User views events
    Given 1 user
    And that user has 1 event
    And I am on the root path
    Then I should see "Org"
    And I should see "E2120"
