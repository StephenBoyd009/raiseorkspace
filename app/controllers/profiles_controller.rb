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
            redirect_to user_path(id: params[:user_id] )
        else
            render action :new
        end
    end
    
    def edit 
        @user =User.find( params[:user_id] )
        @profile = @user.profile
    end
    
    #PATCH to /users/:user_id/profile
    def update
        @user = User.find( params[:user_id] )
        @profile = @user.profile
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile Updated!"
            redirect_to user_path(id: params[:user_id] )
        else
            render action: :edit
        end
            
    end
    
     private
     def profile_params
        params.require(:profile).permit(:first_name, :last_name, :avatar,  :job_title, :phone_number, :contact_email, :description) 
     end
end

