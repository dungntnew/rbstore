class Cart < ActiveRecord::Base
  hash_many: line_items, dependent: :destroy
end
