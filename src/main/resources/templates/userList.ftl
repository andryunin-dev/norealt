<#import "parts/common.ftl" as c>

<@c.page>

    <h2>Список пользователей</h2>

    <table id="dtBasicExample" class="table table-striped table-bordered table-sm table-responsive" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th class="th-sm">ID</th>
            <th class="th-sm">Name</th>
            <th class="th-sm">Email</th>
            <th class="th-sm">Active</th>
            <th class="th-sm">Activation code</th>
            <th class="th-sm">Role</th>
            <th class="th-sm">Edit</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td width="5%">${user.id}</td>
                <td width="10%">${user.username}</td>
                <td width="30%">${user.email!"null"}</td>
                <td width="5%">${user.active?string('yes', 'no')}</td>
                <td width="35%">${user.activationCode!"null"}</td>
                <td width="10%"><#list user.roles as role>${role}<#sep>, </#list></td>
                <td width="5%"><a href="/user/${user.id}">Edit</a></td>
            </tr>
        </#list>

        </tbody>
        <tfoot>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Active</th>
            <th>Activation code</th>
            <th>Role</th>
            <th>Edit</th>
        </tr>
        </tfoot>
    </table>

</@c.page>