<#macro page>
    <!DOCTYPE HTML>
    <html>
    <head>
        <title>No Realt Project</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <!-- Bootstrap core CSS -->
        <link href="/static/css/bootstrap.min.css" rel="stylesheet">
        <!-- Material Design Bootstrap -->
        <link href="/static/css/mdb.min.css" rel="stylesheet">
        <!-- Material Design Table -->
        <link href="/static/css/addons/datatables.min.css" rel="stylesheet">
        <link href="/static/css/addons/datatables-select.min.css" rel="stylesheet">
        <!-- Your custom styles (optional) -->
        <link href="/static/css/style.css" rel="stylesheet">
        <!-- SCRIPTS -->
        <!-- JQuery -->
        <script type="text/javascript" src="/static/js/jquery-3.4.1.min.js"></script>
        <!-- Bootstrap tooltips -->
        <script type="text/javascript" src="/static/js/popper.min.js"></script>
        <script type="text/javascript" src="/static/js/footer.js"></script>
        <!-- Material Design Table -->
        <script type="text/javascript" src="/static/js/addons/datatables.min.js"></script>
        <script type="text/javascript" src="/static/js/addons/datatables-select.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#dtBasicExample').DataTable();
                $('.dataTables_length').addClass('bs-select');
            });
        </script>
    </head>

    <body>
        <#include "navbar.ftl">
        <div class=""></div>
<#--        <div class="container mt-5 pt-5 mb-3">-->
        <div class="container mt-3" >
            <#nested>
        </div>
        <#include "footer.ftl">
        <!-- Bootstrap core JavaScript -->
        <script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
        <!-- MDB core JavaScript -->
        <script type="text/javascript" src="/static/js/mdb.min.js"></script>

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </body>
    </html>

</#macro>