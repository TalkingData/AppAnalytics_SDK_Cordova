/*  
    Javascript interface of Cordova plugin for TalkingData Analytics SDK 
*/

var TalkingDataOrder = {
    createOrder:function(orderId, total, currencyType) {
        var order = {};
        order.orderId = orderId;
        order.total = total;
        order.currencyType = currencyType;
        order.items = [];

        order.addItem = function(itemId, category, name, unitPrice, amount) {
            var item = {
                itemId: itemId,
                category: category,
                name: name,
                unitPrice: unitPrice,
                amount: amount
            };
            order.items.push(item);
        };

        return order;
    }
};

module.exports = TalkingDataOrder;
