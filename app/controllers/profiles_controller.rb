class ProfilesController < ApplicationController
    def new
        #Render blank profiles detail form
        @profile = Profile.new
    end
end