class ProfilesController < ApplicationController
  require 'ProDetail'
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
     @user = User.find(current_user.id)     
     @profile = Profile.new     
     @profile.user_id = @user.id 
        
    respond_to do |format|       
      format.html # new.html.erb       
      format.json { render json: @profile }     
    end 
    
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])
    
    @p1 = ::ProDetail.new("ProfileDetail.txt")
    @p1.addPerson(params[:profile][:firstname],params[:profile][:lastname],params[:profile][:address],params[:profile][:mobile],params[:profile][:created_at])
    
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.'}
        format.json { render json: @profile, status: :created, location: @profile }
        @user = User.find(current_user.id)
        @user.firstname = @profile.firstname
        @user.save
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  
        
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
  
   def myprofile     
      profile = Profile.find_by_user_id(current_user.id)           
      
      if profile.nil?       
        redirect_to "/profiles/new"     
      else       
        @user = User.find(current_user.id)       
        @profile = Profile.find_by_user_id(@user.id)       
        redirect_to "/products"
            
      end 
       
   end  
end
