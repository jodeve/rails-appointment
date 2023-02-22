require "rails_helper"

RSpec.feature BooksController, :type => :feature, js: true do

  let(:datetime){
    DateTime(2022, 4, 6, 7)
  }

  before do
    Timecop.freeze(datetime)
    create_seed
  end

  after do
    Timecop.return
  end

  context "without datetime" do

    it "redirects to home" do
      visit new_book_path
      expect(page).to have_current_path("/?start_of_week=2022-04-03")
    end

    it "displays a notice" do
      visit new_book_path
      expect(page).to have_text "Please select a slot to book"
    end

  end

  context "with valid datetime" do

    it "redirects to home" do
      visit root_path
      click_link "2022-04-06-08"
      fill_in "Name", with: 'Kwame'
      fill_in "Phone", with: '0231286723'
      fill_in "Ref no", with: "20304012"
      fill_in "Programme", with: "Bsc. Mat Eng"
      click_on "Book"
      expect(page).to have_text "Slot booked successfully."
      slot = find_by_id("2022-04-06-08")
      expect(slot).to have_text "2 slots left"
    end

  end

end
