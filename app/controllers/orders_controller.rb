class OrdersController < ApplicationController
  def search
    chains = []
    limit = 100 # default

    # 条件はandでつながれる
    params.each do |e|
      method_name, param = e[0], e[1]

      if method_name == "limit"
        limit = param
      elsif method_name =~ /^find/
        # sendで呼ばれる各メソッドは
        # チェーンメソッド用の文字列を返す
        chains << send("#{method_name}", param)
      end
    end

    # chainsを全て結合する
    methods = chains.join(".")
    # チェーンメソッドを全て実行
    @orders = eval "Order.#{methods}.limit(#{limit}).order(:orderDateTime)"

    render "search", :formats => [:json], :handlers => [:jbuilder], status: 200
  end

  private

  # 指定された日時以降
  def findByOrderDateTimeGTE(param)
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
    "where(\"orderQuantity >= ?\", #{params})"
  end

  # orderQuantityが指定された値以下のもののみ返す
  def findByOrderQuantityLTE(param)
    "where(\"orderQuantity <= ?\", #{params})"
  end

  # orderStateが文字列として完全一致で指定されたもののみ返す
  def findByOrderState(param)
    "where(orderState: '#{param}')"
  end

  # 指定されたタグが全て含まれる注文情報のみ返す
  def findByOrderTagsIncludeAll(param)
  end

  # 指定されたタグがひとつでも含まれる注文情報のみ返す
  def findByOrderTagsIncludeAny(param)
    ActiveRecord::Base.connection.select_all(query)
  end


  ##
  # findByUser
  
  # userCompanyが文字列として完全一致で指定された顧客の注文情報
  def findByUserCompany(param)
  end

  # userDiscountRateが指定された値以上の顧客の注文情報のみ返す
  def findByUserDiscountRateGTE(param)
  end

  # userDiscountRateが指定された値以下の顧客の注文情報のみ返す
  def findByUserDiscountRateLTE(param)
  end


  ##
  # findByItem

  # itemSupplierが文字列として完全一致で指定された商品の注文情報のみ返す
  def findByItemSupplier(param)
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
