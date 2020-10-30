Feature: Books listing
  In order to select the next book I am reading and become a wiser person
  As a user
  I want to navigate through the list of available books

  Background:
    Given some books exists
    And   a logged in user exists
    When  I go to the books list

  Scenario: View the list of available books
    Then I should see list of registered books

