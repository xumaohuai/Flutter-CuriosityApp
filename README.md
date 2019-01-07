> 基于Flutter开发，适配Android与iOS。
项目同时适合Flutter的练手学习，覆盖了基本框架的使用，与原生的交互等。
# 相关文章
# [Flutter实战详解--高仿好奇心日报](https://juejin.im/post/5c31f7236fb9a04a04412d0b)
#### 示例图片

![iOS效果图.gif](https://upload-images.jianshu.io/upload_images/1220329-d9aeb90fc255749e.gif?imageMogr2/auto-orient/strip)
![Android效果图.gif](https://upload-images.jianshu.io/upload_images/1220329-e329ec185551c4e4.gif?imageMogr2/auto-orient/strip)
![](https://upload-images.jianshu.io/upload_images/1220329-5e57a13395f1bb6a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-efbdd5f0e13fcbdf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-0407bf1d19e7003f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-b97e694a7a98ff9f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![](https://upload-images.jianshu.io/upload_images/1220329-715e253736f95258.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


由于[flutter_webview_plugin](https://pub.dartlang.org/packages/flutter_webview_plugin)这个插件只支持加载url,于是就需要做一些修改.

*   iOS
    在`FlutterWebviewPlugin.m`文件中的`- (void)navigate:(FlutterMethodCall*)call`方法中的最后一排,将`[self.webview loadRequest:request]`方法改为`[self.webview loadHTMLString:url baseURL:nil]`
*   Android
    在`WebViewManager.java`文件中`webView.loadUrl(url)`方法改为`webView.loadData(url, "text/html", "UTF-8")`,以及下面那排的`void reloadUrl(String url) { webView.loadUrl(url); }`改为`void reloadUrl(String url) { webView.loadData(url, "text/html", "UTF-8"); }`

