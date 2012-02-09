When /^(\w*) adds a new tip with content "([^"]*)"$/ do |who, content|
  steps %Q{
    When I go to the home page
    And I follow "Add new tip"
    And I fill in "tip" with "#{content}"
  }
end
