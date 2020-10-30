When(/^I upload the CSV file "([^"]*)"$/) do |file_name|
  attach_file(:bulk_books_import_uploaded_file, File.join(Rails.root, 'test', 'fixtures', 'books', file_name))
  click_button "Send File"
end

When(/^I upload a CSV file containing the books$/) do
  step 'I upload the CSV file "example_books.csv"'
end

And(/^I upload a CSV file containing invalid books$/) do
  step 'I upload the CSV file "example_wrong_books.csv"'
end

Then(/^I should see the list of books included in the file$/) do
  within "#bulk_import_items" do
    expect(page).to have_selector "td", text: "Don Quijote"
    expect(page).to have_selector "td", text: "Miguel de Cervantes"
    expect(page).to have_selector "td", text: "9783161484100"
    expect(page).to have_selector "td", text: "Freelance"
    expect(page).to have_selector "td", text: "1605/01/01"

    expect(page).to have_selector "td", text: "Don palotes"
    expect(page).to have_selector "td", text: "Anonymous"
    expect(page).to have_selector "td", text: "9783161484101"
    expect(page).to have_selector "td", text: "Freelance"
    expect(page).to have_selector "td", text: "1805/01/01"
  end
end


And(/^I should see the errors of each book$/) do
  within "#bulk_import_items" do
    expect(page).to have_selector "td", text: "title: can't be blank"
  end
end


Then(/^I should see the list of book imports$/) do
  within "#bulk_books_imports" do
    within "tr#bulk_books_import_#{@bulk_import.id}" do
      expect(page).to have_selector "td", text: @bulk_import.created_at.to_s(:short)
      expect(page).to have_selector "td", text: @bulk_import.bulk_import_items.count
      expect(page).to have_selector "td a", text: @bulk_import.uploaded_file_name
    end
  end
end