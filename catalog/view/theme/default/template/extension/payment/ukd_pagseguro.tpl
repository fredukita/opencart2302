<div id="div_content" class="col-sm-12" hidden></div>

<div class="modal fade" id="processModal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer" hidden="hidden">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
      </div>
    </div>
  </div>
</div>

<div class="buttons">
  <div class="pull-right">
    <input data-toggle="modal" data-target="#processModal" type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" data-loading-text="<?php echo $text_loading; ?>" />
  </div>
</div>

<form id="form_pagseguro">

<input name="email" type="hidden" value="<?php echo $email; ?>" />
<input name="token" type="hidden" value="<?php echo $token; ?>" />
<input name="paymentMode" type="hidden" value="default" />
<input name="paymentMethod" type="hidden" value="" />
<input name="receiverMail" type="hidden" value="<?php echo $email; ?>" />
<input name="currency" type="hidden" value="BRL" />

<input name="senderName" type="hidden" value="<?php echo $payment_address['firstname'].' '.$payment_address['lastname'] ?>" />
<input name="senderCPF" type="hidden" value="" />
<input name="senderAreaCode" type="hidden" value="" />
<input name="senderPhone" type="hidden" value="" />
<input name="senderEmail" type="hidden" value="" />
<input name="senderHash" type="hidden" value="" />


<!--only credit card-->
<input name="creditCardToken" type="hidden" value="" />
<input name="installmentQuantity" type="hidden" value="" />
<input name="installmentValue" type="hidden" value="" />
<!-- <input name="noInterestInstallmentQuantity" type="hidden" value="2" /> -->

<input name="creditCardHolderName" type="hidden" value="" />
<input name="creditCardHolderCPF" type="hidden" value="" />
<input name="creditCardHolderBirthDate" type="hidden" value="" />
<input name="creditCardHolderAreaCode" type="hidden" value="" />
<input name="creditCardHolderPhone" type="hidden" value="" />

<input name="billingAddressStreet" type="hidden" value="" />
<input name="billingAddressNumber" type="hidden" value="" />
<input name="billingAddressComplement" type="hidden" value="" />
<input name="billingAddressDistrict" type="hidden" value="" />
<input name="billingAddressPostalCode" type="hidden" value="" />
<input name="billingAddressCity" type="hidden" value="" />
<input name="billingAddressState" type="hidden" value="" />
<input name="billingAddressCountry" type="hidden" value="BRA" />
<!-- credit card-->

<!--only debito online-->
<input name="bankName" type="hidden" value="" />
<!--debito online-->

<?php
if(!$shipping_address){

   $shipping_address['address_1'] = 'n/a';
   $shipping_address['address_2'] = 'n/a';
   $shipping_address['postcode'] = '42850000';
   $shipping_address['city'] = 'n/a';
   $shipping_address['zone_code'] = 'BA';
   $shipping_address['iso_code_3'] = 'BRA';

}
?>

<input name="shippingAddressStreet" type="hidden" value="<?php echo $shipping_address['address_1'] ?>" />
<input name="shippingAddressNumber" type="hidden" value="s/n" />
<input name="shippingAddressComplement" type="hidden" value="" />
<input name="shippingAddressDistrict" type="hidden" value="<?php echo $shipping_address['address_2'] ?>" />
<input name="shippingAddressPostalCode" type="hidden" value="<?php echo $shipping_address['postcode'] ?>" />
<input name="shippingAddressCity" type="hidden" value="<?php echo $shipping_address['city'] ?>" />
<input name="shippingAddressState" type="hidden" value="<?php echo $shipping_address['zone_code'] ?>" />
<input name="shippingAddressCountry" type="hidden" value="<?php echo $shipping_address['iso_code_3'] ?>" />

<?php

if(!$shipping_method){

  $shipping_method['cost'] = '00.00';
  $shipping_method['title'] = 'n/a';


}

$shipping_cost = number_format(str_replace( ',', '.', $shipping_method['cost'] ), 2, '.', '');

$shipping_type = strtolower( $shipping_method['title'] );
if( $shipping_type == 'pac'){
  $shipping_type = '1';
}
elseif ($shipping_type == 'sedex') {
  $shipping_type = '2';
}else{
  $shipping_type = '3';
}

 ?>

<input name="shippingType" type="hidden" value="<?php echo $shipping_type ?>" />
<input name="shippingCost" type="hidden" value="<?php echo $shipping_cost ?>" />

