class Vehicle < ActiveRecord::Base
	validates_presence_of :title
	validates :registration_number, presence: true, uniqueness: true
end
