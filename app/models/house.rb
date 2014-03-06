class House < ActiveRecord::Base
  has_many :chores
  has_many :users

  validates_presence_of :name, :address, :city

end
