Rails.application.routes.draw do
  # Root path
  root to: "arquivos#index"

  resources :arquivos

end
