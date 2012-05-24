package com.ksria.flex.fxblog.view.navbar.view
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayList;

	public class NavBarBoxPM extends EventDispatcher
	{

		[Inject(id="navBarList")]
		public var navBarList : ArrayList;

		public function NavBarBoxPM( target : IEventDispatcher = null ) { super( target ); }

	}
}