## TalkingData App Analytics Cordova/PhoneGap SDK
App Analytics Cordova/PhoneGap 平台 SDK 由 `封装层` 和 `Native SDK` 两部分构成，目前 GitHub 上提供了封装层代码，需要从 [TalkingData官网](https://www.talkingdata.com/spa/sdk/#/config) 下载最新版的 Android 和 iOS 平台 Native SDK，组合使用。

### 集成说明
1. 下载本项目（封装层）到本地；  
2. 访问 [TalkingData官网](https://www.talkingdata.com/spa/sdk/#/config) 下载最新版的 Android 和 iOS 平台 App Analytics SDK（Native SDK）
	- 方法1：选择 PhoneGap 平台进行功能定制；
	- 方法2：分别选择 Android 和 iOS 平台进行功能定制，请确保两个平台功能项一致；  
3. 将下载的最新版 `Native SDK` 复制到 `封装层` 中，构成完整的 Cordova/PhoneGap SDK。  
	- Android 平台  
	将最新的 `.jar` 文件复制到 `src/android` 目录下，并重命名为 `TalkingData.jar` 。
	- iOS 平台  
	将最新的 `.h` 和 `.a` 文件复制到 `src/ios` 目录下
4. 按 `Native SDK` 功能选项对 `封装层` 代码进行必要的删减，详见“注意事项”第2条；
5. 将 Cordova/PhoneGap SDK 集成您需要统计的工程中，并按 [集成文档](http://doc.talkingdata.com/posts/35) 进行必要配置和功能调用。

### 注意事项
1. 分别选择 Android 和 iOS 平台进行功能定制时，请确保两个平台功能项一致。
2. 如果申请 Native SDK 时只选择了部分功能，则需要在本项目中删除未选择功能对应的封装层代码。  
	a) 未选择 `标准化事件分析` 功能则删除以下 7 部分  
	删除 `plugin.xml` 文件中如下代码：
	
	```
		<js-module src="www/TalkingDataShoppingCart.js" name="TalkingDataShoppingCart">
			<clobbers target="TalkingDataShoppingCart" />
		</js-module>
	```
	删除 `www/TalkingDataShoppingCart.js` 文件  
	删除 `www/TalkingData.js` 文件中如下代码：
	
	```
		onPlaceOrder:function(orderId, amount, currencyType) {
			exec(null, null, "TalkingData", "onPlaceOrder", [orderId, amount, currencyType]);
		},
		onOrderPaySucc:function(orderId, amount, currencyType, paymentType) {
			exec(null, null, "TalkingData", "onOrderPaySucc", [orderId, amount, currencyType, paymentType]);
		},
		onCancelOrder:function(orderId, amount, currencyType) {
			exec(null, null, "TalkingData", "onCancelOrder", [orderId, amount, currencyType]);
		},
		onViewItem:function(itemId, category, name, unitPrice) {
			exec(null, null, "TalkingData", "onViewItem", [itemId, category, name, unitPrice]);
		},
		onAddItemToShoppingCart:function(itemId, category, name, unitPrice, amount) {
			exec(null, null, "TalkingData", "onAddItemToShoppingCart", [itemId, category, name, unitPrice, amount]);
		},
		onViewShoppingCart:function(shoppingCart) {
			var shoppingCartJson = JSON.stringify(shoppingCart);
			exec(null, null, "TalkingData", "onViewShoppingCart", [shoppingCartJson]);
		},
	```
	删除 `src/android/TalkingDataPlugin.java` 文件中如下代码：
	
	```
	import com.tendcloud.tenddata.ShoppingCart;
	```
	```
			} else if (action.equals("onPlaceOrder")) {
				...
				return true;
			} else if (action.equals("onOrderPaySucc")) {
				...
				return true;
			} else if (action.equals("onCancelOrder")) {
				...
				return true;
			} else if (action.equals("onViewItem")) {
				...
				return true;
			} else if (action.equals("onAddItemToShoppingCart")) {
				...
				return true;
			} else if (action.equals("onViewShoppingCart")) {
				...
				return true;
	```
	```
		private ShoppingCart stringToShoppingCart(String shoppingCartStr) {
			...
		}
	```
	删除 `src/ios/TalkingDataPlugin.h` 文件中如下代码：
	
	```
	- (void)onPlaceOrder:(CDVInvokedUrlCommand*)command;
	- (void)onOrderPaySucc:(CDVInvokedUrlCommand*)command;
	- (void)onCancelOrder:(CDVInvokedUrlCommand*)command;
	- (void)onViewItem:(CDVInvokedUrlCommand*)command;
	- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand*)command;
	- (void)onViewShoppingCart:(CDVInvokedUrlCommand*)command;
	```
	删除 `src/ios/TalkingDataPlugin.m` 文件中如下代码：
	
	```
	- (void)onPlaceOrder:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onOrderPaySucc:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onCancelOrder:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onViewItem:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onAddItemToShoppingCart:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onViewShoppingCart:(CDVInvokedUrlCommand*)command {
		...
	}
	```
	```
	- (TalkingDataShoppingCart *)stringToShoppingCart:(NSString *)shoppingCartStr {
		...
	}
	```
	b) 未选择 `自定义事件` 功能则删除以下 4 部分  
	删除 `www/TalkingData.js` 文件中如下代码：
	
	```
		onEvent:function(eventId) {
			exec(null, null, "TalkingData", "onEvent", [eventId]);
		},
		onEventWithLabel:function(eventId, eventLabel) {
			exec(null, null, "TalkingData", "onEventWithLabel", [eventId, eventLabel]);
		},
		onEventWithParameters:function(eventId, eventLabel, eventData) {
			var eventDataJson = JSON.stringify(eventData);
			exec(null, null, "TalkingData", "onEventWithParameters", [eventId, eventLabel, eventDataJson]);
		},
		onEventWithValue:function(eventId, eventLabel, eventData, eventValue) {
			var eventDataJson = JSON.stringify(eventData);
			exec(null, null, "TalkingData", "onEventWithValue", [eventId, eventLable, eventDataJson, eventValue]);
		},
	```
	删除 `src/android/TalkingDataPlugin.java` 文件中如下代码：
	
	```
		} else if (action.equals("onEvent")) {
			...
			return true;
		} else if (action.equals("onEventWithLabel")) {
			...
			return true;
		} else if (action.equals("onEventWithParameters")) {
			...
			return true;
		} else if (action.equals("onEventWithValue")) {
			...
			return true;
	```
	```
		private Map<String, Object> toMap(String jsonStr)
		{
			...
		}
	```
	删除 `src/ios/TalkingDataPlugin.h` 文件中如下代码：
	
	```
	- (void)onEvent:(CDVInvokedUrlCommand*)command;
	- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command;
	- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command;
	- (void)onEventWithValue:(CDVInvokedUrlCommand*)command;
	```
	删除 `src/ios/TalkingDataPlugin.m` 文件中如下代码：
	
	```
	- (void)onEvent:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onEventWithValue:(CDVInvokedUrlCommand*)command {
		...
	}
	```
	c) 未选择 `页面统计` 功能则删除以下 4 部分  
	删除 `www/TalkingData.js` 文件中如下代码：
	
	```
		onPage:function(pageName) {
			exec(null, null, "TalkingData", "onPage", [pageName]);
		},
		onPageBegin:function(pageName) {
			exec(null, null, "TalkingData", "onPageBegin", [pageName]);
		},
		onPageEnd:function(pageName) {
			exec(null, null, "TalkingData", "onPageEnd", [pageName]);
		},
	```
	删除 `src/android/TalkingDataPlugin.java` 文件中如下代码：
	
	```
			} else if (action.equals("onPage")) {
				...
				return true;
			} else if (action.equals("onPageBegin")) {
				...
				return true;
			} else if (action.equals("onPageEnd")) {
				...
				return true;
	```
	删除 `src/ios/TalkingDataPlugin.h` 文件中如下代码：
	
	```
	- (void)onPage:(CDVInvokedUrlCommand*)command;
	- (void)onPageBegin:(CDVInvokedUrlCommand*)command;
	- (void)onPageEnd:(CDVInvokedUrlCommand*)command;
	```
	删除 `src/ios/TalkingDataPlugin.m` 文件中如下代码：
	
	```
	#if __has_feature(objc_arc)
	@property (nonatomic, strong) NSString *currPageName;
	#else
	@property (nonatomic, retain) NSString *currPageName;
	#endif
	```
	```
	#if __has_feature(objc_arc)
	#else
	- (void)dealloc {
		[super dealloc];
		[self.currPageName release];
	}
	#endif
	```
	```
	- (void)onPage:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onPageBegin:(CDVInvokedUrlCommand*)command {
		...
	}
	- (void)onPageEnd:(CDVInvokedUrlCommand*)command {
		...
	}
	```
