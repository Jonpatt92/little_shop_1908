require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a merchant show page" do
    it "I can delete a merchant" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

      visit "merchants/#{bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it "I can delete a merchant that has items" do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      visit "merchants/#{bike_shop.id}"

      click_on "Delete Merchant"

      expect(current_path).to eq('/merchants')
      expect(page).to_not have_content("Brian's Bike Shop")
    end

    it 'Merchant can not be deleted if they have orders' do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      # binding.pry

      visit "/items/#{tire.id}"
      click_on 'Add to cart'
      visit "/items/#{tire.id}"
      click_on 'Add to cart'
      visit "/items/#{chain.id}"
      click_on 'Add to cart'

      visit 'cart'
      click_on 'Checkout'

      # name = 'goblin'
      # address = 'some place in denver'
      # city = 'denver'
      # state = 'co'
      # zip = 80238

      fill_in :name, with: 'Goblin'
      fill_in :address, with: 'some place in denver'
      fill_in :city, with: 'denver'
      fill_in :state, with: 'co'
      fill_in :zip, with: '80238'
      # fill_in :name, with: name
      # fill_in :address, with: address
      # fill_in :city, with: city
      # fill_in :state, with: state
      # fill_in :zip, with: zip

      click_button 'Create Order'

      visit "/merchants/#{bike_shop.id}"

      # expect(page).to_not have_link('Delete Merchant')
    end
  end
end
