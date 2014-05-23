class WikisController < ApplicationController
  respond_to :html, :js

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @users = User.all
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    @collaborator = Collaborator.new
    # @users = @users without current_user and wiki owner
  end

  def update
     @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "Error saving wiki. Please try again."
      render :edit
    end
  end


  def destroy
    @wiki = Wiki.find(params[:id])

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
    @wiki = current_user.wikis.build(wiki_params)

    if @wiki.save
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
