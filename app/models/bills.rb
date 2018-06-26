class Bills < ActiveRecord::Base
  belongs_to :property

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:amount].empty?
  end
end
