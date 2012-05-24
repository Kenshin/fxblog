package com.ksria.flex.fxblog.view.sidebar.view 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	
	import spark.components.DataGroup;

	import com.ksria.flex.fxblog.message.FxBlogMessage;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class SideBarBoxMediator extends SideBarBox 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		public function SideBarBoxMediator() 
		{
			super();
			
			//add ADDED_TO_STAGE listener
			addEventListener( Event.ADDED_TO_STAGE, function() : void {
				dispatchEvent( new Event( 'configureIOC', true ));
			});
			
			//add CREATION_COMPLETE listener
			addEventListener(FlexEvent.CREATION_COMPLETE, createEventHandler );

		}
		
		/**
		 * create complete event handler
		 */
		private function createEventHandler( event : FlexEvent ) : void {
			
			//value bind
			valueBind();
			
			//dispatch COMP_SIDEBAR message
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_SIDEBAR ));
			
			/*
			//about mouse event handler
			about.txtAbout.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				navigateToURL( new URLRequest( event.target.name ), '_blank' );
			});
			*/
			
			//mybook.imgMyBook mouse event handler
			mybook.imgMyBook.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				navigateToURL( new URLRequest( event.currentTarget.name ), '_blank' );
			});
			
			//subscribe.imgSubscribe mouse event handler
			weibo.imgSina.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				navigateToURL( new URLRequest( event.currentTarget.name ), '_blank' );
			});
			
			//subscribe.imgSubscribe mouse event handler
			weibo.imgTencent.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				navigateToURL( new URLRequest( event.currentTarget.name ), '_blank' );
			});
			
			//subscribe.imgSubscribe mouse event handler
			subscribe.imgSubscribe.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				navigateToURL( new URLRequest( event.currentTarget.name ), '_blank' );
			});
			
			//mobile.imgMobile mouse event handler
			mobile.imgMobile.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				navigateToURL( new URLRequest( event.currentTarget.name ), '_blank' );
			});
			
			//recommendList mouse event handler
			recommend.recommendList.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target is DataGroup ) return;
				if ( event.target.defaultLabelData.type == "link" ) {
					navigateToURL( new URLRequest( event.target.defaultLabelData.url ), '_blank' );
					return;
				}
				dispatcher( new FxBlogMessage( event.target.defaultLabelData.type, null, event.target.defaultLabelData.url ));
			});
			
			//newArticlesList mouse event handler
			newArticles.newArticlesList.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target is DataGroup ) return;
				dispatcher( new FxBlogMessage( FxBlogMessage.TITLE, null, event.target.defaultLabelData.url ));
			});
			
			//archivesList mouse event handler
			archives.archivesList.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target is DataGroup ) return;
				dispatcher( new FxBlogMessage( FxBlogMessage.DATE, null, event.target.defaultLabelData.url ));
			});
		}
		
		/**
		 * value bind
		 */
		private function valueBind() : void {
			/*
			//bind lblNotice & txtNotice
			BindingUtils.bindProperty( notice.lblNotice, "label", model.noticeVars, "label" );
			BindingUtils.bindProperty( notice.txtNotice, "content", model.noticeVars, "notice" );
			*/
			
			//bind lblAbout & txtAbout
			BindingUtils.bindProperty( about.lblAbout, "label", model.aboutVars, "label" );
			//BindingUtils.bindProperty( about.txtAbout, "name", model.aboutVars, "String" );
			
			//bind lblMyBook & imgMyBook
			BindingUtils.bindProperty( mybook.lblMyBook, "label", model.mybookVars, "label" );
			BindingUtils.bindProperty( mybook.imgMyBook, "name", model.mybookVars, "String" );
			
			//bind lblWeibo & imgSina & imgTencent
			BindingUtils.bindProperty( weibo.lblWeibo, "label", model.weiboVars, "label" );
			BindingUtils.bindProperty( weibo.imgSina, "name", model.weiboVars, "sina" );
			BindingUtils.bindProperty( weibo.imgTencent, "name", model.weiboVars, "tencent" );
			
			//bind lblSubscribe
			BindingUtils.bindProperty( subscribe.lblSubscribe, "label", model.subscribeVars, "label" );
			BindingUtils.bindProperty( subscribe.imgSubscribe, "name", model.subscribeVars, "String" );
			
			//bind lblMobile
			BindingUtils.bindProperty( mobile.lblMobile, "label", model.mobileVars, "label" );
			BindingUtils.bindProperty( mobile.imgMobile, "name", model.mobileVars, "String" );
			
			//bind lblRecommend & recommendList
			BindingUtils.bindProperty( recommend.lblRecommend, "label", model.recommendVars, "label" );
			BindingUtils.bindProperty( recommend.recommendList, "dataProvider", model.recommendVars, "recommendList" );
			
			//bind lblNewArticles & newArticlesList
			BindingUtils.bindProperty( newArticles.lblNewArticles, "label", model.newArticlesVars, "label" );
			BindingUtils.bindProperty( newArticles.newArticlesList, "dataProvider", model.sideBarModel, "newArticles" );
			
			//bind lblNewArticles & archivesList
			BindingUtils.bindProperty( archives.lblArchives, "label", model.archivesVars, "label" );
			BindingUtils.bindProperty( archives.archivesList, "dataProvider", model.sideBarModel, "archives" );
		}
	}

}