<#import "parts/common.ftl" as c>

<@c.page>

    <h2>Список пользователей</h2>

    <table id="dtBasicExample" class="table table-striped table-bordered table-sm table-responsive" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th class="th-sm">ID</th>
            <th class="th-sm">Email</th>
            <th class="th-sm">Name</th>
            <th class="th-sm">Phone</th>
            <th class="th-sm">Active</th>
            <th class="th-sm">LastVisit</th>
            <th class="th-sm">Role</th>
            <th class="th-sm">Edit</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td width="5%">${user.id}</td>
                <td width="25%">${user.email!"null"}</td>
                <td width="15%">${user.username}</td>
                <td width="13%">${user.phone}</td>
                <td width="5%">${user.active?string('yes', 'no')}</td>
                <td width="22%">${user.lastVisit!"null"}</td>
                <td width="10%"><#list user.roles as role>${role}<#sep>, </#list></td>
                <td width="5%"><a href="/administration/edit/${user.id}">Edit</a></td>
            </tr>
        </#list>

        </tbody>
        <tfoot>
        <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Name</th>
            <th>Phone</th>
            <th>Active</th>
            <th>LastVisit</th>
            <th>Role</th>
            <th>Edit</th>
        </tr>
        </tfoot>
    </table>

</@c.page>