class UserinfoController < ApplicationController
  layout "Commonlayout"
  
  before_filter :protect,:except =>[:login,:register]
 
 # the below action executes every time but excepts on login and register time because it is used on new or already logged users
 # and it is executes remaining actions which is in this controller.  
 #Notice that in case of refusal, the protect function returns false. This is the signal for the framework not to go on with a normal action. 
  def protect
    unless session[:user_id]
      flash[:notice] = "Please login first"
      redirect_to :action => 'login'
    return false
    end 
  end
  
  def index
    @user=Userlogindetails.new(params[:userlogindetails])
    currentuser=Userlogindetails.find_by_id(session[:user_id])
    @currentuser=currentuser
    respond_to do |format|
      format.html
    end
    
  end

#Get Method of HTTP
  def login
    respond_to do|format|
      format.html    
    if request.post?
      @user=Userlogindetails.new(params[:userlogindetails])
      userinfo=Userlogindetails.find_by_useremail_and_userpassword(@user.useremail,@user.userpassword)
      if userinfo
        session[:user_id]=userinfo.id
       # flash[:notice]="User #{userinfo.username} logged in."        
        redirect_to :action=>'index'
        return
      else
        @user.userpassword=nil
        format.html { render action: "login" }
        flash[:notice]='Invalid Email/Password combination'       
      end
    end
    end
  end

#Post Method of HTTP

  def register
    @user=Userlogindetails.new    
    respond_to do |format|
      format.html
      format.json {render json @user}
      
    if request.post?
      @user = Userlogindetails.new(params[:userlogindetails])
      if @user.save       
         #format.html { redirect_to :action=>'index'}
         #format.html { redirect_to(@user, :notice => 'User was successfully created.') }
         #session[:login]=1 
         session[:user_id]=@user.id         
        # flash[:notice] = "User with login #{@user.username} created successfully!"
         redirect_to :action=>'index'
         return
         #format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "register" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        #session[:login]=nil
      end
    end
  end
 end
 def logout
   session[:user_id]=nil
   flash[:notice]="User Logged out."
   redirect_to :controller=>'home',:action=>'index'
   
 end
end
