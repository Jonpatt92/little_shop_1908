require 'rails_helper'

describe 'When I checkout from Cart' do
  describe 'I see a new order page'
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 3)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit "/items/#{@tire.id}"
      click_on "Add to cart"
      visit "/items/#{@tire.id}"
      click_on "Add to cart"
      visit "/items/#{@pull_toy.id}"
      click_on "Add to cart"
    end

    it 'Shows me the details of my cart' do

      visit "/orders/new"

      within ".all-order-items" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_link(@pull_toy.name)
      end

      within "#grand-total" do
        expect(page).to have_content("Grand Total: 210")
      end

      within "#order-item-#{@tire.id}" do
        expect(page).to have_link(@tire.merchant.name)
        expect(page).to have_content(@tire.price)
        expect(page).to have_content("Quantity: 2")
        expect(page).to have_content("Subtotal: 200")
      end

      within "#order-item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.merchant.name)
        expect(page).to have_content(@pull_toy.price)
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: 10")
      end
    end

    it 'I can create a new order' do
      visit '/orders/new'

      name = "Guy Fawkes"
      address = '123 Independence ln'
      city = "Denver"
      state = "CO"
      zip = 80204

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button "Create Order"
      new_order = Order.last

      expect(new_order.name).to eq(name)
      expect(new_order.address).to eq(address)
      expect(new_order.city).to eq(city)
      expect(new_order.state).to eq(state)
      expect(new_order.zip).to eq(zip)
      expect(current_path).to eq("/orders/#{new_order.id}")
    end

    it 'I cant submit an incomplete form' do
      visit '/orders/new'

      name = "Guy Fawkes"
      city = "Denver"
      state = "CO"
      zip = 80204

      fill_in :name, with: name
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button "Create Order"

      expect(page).to have_content("Please fill in all forms before submitting order")
      expect(current_path).to eq("/orders/new")
    end
end
