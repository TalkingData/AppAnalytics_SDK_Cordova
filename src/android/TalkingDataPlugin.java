package com.talkingdata.analytics;

import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.content.Context;

import com.tendcloud.tenddata.TCAgent;
import com.tendcloud.tenddata.TDAccount;
import com.tendcloud.tenddata.Order;
import com.tendcloud.tenddata.ShoppingCart;


public class TalkingDataPlugin extends CordovaPlugin {
	Activity act;
	Context ctx;
	String currPageName;
	
	@Override
	public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
		this.act = cordova.getActivity();
		this.ctx = cordova.getActivity().getApplicationContext();
	}
	
	@Override
	public void onResume(boolean multitasking) {
		super.onResume(multitasking);
		TCAgent.onResume(act);
	}
	
	@Override
	public void onPause(boolean multitasking) {
		super.onPause(multitasking);
		TCAgent.onPause(act);
	}
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		if (action.equals("init")) {
    		// 初始化 TalkingData Analytics SDK
			String appKey = args.getString(0);
			String channelId = args.getString(1);
			TCAgent.init(ctx, appKey, channelId);
			return true;
        } else if (action.equals("onRegister")) {
            // 注册事件
            String accountId = args.getString(0);
            TDAccount.AccountType type = this.intToAccountType(args.getInt(1));
            String name = args.getString(2);
            TCAgent.onRegister(accountId, type, name);
            return true;
        } else if (action.equals("onLogin")) {
            // 登录事件
            String accountId = args.getString(0);
            TDAccount.AccountType type = this.intToAccountType(args.getInt(1));
            String name = args.getString(2);
            TCAgent.onLogin(accountId, type, name);
            return true;
		} else if (action.equals("onEvent")) {
    		// 触发自定义事件
			String eventId = args.getString(0);
			TCAgent.onEvent(ctx, eventId);
			return true;
		} else if (action.equals("onEventWithLabel")) {
    		// 触发带事件标签的自定义事件
			String eventId = args.getString(0);
			String eventLabel = args.getString(1);
			TCAgent.onEvent(ctx, eventId, eventLabel);
			return true;
		} else if (action.equals("onEventWithParameters")) {
    		// 触发带事件标签和更多数据的自定义事件
			String eventId = args.getString(0);
			String eventLabel = args.getString(1);
			String eventDataJson = args.getString(2);
			if (eventDataJson != null) {
				Map<String, Object> eventData = this.toMap(eventDataJson);
				TCAgent.onEvent(ctx, eventId, eventLabel, eventData);
			}
			return true;
        } else if (action.equals("onPlaceOrder")) {
            // 下单
            String accountId = args.getString(0);
            String orderStr = args.getString(1);
            Order order = this.stringToOrder(orderStr);
            TCAgent.onPlaceOrder(accountId, order);
            return true;
        } else if (action.equals("onOrderPaySucc")) {
            // 支付订单
            String accountId = args.getString(0);
            String payType = args.getString(1);
            String orderStr = args.getString(2);
            Order order = this.stringToOrder(orderStr);
            TCAgent.onOrderPaySucc(accountId, payType, order);
            return true;
        } else if (action.equals("onViewItem")) {
            // 查看商品
            String itemId = args.getString(0);
            String category = args.getString(1);
            String name = args.getString(2);
            int unitPrice = args.getInt(3);
            TCAgent.onViewItem(itemId, category, name, unitPrice);
            return true;
        } else if (action.equals("onAddItemToShoppingCart")) {
            // 添加商品到购物车
            String itemId = args.getString(0);
            String category = args.getString(1);
            String name = args.getString(2);
            int unitPrice = args.getInt(3);
            int amount = args.getInt(4);
            TCAgent.onAddItemToShoppingCart(itemId, category, name, unitPrice, amount);
            return true;
        } else if (action.equals("onViewShoppingCart")) {
            // 查看购物车
            String shoppingCartStr = args.getString(0);
            ShoppingCart shoppingCart = this.stringToShoppingCart(shoppingCartStr);
            TCAgent.onViewShoppingCart(shoppingCart);
            return true;
		} else if (action.equals("onPage")) {
			// 触发页面事件，在页面加载完毕的时候调用，记录页面名称和使用时长，一个页面调用这个接口后就不用再调用 trackPageBegin 和 trackPageEnd 接口了
			String pageName = args.getString(0);
			// 如果上次记录的页面名称不为空，则本次触发为新页面，触发上一个页面的 onPageEnd
			if (currPageName != null) {
				TCAgent.onPageEnd(act, currPageName);
			}
			// 继续触发本次页面的 onPageBegin 事件
			currPageName = pageName;
			TCAgent.onPageStart(act, currPageName);
			return true;
		} else if (action.equals("onPageBegin")) {
			// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 trackPageEnd 配合使用
			String pageName = args.getString(0);
			currPageName = pageName;
			TCAgent.onPageStart(act, currPageName);
			return true;
		} else if (action.equals("onPageEnd")) {
			// 触发页面事件，在页面加载完毕的时候调用，用于记录页面名称和使用时长，和 trackPageBegin 配合使用
			String pageName = args.getString(0);
			TCAgent.onPageEnd(act, pageName);
			currPageName = null;
			return true;
		} else if (action.equals("getDeviceId")) {
			// 获取 TalkingData Device Id，并将其作为参数传入 JS 的回调函数
			String deviceId = TCAgent.getDeviceId(ctx);
			callbackContext.success(deviceId);
			return true;
		} 
		return false;
	}
	
    private TDAccount.AccountType intToAccountType(final int type) {
        switch (type) {
            case 0:
                return TDAccount.AccountType.ANONYMOUS;
            case 1:
                return TDAccount.AccountType.REGISTERED;
            case 2:
                return TDAccount.AccountType.SINA_WEIBO;
            case 3:
                return TDAccount.AccountType.QQ;
            case 4:
                return TDAccount.AccountType.QQ_WEIBO;
            case 5:
                return TDAccount.AccountType.ND91;
            case 6:
                return TDAccount.AccountType.WEIXIN;
            case 11:
                return TDAccount.AccountType.TYPE1;
            case 12:
                return TDAccount.AccountType.TYPE2;
            case 13:
                return TDAccount.AccountType.TYPE3;
            case 14:
                return TDAccount.AccountType.TYPE4;
            case 15:
                return TDAccount.AccountType.TYPE5;
            case 16:
                return TDAccount.AccountType.TYPE6;
            case 17:
                return TDAccount.AccountType.TYPE7;
            case 18:
                return TDAccount.AccountType.TYPE8;
            case 19:
                return TDAccount.AccountType.TYPE9;
            case 20:
                return TDAccount.AccountType.TYPE10;
            default:
                return TDAccount.AccountType.ANONYMOUS;
        }
    }
    
	private Map<String, Object> toMap(String jsonStr)
	{
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			JSONObject jsonObj = new JSONObject(jsonStr);
			Iterator<String> keys = jsonObj.keys();
			String key = null;
			Object value = null;
			while (keys.hasNext())
			{
				key = keys.next();
				value = jsonObj.get(key);
				result.put(key, value);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return result;
	}
    
    private Order stringToOrder(String orderStr) {
        try {
            JSONObject orderJson = new JSONObject(orderStr);
            Order order = Order.createOrder(orderJson.getString("orderId"), orderJson.getInt("total"), orderJson.getString("currencyType"));
            JSONArray items = orderJson.getJSONArray("items");
            for (int i=0; i<items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                order.addItem(item.getString("itemId"), item.getString("category"), item.getString("name"), item.getInt("unitPrice"), item.getInt("amount"));
            }
            return order;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private ShoppingCart stringToShoppingCart(String shoppingCartStr) {
        try {
            JSONObject shoppingCartJson = new JSONObject(shoppingCartStr);
            ShoppingCart shoppingCart = ShoppingCart.createShoppingCart();
            JSONArray items = shoppingCartJson.getJSONArray("items");
            for (int i=0; i<items.length(); i++) {
                JSONObject item = items.getJSONObject(i);
                shoppingCart.addItem(item.getString("itemId"), item.getString("category"), item.getString("name"), item.getInt("unitPrice"), item.getInt("amount"));
            }
            return shoppingCart;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }
}
