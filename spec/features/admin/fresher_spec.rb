require "rails_helper"

RSpec.shared_examples "assert_popup" do |datetime, date_td|
  it "date is poppedup" do
    sign_in_user
    visit admin_root_path(datetime: datetime)
    click_button "Create a Popup"
    click_button "Yes"
    expect(page).to have_text("Popup successfully created.")
    td = find_by_id(date_td)
    popup = td[:class].include? "popup" #.has_css? '.popup' # has_css looks within node and not the current level
    expect(td).to have_text "Popup"
    expect(popup).to eq(true)
  end
end

RSpec.describe Admin::HomeController, :type => :feature, js: true do

  let(:datetime){
    DateTime.new(2022, 4, 4, 10)
  }

  before do
    Timecop.freeze(datetime)

    create_seed

    create(:book)

    create(:book, on_at: datetime.advance(:days => + 1), name: "User 2")

    create(:book, on_at: datetime.advance(:days => + 1, :hours => +2), name: "User 3")

  end

  after do
    Timecop.return
  end

  def sign_in_user
    sign_in User.create(email: 'john@gmail.com')
  end

  scenario "User visits home without datetime and start_of_week" do
    sign_in_user
    visit admin_root_path
    expect(page).to have_current_path(admin_root_path(start_of_week: "2022-04-03", datetime: datetime))
  end


  scenario "User visits home without datetime" do
    sign_in_user
    visit admin_root_path(start_of_week: "2022-04-03")
    expect(page).to have_current_path(admin_root_path(start_of_week: "2022-04-03", datetime: datetime))
  end

  scenario "User visits home without start_of_week" do
    sign_in_user
    visit admin_root_path(datetime: datetime)
    expect(page).to have_current_path(admin_root_path(start_of_week: "2022-04-03", datetime: datetime))
  end

  scenario "User visits home to see bookings due today" do
    sign_in_user
    visit admin_root_path
    expect(page).to have_text("Example")
    expect(page).to have_text("2 slots", count: 3)
    expect(page).not_to have_text("User 2")
  end

  scenario "User visits home to see bookings due today" do
    sign_in_user
    visit admin_root_path datetime: Time.local(2022, 4, 5, 10)
    expect(page).not_to have_text("Example")
    expect(page).to have_text("User 2")
    expect(page).not_to have_text("User 3")
  end

  scenario "User visits and clicks a spot" do
    sign_in_user
    visit admin_root_path
    click_link "2022-04-05-10"
    expect(page).not_to have_text("Example")
    expect(page).to have_text("User 2")
    expect(page).not_to have_text("User 3")
  end

  scenario "User visits and presses next week" do
    sign_in_user
    visit admin_root_path
    click_link "Next week"
    expect(page).to have_text("11th Apr")
  end

  scenario "Cancels appointment", only: true do
    datetime = DateTime.new(2022, 4, 4, 10)
    sign_in_user
    visit admin_root_path
    click_button "cancel-#{datetime}"
    click_button "Yes"
    appointment = find_by_id("appointment-#{datetime}")
    muted = appointment[:class].include? "text-muted"
    expect(muted).to eq(true)
    expect(page).to have_text("Popup successfully created.")
  end

  context "User visits to create a popup" do

    include_examples "assert_popup", nil, "2022-04-04-10-td"

  end

  context "User visits to create a popup for" do

    include_examples "assert_popup", Time.local(2022, 4, 8, 9), "2022-04-08-9-td"

  end

end
