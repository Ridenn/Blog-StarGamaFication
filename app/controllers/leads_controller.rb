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
    @lead = Lead.new(lead_data)
    if @lead.save
      redirect_to obrigado_path
    else
      flash[:alert] = "Error creating new post!"
      redirect_to root_path
    end
  end

  # The show action renders the individual post after retrieving the the id
  def show
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :surname, :email)
  end

  def find_lead
    @lead = Lead.find(params[:id])
  end

  def lead_data
    request_data = request.safe_location.data.to_json
    request_data = JSON.parse(request_data)
    request_data.slice!("ip", "city", "region_name", "country_name", "longitude", "latitude")
    lead_params.to_h.merge(request_data)
  end
end
