class InteractionsController < ApplicationController

    get '/interactions' do
        if logged_in?
            @user = current_user
            erb :'/interactions/index'
        else
            redirect '/login'
        end
    end

end