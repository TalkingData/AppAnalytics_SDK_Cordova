var TalkingDataOrder = {
    /**
     * 创建订单
     * @param {String} orderId      : 订单ID
     * @param {Number} total        : 订单金额
     * @param {String} currencyType : 货币类型
     */
    createOrder: function(orderId, total, currencyType) {
        var order = {};
        order.orderId = orderId;
        order.total = total;
        order.currencyType = currencyType;
        order.items = [];
        /**
         * 添加订单详情
         * @param {String} itemId   : 商品ID
         * @param {String} category : 商品类别
         * @param {String} name     : 商品名称
         * @param {Number} unitPrice: 商品单价
         * @param {Number} amount   : 商品数量
         */
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
