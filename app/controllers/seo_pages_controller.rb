class SeoPagesController < ApplicationController
  before_action :set_seo_page, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :verify_admin, only: [:new, :edit, :update, :destroy]
  # GET /seo_pages
  # GET /seo_pages.json
  def index
    @seo_pages = SeoPage.all
  end

  # GET /seo_pages/1
  # GET /seo_pages/1.json
  def show
    @lawyers = Profile.where(city: params[:city])
  end

  # GET /seo_pages/new
  def new
    @seo_page = SeoPage.new
  end

  # GET /seo_pages/1/edit
  def edit
  end

  # POST /seo_pages
  # POST /seo_pages.json
  def create
    @seo_page = SeoPage.new(seo_page_params)

    respond_to do |format|
      if @seo_page.save
        format.html { redirect_to @seo_page, notice: 'Seo page was successfully created.' }
        format.json { render :show, status: :created, location: @seo_page }
      else
        format.html { render :new }
        format.json { render json: @seo_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seo_pages/1
  # PATCH/PUT /seo_pages/1.json
  def update
    respond_to do |format|
      if @seo_page.update(seo_page_params)
        format.html { redirect_to @seo_page, notice: 'Seo page was successfully updated.' }
        format.json { render :show, status: :ok, location: @seo_page }
      else
        format.html { render :edit }
        format.json { render json: @seo_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seo_pages/1
  # DELETE /seo_pages/1.json
  def destroy
    @seo_page.destroy
    respond_to do |format|
      format.html { redirect_to seo_pages_url, notice: 'Seo page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify_admin
    unless current_user.admin? == true
      redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seo_page
      @seo_page = SeoPage.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seo_page_params
      params.require(:seo_page).permit(:city, :state, :og_description, :slug, :image_tag, :name)
    end
end
