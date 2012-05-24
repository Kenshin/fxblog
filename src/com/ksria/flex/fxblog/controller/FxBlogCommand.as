package com.ksria.flex.fxblog.controller 
{
	
	import com.ksria.flex.fxblog.model.FxBlogPM;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class FxBlogCommand
	{
		
		[Inject(id = "fxblogPM")]
		public var model : FxBlogPM;
		
		/**
		 * constructor
		 */
		public function FxBlogCommand() 
		{
			//TO DO
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * message handler selector is initZblog
		 */
		[MessageHandler(selector="initZblog")]
		public function initZblog() : void {
			model.initZblog4AS3();
		}
		
		/**
		 * message handler selector is compZblog
		 */
		[MessageHandler(selector="compZblog")]
		public function compZblog() : void {
			model.getHeadModuleUrl();
			model.getBodyModuleUrl();
		}
		
		/**
		 * message handler selector is compHead
		 */
		[MessageHandler(selector="compHead")]
		public function compHead() : void {
			trace("aaaaaaaaaaaaaaaaaaaaa")
			model.getNavBarModuleUrl();
		}
		
		/**
		 * message handler selector is compNavBar
		 */
		[MessageHandler(selector="compNavBar")]
		public function compNavBar() : void {
			trace("cccccccccccccccccccccc")
			model.getSideBarModuleUrl();
			//model.getFooterModuleUrl();
		}
		
		/**
		 * message handler selector is compFooter
		 */
		[MessageHandler(selector="compFooter")]
		public function compFooter() : void {
			trace("ddddddddddddddddddddddd")
			//model.getSideBarModuleUrl();
		}
		
		/**
		 * message handler selector is compSideBar
		 */
		[MessageHandler(selector="compSideBar")]
		public function compSideBar() : void {
			trace("eeeeeeeeeeeeeeeeeeeeeeee")
			model.getBottomModuleUrl();
			//model.getBottomModuleUrl();
		}
		
		/**
		 * message handler selector is compBottom
		 */
		[MessageHandler(selector="compBottom")]
		public function compBottom() : void {
			trace("ffffffffffffffffffffffff")
			model.getFooterModuleUrl();
			//model.getBodyModuleUrl();
		}
		
		/**
		 * message handler selector is compBody
		 */
		[MessageHandler(selector="compBody")]
		public function compBody() : void {
			trace("gggggggggggggggggggggggg")
		}
		
	}

}