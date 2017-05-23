class HomeController < ApplicationController
  def index
    @lead = Lead.new
  end

  def contact
  end

  def thanks
  end

   def pdf
    send_file Rails.root.join('private', 'ebook.pdf'), :type=>"application/pdf", :x_sendfile=>true
  end
end
