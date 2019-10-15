class Merchant < ApplicationRecord
  has_many :items
  has_many :order_items, through: :items

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
