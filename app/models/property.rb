class Property < ActiveRecord::Base
  has_many :users, through: :bills
  has_many :property_bills
  has_many :bills, through: :property_bills

  def slug
    self.name.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.where('name LIKE ?', "#{slug.gsub('-', ' ').downcase}").take
  end
end
