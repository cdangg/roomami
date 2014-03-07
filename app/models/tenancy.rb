class Tenancy < ActiveRecord::Base
	belongs_to :user
	belongs_to :house

  validates_uniqueness_of :user_id, scope: :house_id

end
