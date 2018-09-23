var homeFunctions = {
  enableGetTransferenceFormLink: function(){
    $("#getTransferenceFormLink").click(function(e){
      e.preventDefault();
      homeFunctions.openTransferenceModal( $(this).data("source-account-id") );
    });
  },

  openTransferenceModal: function(accountId){
    $.ajax({
      method: "GET",
      url: "/home/transference_form",
      data: { source_account_id: accountId },
      beforeSend: function(){
        $("#generalModal .modal-title").html("Transfer Money");
        $("#generalModal").modal();
      },
      success: function(data){
        $("#generalModal .modal-body").html(data);
        homeFunctions.setMaskMoney();
        homeFunctions.enableTransferMoneySubmit();
      }
    });
  },

  setMaskMoney: function(){
    $(".maskMoney").maskMoney({
      prefix:'R$ ',
      allowNegative: false,
      thousands:'.',
      decimal:',',
      affixesStay: false
    });
  },

  enableTransferMoneySubmit: function(){
    $("#transferMoneySubmit").click(function(){
      $.ajax({
        method: "POST",
        url: "/home/transfer_money",
        data: $("#transferenceForm").serialize(),
        success: function(data){
          swal({
            type: 'success',
            title: 'Transferred!',
            text: 'The page will reresh in 3s...',
            timer: 3000,
            onClose: function(){
              location.reload();
            }
          })
        },
        statusCode: {
          400: function(){
            swal({
              type: 'error',
              title: 'Not Transferred',
              text: 'Something went wrong!'
            })
          },
          422: function(){
            swal({
              type: 'error',
              title: 'Not Transferred',
              text: 'Fill all fields!'
            })
          }
        }
      });
    });
  }
}

$( document ).ready(function() {
  homeFunctions.enableGetTransferenceFormLink();
});
