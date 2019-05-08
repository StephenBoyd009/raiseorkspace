class ProfilesController < ApplicationController
    def new
        #Render blank profiles detail form
        @profile = Profile.new
    end
    
    def create
        #Ensuring that the right user is filing the right profile
        @user =User.find( params[ :user_id] )
        #The create a profile linked to this specific user
        @profile = @user.build_profile( profile_params )
        if @profile.save
            flash[:success] ="Profile Updated!"
            redirect_to root_path
        else
            render action :new
        end
    end
     private
     def profile_params
        params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description) 
     end
end

