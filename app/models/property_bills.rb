class SongGenre < ActiveRecord::Base
  belongs_to :bill
  belongs_to :property
end
