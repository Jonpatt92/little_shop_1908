require 'rails_helper'

describe 'From an items show Page' do
  describe 'I see a link to add item to cart'
    describe 'I click on the link, and routed to the item index page'
      before(:each) do
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      end

        it 'I see the updated cart total, and a message saying Ive added an item to my cart' do

          visit "/items/#{@tire.id}"
          within ".topnav" do
            expect(page).to have_content("Cart: 0")
          end
          click_on "Add to cart"
          expect(current_path).to eq("/items")
          expect(page).to have_content("#{@tire.name} added to cart")
          expect(page).to have_content("You now have 1 Gatorskins in your cart.")
          within ".topnav" do
            expect(page).to have_content("Cart: 1")
          end

          visit "/items/#{@pull_toy.id}"
          within ".topnav" do
            expect(page).to have_content("Cart: 1")
          end
          click_on "Add to cart"
          expect(current_path).to eq("/items")
          expect(page).to have_content("#{@pull_toy.name} added to cart")
          expect(page).to have_content("You now have 1 Pull Toy in your cart.")
          within ".topnav" do
            expect(page).to have_content("Cart: 2")
          end

          visit "/items/#{@dog_bone.id}"
          within ".topnav" do
            expect(page).to have_content("Cart: 2")
          end
          click_on "Add to cart"
          expect(current_path).to eq("/items")
          expect(page).to have_content("#{@dog_bone.name} added to cart")
          expect(page).to have_content("You now have 1 Dog Bone in your cart.")
          within ".topnav" do
            expect(page).to have_content("Cart: 3")
          end

          visit "/items/#{@tire.id}"
          within ".topnav" do
            expect(page).to have_content("Cart: 3")
          end
          click_on "Add to cart"
          expect(current_path).to eq("/items")
          expect(page).to have_content("#{@tire.name} added to cart")
          expect(page).to have_content("You now have 2 Gatorskins in your cart.")
          within ".topnav" do
            expect(page).to have_content("Cart: 4")
          end

          visit "/items/#{@dog_bone.id}"
          within ".topnav" do
            expect(page).to have_content("Cart: 4")
          end
          click_on "Add to cart"
          expect(current_path).to eq("/items")
          expect(page).to have_content("#{@dog_bone.name} added to cart")
          expect(page).to have_content("You now have 2 Dog Bones in your cart.")
          within ".topnav" do
            expect(page).to have_content("Cart: 5")
          end
        end
end
