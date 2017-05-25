class HomeController < ApplicationController
  def index
    @lead = Lead.new
  end

  def contact
    @lead = Lead.new
  end

  def thanks
  end

  def google_validation
  end

   def pdf
    send_file Rails.root.join('private', 'Como_Mensurar_e_Otimizar.pdf'), :type=>"application/pdf", :x_sendfile=>true
  end
end
