module SpreeAdminInsights
  module UserDecorator
    def self.prepended(base)
      base.has_many :spree_orders, class_name: 'Spree::Order'
    end
  end
end

::Spree.user_class.prepend(::SpreeAdminInsights::UserDecorator)
