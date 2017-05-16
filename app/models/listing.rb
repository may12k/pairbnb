class Listing < ApplicationRecord

validates :title, presence: true
validates :price, presence: true
validates :place, presence: true
belongs_to :user
has_many :reservations
end
