class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :publish, :prepare_publish, :unpublish, :destroy]

  # GET /articles
  def index
    @search = Article.includes(:user, :tag_list).search do
      fulltext params[:search]

      with :published, false
      order_by :updated_at, :desc
      paginate :page => params[:page], :per_page => 25
    end
    @articles = @search.results
  end

  # GET /published
  def published
    @search = Article.includes(:user, :tag_list).search do
      fulltext params[:search]

      with :published, true
      order_by :updated_at, :desc
      paginate :page => params[:page], :per_page => 25
    end
    @articles = @search.results
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_url, notice: 'Article created.'
    else
      render :edit
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      if params[:commit] === 'Save'
        redirect_to edit_article_path, notice: 'Article saved.'
      elsif params[:commit] === 'Save & Close'
        redirect_to articles_path, notice: 'Article updated.'
      end
    else
      render :edit
    end
  end

  # PUT /articles/1/publish
  def publish
    if @article.save
      if params[:article][:published_at].blank? || params[:article][:tag_list].blank?
        redirect_to prepare_publish_article_url(@article), alert: "Tags and Release Date cannot be blank."
      else
        @article.update!(
          tag_list: params[:article][:tag_list],
          published_at: DateTime.strptime(params[:article][:published_at],'%m-%d-%Y %H:%M %z'), 
          published: true
        )
        redirect_to published_articles_url, notice: 'Article published.'
      end
    else
      redirect_to articles_url, alert: "Article could not be published."
    end
  end

  # PUT /articles/1/publish_date
  def prepare_publish
  end

  # PUT /articles/1/unpublish
  def unpublish
    @article.update!(published_at: nil, tag_list: nil, published: false)

    if @article.save
      redirect_to articles_url, notice: 'Article unpublished.'
    else
      redirect_to published_articles_url, alert: "Article could not be unpublished."
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :preview_image_url, :description, :content, :user_id, :published, :published_at, :slug, :tag_list)
    end
end
