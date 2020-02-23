<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <div>Add new user</div>
    ${message?ifExists}
<#-- или -->
<#--    ${message!}-->
    <@l.login "/registration" />
</@c.page>