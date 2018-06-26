class Bills < ActiveRecord::Base
  belongs_to :user
  has_many :property_bills
  has_many :properties, through: :property_bills
  def slug
    self.name.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.where('name LIKE ?', "#{slug.gsub('-', ' ').downcase}").take
  end
end
