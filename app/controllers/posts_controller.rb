class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]
  before_action :authenticate_admin!, except: [:index, :show]

  # Index action to render all posts
  def index
    @posts = Post.all
  end

  # New action for creating post
  def new
    @post = Post.new
  end

  # Create action saves the post into database
  def create
    @post = current_admin.posts.build(post_params)
    if @post.save
      flash[:notice] = "Postagem criada com sucesso!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Erro ao criar nova postagem!"
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
    find_post
  end

  # Update action updates the post with the new information
  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Postagem atualizada com sucesso!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Erro ao atualizar postagem!"
      render :edit
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
    find_post
  end

  # The destroy action removes the post permanently from the database
  def destroy
    find_post
    if @post.destroy
      flash[:notice] = "Postagem deletada com sucesso!"
      redirect_to posts_path
    else
      flash[:alert] = "Erro ao atualizar postagem!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
