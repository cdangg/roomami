class Shoppinglist < ActiveRecord::Base
  belongs_to :house
  belongs_to :user
  belongs_to :expense

  validates_presence_of :name

  scope :complete, -> { where(status: true) }
  scope :pending, -> { where(status: false) }
end
