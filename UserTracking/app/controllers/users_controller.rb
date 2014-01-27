class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    #@user_grid=initialize_grid(User)
    time_range=Time.now.midnight..Time.now.end_of_day
    @usertimes=UserTime.where(:arrival_time=>time_range)
    @u=@usertimes.map{|e| e.user_id}
    @users=User.find(@u)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    puts "this is sparta @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    #@current_user=User.find(session[:user_id])
    
    #puts "this is #{@user.id}"
    @user=User.find(params[:id])
    @avrg_time=avg_times(@user.user_times.map{|e|e.arrival_time.localtime.strftime("%H:%M")})

  end

  def statistics
    @users=User.all
    #count=0
  end

  def sort

  end

  # GET /users/new
  def new
    @user = User.new
  end

  def login
    puts "blaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    if  @user=User.find_by_name(params[:name])
      session[:user_id]=@user.id
      @user_time=UserTime.new
      @user_time=@user.user_times.create(:arrival_time=>DateTime.now)
      #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      redirect_to user_path(@user)
    else
      redirect_to users_path, :notice=> "You are not registered. Please sign up first."
    end
  end

  # GET /users/1/edit
  def edit
  end

  def analytics
    @average_time= avg_times(UserTime.all.where("date(arrival_time)=?",DateTime.now.to_date).map{|e|e.arrival_time.in_time_zone('Mumbai').strftime("%H:%M")})
  end

  def avg_times(var)
    begin
         grand_total=0
         size=var.size 
         puts "size #{size}"
         
         avg_minutes=var.map do|x| 
           hour,minute=x.split(':')
           puts "size1"
           total_minutes=hour.to_i*60+minute.to_i 
           puts "total_minutes #{total_minutes}"
           grand_total=grand_total+total_minutes
         end
          puts "avg_minutes #{avg_minutes}"
          puts "grand_total #{grand_total}"
          avg_value=grand_total/size
          average_time=avg_value.to_f/60
    rescue ZeroDivisionError
          redirect_to users_path, :notice=> "None of the users have logged in yet so can't provide you an average login time."
    end 
  end

  # POST /users
  # POST /users.json


  def create
    puts "this is not sparta ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :role)
    end
end
