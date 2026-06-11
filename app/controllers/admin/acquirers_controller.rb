# Admin CRUD for the acquirer network (the `Buyer` model). This makes the
# buyer list hand-curated, real data you own — the seed is only a starter set.
class Admin::AcquirersController < Admin::BaseController
  before_action :set_acquirer, only: %i[edit update destroy]

  def index
    @acquirers = Buyer.order(:name)
  end

  def new
    @acquirer = Buyer.new(active: true, acquisitions_count: 0)
  end

  def create
    @acquirer = Buyer.new(acquirer_params)
    if @acquirer.save
      redirect_to admin_acquirers_path, notice: "Acquirer added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @acquirer.update(acquirer_params)
      redirect_to admin_acquirers_path, notice: "Acquirer updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @acquirer.destroy
    redirect_to admin_acquirers_path, notice: "Acquirer removed."
  end

  private

  def set_acquirer
    @acquirer = Buyer.find(params[:id])
  end

  def acquirer_params
    params.require(:buyer).permit(
      :name, :buyer_type, :backed_by, :thesis, :website,
      :min_revenue, :max_revenue, :acquisitions_count, :active, :source, :source_url,
      sectors: []
    )
  end
end
