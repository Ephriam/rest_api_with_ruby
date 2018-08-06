module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                
                if articles = Article.order('created_at DESC')
                    render json: {status: 'SUCCESS', message:'Loaded articles', data:articles}, status: :ok
                else
                    render json: {status: 'ERROR', message:'Could not find articles', data: article}, status: :unprocessable_entity
                end
            end
            def show
                
                if article = Article.find(params[:id])
                    render json: {status: 'SUCCESS', message:'Loaded article', data:article}, status: :ok
                else 
                    render json: {status: 'ERROR', message:'Could not find articles', data: article}, status: :unprocessable_entity
                end    
            end
            def create
                article = Article.new(article_params)
                if article.save
                    render json: {status: 'SUCCESS', message:'Saved article', data:article}, status: :ok
                else 
                    render json: {status: 'ERROR', message: 'Article Could not be saved!!',
                    data: article.errors}, status: :unprocessable_entity
                end
                #render json: {status: 'SUCCESS', message:'Loaded article', data:article}, status: :ok
            end
            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'SUCCESS', message:'Deleted article', data: article}, status: :ok
            end
            def  update
                article = Article.find(params[:id])
                if article.update_attributes(article_params)
                    render json: {status: 'SUCCESS', message:'Updated article', data: article}, status: :ok 
                else
                    render json: {status: 'ERROR', message:'Deleted failed', data: article}, status: :unprocessable_entity            
                end
            end

            private

            def article_params
                params.permit(:title, :body)
            end
        end    
    end
end