package com.ksria.flex.fxblog.init 
{
	import flash.display.DisplayObject;
	
	import org.spicefactory.parsley.dsl.context.ContextBuilder;
	import org.spicefactory.parsley.flex.FlexConfig;
	import org.spicefactory.parsley.xml.XmlConfig;
	
	import org.spicefactory.parsley.flex.FlexContextBuilder;
	import org.spicefactory.parsley.xml.XmlContextBuilder;
	
	import org.spicefactory.parsley.asconfig.ActionScriptContextBuilder;
	
	/**
	 * ...
	 * @author Kenshin
	 */
	public class Initialize 
	{
		
		public function Initialize() 
		{
			//TO DO
		}
		
		/**
		 * build config context
		 * 
		 * @param	config
		 * @param	viewRoot
		 */
		public static function buildConfig( config : Class, viewRoot : DisplayObject ) : void {
			FlexContextBuilder.build( config, viewRoot );
		}
		
		/**
		 * build xml context
		 * 
		 * @param	filename
		 * @param	viewRoot
		 */
		public static function buildXML( filename : String, viewRoot : DisplayObject ) : void {
			//FxBlogCommand; FxBlogPM; FxBlogMessage;
			XmlContextBuilder.build( filename, viewRoot );
		}
		
		/**
		 * build merge context
		 * 
		 * @param	configClass
		 * @param	filename
		 * @param	viewRoot
		 */
		public static function mergeContext( configClass : Class, filename : String, viewRoot : DisplayObject ) : void {
			ContextBuilder.newSetup()
				.viewRoot( viewRoot )
				.newBuilder()
					.config( FlexConfig.forClass( configClass ))
					.config( XmlConfig.forFile( filename ))
					.build();
		}
	}

}