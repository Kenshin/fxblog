package com.ksria.flex.fxblog.view.body.view.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class BodyEvent extends Event 
	{
		//progress
		public static const PROGRESS              : String = "progress";
		//createPagination
		public static const CREATE_PAGINATION     : String = "createPagination";
		//tagCloud
		public static const TAG_CLOUD_LAYOUT      : String = "tagCloudLayout";
		//list map
		public static const LIST_MAP_LAYOUT       : String = "listMapLayout";
		//list map
		public static const ARTICLE_DETAIL_LAYOUT : String = "articleDetailLayout";
		
		public var args : Object;
		
		public function BodyEvent( type : String, args : Object = null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super(type, bubbles, cancelable);
			this.args = args;
		}
		
	}

}