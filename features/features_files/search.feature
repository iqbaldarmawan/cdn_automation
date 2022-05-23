@web_chrome @web_firefox
Feature: Search vehicle

  Scenario: Search vehicle
    Given I have successfully navigated to the car next door searchpage
    When I search location "10 Bayshore Drive, Byron Bay, New South Wales"
    And I select month "Dec from date "2 to "4"
    And I set times for pickup and return
    Then I see the result vehicle on map match with the list
    When I open detail vehicle
    Then I am on detail page vehicle