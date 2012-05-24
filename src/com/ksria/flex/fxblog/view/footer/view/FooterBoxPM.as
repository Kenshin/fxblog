package com.ksria.flex.fxblog.view.footer.view
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FooterBoxPM extends EventDispatcher
	{
		
		[Inject(id="footerVars")]
		public var footerVars : Object;
		
		public function FooterBoxPM( target : IEventDispatcher = null ) { super( target ); }
	}
}