Given(/^some books exists$/) do
  Book.create(title: 'No name', isbn: '9783161484100')
  Book.create(title: 'With name', isbn: '9781782808084')
end

Given(/^a logged in user exists$/) do
  @user = User.create(email: 'me@example.com', password: 'a1B2C3')
  login_as(@user)
end

Given(/^some book imports exist$/) do

  service = BooksCsvImportCreationService.new(
    user: @user,
    uploaded_file: Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
    )
  )
  service.save
  @bulk_import = service.instance
end
