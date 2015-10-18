class OrdersController < ApplicationController
  def search
    chains = []
    limit = 100
    @base_flag = 0

    params.each do |e|
      method_name, param = e[0], e[1]
      if method_name == "limit"
        limit = param
      elsif method_name =~ /^find/
        chains << send("#{method_name}", param)
      end
    end

    chained_methods = chains.join(".")
    if chained_methods.empty?
      @orders = []
    elsif @base_flag == 1
      chains_data = []
      chains_data = chains.flatten.uniq.sort{|a, b| a[1] <=> b[1]}
      @orders = [ chains_data[0, limit] ]
    else
      @orders = eval "Order.#{chained_methods}.order(:orderDateTime).limit(#{limit})"
    end
    render "search", :formats => [:json], :handlers => [:jbuilder], status: 200
  end

  private

  # 指定された日時以降
  eef findByOrderDateTimeGTE(param)
    # NOTE: データはorderDateTime順 
    # => ひとつ境界線がわかればあとは計算しなくてもわかる
    "where(\"orderDateTime > ?\", #{param})"
  end

  # 指定された日時以前
  def findByOrderDateTimeLTE(param)
    "where(\"orderDateTime < ?\", #{param})"
  end
  
  # orderUserIdが指定されたもののみ
  def findByOrderUserId(param)
    "where(orderUserId: '#{param}')"
  end
  
  # orderItemIdが指定されたもののみ
  def findByOrderItemId(param)
    "where(orderItemId: '#{param}')"
  end

  #  orderQuantityが指定された値以上のもののみ返す
  def findByOrderQuantityGTE(param)
    "where('orderQuantity >= ?', #{param})"
  end

  # orderQuantityが指定された値以下のもののみ返す
  def findByOrderQuantityLTE(param)
    "where(\"orderQuantity <= ?\", #{param})"
  end

  # orderStateが文字列として完全一致で指定されたもののみ返す
  def findByOrderState(param)
    "where(orderState: '#{param}')"
  end

  # TODO: 指定されたタグが全て含まれる注文情報のみ返す
  def findByOrderTagsIncludeAll(param)
    @base_flag = 1
    finds = []
    param.split(",").each do |p|
      finds << "FIND_IN_SET('#{p}', orderTags)"
    end
    cond = finds.join(" AND ")
    query = "SELECT * FROM orders WHERE #{cond} ORDER BY orderDateTime;"
    ActiveRecord::Base.connection.select_all(query).rows
  end

  # TODO: 指定されたタグがひとつでも含まれる注文情報のみ返す
  def findByOrderTagsIncludeAny(param)
    @base_flag = 1
    query = "SELECT * FROM orders WHERE FIND_IN_SET(orderTags, '#{param}') ORDER BY orderDateTime;"
    ActiveRecord::Base.connection.select_all(query).rows
  end


  ##
  # findByUser
  
  # return all user id conditions array
  def userIdConditions(users)
    conditions = []
    users.pluck(:userId).each do |userId|
      conditions << "orderUserId = \"#{userId}\""
    end
    conditions
  end
  
  # userCompanyが文字列として完全一致で指定された顧客の注文情報
  def findByUserCompany(param)
    users = User.where(userCompany: param)
    conditions = userIdConditions(users)
    "where('" << conditions.join(" or ") << "')" unless conditions.empty?
  end

  # FIXME: userDiscountRateが指定された値以上の顧客の注文情報のみ返す
  def findByUserDiscountRateGTE(param)
    @base_flag = 1
    "SELECT * FROM users WHERE userDiscountRate >= id"
    users = User.where("userDiscountRate >= ?", param)
    conditions = userIdConditions(users)
    "where('" << conditions.join(" or ") << "')" unless conditions.empty?
  end

  # FIXME: userDiscountRateが指定された値以下の顧客の注文情報のみ返す
  def findByUserDiscountRateLTE(param)
    users = User.where("userDiscountRate <= ?", param)
    conditions = userIdConditions(users)
    "where('" << conditions.join(" or ") << "')" unless conditions.empty?
  end



  ##
  # findByItem

  # itemSupplierが文字列として完全一致で指定された商品の注文情報のみ返す
  def findByItemSupplier(param)
    items = Item.where(itemSupplier: param)
    conditions = userIdConditions(items)
    "where('" << conditions.join(" or ") << "')" unless conditions.empty?
  end

  # itemStockQuantityが指定された値以上の商品の注文情報のみ返す
  def findByItemStockQuantityGTE(param)
  end

  # itemStockQuantityが指定された値以下の商品の注文情報
  def findByItemStockQuantityLTE(param)
  end

  # itemBasePriceが指定された値以上の商品の注文情報のみ返す
  def findByItemBasePriceGTE(param)
  end

  # itemBasePriceが指定された値以下の商品の注文情報の見返す
  def findByItemBasePriceLTE(param)
  end

  # 指定されたタグが全て含まれる商品の注文情報のみ返す
  def findByItemTagsIncludeAll(param)
  end

  # 指定されたタグがひとつでも含まれている
  def findByItemTagsIncludeAny(param)
  end
end
