module PostsHelper
  def highlight_img(post)
    Nokogiri::HTML.fragment(post.body).css('img').remove_attr('style').add_class('img-responsive').collect(&:to_s)[0]
  end
end
