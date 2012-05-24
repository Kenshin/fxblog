package com.ksria.flex.fxblog.view.bottom.view
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.ksria.as3.zblog.Zblog;
	import com.ksria.as3.zblog.event.ZblogEvent;
	import com.ksria.as3.zblog.method.GetCategorys;
	import com.ksria.as3.zblog.vo.ErrorVO;

	import com.ksria.flex.fxblog.view.bottom.view.model.BottomModel;

	[Bindable]
	public class BottomBoxPM extends EventDispatcher
	{
		
		[Inject(id="categroyVars")]
		public var categroyVars : Object;
		
		[Inject(id="randomArticlesVars")]
		public var randomArticlesVars : Object;
		
		[Inject(id="topArticlesVars")]
		public var topArticlesVars : Object;
		
		[Inject(id="model")]
		public var bottomModel : BottomModel;
		
		public function BottomBoxPM( target : IEventDispatcher = null ) { super( target ); }
		
		[Init]
		public function inits() : void {
			getCategorys();
		}
		
		/**
		 * get getCategorys use zblog api for as3
		 */
		private function getCategorys() : void {
			var zb : GetCategorys = new GetCategorys();
			zb.execute();
			zb.addEventListener( ZblogEvent.FAULT, faultHandler );
			zb.addEventListener( ZblogEvent.SUCCESS, function( event : ZblogEvent ) : void {
				bottomModel.categoryList = event.target.resultObject.categoryList;
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