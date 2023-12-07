require "application_system_test_case"

class GuestBooksTest < ApplicationSystemTestCase
  setup do
    @guest_book = guest_books(:one)
  end

  test "visiting the index" do
    visit guest_books_url
    assert_selector "h1", text: "Guest books"
  end

  test "should create guest book" do
    visit guest_books_url
    click_on "New guest book"

    fill_in "Message", with: @guest_book.message
    fill_in "User", with: @guest_book.user_id
    click_on "Create Guest book"

    assert_text "Guest book was successfully created"
    click_on "Back"
  end

  test "should update Guest book" do
    visit guest_book_url(@guest_book)
    click_on "Edit this guest book", match: :first

    fill_in "Message", with: @guest_book.message
    fill_in "User", with: @guest_book.user_id
    click_on "Update Guest book"

    assert_text "Guest book was successfully updated"
    click_on "Back"
  end

  test "should destroy Guest book" do
    visit guest_book_url(@guest_book)
    click_on "Destroy this guest book", match: :first

    assert_text "Guest book was successfully destroyed"
  end
end
