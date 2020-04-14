<#import "parts/common.ftl" as c>
<#import "parts/pagerUsers.ftl" as p>

<@c.page>
    <h3 class="text-center">Пользователи</h3>

    <input type="hidden" id="max_id" name="max_id" value="${max_id?c}" />

    <form class="form-group row" action="/administration/user_list" method="get">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 px-4">
            <div class="row align-items-center">

                <div class="col-12 col-lg-7 col-sm-12">
                    <div id="slider-connect"></div>
                </div>
                <div class="col-5 col-lg-2 col-sm-5">
                    <input type="number" class="form-control form-control-sm" name="min" id="input-min">
                </div>
                <div class="col-5 col-lg-2 col-sm-5">
                    <input type="number" class="form-control form-control-sm" name="max" id="input-max">
                </div>
                <div class="col-1 col-lg-1 col-sm-1">
                    <button type="submit" class="btn btn-primary btn-sm px-3"><i class="fas fa-check" aria-hidden="true"></i></button>
                </div>

            </div>
        </div>
    </form>

    <script>
        window.onload = function() {
            var connectSlider = document.getElementById('slider-connect');
            var max_id = document.getElementById('max_id').value;
            max_id = Number(max_id);
            noUiSlider.create(connectSlider, {
                start: [0, max_id],
                connect: [false, true, false],
                keyboardSupport: true,
                margin: 1,
                step: 1,
                range: {
                    'min': 0,
                    'max': max_id
                }
            });

            var inputMin = document.getElementById('input-min');
            var inputMax = document.getElementById('input-max');

            connectSlider.noUiSlider.on('update', function (values, handle) {

                var value = values[handle];

                if (handle) {
                    inputMax.value = Math.round(value);
                } else {
                    inputMin.value = Math.round(value);
                }
            });

            inputMin.addEventListener('change', function () {
                connectSlider.noUiSlider.set([this.value, null]);
            });

            inputMax.addEventListener('change', function () {
                connectSlider.noUiSlider.set([null, this.value]);
            });

        }
    </script>



    <@p.pager url users totalpages min max page size group sort />

    <div>Найдено <b>${totalelements?c}</b></div>
    <div>MAX ID :<b>${max_id?c}</b></div>



    <table id="dtBasicExample" class="table table-striped table-bordered table-sm table-responsive" cellspacing="0" width="100%">
        <thead>
        <tr class="text-center">
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=id&sort=asc"><i class="fas fa-sort-up"></i></a>
                #
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=id&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=email&sort=asc"><i class="fas fa-sort-up"></i></a>
                Email
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=email&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=username&sort=asc"><i class="fas fa-sort-up"></i></a>
                Name
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=username&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=phone&sort=asc"><i class="fas fa-sort-up"></i></a>
                Phone
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=phone&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=active&sort=asc"><i class="fas fa-sort-up"></i></a>
                Active
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=active&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=registrationDate&sort=asc"><i class="fas fa-sort-up"></i></a>
                Registration
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=registrationDate&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=lastVisit&sort=asc"><i class="fas fa-sort-up"></i></a>
                LastVisit
                <a href="?min=${min?c}&max=${max?c}&size=${size?c}&page=${page?c}&group=lastVisit&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td width="2%" >${user.id?c}</td>
                <td width="25%"><a href="/administration/edit/${user.id?c}">${user.email!"null"}</a></td>
                <td width="15%">${user.username}</td>
                <td width="13%">${user.phone}</td>
                <td width="2%" >${user.active?string('yes', 'no')}</td>
                <td width="20%">${user.registrationDate!"null"}</td>
                <td width="23%">${user.lastVisit!"null"}</td>
            </tr>
        </#list>

        </tbody>
        <tfoot>
        <tr>
            <th>#</th>
            <th>Email</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Active</th>
            <th>Registration</th>
            <th>LastVisit</th>
        </tr>
        </tfoot>
    </table>

    <@p.pager url users totalpages min max page size group sort />

</@c.page>