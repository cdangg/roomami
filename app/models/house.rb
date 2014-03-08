class House < ActiveRecord::Base
  has_many :chores
  has_many :tenancies
  has_many :tenants, through: :tenancies, source: 'user'
  has_many :comments, as: :commentable
  belongs_to :admin, class_name: "User", foreign_key: :user_id

  validates_presence_of :name, :address, :city

end
