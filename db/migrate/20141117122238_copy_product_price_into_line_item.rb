class CopyProductPriceIntoLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
    
    say_with_time "Updating item prices.." do
      LineItem.all.each do |line_item|
        line_item.update_attributes :price => line_item.product.price
      end
    end
  end
end
