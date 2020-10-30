Feature: Books Bulk Import
  In order to easily add new books to our library
  As a user
  I want to upload CSV files with book information

  Background:
    Given   a logged in user exists

  Scenario: View the list of uploaded files
    Given some book imports exist
    When I go to the import books list screen
    Then I should see the list of book imports

  Scenario: Upload a new csv file containing books
    When I go to the import books screen
    And  I upload a CSV file containing the books
    Then I should see the list of books included in the file

  Scenario: View the errors in a wrong books CSV file
    When I go to the import books screen
    And  I upload a CSV file containing invalid books
    Then I should see the errors of each book

  @wip
  Scenario: Complete the items import
    Given a books CSV upload was started
    When I go to the recently started books upload



