class Admin::CategoriesController < ApplicationController
   def index
      @categories = Category.all
   end

   def create
   end
   
   def new
   end

end