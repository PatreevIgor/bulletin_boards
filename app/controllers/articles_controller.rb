class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  # GET /articles
  # GET /articles.json
  include Record_history

  def published
    @search = Article.search(params[:q])
    @articles = @search.result.where(state: ['published','archive']).page(params[:page]).per(3)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def not_published
    @articles = Article.where(state: ['pending_publication','rejected'])
  end

  def all_users
    @users = User.all
  end

  def index
    @articles = Article.all
  end

  def main_articles
    @articles = Article.where(creater: current_user.name)
  end
  # GET /articles/1
  # GET /articles/1.json
  def show
    find_comment_for_current_article
    record_history_show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    record_history_edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    record_the_current_user_in_the_name_field
    new_state_when_creating
    record_history_create
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :image, :price, :category, :state, :creater)
    end

    def record_the_current_user_in_the_name_field
      if @article.save
        @article.creater = current_user.name
        @article.save
      end
    end

    def new_state_when_creating
      if @article.save
        @article.state = "pending_publication"
        @article.save
      end
    end
    def find_comment_for_current_article
      @massiv_id_articles_for_comments = []
      Comment.all.each do |comment|
        @massiv_id_articles_for_comments << comment.article_id
      end

      if @massiv_id_articles_for_comments.include?(@article.id)
        @comment = Comment.where(article_id: @article.id).first
      else
        @comment = Comment.new
        @comment.article_id = @article.id
        @comment.save
      end
      @main_comment = Comment.where(article_id: @article.id).first.body
    end
end
