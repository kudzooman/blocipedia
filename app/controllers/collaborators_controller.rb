class CollaboratorsController < ApplicationController

  respond_to :html, :js

  def create
    @wiki = Wiki.find(params[:wiki_id])

    @collaborator = @wiki.collaborators.build(collaborator_params)
  

    if @collaborator.save
      flash[:notice] = "Collaborator was added."
    else
      flash[:error] = "There was an error saving your collaborator. Please try again."
    end

    respond_with(@collaborator) do |f|
      f.html { redirect_to edit_wiki_path(@wiki) }
    end
  end

    def destroy
    @wiki = Wiki.find(params[:wiki_id])  

    @collaborator = @wiki.collaborators.find(params[:id])

   
   

    if @collaborator.destroy
      flash[:notice] = "Item was removed."
    else
      flash[:error] = "Item couldn't be deleted. Try again."
    end

    respond_with(@collaborator) do |f|
      f.html { redirect_to edit_wiki_path(@wiki) }
    end
  end

   private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end