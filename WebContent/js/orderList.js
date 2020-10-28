// Example starter JavaScript for disabling form submissions if there are invalid fields
(function () {
  'use strict'

  window.addEventListener('load', function () {
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation')

    // Loop over them and prevent submission
    Array.prototype.filter.call(forms, function (form) {
      form.addEventListener('submit', function (event) {
        if (form.checkValidity() === false) {
          event.preventDefault()
          event.stopPropagation()
        }

        form.classList.add('was-validated')
      }, false)
    })
  }, false)
})()

let order_time = '';
let uid = '';

$(".pay_btn").click(function() {
	order_time = $(this).parent().parent().find(".order_time")[0].innerHTML;
	uid = $(this).parent().find('p')[0].innerHTML;
})

$(".comfirmPay_btn").click(function() {
	$.post("PaymentServlet", { order_time: order_time, uid: uid });
	$(this).parent().find('.order_status')[0].innerHTML = "The order has been paid, waiting for the dealer to deliver.";
//	$(this).remove();
	$(this).parent().find('.comfirmPay_btn').remove();
})

$(".confirm_delivery_btn").click(function() {
	order_time = $(this).parent().parent().find(".order_time")[0].innerHTML;
	uid = $(this).parent().find("p")[0].innerHTML;
	$.post("ConfirmDeliveryServlet", { order_time: order_time, uid: uid });
	$(this).parent().find('.order_status')[0].innerHTML = "The order has been completed.";
	$(this).remove();
})