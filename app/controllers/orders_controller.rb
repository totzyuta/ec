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

    json = eval "Order.#{methods}.limit(#{limit})"
    render json: json, status: 200
  end

  private

  # 指定された日時以降
  def findByOrderDateTimeGTE(param)
    # NOTE: データはorderDateTime順 
    # => ひとつ境界線がわかればあとは計算しなくてもわかる
    "where('orderDateTime > #{param}')"
  end

  # 指定された日時以前
  def findByOrderDateTimeLTE(param)
    "where(\"orderDateTime > ?\", #{param})"
  end
  
  # orderUserIdが指定されたもののみ
  def findByOrderUserId(param)
    "where(orderUserId: #{param})"
  end
  
  # orderItemIdが指定されたもののみ
  def findByOrderItemId(param)
    "where(orderItemId: #{param})"
  end

  #  orderQuantityが指定された値以上のもののみ返す
  def findByOrderQuantityGTE(param)
  end

  # orderQuantityが指定された値以下のもののみ返す
  def findByOrderQuantityLTE(param)
  end

  # orderStateが文字列として完全一致で指定されたもののみ返す
  def findByOrderState(param)
  end

  # 指定されたタグが全て含まれる注文情報のみ返す
  def findByOrderTagsIncludeAll(param)
  end

  def findByOrderTagsIncludeAny(param)
  end
end
