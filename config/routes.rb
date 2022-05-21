class SubdomainRequired
  def self.matches?(request)
    subdomain = request.subdomains.first
    Rails.logger.debug("@@ route subdomain: #{subdomain}")
    # tenant = Author.find_by subdomain: subdomain
    tenant = request.subdomains.size == 2
    subdomain.present? && tenant
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints(SubdomainRequired) do
    get '/', to: "home#index"
  end

end
