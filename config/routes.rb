Rails.application.routes.draw do
  # Root path
  root to: "arquivos#index"

  resources :arquivos

  # Impede tentativa de acionar pagina que nao existe
  match '*path', via: :all, to: redirect('/404')

end
