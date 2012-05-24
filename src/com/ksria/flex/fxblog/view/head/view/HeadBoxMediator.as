package com.ksria.flex.fxblog.view.head.view 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	import mx.binding.utils.BindingUtils;
	import mx.events.FlexEvent;
	
	import com.ksria.flex.fxblog.message.FxBlogMessage;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class HeadBoxMediator extends HeadBox 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		public function HeadBoxMediator() 
		{
			super();
			
			//add ADDED_TO_STAGE listener
			addEventListener( Event.ADDED_TO_STAGE, function() : void {
				dispatchEvent( new Event( 'configureIOC', true ));
			});
			
			//add CREATION_COMPLETE listener
			addEventListener(FlexEvent.CREATION_COMPLETE, createEventHandler );
			
			//imgGithub mouse click event listener
			imgGithub.addEventListener( MouseEvent.CLICK, function( events : MouseEvent ) : void {
				navigateToURL( new URLRequest( events.currentTarget.name ), "_blank" );
			});
			
			//add ENTER listener
			txtSearch.addEventListener( FlexEvent.ENTER, function() : void {
				if ( txtSearch.text !== null && txtSearch.text != "" )
					dispatcher( new FxBlogMessage( FxBlogMessage.SEARCH, null, txtSearch.text ));
			});
		}
		
		/**
		 * create complete event handler
		 */
		private function createEventHandler( event : FlexEvent ) : void {
			//dispatch COMP_HEAD message
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_HEAD ));
			//bind lblTitle
			BindingUtils.bindProperty( lblTitle, "text", model.headVars, "title" );
			//bind lblDesc
			BindingUtils.bindProperty( lblDesc, "text", model.headVars, "desc" );
			//bind lblDesc
			BindingUtils.bindProperty( imgGithub, "name", model.githubVars, "url" );
		}
		
	}

}