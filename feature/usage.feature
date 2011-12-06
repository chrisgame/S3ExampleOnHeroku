Feature: Defines how to interact with the app which will prove reading and wrtting to s3

  Scenario: Write an image to the s3 store
    Given The app is running
    Then i should be able to add an image to my bucket
    And retrieve it

