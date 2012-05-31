##FxBlog
FxBlog - 基于Adobe Flex技术的开源博客程序

### 项目主页：  
[http://www.k-zone.cn/project/fxblog.html](http://www.k-zone.cn/project/fxblog.html)

### Demo预览地址：  
[http://www.k-zone.cn/fxblog/](http://www.k-zone.cn/fxblog/)

### 技术要点：  
* 基于Adobe Flex SDK 4.6.0.23201B；   
* 全站采用 RSL + Modules + Parsley 架构；   
* Modules之间的通讯（主程序与Module通讯、Modules之间的通讯）采用Parsley独有的Message机制；   
* 采用Parsley的配置功能（Flex配置、XML配置）可以方便的对Flex Modules进行管理、扩展，以达到Flex业务分离/解耦的目的；   
* 在Parsley的基础上融合了其他框架的优点，如Robotlegs、PureMVC的Mediator机制；   
* 基于Parsley的IoC方式和ActionScript 3.0的绑定机制（Binding），所以视图层（V）和逻辑层（M C）彻底分离；  

### FxBlog依赖其他的开源类库：
* SilverGreen：[http://www.k-zone.cn/project/silvergreen.html](http://www.k-zone.cn/project/silvergreen.html)
* Pagination for Flex：[http://www.k-zone.cn/project/flexpagination.html](http://www.k-zone.cn/project/flexpagination.html)
* Pagination for AS3：[https://github.com/Kenshin/flex-pagination](https://github.com/Kenshin/flex-pagination)

### 使用方法：  
非Flash Builder构建：  
<pre>
编译参数需要增加如下内容：（注意文件夹结构与项目对应）
-theme ../libs/silvergreen-2.1.swc 
-swf-version=15
-target-player=11.2
-show-invalid-css-property-warnings=false
-load-config+=../obj/classref.config

需要如下Modules进行编译：
com/ksria/flex/fxblog/view/head/HeadModule.swf
com/ksria/flex/fxblog/view/navbar/NavBarModule.swf
com/ksria/flex/fxblog/view/footer/FooterModule.swf
com/ksria/flex/fxblog/view/sidebar/SideBarModule.swf
com/ksria/flex/fxblog/view/bottom/BottomModule.swf
com/ksria/flex/fxblog/view/body/BodyModule.swf
</pre>

Flash Builder构建：  
<pre>
在FB中，构建一个FxBlog的Flex项目（注意：Flex SDK选取4.6.0.23201B， Flash Player的版本大于11.2.0）
构建项目完毕后，用.actionScriptProperties替换刚刚构建的.actionScriptProperties文件即可。
</pre>

### 更新日志：
version 5.0（功能（代码）没有改变） [2012-5-31]
* 增加了构建FxBlog的方法（包括：FB的构建与非FB的构建）

version 5.0 [2012-5-23]
* 基于Adobe Flex SDK 4.6.0.23201B开发
* 项目主页：[http://www.k-zone.cn/project/fxblog.html](http://www.k-zone.cn/project/fxblog.html)

version 4.0 [2009-11-10]
* 基于Adobe Flex SDK 4.0 Beta版（Gumbo）开发
* 由于使用了Beta版，所以当Flex SDK升级为正式版（4.0）时，此版本完全失效

version 3.0 [2007-04-05]
* 基于Adobe Flex 2.0.1 开发
* 这是一个FxBlog的变种，命名为：FBW（Flex Blog Writer）
* FBW属于离线写作工具，其功能类似Zoundry、Performacing、Windows Live Writer等
* 项目主页：[http://www.k-zone.cn/zblog/post/log-2007-04-02-FlexBlogWriterCTP.html](http://www.k-zone.cn/zblog/post/log-2007-04-02-FlexBlogWriterCTP.html)

version 2.0 [2006-08-05]
* 基于Adobe Flex SDK 2.0 开发
* 项目主页：[http://www.k-zone.cn/zblog/post/log-2006-08-05-001.html](http://www.k-zone.cn/zblog/post/log-2006-08-05-001.html)

version 1.0 [2006-03-20]
* 基于Adobe Flex SDK 1.5 开发
* 项目主页：[http://www.k-zone.cn/zblog/post/log-2006-03-20-003.html](http://www.k-zone.cn/zblog/post/log-2006-03-20-003.html)

## 联系方式：
* 博客：[k-zone.cn](http://www.k-zone.cn/zblog)
* 微博：[新浪微博](http://weibo.com/23784148)
* 联络：kenshin[AT]ksria.com

## 版权和许可：
Copyright 2012 [k-zone.cn](http://www.k-zone.cn/zblog)  
Licensed under MIT or GPL Version 2 licenses
