json.array!(@quick_codes) do |quick_code|
  json.extract! quick_code, :id, :name, :content, :size, :level, :offset, :unit, :fill, :color
  json.url quick_code_url(quick_code, format: :json)
end
