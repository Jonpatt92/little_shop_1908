
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within '.topnav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within '.topnav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end
  end
end
