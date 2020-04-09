<a href="/remove/${message.author.id?c}/${message.id?c}/<#if message.filename?has_content>${message.filename}<#else>null</#if>">
    Delete
</a>
<a href="/messageEdit/<#if isAdmin>2<#else>${message.author.id?c}</#if>?message=${message.id?c}">
    Edit
</a>
