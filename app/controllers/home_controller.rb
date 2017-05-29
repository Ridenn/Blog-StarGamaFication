class HomeController < ApplicationController
  def index
    @lead = Lead.new
    if Post.count >= 3
      @randposts = Post.all.sample(3)
    end
  end

  def contact
    @lead = Lead.new
  end

  def thanks
  end

  def pdf
    send_file Rails.root.join('private', 'Como_Mensurar_e_Otimizar.pdf'), :type=>"application/pdf", :x_sendfile=>true
  end

  def googlekey
    render plain: "google-site-verification: #{Rails.application.config.google_verification}"
  end
end
