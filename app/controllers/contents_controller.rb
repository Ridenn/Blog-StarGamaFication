class ContentsController < ApplicationController
  before_action :find_content, only: [:edit, :update, :show, :delete]
  before_action :authenticate_admin!, except: [:index, :show]

  # Index action to render all contents
  def index
    @contents = Content.all
  end

  # New action for creating content
  def new
    @content = Content.new
  end

  # Create action saves the content into database
  def create
    @content = Content.new(content_params)
    if @content.save
      flash[:notice] = "Conteúdo criado com sucesso!"
      redirect_to contents_path(@content)
    else
      flash[:alert] = "Erro ao criar novo conteúdo!"
      render :new
    end
  end

  # Edit action retrives the content and renders the edit page
  def edit
    find_content
  end

  # Update action updates the content with the new information
  def update
    if @content.update_attributes(content_params)
      flash[:notice] = "Conteúdo atualizado com sucesso!"
      redirect_to contents_path(@contents)
    else
      flash[:alert] = "Erro ao atualizar conteúdo!"
      render :edit
    end
  end

  # The show action renders the individual content after retrieving the the id
  def show
    find_content
  end

  # The destroy action removes the content permanently from the database
  def destroy
    find_content
    if @content.destroy
      flash[:notice] = "Conteúdo deletado com sucesso!"
      redirect_to contents_path
    else
      flash[:alert] = "Erro ao atualizar conteúdo!"
    end
  end

  private

  def content_params
    params.require(:content).permit(:site_area, :featured_image, :lead, :content)
  end

  def find_content
    @content = Content.find(params[:id])
  end
end
