Rails.application.routes.draw do
  resources :shortened_uris
  get '*path', to: 'shortened_uris#access_uri'
end
