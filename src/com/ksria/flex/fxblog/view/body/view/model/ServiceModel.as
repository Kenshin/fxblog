package com.ksria.flex.fxblog.view.body.view.model 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;

	import com.ksria.as3.zblog.Zblog;
	import com.ksria.as3.zblog.core.zblog_internal;
	import com.ksria.as3.zblog.event.ZblogEvent;
	import com.ksria.as3.zblog.ui.IZblog;
	import com.ksria.as3.zblog.vo.ErrorVO;

	import com.ksria.as3.zblog.method.GetArticles;
	import com.ksria.as3.zblog.method.GetArticlesCount;
	import com.ksria.as3.zblog.method.GetArticlesByCategory;
	import com.ksria.as3.zblog.method.GetArticlesByTag;
	import com.ksria.as3.zblog.method.GetArticlesBySearch;
	import com.ksria.as3.zblog.method.GetArticlesByDate;
	import com.ksria.as3.zblog.method.GetArticlebyId;
	import com.ksria.as3.zblog.method.GetArticlebyTitle;
	import com.ksria.as3.zblog.method.GetTags;
	import com.ksria.as3.zblog.method.GetAllArticles;

	import com.ksria.flex.fxblog.view.body.view.event.BodyEvent;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	use namespace zblog_internal;
	
	[Event(name="progress"            ,type="com.ksria.flex.fxblog.view.body.view.event.BodyEvent")]
	[Event(name="tagCloudLayout"      ,type="com.ksria.flex.fxblog.view.body.view.event.BodyEvent")]
	[Event(name="listMapLayout"       ,type="com.ksria.flex.fxblog.view.body.view.event.BodyEvent")]
	[Event(name="createPagination"    ,type="com.ksria.flex.fxblog.view.body.view.event.BodyEvent")]
	[Event(name="articleDetailLayout" ,type="com.ksria.flex.fxblog.view.body.view.event.BodyEvent")]
	[ManagedEvents( "progress, tagCloudLayout, createPagination, listMapLayout, articleDetailLayout" )]

	/**
	 * ...
	 * @author Kenshin
	 */
	public class ServiceModel extends EventDispatcher
	{
		
		[Inject(id="model")]
		public var bodyModel : BodyModel;
		
		[Inject(id="deeplink")]
		public var deeplink : DeepLinkModel;
		
		private var zb : IZblog;
		
		public function ServiceModel( target : IEventDispatcher = null ) { super( target ); MonsterDebugger.initialize( this );  }
		
		/**
		 * get articles count
		 */
		public function getArticlesCount() : void {
			zb = new GetArticlesCount();
			zb.execute();
			( zb as Zblog ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				//getArticles( 1 );
				getAllArticles();
				//SWFAddress.addEventListener( SWFAddressEvent.CHANGE, urlChangeHandler );
				deeplink.initialize();
			});
			( zb as Zblog ).addEventListener( ZblogEvent.FAULT, faultHandler );
		}
		
		/**
		 * get articles
		 * @param	page
		 */
		public function getArticles( page : int ) : void {
			
			bodyModel.currentSate = BodyModel.ARTICLES;
			
			zb = new GetArticles();
			( zb as GetArticles ).articlesnum = ( zb as Zblog ).zblog_internal::mo.maxarticlenum;
			( zb as GetArticles ).curpage     = page;
			( zb as GetArticles ).pagesize    = 6;
			( zb as GetArticles ).execute();
			( zb as GetArticles ).addEventListener( ZblogEvent.SUCCESS, function( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.CREATE_PAGINATION, { total : ( zb as Zblog ).zblog_internal::mo.maxarticlenum, 
																			 "currentState" : "articles", 
																			 "page" : page
																			} ));
																			
				bodyModel.articleList = event.target.resultObject.articleList;
				
				deeplink.setDeepLink( "Kenshin's Flex Blog", "?mode=articles&page=" + page );
				
				MonsterDebugger.trace( this, event, "getArticles" );
			});
			( zb as GetArticles ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticles ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get articles by category
		 * @param	page
		 * @param	categoryid
		 * @param	total
		 * @private
		 */
		public function getArticlesByCategory( page : int, param : Object ) : void {
			
			bodyModel.currentSate = BodyModel.CATEGORY;
			
			zb = new GetArticlesByCategory();
			if ( isNaN( param.id )) {
				( zb as GetArticlesByCategory ).categoryname = param.id;
				( zb as GetArticlesByCategory ).articlesnum  = 2;
			}
			else {
				( zb as GetArticlesByCategory ).categoryid  = int( param.id );
				( zb as GetArticlesByCategory ).articlesnum = int( param.total );
			}
			
			( zb as GetArticlesByCategory ).pagesize    = 6;
			( zb as GetArticlesByCategory ).curpage     = page;
			zb.execute();
			( zb as GetArticlesByCategory ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.CREATE_PAGINATION, 
											   { total : ( zb as GetArticlesByCategory ).articlesnum, 
												 currentState : "category",
												 categoryid : ( zb as GetArticlesByCategory ).categoryid,
												 "page" : page
												} ));
												
				bodyModel.articleList = event.target.resultObject.articleList;
				
				deeplink.setDeepLink( "Kenshin's Flex Blog - 分类", "?mode=category&categoryid=" + ( zb as GetArticlesByCategory ).categoryid + "&count=" + ( zb as GetArticlesByCategory ).articlesnum + "&page=" + page );
			});
			( zb as GetArticlesByCategory ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticlesByCategory ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get articles by tag
		 * @param	page
		 * @param	tag
		 * @private
		 */
		public function getArticlesByTag( page : int, tag : String ) : void {
			
			bodyModel.currentSate = BodyModel.TAG;
			
			zb = new GetArticlesByTag();
			( zb as GetArticlesByTag ).tag      = encodeURI( decodeURI( tag ));
			( zb as GetArticlesByTag ).pagesize = 6;
			( zb as GetArticlesByTag ).curpage  = page;
			zb.execute();
			( zb as GetArticlesByTag ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.CREATE_PAGINATION, 
											   { total : event.target.resultObject.total,  
												 currentState : "tag",
												 tag : tag,
												 "page" : page
												} ));
				
				bodyModel.articleList = event.target.resultObject.articleList;
				
				MonsterDebugger.trace( this, decodeURI( tag ) , "decode" );
				
				deeplink.setDeepLink( "Kenshin's Flex Blog - 标签：" + tag, "?mode=tag&tag=" + tag + "&count=" + event.target.resultObject.total + "&page=" + page );
				
				MonsterDebugger.trace( this, ( zb as GetArticlesByTag ).apiurl, "tag api" )
			});
			( zb as GetArticlesByTag ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticlesByTag ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get articles by Search
		 * @param	page
		 * @param	Search
		 * @private
		 */
		public function getArticlesBySearch( page : int, key : String ) : void {
			
			bodyModel.currentSate = BodyModel.SEARCH;
			
			zb = new GetArticlesBySearch();
			( zb as GetArticlesBySearch ).key      = encodeURI( decodeURI( key ));;
			( zb as GetArticlesBySearch ).pagesize = 6;
			( zb as GetArticlesBySearch ).curpage  = page;
			zb.execute();
			( zb as GetArticlesBySearch ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.CREATE_PAGINATION, 
											   { total : event.target.resultObject.total,  
												 currentState : "search",
												 key : key,
												 "page" : page
												} ));
				
				bodyModel.articleList = event.target.resultObject.articleList;
				
				deeplink.setDeepLink( "Kenshin's Flex Blog - 搜索：" + key, "?mode=search&key=" + key + "&count=" + event.target.resultObject.total + "&page=" + page );
			});
			( zb as GetArticlesBySearch ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticlesBySearch ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get articles by date
		 * @param	page
		 * @param	date
		 * @private
		 */
		public function getArticlesByDate( page : int, date : String ) : void {
			
			bodyModel.currentSate = BodyModel.DATE;
			
			zb = new GetArticlesByDate();
			( zb as GetArticlesByDate ).date     = date;
			( zb as GetArticlesByDate ).pagesize = 6;
			( zb as GetArticlesByDate ).curpage  = page;
			zb.execute();
			( zb as GetArticlesByDate ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.CREATE_PAGINATION, 
											   { total : event.target.resultObject.total,  
												 currentState : "date",
												 date : date,
												 "page" : page
												} ));
												
				bodyModel.articleList = event.target.resultObject.articleList;
				
				deeplink.setDeepLink( "Kenshin's Flex Blog - 日期：" + date, "?mode=date&date=" + date + "&count=" + event.target.resultObject.total + "&page=" + page );
			});
			( zb as GetArticlesByDate ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticlesByDate ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get article by id
		 * @param	id
		 * @private
		 */
		public function getArticlebyID( id : int ) : void {
			//getarticlebyid api testing
			zb = new GetArticlebyId();
			( zb as GetArticlebyId ).articleid = id;
			zb.execute();
			( zb as GetArticlebyId ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.ARTICLE_DETAIL_LAYOUT ));
				
				bodyModel.articleDetail = event.target.resultObject;
				
				MonsterDebugger.trace( this, bodyModel.articleDetail, "getArticlebyID" );			
			});
			( zb as GetArticlebyId ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticlebyId ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get article by title
		 * @param	id
		 * @private
		 */
		public function getArticlebyTitle( title : String ) : void {
			//GetArticlebyTitle api testing
			zb = new GetArticlebyTitle();
			( zb as GetArticlebyTitle ).articletitle = title;
			zb.execute();
			( zb as GetArticlebyTitle ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				dispatchEvent( new BodyEvent( BodyEvent.ARTICLE_DETAIL_LAYOUT ));
				
				bodyModel.articleDetail = event.target.resultObject;
				
				deeplink.setDeepLink( "Kenshin's Flex Blog - 文章页", "?mode=title&title=" + title );
				
				MonsterDebugger.trace( this, bodyModel.articleDetail, "GetArticlebyTitle" );
				
			});
			( zb as GetArticlebyTitle ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetArticlebyTitle ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
			MonsterDebugger.trace( this, ( zb as GetArticlebyTitle ).apiurl, "api" )
		}
		
		/**
		 * get tags
		 * @private
		 */
		public function getTags() : void {
			zb = new GetTags();
			zb.execute();
			( zb as GetTags ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				
				MonsterDebugger.trace( this, event, "getTags" );
				
				dispatchEvent( new BodyEvent( BodyEvent.TAG_CLOUD_LAYOUT ));
				
				deeplink.setDeepLink( "Kenshin's Flex Blog - 标签云", "?mode=tagcloud" );
				
				bodyModel.tagsList = event.target.resultObject.tagsList;
				
			});
			( zb as GetTags ).addEventListener( ZblogEvent.FAULT, faultHandler );
			( zb as GetTags ).addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}
		
		/**
		 * get all articles
		 * @private
		 */
		public function getAllArticles() : void {
			zb = new GetAllArticles();
			zb.execute();
			( zb as GetAllArticles ).addEventListener( ZblogEvent.SUCCESS, function ( event : ZblogEvent ) : void {
				bodyModel.allArticleList = event.target.resultObject.articleList;
			});
			( zb as GetAllArticles ).addEventListener( ZblogEvent.FAULT, faultHandler );
		}
		
		/**
		 * go to list map layout
		 */
		public function gotoListMapLayout() : void {
			dispatchEvent( new BodyEvent( BodyEvent.LIST_MAP_LAYOUT ));
		}
		
		/**
		 * fault event handler
		 */
		private function faultHandler( event : ZblogEvent ) : void {
			var err : ErrorVO =  event.target.resultFaultObject as ErrorVO;
		}
	
		/**
		 * progress event hanlder
		 */
		private function progressHandler( event : ProgressEvent ) : void {
			dispatchEvent( new BodyEvent( BodyEvent.PROGRESS, event ));
		}
		
	}

}