json.task do
  json.id   @task.id
  json.rid  @task.restaurant_id
  json.name @task.restaurant.name
end