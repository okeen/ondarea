When(/^I go to the books list$/) do
  visit '/books'
end

When(/^I go to the import books screen$/) do
  visit '/bulk_books_imports/new'
end


When(/^I go to the import books list screen$/) do
  visit "/bulk_books_imports"
end