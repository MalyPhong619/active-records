require ('sinatra')
require ('sinatra/reloader')
require ("sinatra/activerecord")
require ('./lib/task')
require ('./lib/list')
also_reload 'lib/**/*rb'
require ('pg')




get('/') do
  @tasks = Task.all
  erb(:index)
end

post('/tasks') do
  description = params.fetch('description')
  task = Task.new({:description => description, :done => false})
  task.save
  erb(:success)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i)
  erb(:task_edit)
end

patch('/tasks/:id') do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i)
  @task.update({:description => description})
  @tasks = Task.all
  erb(:index)
end
