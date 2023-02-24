class TodoController < Sinatra::Base

    set :views, './app/views'

    get '/hello' do
        "Welcome To TodoController"
    end

    post '/todos/create'do
        data = JSON.parse(request.body.read)
    begin
        #approach 1 (individual columns)
        #today = Time.now 
        #title = data ["title"]
        #description = data ["description"]
        #Todo.create(title:title, description:description, createdAt:today)
        #todo.to_json

        #approach 2
        data["createdAt"] = Time.now
        todo = Todo.create(data)
        todo.to_json
    rescue => e
        {
            "error": e.message
        }.to_json
       end
    end

    get '/todos' do
        todos= Todo.all
        [200, todos.to_json]
    end

    get '/views/todos'do
         @todos= Todo.all
         erb :todos
    end

end