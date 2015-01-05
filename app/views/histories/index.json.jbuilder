json.array!(@histories) do |history|
  json.extract! history, :id, :user_name, :action, :object, :time
  json.url history_url(history, format: :json)
end
