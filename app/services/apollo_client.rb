require "net/http"
require "json"

# Thin wrapper around Apollo.io's REST API. Powers live buyer sourcing
# (BuyerSourcer) when APOLLO_API_KEY is set; otherwise the app falls back to the
# seeded Buyer dataset.
class ApolloClient
  BASE_URL = "https://api.apollo.io/api/v1".freeze

  class NotConfigured < StandardError; end

  def self.configured?
    ENV["APOLLO_API_KEY"].present?
  end

  # Organization search. `filters` is a Hash of Apollo search params (e.g.
  # q_organization_keyword_tags, organization_num_employees_ranges,
  # organization_locations, revenue_range). Returns an array of organization
  # Hashes (string keys) — never raises on "no results", just returns [].
  def self.search_organizations(filters, per_page: 10, page: 1)
    raise NotConfigured, "APOLLO_API_KEY is not set" unless configured?

    body = filters.compact.merge(per_page: per_page, page: page)
    response = post("/mixed_companies/search", body)
    Array(response["organizations"])
  end

  def self.post(path, body)
    uri = URI("#{BASE_URL}#{path}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 5
    http.read_timeout = 12

    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Cache-Control"] = "no-cache"
    request["x-api-key"] = ENV["APOLLO_API_KEY"]
    request.body = body.to_json

    response = http.request(request)
    unless response.is_a?(Net::HTTPSuccess)
      raise "Apollo API error #{response.code}: #{response.body.to_s.first(200)}"
    end

    JSON.parse(response.body)
  end
end
