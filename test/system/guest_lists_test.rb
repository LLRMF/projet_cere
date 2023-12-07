require "application_system_test_case"

class GuestListsTest < ApplicationSystemTestCase
  setup do
    @guest_list = guest_lists(:one)
  end

  test "visiting the index" do
    visit guest_lists_url
    assert_selector "h1", text: "Guest lists"
  end

  test "should create guest list" do
    visit guest_lists_url
    click_on "New guest list"

    fill_in "Name", with: @guest_list.name
    fill_in "User", with: @guest_list.user_id
    click_on "Create Guest list"

    assert_text "Guest list was successfully created"
    click_on "Back"
  end

  test "should update Guest list" do
    visit guest_list_url(@guest_list)
    click_on "Edit this guest list", match: :first

    fill_in "Name", with: @guest_list.name
    fill_in "User", with: @guest_list.user_id
    click_on "Update Guest list"

    assert_text "Guest list was successfully updated"
    click_on "Back"
  end

  test "should destroy Guest list" do
    visit guest_list_url(@guest_list)
    click_on "Destroy this guest list", match: :first

    assert_text "Guest list was successfully destroyed"
  end
end
