class HomeController < ApplicationController
  def index
    logger.debug("@@ subdomain #{request.subdomain}")
  end
end
