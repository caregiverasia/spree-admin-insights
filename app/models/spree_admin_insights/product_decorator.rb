module SpreeAdminInsights
  module ProductDecorator
    def self.prepended(base)
      base.has_many :page_view_events, -> { viewed }, class_name: 'Spree::PageEvent', foreign_key: :target_id
    end
  end
end

::Spree::Product.prepend(::SpreeAdminInsights::ProductDecorator)
