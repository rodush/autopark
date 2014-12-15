class Vehicle < ActiveRecord::Base
	validates_presence_of :title, :registration_number
end
