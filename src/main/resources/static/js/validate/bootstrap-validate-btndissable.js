$(document).ready(function () {

                var button = 'button[id="submit"]';
                $(button).attr('disabled', true);

                $(function(){
                    //using param completed
                    $("#phone").mask("+7 999 999-99-99", {
                        completed: function(){
                        }
                    });
                });

                $('input').on('keyup', function () {
                    var isInvalid = $(".form-control").hasClass("is-invalid")
                    var username = $("#username").val();
                    var email = $("#email").val();
                    var phone = $("#phone").val();
                    var password = $("#password").val();
                    var password2 = $("#password2").val();
                    var text = $("#text").val();

                    if (!isInvalid
                        && username != ''
                        && email != ''
                        && phone != ''
                        && password != ''
                        && password2 != ''
                        && text != ''
                    ) {
                        $(button).attr('disabled', false);
                    } else {
                        $(button).attr('disabled', true);
                    }
                });
            });