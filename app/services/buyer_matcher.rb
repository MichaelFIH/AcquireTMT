# Buyer-universe engine for TMT businesses, backed by the seeded Buyer dataset.
#
# Given a sector + revenue, it pulls the real, active acquirers that operate in
# that sector and pursue that size (Buyer rows, sourced from 2025 M&A reporting
# — see db/seeds.rb), groups them by buyer type, and surfaces the named buyers
# with their acquisition thesis. Output keys are kept stable for the find-buyers
# front-end; provenance (as_of / sources / market_activity) is added on top.
class BuyerMatcher
  # Sourced sector M&A deal volume, for honest market-activity context where we
  # have a citable figure.
  SECTOR_ACTIVITY = {
    "msp-it-services" => "466 MSP/MSSP deals closed in 2025 (Solganick).",
    "cybersecurity"   => "426 cybersecurity M&A deals were announced in 2025 (SecurityWeek)."
  }.freeze

  def initialize(industry:, revenue:)
    @industry = ValuationData.sector_slug(industry)
    @revenue  = revenue.to_f
  end

  def call
    buyers = Buyer.matching(@industry, @revenue)
    sector_name = ValuationData.sector(@industry)["name"]

    {
      "industry"               => @industry,
      "industry_name"          => sector_name,
      "buyer_count"            => buyers.size,
      "acquisitions_last_year" => buyers.sum(&:acquisitions_count),
      "market_activity"        => SECTOR_ACTIVITY[@industry],
      "categories"             => categories(buyers),
      "buyers"                 => buyers.first(6).map { |b| buyer_for(b) },
      "sources"                => buyers.map { |b| { "name" => b.source, "url" => b.source_url } }
                                        .reject { |s| s["name"].blank? }.uniq { |s| s["name"] },
      "as_of"                  => "2025"
    }
  end

  private

  def categories(buyers)
    buyers.group_by(&:buyer_type).map do |type, group|
      { "label" => Buyer::TYPE_LABELS[type] || type, "count" => group.size }
    end
  end

  def buyer_for(buyer)
    {
      "name"         => buyer.name,
      "backed_by"    => buyer.backed_by,
      "rationale"    => buyer.thesis,
      "type_label"   => buyer.type_label,
      "acquisitions" => buyer.acquisitions_count
    }
  end
end