<?php
$i = 1;
foreach ($products as $product) {
  $price = number_format(str_replace( ',', '.', $product['price'] ), 2, '.', '');
?>
<!-- Item list -->
<input name="itemId<?php echo $i ?>" type="hidden" value="<?php echo $product['product_id'] ?>" />
<input name="itemDescription<?php echo $i ?>" type="hidden" value="<?php echo $product['name'] ?>" />
<input name="itemAmount<?php echo $i ?>" type="hidden" value="<?php echo $price ?>" />
<input name="itemQuantity<?php echo $i ?>" type="hidden" value="<?php echo $product['quantity'] ?>" />
<?php
$i++;
}
?>

<input name="notificationURL" type="hidden" value="" />
<input name="reference" type="hidden" value="" />

<input name="transactions" type="hidden" value="<?php echo $transactions ?>" />

</form>

<script type="text/javascript">

getSessionId();

var img_url = '<?php echo $img_url ?>';
var directpayment = '<?php echo $directpayment ?>';
var amount = '<?php echo number_format( $total + $shipping_method['cost'], 2, '.', '' ) ?>';
var pagseguro_method =  window.payment_method_form.pagseguro_method;

$('#button-confirm').attr('disabled', true);

$('#processModal').modal({
    backdrop: 'static',
    keyboard: true,
    show: false
}).on('hidden.bs.modal', function () {
    $('#processModal .modal-footer').hide();
})

$('#button-confirm').on('click', function() {

    $('#processModal .modal-title').html('Processando pagamento...');

    $('#processModal .modal-body').html('<p><center><i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw" style="font-size:64px;color:grey"></i></center></p>');

    if (pagseguro_method == 'eft') {

        if (!$('#form_pagseguro input[name=bankName]').val()) {
            alert('Selecione um Banco!');
            //return false;
        }

    }

    $.ajax({
        type: 'get',
        url: 'index.php?route=extension/payment/ukd_pagseguro/confirm',
        cache: false,
        beforeSend: function() {
            $('#button-confirm').button('loading');
        },
        complete: function(res) {
            //$('#button-confirm').button('reset');
        },
        success: function() {
            //location = '<?php //echo $continue; ?>';
            //process();
            startPayment();
        },
        error: function() {
            for (i in res) {
                //console.log(res[i], i);
            }
        }
    });
});

var cpf = $('#collapse-payment-address input[placeholder=CPF]').val()
$('#form_pagseguro input[name=senderCPF]').val(cpf);

var email = $('#collapse-payment-address input[name=email]').val()
$('#form_pagseguro input[name=senderEmail]').val(email);

var payment_telephone = $('#collapse-payment-address input[name=telephone]').val()

payment_telephone = payment_telephone.split(' ');

var ddd = payment_telephone[0].replace(/[^0-9\.]+/g, '');
$('#form_pagseguro input[name=senderAreaCode]').val(ddd);

var telephone = payment_telephone[1].replace(/[^0-9\.]+/g, '');
$('#form_pagseguro input[name=senderPhone]').val(telephone);

$('#form_pagseguro input[name=paymentMethod]').val(pagseguro_method);

$('#div_content').html('<p><center><i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw" style="font-size:48px;color:grey"></i></center></p>').show();

$.get('catalog/view/ukd_assets/php/checkout/' + pagseguro_method + '.php')
    .done(function(data) {
        $('#div_content').html(data);
    });

var error_count = 0;

function getSessionId() {

    $.ajax({
        dataType: 'json',
        url: 'catalog/view/ukd_assets/php/checkout/getSessionId.php',
        data: $('#form_pagseguro input[name=email], #form_pagseguro input[name=token]'),
        type: 'post',
        cache: false,
        success: function(res) {

            if (res.error) {

                console.log(res.error);

                if (error_count < 3) {

                    setTimeout(getSessionId, 5000);

                } else {

                    alert('FALHA AO CONECTAR SERVIDOR: ' + res.error);

                }

                error_count++;

            } else {

                getPaymentMethods(res.sessionId);

                //setTimeout(getSessionId, 120000);

                error_count = 0;

                //console.log('my id:', res.sessionId);

            }

        },
        error: function(res) {
            console.log(res);
            // if (error_count < 5) getSessionId();
            // error_count++;
        }
    })
}

