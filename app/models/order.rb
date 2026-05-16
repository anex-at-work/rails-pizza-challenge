class Order < ApplicationRecord
  enum :state, { open: "open", completed: "completed" }
  has_many :order_pizzas

  before_create :generate_id

  scope :with_pizzas, -> { includes(order_pizzas: :pizza) }

  private
  def generate_id
    self.id = SecureRandom.uuid_v7 if id.blank?
  end
end
