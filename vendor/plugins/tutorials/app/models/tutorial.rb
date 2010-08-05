class Tutorial < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description, :category, :author, :content]

  validates_presence_of :title
  validates_uniqueness_of :title

  has_friendly_id :title, :use_slug => true

  named_scope :live, :conditions => {:draft => false}

  def self.categories
    categories = []
    all.each do |tutorial|
      categories << tutorial.category
    end
    categories.uniq
  end

  def self.with_category(category)
    tutorials = []
    all.each do |tutorial|
      tutorials << tutorial if tutorial.category == category.to_s
    end
    tutorials.uniq
  end

end
