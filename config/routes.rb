Rails.application.routes.draw do
 get 'query', to: 'query#index', defaults: {format: :json}
end
