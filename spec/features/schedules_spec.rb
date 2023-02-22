require "rails_helper"

RSpec.feature SchedulesController, :type => :feature, js: true do

  let(:datetime){
    DateTime.new(2022, 4, 6, 7)
  }

  let(:slot_datetime){
    DateTime.new(2022, 4, 6, 8)
  }

  before do
    Timecop.freeze(datetime)
    create_seed
  end

  after do
    Timecop.return
  end

  it "redirects to date of beginning_of_week" do
    visit root_path
    expect(page).to have_current_path("/?start_of_week=2022-04-03")
  end

  it "has no Last week link" do
    visit root_path
    expect(page).not_to have_link("Last week")
  end

  it "has link to beginning_of_ next week" do
    visit root_path
    expect(page).to have_link("Next week", href: root_path(start_of_week: "2022-04-10"))
  end

  context "next week" do

    it "has Last week link" do
      visit root_path
      click_link "Next week" # this performs setting by param so there's no need to test from that
      expect(page).to have_link("Last week", href: root_path(start_of_week: "2022-04-03"))
    end

  end

  context "slot" do

    context "in the future" do

      context "without popups" do

        # next day at 10
        it "has a link to new_book_path" do
          visit root_path
          click_link "2022-04-06-08"
          expect(page).to have_current_path new_book_path(datetime: slot_datetime)
        end

        it "with bookings have text as Booked" do
          create_list(:book, 3, on_at: slot_datetime)
          visit root_path
          slot = find_by_id("2022-04-06-08")
          expect(slot).to have_text "Booked"
        end

      end

      context "with popups" do

        it "has text as Cancelled" do
          Popup.create(on_at: slot_datetime)
          visit root_path
          expect(page).to have_button "Cancelled", count: 1
        end

        it "with bookings have text as Cancelled"do
          create_list(:book, 3, on_at: slot_datetime)
          Popup.create(on_at: slot_datetime)
          visit root_path
          expect(page).to have_button "Cancelled"
        end

      end

    end

    context "in the past" do

      #popups can't be created for the past
      it "has no link" do
        visit root_path
        expect(page).not_to have_link "2022-04-04-10"
      end

    end

  end

end
