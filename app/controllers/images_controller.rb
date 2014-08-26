class ImagesController < ApplicationController
	before_action :set_image, only: [:destroy]

  # GET /images/new
  def new
    @image = Image.new
    @images = Image.all.order(created_at: :desc).limit(15)
  end

  # POST /images
  def create
    @images = Image.all
    @image = Image.new(image_params)

    if params[:image]
      if @image.save
        redirect_to new_image_path, notice: 'Photo uploaded.'
      else
        @image.errors.delete(:photo)
        render :new
      end
    else
      redirect_to new_image_path, alert: 'Photo cannot be blank.'
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
    redirect_to new_image_url, notice: 'Image destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:photo) if params[:image]
    end

end
