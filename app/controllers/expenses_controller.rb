class ExpensesController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :contain_house?

  def index
    if params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end
    @expenses = @house.expenses.pending
  end

  def new
    @house = House.find(params[:house_id])
    @expense = @house.expenses.new( :description => params[:description] )
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id

    if @expense.save
      redirect_to house_expenses_path, :notice => "Expense added!"
    else
      render :new, :alert => "Can't add"
    end
  end

  def update
    @expense = Expense.find(params[:id])

    if @expense.update_attributes(expense_params)
      redirect_to house_expenses_path, :notice => "Expense updated"
    else
      render :edit, :alert => "Invalid request"
    end
    @expense.status = false
    @expense.save
  end

  def complete_task
    @house = House.find(params[:house_id])
    @expense = Expense.find(params[:expense_id])
    @expense.status = true
    @expense.save
    redirect_to house_expenses_path
  end

  def edit
    @expense = Expense.find(params[:id])
    @house = House.find(params[:house_id])
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to house_expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:description, :house_id, :user_id, :status, :amount, :roommates)
  end
end
