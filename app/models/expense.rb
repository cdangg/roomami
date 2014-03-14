class Expense < ActiveRecord::Base
	belongs_to :house
  belongs_to :user
  has_many :shoppinglists

  validates_presence_of :description
  validates_presence_of :amount
  validates :amount, numericality: { only_interger: true }


  scope :complete, -> { where(status: true) }
  scope :pending, -> { where(status: false) }

  def split
		result = 0

		if (amount && roommates)
			result = amount / roommates
		end

		result
	end

end
