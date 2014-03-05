class House < ActiveRecord::Base
  has_many :chores
  has_many :tenancies
end
