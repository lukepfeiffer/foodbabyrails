When /^I check "(.+)"$/ do |selector|
  check(selector)
end

When /^I fill in the trix editor with id of "(.+)" with "(.+)"$/ do |id, value|
  if Faq.last.present?
    find("#{id}_#{Faq.last.id}", visible: false).set(value)
  else
    find(id, visible: false).set(value)
  end
end

When /^I click link with "(.+)" class$/ do |selector|
  find(".#{selector}").click
end

When /^I click the first "(.+)"$/ do |selector|
  first(selector).click
end

When /^I select "(.+)" from "(.+)"$/ do |value, select_tag|
  select value, from: select_tag
end

Given /^I am on the root path$/ do
  visit root_path
end

When /^I go to the "(.+)" page$/ do |path|
  visit path
end

When /^I follow "(.+)"$/ do |link_name|
  click_link link_name
end

When "I debug" do
  require 'pry'; binding.pry;
end

Given "I am on the home page" do
  visit root_path
end

And /^I am on the "(.+)" page$/ do |path|
  visit path
end

When /^I fill in "(.+)" with "(.+)"$/ do |field, value|
  fill_in field, with: value
end

When /^I press "(.+)"$/ do |button_name|
  click_button button_name
end

Then /^I should be on the "(.+)" page$/ do |path|
  expect(page.current_path).to eq(path)
end

Then /^I should see "(.+)"$/ do |content|
  expect(page).to have_content(content)
end

Then /^I should not see "(.+)"$/ do |content|
  expect(page).not_to have_content(content)
end

