class Post < ActiveRecord::Base
  belongs_to :query
  validates_uniqueness_of :url
  validates_presence_of :url
end
