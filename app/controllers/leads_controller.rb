class LeadsController < ApplicationController
  include ApplicationHelper
  before_action :find_lead, only: [:edit, :update, :show, :delete]
  before_action :authenticate_admin!, except: [:new, :create]

  def index
    @leads = Lead.all
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"lead-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # New action for creating post
  def new
    @lead = Lead.new
  end

  # Create action saves the post into database
  def create
    validate_lead_data
    if @lead_data != nil
      @lead = Lead.new(@lead_data)
      if @lead.save
        redirect_to thanks_path
      else
        flash[:alert] = "Erro ao realizar inscrição, este email não é válido!"
        redirect_to root_path
      end
    else
      flash[:alert] = "Erro ao realizar inscrição, certifique-se de que todas as informações estão corretas."
      redirect_to root_path
    end
  end

  def destroy
  end

  def edit
  end

  private

  def lead_params
    params.require(:lead).permit(:name, :surname, :email, :occupation)
  end

  def find_lead
    @lead = Lead.find(params[:id])
  end

  def qualify_email
    EmailValidator(params[:lead]['email'])
  end

  def all_letters(str)
    str[/^[a-zA-Z \u00C0-\u017F]+/] == str
  end

  def validate_lead_data
    if lead_data['kind'] != "Invalid" && all_letters(lead_data['name']) && all_letters(lead_data['surname'])
      @lead_data = lead_data
    else
      @lead_data = nil
    end
  end

  def lead_data
    qualify_email
    if qualify_email != false
      request_data = request.location.data.to_json
      request_data = JSON.parse(request_data)
      request_data.slice!("ip", "city", "region_name", "country_name", "longitude", "latitude")
      data = lead_params.to_h.merge(request_data)
      data['kind'] = qualify_email
      data['occupation'] = data['occupation'].to_i
      data
    else
      false
    end
  end
end
