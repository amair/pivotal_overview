PivotalOverview::Application.routes.draw do

  root :to => "root_page#index"

  resources :root_page, :print

  resources :projects do
    resources :stories
  end

end
