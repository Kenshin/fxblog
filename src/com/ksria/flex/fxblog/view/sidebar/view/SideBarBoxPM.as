package com.ksria.flex.fxblog.view.sidebar.view
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.ksria.as3.zblog.Zblog;
	import com.ksria.as3.zblog.event.ZblogEvent;
	import com.ksria.as3.zblog.method.GetArchives;
	import com.ksria.as3.zblog.method.GetNewArticles;
	import com.ksria.as3.zblog.vo.ErrorVO;
	
	import com.ksria.flex.fxblog.view.sidebar.view.model.SideBarModel;
	
	[Bindable]
	public class SideBarBoxPM extends EventDispatcher
	{
		
		/*
		[Inject(id="noticeVars")]
		public var noticeVars : Object;
		*/
		
		[Inject(id="aboutVars")]
		public var aboutVars : Object;
		
		[Inject(id="mybookVars")]
		public var mybookVars : Object;
		
		[Inject(id="weiboVars")]
		public var weiboVars : Object;
		
		[Inject(id="subscribeVars")]
		public var subscribeVars : Object;
		
		[Inject(id="mobileVars")]
		public var mobileVars : Object;
		
		[Inject(id="recommendVars")]
		public var recommendVars : Object;
		
		[Inject(id="newArticlesVars")]
		public var newArticlesVars : Object;
		
		[Inject(id="archivesVars")]
		public var archivesVars : Object;
		
		[Inject(id="model")]
		public var sideBarModel : SideBarModel;
		
		public function SideBarBoxPM( target : IEventDispatcher = null ) { super( target ); }
		
		[Init]
		public function inits() : void {
			getNewArticles();
			getArchives();
		}
		
		/**
		 * get new articles use zblog api for as3
		 */
		private function getNewArticles() : void {
			var zb : GetNewArticles = new GetNewArticles();
			zb.count = 10;
			zb.execute();
			zb.addEventListener( ZblogEvent.FAULT, faultHandler );
			zb.addEventListener( ZblogEvent.SUCCESS, function( event : ZblogEvent ) : void {
				sideBarModel.newArticles = event.target.resultObject.articleList;
			});
		}
		
		/**
		 * get new archives use zblog api for as3
		 */
		private function getArchives() : void {
			var zb : GetArchives = new GetArchives();
			zb.execute();
			zb.addEventListener( ZblogEvent.FAULT, faultHandler );
			zb.addEventListener( ZblogEvent.SUCCESS, function( event : ZblogEvent ) : void {
				sideBarModel.archives = event.target.resultObject.archivesList;
			});
		}
		
		/**
		 * fault event handler
		 */
		private function faultHandler( event : ZblogEvent ) : void {
			var err : ErrorVO =  event.target.resultFaultObject as ErrorVO;
			trace( "eror api777" )
		}
	}
}