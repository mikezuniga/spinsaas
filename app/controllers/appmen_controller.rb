class AppmenController < ApplicationController
  before_action :set_appman, only: [:show, :edit, :update, :destroy]

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
      params.require(:appman).permit(:name, :stackmetadata, :stackid, :details)
    end
end
