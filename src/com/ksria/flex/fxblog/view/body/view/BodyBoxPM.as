package com.ksria.flex.fxblog.view.body.view
{	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ksria.flex.fxblog.message.FxBlogMessage;	
	import com.ksria.flex.fxblog.view.body.view.model.ServiceModel;
	
	import com.demonsters.debugger.MonsterDebugger;

	[Bindable]
	public class BodyBoxPM extends EventDispatcher
	{
		
		[Inject(id = "service")]
		public var service : ServiceModel;
		
		public function BodyBoxPM( target : IEventDispatcher = null ) { super( target ); MonsterDebugger.initialize( this );  }
		
		[Init]
		public function inits() : void {
			service.getArticlesCount();
		}
		
		/**
		 * message handler selector is search
		 */
		[MessageHandler(selector="index")]
		public function index( value : FxBlogMessage ) : void {
			trace("bbbbbbb index  bbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "index" );
			service.getArticles( 1 );
		}
		
		/**
		 * message handler selector is tagcloud
		 */
		[MessageHandler(selector="tagcloud")]
		public function tagcloud( value : FxBlogMessage ) : void {
			trace("bbbbbbb tagcloud  bbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "tagcloud" );
			service.getTags();
		}
		
		/**
		 * message handler selector is listmap
		 */
		[MessageHandler(selector="listmap")]
		public function listmap( value : FxBlogMessage ) : void {
			trace("bbbbbbb listmap  bbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "listmap" );
			//getAllArticles();
			//dispatchEvent( new BodyEvent( BodyEvent.LIST_MAP_LAYOUT ));
			service.gotoListMapLayout();
	}
		
		/**
		 * message handler selector is search
		 */
		[MessageHandler(selector="search")]
		public function search( value : FxBlogMessage ) : void {
			trace("bbbbbbb search bbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "search" );
			service.getArticlesBySearch( 1, value.args.toString() )
		}
		
		/**
		 * message handler selector is category
		 */
		[MessageHandler(selector="category")]
		public function category( value : FxBlogMessage ) : void {
			trace("bbbb  category  bbbbb = " + value.args.total )
			MonsterDebugger.trace( this, value, "category" );
			service.getArticlesByCategory( 1, value.args );
		}
		
		/**
		 * message handler selector is title
		 */
		[MessageHandler(selector="title")]
		public function title( value : FxBlogMessage ) : void {
			trace("bbbb  title  bbbbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "title" );
			service.getArticlebyTitle( value.args.toString() );
		}
		
		/**
		 * message handler selector is title
		 */
		[MessageHandler(selector="titleid")]
		public function titleid( value : FxBlogMessage ) : void {
			trace("bbbb  titleid  bbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "titleid" );
			service.getArticlebyID( int( value.args ));
		}
		
		/**
		 * message handler selector is date
		 */
		[MessageHandler(selector="date")]
		public function date( value : FxBlogMessage ) : void {
			trace("bbbb  date   bbbbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "date" );
			service.getArticlesByDate( 1, value.args.toString() );
		}
		
		/**
		 * message handler selector is tag
		 */
		[MessageHandler(selector="tag")]
		public function tag( value : FxBlogMessage ) : void {
			trace("bbbb  tag    bbbbbbbb = " + value.args )
			MonsterDebugger.trace( this, value.args, "tag" );
			service.getArticlesByTag( 1, value.args.toString() )
		}
	}
}