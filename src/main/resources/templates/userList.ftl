<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>

<@c.page>
    <h2>Список пользователей</h2>

    <@p.pager url users totalpages page size group sort />



    <table id="dtBasicExample" class="table table-striped table-bordered table-sm table-responsive" cellspacing="0" width="100%">
        <thead>
        <tr class="text-center">
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=id&sort=asc"><i class="fas fa-sort-up"></i></a>
                #
                <a href="?size=${size?c}&page=${page?c}&group=id&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=email&sort=asc"><i class="fas fa-sort-up"></i></a>
                Email
                <a href="?size=${size?c}&page=${page?c}&group=email&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=username&sort=asc"><i class="fas fa-sort-up"></i></a>
                Name
                <a href="?size=${size?c}&page=${page?c}&group=username&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=phone&sort=asc"><i class="fas fa-sort-up"></i></a>
                Phone
                <a href="?size=${size?c}&page=${page?c}&group=phone&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=active&sort=asc"><i class="fas fa-sort-up"></i></a>
                Active
                <a href="?size=${size?c}&page=${page?c}&group=active&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=registrationDate&sort=asc"><i class="fas fa-sort-up"></i></a>
                Registration
                <a href="?size=${size?c}&page=${page?c}&group=registrationDate&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
            <th class="th-sm">
                <a href="?size=${size?c}&page=${page?c}&group=lastVisit&sort=asc"><i class="fas fa-sort-up"></i></a>
                LastVisit
                <a href="?size=${size?c}&page=${page?c}&group=lastVisit&sort=desc"><i class="fas fa-sort-down"></i></a>
            </th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td width="2%" >${user.id}</td>
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

    <@p.pager url users totalpages page size group sort />

</@c.page>