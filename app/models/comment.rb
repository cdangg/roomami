class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :house

  validates_presence_of :content
end
