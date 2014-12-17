json.array!(@articles) do |article|
  json.extract! article, :id, :title, :description, :image, :price, :category, :state, :creater
  json.url article_url(article, format: :json)
end
