var TalkingDataShoppingCart = {
    /**
     * 创建购物车
     */
    createShoppingCart: function() {
        var shoppingCart = {};
        shoppingCart.items = [];
        /**
         * 添加购物车详情
         * @param {String} itemId   : 商品ID
         * @param {String} category : 商品类别
         * @param {String} name     : 商品名称
         * @param {Number} unitPrice: 商品单价
         * @param {Number} amount   : 商品数量
         */
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
