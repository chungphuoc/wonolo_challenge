require 'feature_helper'

feature 'Homes' do
  describe 'index page' do
    it "User view search form" do
      visit "/homes"
      expect(page).to have_text("Search for Instagram posts in a location")
    end

    it "input values and search" do
      visit "/homes"
      find('#inputLat').set('10.790261')
      find('#inputLong').set('106.658642')
      find('#inputDistance').set('2000')
      click_on 'Search'
      expect(page.status_code).to eq 200
    end
  end
end