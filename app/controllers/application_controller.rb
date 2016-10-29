class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def testHello
    render html: "Hello TestWorld"
  end
  
end
