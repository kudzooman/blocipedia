class WikisController < ApplicationController
  respond_to :html, :js

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    if request.path != wiki_path(@wiki)
      redirect_to @wiki, status: :moved_permanently
    end
  end

  def new
    @wiki = Wiki.new
    @users = User.all
    @collaborator = Collaborator.new
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @users = User.all - [current_user, @wiki.user]
    @collaborator = Collaborator.new
  end

  def update
     @wiki = Wiki.friendly.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end


  def destroy
    @wiki = Wiki.friendly.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki was removed."
    else
      flash[:error] = "Wiki couldn't be deleted. Try again."
    end

    respond_with(@wiki) do |f|
      f.html { redirect_to [@wiki] }
    end
  end

  def create
     @wiki = Wiki.new(wiki_params)
     @wiki.user = current_user

    if @wiki.save!
      redirect_to @wiki, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :public)
  end
end
