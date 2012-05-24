package com.ksria.flex.fxblog.view.head.view
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
		
	public class HeadBoxPM extends EventDispatcher
	{
		
		[Inject(id="headVars")]
		public var headVars : Object;
		
		[Inject(id="githubVars")]
		public var githubVars : Object;
		
		public function HeadBoxPM( target : IEventDispatcher = null ) { super( target ); }
		
	}
}