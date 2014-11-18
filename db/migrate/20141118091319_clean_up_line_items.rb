class CleanUpLineItems < ActiveRecord::Migration
  def up
    say_with_time "Cleaning unused line items" do
      
      LineItem.all.each do |line_item|
        if !Cart.exists?(line_item.cart_id) and !line_item.order_id
          LineItem.destroy(line_item)
        end
      end
    end
  end
end
