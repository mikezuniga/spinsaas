json.extract! cloud, :id, :name, :provider, :apikey, :secretkey, :endpoint, :created_at, :updated_at
json.url cloud_url(cloud, format: :json)
