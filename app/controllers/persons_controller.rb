class PersonsController < ApplicationController

    get '/persons' do
        erb :'/persons/index'
    end
end