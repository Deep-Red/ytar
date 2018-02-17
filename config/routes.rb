Rails.application.routes.draw do
  get 'home/index'

  get 'videos/show'

  get 'videos/accept'

  get 'videos/reject'

  get 'videos/retry'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
