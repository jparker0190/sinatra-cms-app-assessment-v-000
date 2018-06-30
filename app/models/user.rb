class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
	extend Slugifiable::ClassMethods
  validates :username, uniqueness: true
  has_many :propertys
end
