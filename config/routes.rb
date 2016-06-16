Rails.application.routes.draw do
  
  root 'user#home'
  post '/login' => 'user#login'
  post '/signup' => 'user#signup'
  get '/logout' => 'user#logout'
  get 'users/:user_id' => 'user#profile'
  get '/friends' => 'user#friends'

  post '/posts/create' => 'post#create'
  get 'posts/:post_id' => 'post#show'
  get 'posts/:post_id/like' => 'post#like'
  get 'posts/:post_id/unlike' => 'post#unlike'
  post 'posts/:post_id/comment' => 'post#comment'

  get 'search/users' => 'search#show'
  get 'search/posts' => 'search#posts'
end
