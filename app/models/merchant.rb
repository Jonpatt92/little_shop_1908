class Merchant < ApplicationRecord
<<<<<<< HEAD
  has_many :items
  has_many :order_items, through: :items
=======
  has_many :items, :dependent => :destroy
>>>>>>> 08f2824f495f416d1d0539d6bef2d50e6b8cf740

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def no_orders
    order_items.empty?
  end

  def average_item_price
    items.average(:price)
  end

  def cities
    order_items.distinct.joins(:order).pluck(:city)
  end
end
