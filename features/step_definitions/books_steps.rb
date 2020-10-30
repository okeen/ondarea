Then(/^I should see list of registered books$/) do
  @books = Book.all
  within "#books" do
    @books.each do |book|
      expect(page).to have_selector "tr#book_#{book.id}", text: book.title
    end
  end
end