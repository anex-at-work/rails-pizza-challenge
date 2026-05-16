class OrderPizza < ApplicationRecord
  belongs_to :order
  belongs_to :pizza

  serialize :add, coder: JSON
  serialize :remove, coder: JSON
end
