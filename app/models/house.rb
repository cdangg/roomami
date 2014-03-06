class House < ActiveRecord::Base
  has_many :chores
  has_many :tenancies

  validates_presence_of :name, :address, :city
end
