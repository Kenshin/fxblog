package com.ksria.flex.fxblog.view.main 
{
	import mx.events.FlexEvent;
	import spark.components.Button;

	import flash.utils.setTimeout;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import com.ksria.flex.fxblog.init.Initialize;
	import com.ksria.flex.fxblog.view.main.MainBox;
	import com.ksria.flex.fxblog.message.FxBlogMessage;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class MainBoxMediator extends MainBox 
	{
		
		[MessageDispatcher]
		public var dispather : Function;
		
		public function MainBoxMediator()
		{
			super();
			
			//add ADDED_TO_STAGE listener
			addEventListener( Event.ADDED_TO_STAGE, function() : void {
				dispatchEvent( new Event( 'configureIOC', true ));
			});
			
			//add PREINITIALIZE listener
			addEventListener( FlexEvent.PREINITIALIZE, preinitializeHandler );
			
			//add mouse right click event
			addEventListener( MouseEvent.RIGHT_CLICK, rightClickEventHandler );
			
		}
		
		/*
		 * PREINITIALIZE event handler
		 */
		private function preinitializeHandler( event : FlexEvent ) : void {
			//Initialize.buildConfig( FxBlogConfig, this );
			//Initialize.buildXML( "NavBarConfig.xml", this );
			Initialize.mergeContext( FxBlogConfig, "FxBlogConfig.xml", this );
		}
		
		/**
		 * mouse right click event
		 * @param	event
		 */
		private function rightClickEventHandler( event : MouseEvent ) : void {
			//TO DO
		}
		
		[Init]
		public function inits() : void {
			setTimeout( function() : void {
				dispather( new FxBlogMessage( FxBlogMessage.INIT_ZBLOG ));
			}, 500 );
		}
		
	}

}