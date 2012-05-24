package com.ksria.flex.fxblog.view.body.view 
{
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	import mx.binding.utils.BindingUtils;
	
	import com.ksria.flex.pagination.event.PaginationEvent;
	
	import com.ksria.flex.fxblog.message.FxBlogMessage;
	import com.ksria.flex.fxblog.view.body.view.event.BodyEvent;
	import com.ksria.flex.fxblog.view.body.view.view.Pagination;
	
	import com.demonsters.debugger.MonsterDebugger;
		
	/**
	 * ...
	 * @author Kenshin
	 */
	public class BodyBoxMediator extends BodyBox 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		private var page : Pagination;
		
		public function BodyBoxMediator() 
		{
			super();
			
			MonsterDebugger.initialize( this );
			
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
			
			//dispatch COMP_HEAD message
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_BODY ));
			
			//bind values
			bindValues();
			
			//listener events
			listenerEvents();
			
		}
		
		/**
		 * bind values
		 * @private
		 */
		private function bindValues() : void {
			BindingUtils.bindProperty( articlesList,  "dataProvider", model, "articleList" );
			BindingUtils.bindProperty( tagCloud,      "dataProvider", model, "tagsList" );
			BindingUtils.bindProperty( listMap,       "dataProvider", model, "allArticleList" );
			BindingUtils.bindProperty( articleDetail, "data"        , model, "articleDetail" );
		}
		
		/**
		 * listen event
		 * 
		 * @private
		 */
		private function listenerEvents() :void {
			
			//bar complete event handler
			bar.addEventListener( Event.COMPLETE, function() : void {
				vs.selectedIndex = 1;
			});
		}
		
		/**
		 * message handler selector is search
		 */
		[MessageHandler(selector="progress")]
		public function progress( event : BodyEvent ) : void {
			if ( vs.selectedIndex != 0 ) vs.selectedIndex = 0;
			bar.label = "文章内容加载中：" + Math.round( event.args.bytesLoaded / event.args.bytesTotal * 100 ) + "%";
			bar.setProgress( event.args.bytesLoaded, event.args.bytesTotal );
		}
		
		/**
		 * message handler selector is createPagination
		 */
		[MessageHandler(selector="createPagination")]
		public function createPagination( event : BodyEvent ) : void {
			
			MonsterDebugger.trace( this, event, "createPagination" )
			
			//remove elements
			paginationGroup.removeAllElements();
			
			//create pagination
			page = new Pagination();
			page.total = event.args.total;
			page.page  = event.args.page;
			
			if ( event.args.currentState == "category" ) {
				page.data = { categoryid : event.args.categoryid };
			}
			else if ( event.args.currentState == "tag" ) {
				page.data = { tag : event.args.tag };
			}
			else if ( event.args.currentState == "search" ) {
				page.data = { key : event.args.key };
			}
			else if ( event.args.currentState == "date" ) {
				page.data = { date : event.args.date };
			}
				
			//add PAGE_TURNING event
			page.addEventListener( PaginationEvent.PAGE_TURNING, function( event : PaginationEvent ) : void {
				
				if ( vs.selectedIndex != 0 ) vs.selectedIndex = 0;
					
				switch ( model.currentSate ) {
					case "articles" : 
						service.getArticles( event.page );
						break;
					case "category" : 
						service.getArticlesByCategory( event.page, { id : page.data.categoryid, total : page.total });
						break;
					case "tag" : 
						service.getArticlesByTag( event.page, page.data.tag );
						break;
					case "search" : 
						service.getArticlesBySearch( event.page, page.data.key );
						break;
					case "date" : 
						service.getArticlesByDate( event.page, page.data.date );
						break;
				}
				
			});
			paginationGroup.addElement( page );
			
			if ( vs.selectedIndex != 1 ) vs.selectedIndex = 1;
		}
		
		/**
		 * message handler selector is tagCloudLayout
		 */
		[MessageHandler(selector="tagCloudLayout")]
		public function tagCloudLayout( event : BodyEvent ) : void {
			if ( vs.selectedIndex != 2 ) vs.selectedIndex = 2;
		}
		
		/**
		 * message handler selector is listMapLayout
		 */
		[MessageHandler(selector="listMapLayout")]
		public function listMapLayout( event : BodyEvent ) : void {
			if ( vs.selectedIndex != 3 ) vs.selectedIndex = 3;
		}
		
		/**
		 * message handler selector is articleDetailLayout
		 */
		[MessageHandler(selector="articleDetailLayout")]
		public function articleDetailLayout( event : BodyEvent ) : void {
			if ( vs.selectedIndex != 4 ) vs.selectedIndex = 4;
		}
		
	}

}