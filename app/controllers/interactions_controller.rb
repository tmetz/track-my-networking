class InteractionsController < ApplicationController

    get '/interactions' do
        if logged_in?
            @user = current_user
            erb :'/interactions/index'
        else
            redirect '/login'
        end
    end

    get "/interactions/:id" do
        if logged_in?
            @interaction = Interaction.find_by_id(params[:id])
            erb :'/interactions/show'
        else
            redirect '/login'
        end
    end

end