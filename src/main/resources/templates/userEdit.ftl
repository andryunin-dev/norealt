<#import "parts/common.ftl" as c>

<@c.page>
    User editor

    <form action="/user" method="post">
        <input type="text" name="username" value="${user.username}">
        <#list roles as role>
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="${role}" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                <label for="${role}" class="custom-control-label">${role}</label>
            </div>
        </#list>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit">Save</button>
    </form>
</@c.page>