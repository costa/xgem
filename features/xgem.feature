Feature: Sharing and using code snippetes - extensions
  In order to conquer the world
  As a ruby developer
  I want to share my code and use other's code in a simplest possible way

  Scenario: Using a project-local extension
    Given I have x/tension.rb in a project's directory
      And I require 'x/tension' in the project's code
    When I run the project's specs
    Then it shall be okay

  Scenario: Publishing a project-local extension with a git push
    Given I have previously run `xgem share` in the project's directory
      And I have x/tension.rb and x/tension_spec.rb committed there
      And `spec tension_spec.rb` run from x/ passes
    When I push the repository with that commit to github.com
    Then the new x/tension version shall be available on xgem.org

  Scenario: Using a new shared extension (swift flavour)
    Given x/tension is a registered and valid extension on xgem.org
      And I require 'x/tension' in a project's code
      And there is no x/tension.rb in the project's directory
    When I run the project's specs
    Then `xgem choose tension` shall be run from the project's directory
      And -- if it succeeds -- it shall be okay

  Scenario: Using a new shared extension (vanilla flavour)
    Given x/tension is a registered and valid extension on xgem.org
    When I run `xgem choose tension` from a project's directory
    Then I shall be presented with a choice of versions available for download
     And the chosen version of tension.rb and tension_spec.rb shall be downloaded to x/
# if x/tension.rb and/or x/tension_spec.rb exist and no --force given
#   a warning prompt shall be presented

  Scenario: Updating an extension
    Given I have x/tension.rb which is a registered version of an extension on xgem.org
      And a newer version of x/tension is available at xgem.org
    When I run `xgem update tension`
    Then I shall be presented with a choice of newer versions available for download
     And the chosen version of tension.rb and tension_spec.rb shall be downloaded to x/
# running `xgem update` will effectively do the same for every extension in x/
