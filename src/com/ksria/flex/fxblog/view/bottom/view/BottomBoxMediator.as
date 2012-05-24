package com.ksria.flex.fxblog.view.bottom.view 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	
	import spark.components.DataGroup;
	
	import com.ksria.flex.fxblog.message.FxBlogMessage;
		
	/**
	 * ...
	 * @author Kenshin
	 */
	public class BottomBoxMediator extends BottomBox 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		public function BottomBoxMediator() 
		{
			super();
			
			//add ADDED_TO_STAGE listener
			addEventListener( Event.ADDED_TO_STAGE, function() : void {
				dispatchEvent( new Event( 'configureIOC', true ));
			});
			
			//add CREATION_COMPLETE listener
			addEventListener( FlexEvent.CREATION_COMPLETE, createEventHandler );
			
		}
		
		/**
		 * create complete event handler
		 */
		private function createEventHandler( event : FlexEvent ) : void {
			
			valueBind();
			
			//dispatch COMP_BOTTOM message
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_BOTTOM ));
			
			//categroyList mouse event handler
			category.categroyList.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target is DataGroup ) return;
				dispatcher( new FxBlogMessage( event.target.defaultLabelData.type, null, { id : event.target.defaultLabelData.url, total : event.target.defaultLabelData.total }));
			});
			
			//randomArticlesList mouse event handler
			randomArticles.randomArticlesList.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target is DataGroup ) return;
				dispatcher( new FxBlogMessage( event.target.defaultLabelData.type, null, event.target.defaultLabelData.url ));
			});
			
			//topArticlesList mouse event handler
			topArticles.topArticlesList.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target is DataGroup ) return;
				dispatcher( new FxBlogMessage( event.target.defaultLabelData.type, null, event.target.defaultLabelData.url ));
			});
		}
		
		/**
		 * value bind
		 */
		private function valueBind() : void {
			//bind lblCategory & categroyList
			BindingUtils.bindProperty( category.lblCategory, "text", model.categroyVars, "label" );
			BindingUtils.bindProperty( category.categroyList, "dataProvider", model.bottomModel, "categoryList" );
			
			//bind lblCategory & categroyList
			BindingUtils.bindProperty( randomArticles.lblRandomArticles, "text", model.randomArticlesVars, "label" );
			BindingUtils.bindProperty( randomArticles.randomArticlesList, "dataProvider", model.randomArticlesVars, "randomArticlesList" );
			
			//bind lblCategory & categroyList
			BindingUtils.bindProperty( topArticles.lblTopArticles, "text", model.topArticlesVars, "label" );
			BindingUtils.bindProperty( topArticles.topArticlesList, "dataProvider", model.topArticlesVars, "topArticlesList" );
			
		}
		
	}

}