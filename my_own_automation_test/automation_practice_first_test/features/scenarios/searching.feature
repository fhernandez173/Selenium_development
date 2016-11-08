@search
  Feature: Testing search for items found/ not found

    Scenario: I find items based on searched keyword
    Given I am at homepage or any page
    And I search for item
    When I click the search icon
    Then I expected to see results for my search keyword

    Scenario: I search for an item that does not exist
    Given I am at homepage or any page
    And I search for an item that does not exist
    When I click the search icon
    Then I expect to be let known that there ar eno results for my search
