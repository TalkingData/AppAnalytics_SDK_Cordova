/*  
    Javascript interface of Cordova plugin for TalkingData Analytics SDK 
*/

var TalkingDataShoppingCart = {
    createShoppingCart:function() {
        var shoppingCart = {};
        shoppingCart.items = [];

        shoppingCart.addItem = function(itemId, category, name, unitPrice, amount) {
            var item = {
                itemId: itemId,
                category: category,
                name: name,
                unitPrice: unitPrice,
                amount: amount
            };
            shoppingCart.items.push(item);
        }

        return shoppingCart;
    }
};

module.exports = TalkingDataShoppingCart;
