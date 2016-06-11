class Item < ApplicationRecord
   validates :name, presence: true
   validates :quantity, presence: true
end
