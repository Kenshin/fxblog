package com.ksria.flex.fxblog.model 
{
	import com.ksria.as3.zblog.Zblog;
	
	import com.ksria.flex.fxblog.message.FxBlogMessage;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class FxBlogPM 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		[Inject(id="moduleUrls")]
		public var moduleUrls : Array;
		
		[Inject(id="zblogVars")]
		public var zblogVars : Object;
		
		public function FxBlogPM() {}
		
		/**
		 * init zblog for as3 lib
		 */
		public function initZblog4AS3() : void {
			
			Zblog.URI      = zblogVars.uri;
			Zblog.username = zblogVars.username;
			Zblog.password = zblogVars.password;
			
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_ZBLOG ));
		}
		
		/**
		 * get head module urls
		 */
		public function getHeadModuleUrl() : void {
			dispatcher( new FxBlogMessage( FxBlogMessage.INIT_HEAD, moduleUrls[0] ));
		}
		
		/**
		 * get navbar module urls
		 */
		public function getNavBarModuleUrl() : void {
			dispatcher( new FxBlogMessage( FxBlogMessage.INIT_NAVBAR, moduleUrls[1] ));
		}
		
		/**
		 * get footer module urls
		 */
		public function getFooterModuleUrl() : void {
			dispatcher( new FxBlogMessage( FxBlogMessage.INIT_FOOTER, moduleUrls[2] ));
		}
		
		/**
		 * get sidebar module urls
		 */
		public function getSideBarModuleUrl() : void {
			dispatcher( new FxBlogMessage( FxBlogMessage.INIT_SIDEBAR, moduleUrls[3] ));
		}
		
		/**
		 * get bottom module urls
		 */
		public function getBottomModuleUrl() : void {
			dispatcher( new FxBlogMessage( FxBlogMessage.INIT_BOTTOM, moduleUrls[4] ));
		}
		
		/**
		 * get body module urls
		 */
		public function getBodyModuleUrl() : void {
			dispatcher( new FxBlogMessage( FxBlogMessage.INIT_BODY, moduleUrls[5] ));
		}
		
	}

}