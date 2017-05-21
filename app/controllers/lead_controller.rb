class LeadsController < ApplicationController
  before_action :find_lead, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    @leads = Lead.all
  end

  # New action for creating post
  def new
    @lead = Lead.new
  end

  # Create action saves the post into database
  def create
    @lead = Lead.new
    if @lead.save(lead_params)
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@lead)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
  end

  # Update action updates the post with the new information
  def update
    if @lead.update_attributes(lead_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@leads)
    else
      flash[:alert] = "Error updating post!"
      render :edit
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
  end

  # The destroy action removes the post permanently from the database
  def destroy
    if @lead.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to posts_path
    else
      flash[:alert] = "Error updating post!"
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :surname, :email)
  end

  def find_lead
    @lead = Lead.find(params[:id])
  end
end
