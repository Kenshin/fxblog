package com.ksria.flex.fxblog.view.navbar.view 
{	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayList;
	import mx.events.FlexEvent;

	import com.ksria.flex.fxblog.message.FxBlogMessage;	
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class NavBarBoxMediator extends NavBarBox 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		/*[Inject(id="navBarList")]
		public var navBarList : ArrayList;*/
		
		public function NavBarBoxMediator() 
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
			//dispatch nav bar complete message
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_NAVBAR ));
			
			//bind datagroup
			BindingUtils.bindProperty( datagroup, "dataProvider", model, "navBarList" );
			
			//add MouseEvent.CLICK event listener
			datagroup.addEventListener( MouseEvent.CLICK, function( event : MouseEvent ) : void {
				if ( event.target.name.substr( 0, 14 ) == "NavBarListItem" ) return;
				if ( event.target.name == "index" ) {
					dispatcher( new FxBlogMessage( FxBlogMessage.INDEX, null, event.target.name ));
				}
				else if ( event.target.name == "tagcloud" ) {
					dispatcher( new FxBlogMessage( FxBlogMessage.TAG_CLOUD, null, event.target.name ));
				}
				else if ( event.target.name == "listmap" ) {
					dispatcher( new FxBlogMessage( FxBlogMessage.LIST_MAP, null, event.target.name ));
				}
				else if ( event.target.name == "flex" ) {
					dispatcher( new FxBlogMessage( FxBlogMessage.TAG, null, event.target.name ));
				}
				else {
					navigateToURL( new URLRequest( event.target.name ), '_blank' );
				}
				
			});
		}
		
	}

}