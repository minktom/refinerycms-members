Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :members do
    root :to => "groups#index"
    resources :groups, :path => '', :only => [:index, :show] do
      resources :items, :path => '', :only => :show
    end
  end

  # Admin routes
  namespace :members, :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'members' do
        resources :groups, :except => :show do
          collection do
            post :update_positions
          end
          resources :items, :only => :index
        end
        resources :items, :except => [:index, :show] do
          collection do
            post :update_positions
          end
        end
        resource :profile
        #match 'profile' => 'profiles#show'
      end
    end
  end

end