class Admin::DealDocumentsController < Admin::BaseController
  before_action :set_deal

  def create
    document = @deal.deal_documents.new(document_params)
    if document.save
      redirect_to edit_admin_deal_path(@deal), notice: "Document added."
    else
      redirect_to edit_admin_deal_path(@deal), alert: document.errors.full_messages.to_sentence
    end
  end

  def destroy
    @deal.deal_documents.find(params[:id]).destroy
    redirect_to edit_admin_deal_path(@deal), notice: "Document removed."
  end

  private

  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def document_params
    params.require(:deal_document).permit(:title, :file)
  end
end
