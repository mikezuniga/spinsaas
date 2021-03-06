class AppmenController < ApplicationController
  before_action :set_appman, only: [:show, :edit, :update, :destroy]


  # GET /appmen/112341234-1234-12341234-1234/getclconfig
  # GET /getclconfig
  def getclconfig
    #@creds = @current_user.clouds.all.sort_by(&:provider)
    @stack = Appman.find_by_uuid(params[:uuid])
    @creds = @stack.clouds.all.sort_by(&:provider)
    #@creds = Cloud.all.sort_by(&:provider)
    @azure = false
    @google = false
    @kubernetes = false
    @openstack = false
    @dockerregistry = false
    @aws = false
    @creds.each do |c|
      case c.provider
      when "azure"
        @azure = true
      when "google"
        @google = true
      when "kubernetes"
        @kubernetes = true
      when "openstack"
        @openstack = true
      when "dockerregistry"
        @dockerregistry = true
      when "aws"
        @aws = true
      end
    end
    @appmenid = params[:uuid]
    render "clouds/getclconfig", layout: false
  end

  # GET /appmen/123412341234-12341234-12341-234/getspnkconfig
  # GET /getspnkconfig
  def getspnkconfig
    @jenkinsurl = ""
    @jenkinsuser = ""
    @jenkinspassword = ""
    @enable_email = false
    @email_server = ""
    @email_from = ""
    @enable_hipchat = false
    @hipchat_url = ""
    @hipchat_token = ""
    @hipchat_botname = ""
    @enable_twilio = false
    @twilio_account = ""
    @twilio_token = ""
    @twilio_sender = ""
    @enable_slack = false
    @slack_token = ""
    @slack_bot = ""
    @appman = Appman.find_by_uuid(params[:uuid])
    @appmanid = params[:uuid]
    @stackname = @appman.name
    render "clouds/getspnkconfig", layout: false
  end
  # GET /appmen
  # GET /appmen.json
  def index
    @appmen = @current_user.appmen.all
  end

  # GET /appmen/1
  # GET /appmen/1.json
  def show
    stack = Appman.find(params[:id])
    UpdateStackStatusJob.perform_later(stack)
  end

  # GET /appmen/new
  def new
    @appman = Appman.new
  end

  # GET /appmen/1/edit
  def edit
    redirect_to ("/")
  end

  # POST /appmen
  # POST /appmen.json
  def create
    @appman = Appman.new(appman_params)
    @appman.user_id = session[:user_id]
    respond_to do |format|
      if @appman.save
        UpdateStackStatusJob.perform_later(@appman)        
        format.html { redirect_to @appman, notice: 'Appman was successfully created.' }
        format.json { render :show, status: :created, location: @appman }
      else
        format.html { render :new }
        format.json { render json: @appman.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appmen/1
  # PATCH/PUT /appmen/1.json
  def update
    respond_to do |format|
      if @appman.update(appman_params)
        format.html { redirect_to @appman, notice: 'Appman was successfully updated.' }
        format.json { render :show, status: :ok, location: @appman }
      else
        format.html { render :edit }
        format.json { render json: @appman.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appmen/1
  # DELETE /appmen/1.json
  def destroy
    @appman.destroy
    respond_to do |format|
      format.html { redirect_to appmen_url, notice: 'Appman was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appman
      @appman = Appman.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appman_params
      params.require(:appman).permit(:name, :stackmetadata, :stackid, :details, :cloud_ids)
    end
end
