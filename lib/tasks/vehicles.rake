"""THE_MAP_OF_FIELDS
0 - Регистр. номер
1 - Тип
2 - Модель
3 - Цвет
4 - Владелец
5 - Телефон
6 - Скайп
7 - Офис
8 - Комната
9 - Strong need and commit in parking place in the territory
"""

require 'csv'
require 'iconv'

namespace :vehicles do
  desc "Import Vehicles from XLSX file into project DB"
  task import: :environment do
  	spreadsheet = open_spreadsheet(File.expand_path("../../../tmp/vehicles.xlsx", __FILE__))
  	headers = spreadsheet.row(1)
  	(2..spreadsheet.last_row).each do |i|
  		# row = Hash[[headers, spreadsheet.row(i)].transpose]
  		# vehicle.attributes = row.to_hash.slice(*accessible_attributes)

  		row = spreadsheet.row(i)

  		# Extract info about vehicle
  		vehicle_reg_number = row[0]
  		vehicle_type = row[1]
  		vehicle_model = row[2]
  		vehicle_color = row[3] # TODO: Convert from text to HEX and then to Integer

  		# Extract info about owner
  		user_full_name = row[4]
  		user_phone = row[5]
  		user_skype = row[6]
  		user_office = row[7]
  		user_room = row[8]
  		user_has_parking_slot = row[8]


  		###########
  		# VEHICLE
  		###########
  		vehicle = Vehicle.find_by_registration_number(vehicle_reg_number) || Vehicle.new
  		vehicle.vehicle_type = vehicle_type
  		vehicle.title = vehicle_model
  		vehicle.color = vehicle_color
  		vehicle.registration_number = vehicle_reg_number

  		########
  		# USER 
  		########
 		# Hack - try to compile username from user full name according to CGN rules
  		# 1st letter of name and full surname are lowercased and concatenated
  		username_parts = %r{^(\w)\w+\s(\w+)}.match(user_full_name.downcase)
  		username= username_parts[1] + username_parts[2]

  		user = User.find_by_username(username) || User.new
  		user.username= username
      user.full_name= user_full_name
  		user.phone= user_phone
  		user.skype= user_skype
  		user.office= user_office
  		user.room= user_room
  		user.has_passcard= user_has_parking_slot

  		begin
  			# Save User and Vehicle at the same time
  			user.save!
  			user.vehicles.create vehicle.attributes
  		rescue Exception => e
  			puts "Can not save Record", e.message
  		end
  	end
  end

  private

  def open_spreadsheet(filePath)
  	case File.extname(filePath)
		when ".csv" then Roo::Csv.new(filePath, nil, :ignore)
		when ".xls" then Roo::Excel.new(filePath, nil, :ignore)
		when ".xlsx" then Roo::Excelx.new(filePath, nil, :ignore)
		else raise "Unknown file type: #{filePath}"
	end
  end

end
