@javascript
Feature: Adding tips

  Scenario: Posting a new tip
    When Frank adds a new tip with content "Hello world!"
    Then Bob sees tip with content "Hello world!"
