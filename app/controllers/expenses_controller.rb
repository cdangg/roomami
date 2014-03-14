class ExpensesController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :contain_house?
  before_filter :load_house, except: [:index, :destroy]

  def index
    if params[:house_id]
      @house = House.find(params[:house_id])
    else
      @house = current_user.houses.first
    end
    @expense = @house.expenses.new
    @expenses = @house.expenses.pending.order("expenses.created_at desc")
  end

  def new
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
      respond_to do |format|
        format.html { redirect_to house_expenses_path, :notice => "Expense updated" }
        format.json { render json: { house_id: @house.id, expense_id: @expense.id, user_name: current_user.first_name + " " + current_user.last_name, expense_name: @expense.description, amount: @expense.amount.round(2), roommates: @expense.roommates, split: @expense.split.round(2), created_at: @expense.updated_at } }
      end
      
    else
      render :edit, :alert => "Invalid request"
    end
    @expense.status = false
    @expense.save
  end

  def complete_task
    @expense = Expense.find(params[:expense_id])
    @expense.status = true
    @expense.save
    redirect_to house_expenses_path
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to house_expenses_path
  end

  private
  def load_house
    @house = House.find(params[:house_id])
  end

  def expense_params
    params.require(:expense).permit(:description, :house_id, :user_id, :status, :amount, :roommates)
  end
end
