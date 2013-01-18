PivotalOverview::Application.routes.draw do

  resources :print do

  end

  resources :projects do
    resources :stories
  end

end
