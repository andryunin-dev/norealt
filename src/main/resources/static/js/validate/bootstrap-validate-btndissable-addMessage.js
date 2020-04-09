$(document).ready(function () {

                var button = 'button[id="submit-message"]';
                $(button).attr('disabled', true);

                $('input,textarea').on('keyup', function () {
                    var isInvalid = $(".form-control").hasClass("is-invalid")
                    var city = $("#city").val();
                    var street = $("#street").val();
                    var house = $("#house").val();
                    var square = $("#square").val();
                    var price = $("#price").val();
                    var text = $("#text").val();

                    if (!isInvalid
                        && city != ''
                        && street != ''
                        && house != ''
                        && square != ''
                        && price != ''
                        && text != ''
                    ) {
                        $(button).attr('disabled', false);
                    } else {
                        $(button).attr('disabled', true);
                    }
                });
            });