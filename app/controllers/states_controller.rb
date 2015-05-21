class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :verify_admin, only: [:new, :edit, :update, :destroy]
  # GET /seo_pages
  # GET /seo_pages.json
  def index
    @states = State.all
  end

  # GET /seo_pages/1
  # GET /seo_pages/1.json
  def show
    @cities = SeoPage.where(state: params[:name].capitalize)
  end

  # GET /seo_pages/new
  def new
    @state = State.new
  end

  # GET /seo_pages/1/edit
  def edit
  end

  # POST /seo_pages
  # POST /seo_pages.json
  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        format.html { redirect_to @state, notice: 'State was successfully created.' }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seo_pages/1
  # PATCH/PUT /seo_pages/1.json
  def update
    respond_to do |format|
      if @s_tate.update(state_params)
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { render :show, status: :ok, location: @state }
      else
        format.html { render :edit }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seo_pages/1
  # DELETE /seo_pages/1.json
  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to states_url, notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find_by_name(params[:name].capitalize)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :divorce_cost, :divorce_rate, :total_divorce, :distribution_type, :divorce_law_description)
    end
end
