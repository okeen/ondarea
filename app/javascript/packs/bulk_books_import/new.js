$('#bulk_books_import_uploaded_file').change(function (e) {
    $(this).parents("form").submit()
})
$('#select_bulk_import_file_button').click(function (e) {
    e.preventDefault();
    $("#bulk_books_import_uploaded_file").click()
})