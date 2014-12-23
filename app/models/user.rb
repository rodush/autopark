class User < ActiveRecord::Base
	has_many :vehicles, dependent: :destroy
end
