class RenameColumnPlayTypeToPayTypeForOrderTable < ActiveRecord::Migration
  def change
    rename_column :orders, :play_type, :pay_type
  end
end
