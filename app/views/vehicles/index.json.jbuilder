json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :title, :registration_number, :color
  json.url vehicle_url(vehicle, format: :json)
end
