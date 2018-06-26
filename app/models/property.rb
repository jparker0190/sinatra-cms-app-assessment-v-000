class Property < ActiveRecord::Base
  has_many :bills
  belongs_to :user

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:rooms].empty?
  end
end
