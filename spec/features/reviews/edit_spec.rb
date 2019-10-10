require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I visit an Item page' do
    describe 'and click edit review' do
      before(:each) do
        @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)


        @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        @review_1 = @chain.reviews.create(title: 'Leiya', content: 'Awful chain, Meeg lied to me!', rating: 1)
        @review_2 = @chain.reviews.create(title: 'Josh', content: "It wasn't that bad.", rating: 2)
        @review_3 = @chain.reviews.create(title: 'John', content: "I don't know why I bought a chain, I don't even use my bike", rating: 3)
        @review_4 = @chain.reviews.create(title: 'Evette', content: "Great chain! Used it to make an amazing collar for my pug Larry.", rating: 4)
        @review_5 = @chain.reviews.create(title: 'Meg', content: "I made this chain, it's great. Wish I could git it a 55/5", rating: 5)
      end

      it 'I can see populated reviews' do
        visit "/items/#{@chain.id}"

        expect(page).to have_link('Edit Review')

        click_on 'Edit Review'

        expect(current_path).to eq("/items/#{@chain.id}/#{@review_1.id}/edit")
        expect(page).to have_link('Chain')
        expect(find_field('title').value).to eq('Leiya')
        expect(find_field('content').value).to eq('Awful chain, Meeg lied to me!')
        expect(find_field('rating').value).to eq(1)
      end
    end
  end
end