class Tutorial < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :category, :author, :content]

  validates_presence_of :title
  validates_uniqueness_of :title



end
