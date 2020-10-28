$(".confirm_btn").click(function() {
	var order_time = $(this).siblings('.order_time')[0];
	order_time = order_time.innerHTML;
	var uid = $(this).siblings()[9].children[1].innerHTML;
	$.post("ConfirmOrderServlet", { order_time: order_time, uid: uid, confirmed: 'y' });
	$(this).parent().find('.order_status')[0].innerHTML = "The order has been confirmed, waiting for the customer's payment.";
	$(this).parent().find('.confirm_btn, .cancel_btn').remove();
})

$(".cancel_btn").click(function() {
	var order_time = $(this).siblings('.order_time')[0];
	order_time = order_time.innerHTML;
	var uid = $(this).siblings()[9].children[1].innerHTML;
	$.post("ConfirmOrderServlet", { order_time: order_time, uid: uid, confirmed: 'n' });
	$(this).parent().find('.order_status')[0].innerHTML = "The order has been canceled.";
	$(this).parent().find('.confirm_btn, .cancel_btn').remove();
})

$(".confirm_date_btn").click(function() {
	let order_time = $(this).parent().parent().find(".order_time")[0].innerHTML;
	let uid = $(this).parent().parent().find(".uid")[0].innerHTML;
	let edd = $(this).parent().find(".datepicker").datepicker('getDate');
	$.post("SetEDDServlet", { order_time: order_time, uid: uid, edd: edd });
	$(this).parent().find('.order_status')[0].innerHTML = "The order is being delivered.<br>Expected deliver date: " + edd;
	$(this).parent().find('p').remove();
	$(this).parent().find('.confirm_date_btn').remove();
})


$(function() {
	$(".datepicker").datepicker();
	$(".datepicker").datepicker("option", "dateFormat", "yy-mm-dd");
});