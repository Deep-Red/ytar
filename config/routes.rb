Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  get 'videos/index'

  get 'videos/show'

  get 'videos/viewer'

  get 'videos/accept'

  get 'videos/reject'

  get 'videos/retry'

  get 'videos/finalize'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
