class SubdomainRequired
  def self.matches?(request)
    subdomain = request.subdomains.first
    # tenant = Author.find_by subdomain: subdomain
    tenant = true
    # subdomain.present? && tenant
    subdomain.present? && /^[a-zA-Z][a-zA-Z0-9-]*{2}$/.match(subdomain)
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  constraints(SubdomainRequired) do
    get '/', to: "home#index"
  end

end
