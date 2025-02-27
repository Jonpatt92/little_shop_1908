require 'rails_helper'

RSpec.describe 'Cart Show Page', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    visit "items/#{@chain.id}"
    click_on "Add to cart"

    visit "items/#{@tire.id}"
    click_on "Add to cart"

    visit '/cart'
  end

  it 'there is a button Remove Item next to each item' do
    expect(page).to have_content("#{@chain.name}")
    expect(page).to have_content("#{@tire.name}")

    within "#cart-item-#{@chain.id}" do
      click_button 'Remove Item'
    end

    expect(current_path).to eq('/cart')
    expect(page).to have_content("#{@tire.name}")
    expect(page).to_not have_content("#{@chain.name}")
  end


end
