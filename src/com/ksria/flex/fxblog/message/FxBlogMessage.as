package com.ksria.flex.fxblog.message
{
	public class FxBlogMessage
	{
		//zblog
		public static const INIT_ZBLOG   : String = "initZblog";
		public static const COMP_ZBLOG   : String = "compZblog";
		
		//head
		public static const INIT_HEAD    : String = "initHead";
		public static const COMP_HEAD    : String = "compHead";
		
		//navbar
		public static const INIT_NAVBAR  : String = "initNavBar";
		public static const COMP_NAVBAR  : String = "compNavBar";
		
		//footer
		public static const INIT_FOOTER  : String = "initFooter";
		public static const COMP_FOOTER  : String = "compFooter";
		
		//siderbar
		public static const INIT_SIDEBAR : String = "initSideBar";
		public static const COMP_SIDEBAR : String = "compSideBar";
		
		//bottom
		public static const INIT_BOTTOM  : String = "initBottom";
		public static const COMP_BOTTOM  : String = "compBottom";
		
		//body
		public static const INIT_BODY    : String = "initBody";
		public static const COMP_BODY    : String = "compBody";
		
		//index
		public static const INDEX        : String = "index";
		//tagcloud
		public static const TAG_CLOUD    : String = "tagcloud";
		//listmap
		public static const LIST_MAP     : String = "listmap";
		//search
		public static const SEARCH       : String = "search";
		//category
		public static const CATEGORY     : String = "category";
		//title
		public static const TITLE        : String = "title";
		//title
		public static const TITLE_ID     : String = "titleid";
		//date
		public static const DATE         : String = "date";
		//tag
		public static const TAG          : String = "tag";
		
		[Selector]
		public var type : String;
		
		//module url
		public var url : String;
		
		//传的参数，包括：key
		public var args : Object;
		
		public function FxBlogMessage( type : String, url : String = null, args : Object = null ) {
			this.type = type;
			this.url  = url;
			this.args = args;
		}
	}
}