function getPaymentMethods(sessionId) {

    $.getScript(directpayment, function() {

        PagSeguroDirectPayment.setSessionId(sessionId);
        PagSeguroDirectPayment.getPaymentMethods({
            amount: amount,
            success: function(res) {
                getPaymentMethodsCallback(res);
            },
            error: function(res) {
                //console.log(res);
            },
            complete: function(res) {

            }
        });

    });

}

function getPaymentMethodsCallback(res) {

    //console.log(res);

    if (pagseguro_method == 'boleto') {

        if (res['paymentMethods']['BOLETO']['options']['BOLETO']['status'] == 'AVAILABLE') {
            $('#button-confirm').attr('disabled', false);
        } else {
            alert('Pagamento via Boleto Bancário temporariamente indisponível.');
        }

    } else if (pagseguro_method == 'creditCard') {

        var options = res['paymentMethods']['CREDIT_CARD']['options'];

        if (options) {
            $('#button-confirm').attr('disabled', false);
            window.options = options;
        } else {
            alert('Pagamento via Cartão de Crédito está temporariamente indisponível.');
        }

    } else if (pagseguro_method == 'eft') {

        var options = res['paymentMethods']['ONLINE_DEBIT']['options'];

        if (options) {
            $('#button-confirm').attr('disabled', false);
            window.options = options;
        } else {
            alert('Pagamento via Débito Online está temporariamente indisponível.');
        }

    } else {

        alert('...');

    }

}

function process() {

    var error = false;

    $("#form_pagseguro input[name=senderHash]").val(PagSeguroDirectPayment.getSenderHash());

    $.ajax({
        type: "POST",
        url: "catalog/view/ukd_assets/php/checkout/process.php",
        data: $("#form_pagseguro").serialize(),
        dataType: "json",
        cache: false,
        success: function(resonse) {

            if (resonse) {
                //process = null;
                if (resonse['paymentLink']) {

                    console.log('paymentLink');

                }

                if (resonse['error']) {

                    console.log(resonse, 'error');

                    error = true;

                    processError(resonse['error']);

                } else {
                    console.log('processed', resonse);
                }
            } else {
                process();
            }

        },
        error: function(jqxhr) {

            alert(jqxhr.resonseText);


        },
        complete: function() {

            if (!error) $('#processModal').modal('hide');
            $('#button-confirm').button('reset');
            window.token = null;

        }

    })

}

function processError(error) {

    $('.form-group').removeClass('has-error');
    $('.input-group').removeClass('has-error');

    //console.log(error);
    window.token = null;

    var content = '';

    if (error['code']) {

        content += error['code'] + ' - ' + error['message'];
        filterError(error['code']);

    } else {
        if (error[0]) {

            for (i in error) {

                content += error[i]['code'] + ' - ' + error[i]['message'] + '<br />';

                filterError(error[i]['code']);

            }
        }

    }

    if (content == '') {

        for (i in error) {

            content += i + ' - ' + error[i] + '<br />';

            filterError(i);


        }

    }

    $('#processModal .modal-title').html('Erro ao processar pagamento');

    $('#processModal .modal-footer').show();

    $('#processModal .modal-body').html('<span style="text-transform: uppercase">' + content + '</span>');

    //$('#processModal').modal('show');

}

function filterError(code) {

    if (code == 10000 || code == 10001) {
        $('#cc_form input[name=cardNumber]').parent('.input-group').addClass('has-error');
    }
    if (code == 10004 || code == 10006) {
        $('#cc_form input[name=cardCVC]').parent('.form-group').addClass('has-error');
    }
    if (code == 53042 || code == 53044) {
        $('#cc_form input[name=cardOwner]').parent('.form-group').addClass('has-error');
    }
    if (code == 53038 || code == 53040) {
        $('#cc_form select[name=installments]').parent('.form-group').addClass('has-error');
    }
    if (code == 53045 || code == 53046) {
        $('#cc_form input[name=cpf]').parent('.form-group').addClass('has-error');
    }
    if (code == 53047 || code == 53048) {
        $('#cc_form input[name=birthDate]').parent('.form-group').addClass('has-error');
    }
    if (code == 10002 ||code == 30405) {
        $('#cc_form input[name=cardExpiry]').parent('.form-group').addClass('has-error');
    }
    if (code == 30400) {
        $('#cc_form input[name=cardNumber]').parent('.input-group').addClass('has-error');
    }

    console.log(code, 'filterError');

}

</script>