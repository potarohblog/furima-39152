class Order < ApplicationRecord
  attr_accessor :token
  # validates :presence: true
    belongs_to :user
    belongs_to :item
    has_one :payment
  end