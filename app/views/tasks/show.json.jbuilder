json.name       @task.restaurant.name
json.address    @task.restaurant.address
json.telephone  @task.restaurant.telephone
json.url        @task.url
json.geocoder do
  json.latlong  "#{@task.restaurant.latitude},#{@task.restaurant.longitude}"
  json.lat      @task.restaurant.latitude
  json.long     @task.restaurant.longitude
end
