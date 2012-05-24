package com.ksria.flex.fxblog.view.footer.view 
{
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	import mx.binding.utils.BindingUtils;
	
	import com.ksria.flex.fxblog.message.FxBlogMessage;
		
	/**
	 * ...
	 * @author Kenshin
	 */
	public class FooterBoxMediator extends FooterBox 
	{
		[MessageDispatcher]
		public var dispatcher : Function;
		
		public function FooterBoxMediator() 
		{
			super();
			
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
			dispatcher( new FxBlogMessage( FxBlogMessage.COMP_FOOTER ));
			//bind lblTitle
			BindingUtils.bindProperty( lblCopyright, "text", model.footerVars, "copyright" );
			//bind lblTitle
			BindingUtils.bindProperty( lblPoweredby, "text", model.footerVars, "poweredby" );
		}
		
	}

}