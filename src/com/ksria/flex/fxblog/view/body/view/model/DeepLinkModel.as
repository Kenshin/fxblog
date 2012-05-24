package com.ksria.flex.fxblog.view.body.view.model 
{
	
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	import com.demonsters.debugger.MonsterDebugger;

	/**
	 * ...
	 * @author Kenshin
	 */
	public class DeepLinkModel 
	{
		[Inject(id = "service")]
		public var service : ServiceModel;
		
		public function DeepLinkModel() 
		{
			MonsterDebugger.initialize( this );
		}
		
		/**
		 * initialize SWFAddress
		 */
		public function initialize() : void {
			SWFAddress.addEventListener( SWFAddressEvent.EXTERNAL_CHANGE, urlChangeHandler );
		}
		
		/**
		 * set deep link
		 * @param	title
		 * @param	params
		 */
		public function setDeepLink( title : String, params : String ) : void {
			SWFAddress.setTitle( title );
			SWFAddress.setValue( params );
		}
		
		/**
		 * change event handler
		 */
		private function urlChangeHandler( event : SWFAddressEvent ) : void {
			MonsterDebugger.trace( this, event, "urlChangeHandler" );
			if ( event.value == "/" ) {
				service.getArticles( 1 );
			}
			else if ( event.parameters.mode == "articles" ) {
				service.getArticles( int( event.parameters.page ));
			}
			else if ( event.parameters.mode == "category" ) {
				service.getArticlesByCategory( int( event.parameters.page ), { id : event.parameters.categoryid, total : event.parameters.count } );
			}
			else if ( event.parameters.mode == "tag" ) {
				service.getArticlesByTag( int( event.parameters.page ), event.parameters.tag );
			}
			else if ( event.parameters.mode == "search" ) {
				service.getArticlesBySearch( int( event.parameters.page ), event.parameters.key );
			}
			else if ( event.parameters.mode == "date" ) {
				service.getArticlesByDate( int( event.parameters.page ), event.parameters.date );
			}
			else if ( event.parameters.mode == "tagcloud" ) {
				service.getTags();
			}
			else if ( event.parameters.mode == "title" ) {
				//暂时无法使用
				service.getArticlebyTitle( event.parameters.title );
			}
			else if ( event.parameters.mode == "listmap" ) {
				//暂时无法使用
			}
		}
		
	}

}