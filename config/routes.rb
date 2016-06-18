Rails.application.routes.draw do
  
  root 'user#home'
  post '/login' => 'user#login'
  post '/signup' => 'user#signup'
  get '/logout' => 'user#logout'
  get 'users/:user_id' => 'user#profile'
  get '/friends' => 'user#friends'
  get '/user/edit' => 'user#edit'
  post '/user/save' => 'user#save_edits'

  post '/posts/create' => 'post#create'
  get 'posts/:post_id' => 'post#show'
  get 'posts/:post_id/like' => 'post#like'
  get 'posts/:post_id/unlike' => 'post#unlike'
  post 'posts/:post_id/comment' => 'post#comment'

  get 'search/users' => 'search#show'
  get 'search/posts' => 'search#posts'

  get 'friendship/:user_id/send' => 'friendship#send_request'
  get 'friendship/:user_id/cancel' => 'friendship#cancel'
  get 'friendship/:user_id/unfriend' => 'friendship#unfriend'
  get 'friendship/show' => 'friendship#show'

  get 'friendship/:user_id/accept' => 'friendship#accept'
  get 'friendship/:user_id/reject' => 'friendship#reject'

end
