# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def index; end

  def create
    calculator = LoanProfitCalculator.new(**calculator_args)

    calculator.trigger_email(**calculation_params)

    flash[:notice] =
      "Request submitted successfully, please keep an eye on your email for term sheet. \
       Estimated profit: #{calculator.estimated_profit}, Return rate: #{calculator.return_rate}%"

    redirect_to root_path
  end

  private

  def calculator_args
    calculation_params.slice(:arv, :loan_term, :purchase_price, :repair_budget).symbolize_keys
  end

  def calculation_params
    params.permit(:address, :name, :email, :phone, :loan_term, :arv, :repair_budget, :purchase_price)
          .to_h.symbolize_keys
  end
end
