class Expense < ActiveRecord::Base
	belongs_to :house
  belongs_to :user

  validates_presence_of :description

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
