module Spree
  class ProductViewsToCartAdditionsReport < Spree::Report
    HEADERS = [:product_name, :views, :cart_additions]

    def self.generate(options = {})
      cart_additions = SpreeReportify::ReportDb[:spree_cart_events___cart_events].
      join(:spree_variants___variants, id: :variant_id).
      join(:spree_products___products, id: :product_id).
      where(cart_events__activity: 'add').
      group(:product_name).
      select{[(
        :products__name___product_name),
        Sequel.as(sum(cart_events__quantity), :cart_additions)
      ]}.as(:cart_additions)


      total_views_results = ::SpreeReportify::ReportDb[:spree_products___products].
      join(:spree_page_events___page_events, target_id: :id).
      where(page_events__target_type: 'Spree::Product', page_events__activity: 'view').
      group(:product_name).
      select{[
        products__name.as(product_name),
        count('*').as(views),
      ]}

      ::SpreeReportify::ReportDb[total_views_results].
      join(cart_additions, product_name: :product_name).
      select{[
        cart_additions__product_name,
        views,
        cart_additions__cart_additions
      ]}
    end
  end
end
