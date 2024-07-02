# frozen_string_literal: true

class LoanProfitCalculator
  extend Memoist

  PURCHASE_PRICE_LIMITING_FACTOR = 0.9
  ARV_LIMITING_FACTOR = 0.7

  COMPOUNDING_FACTOR = 1.010833333 # (1 + 0.13/12)

  def initialize(arv:, loan_term:, purchase_price:, repair_budget:)
    @arv = arv.to_f
    @loan_term = loan_term.to_f
    @purchase_price = purchase_price.to_f
    @repair_budget = repair_budget.to_f
  end

  memoize def loan_amount
    amount = (PURCHASE_PRICE_LIMITING_FACTOR * purchase_price) + repair_budget

    [amount, arv * ARV_LIMITING_FACTOR].min
  end

  memoize def estimated_profit
    arv - total_interest - purchase_price - repair_budget
  end

  memoize def total_interest
    total_expense - loan_amount
  end

  memoize def return_rate
    100.00 * estimated_profit / (arv - estimated_profit)
  end

  def trigger_email(**args)
    UserMailer.term_sheet_email(
      **args, loan_amount:, estimated_profit:, total_interest:, return_rate:
    ).deliver_later
  end

  private

  attr_reader :purchase_price, :arv, :repair_budget, :loan_term

  memoize def total_expense
    loan_amount * (COMPOUNDING_FACTOR**loan_term)
  end
end
