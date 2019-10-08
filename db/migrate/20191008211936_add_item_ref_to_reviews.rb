class AddItemRefToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :item, foreign_key: true
  end
end
