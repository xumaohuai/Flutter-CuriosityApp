# 欢迎Star

> 基于Flutter开发，适配Android与iOS。
项目同时适合Flutter的练手学习，覆盖了基本框架的使用，与原生的交互等。
#### 注意事项
> 1.下载项目后报错是因为没有添加依赖,在pubspec.yaml文件中点击Packages get下载依赖,有时候会在这里出现卡死的情况,可以配置一下环境变量.在终端执行`vi ~/.bash_profile `,再添加`export PUB_HOSTED_URL=https://pub.flutter-io.cn`和
`export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn`.详情请看[修改Flutter环境变量](https://flutter.io/community/china).

>2.需要将File Encodings里的`Project Encoding设置为UTF-8`,否则有时候安卓会报错

> 3.如果cocoapods不是最新可能会出现`Error Running Pod Install`,请更新cocoapods.

> 4.由于[flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin)这个插件只支持加载url,于是就需要做一些修改.
>*   iOS 在`FlutterWebviewPlugin.m`文件中的`- (void)navigate:(FlutterMethodCall*)call`方法中的最后一排,将`[self.webview loadRequest:request]`方法改为`[self.webview loadHTMLString:url baseURL:nil]`
>*   Android 在`WebViewManager.java`文件中`webView.loadUrl(url)`方法改为`webView.loadData(url, "text/html; charset=UTF-8", null);`,以及下面那排的`void reloadUrl(String url) { webView.loadUrl(url); }`改为`void reloadUrl(String url) { webView.loadData(url, "text/html; charset=UTF-8", null); }`
# 相关文章
# [Flutter实战详解--高仿好奇心日报](https://juejin.im/post/5c31f7236fb9a04a04412d0b)
#### 示例图片

![iOS效果图.gif](https://upload-images.jianshu.io/upload_images/1220329-d9aeb90fc255749e.gif?imageMogr2/auto-orient/strip)
![Android效果图.gif](https://upload-images.jianshu.io/upload_images/1220329-e329ec185551c4e4.gif?imageMogr2/auto-orient/strip)

![](https://upload-images.jianshu.io/upload_images/1220329-6213761c70c25366.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-250c5c7b013e66b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-131273bb45b1b79d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-712799e7e1f86f45.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-587d0c87efcfdf3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-138e45f5633e2d5c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-53cae7d88c690973.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### Code Visualization:

Here is a cool visualization of the code evolution

 [![Watch the video](https://img.youtube.com/vi/yvO8KyA80GE/0.jpg)](https://www.youtube.com/watch?v=yvO8KyA80GE)

 [https://www.youtube.com/watch?v=yvO8KyA80GE](https://www.youtube.com/watch?v=yvO8KyA80GE)

