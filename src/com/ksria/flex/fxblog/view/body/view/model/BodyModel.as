package com.ksria.flex.fxblog.view.body.view.model 
{
	import mx.collections.ArrayList;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	[Bindable]
	public class BodyModel 
	{
		//articles
		public static const ARTICLES : String = "articles";
		//category
		public static const CATEGORY : String = "category";
		//tag
		public static const TAG      : String = "tag";
		//tag
		public static const SEARCH   : String = "search";
		//tag
		public static const DATE     : String = "date";
		
		//articles list
		public var articleList       : ArrayList;
		//tags list
		public var tagsList          : ArrayList;
		//all articles list
		public var allArticleList    : ArrayList;
		//article detail
		public var articleDetail     : *;
		
		//current states
		public var currentSate       : String;
	}

}