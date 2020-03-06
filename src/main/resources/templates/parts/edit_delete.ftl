<a href="/messageEdit/<#if isAdmin>2<#else>${message.author.id}</#if>?message=${message.id}">
    Edit
</a>

<a href="/remove/${message.author.id}/${message.id}/<#if message.filename?has_content>${message.filename}<#else>null</#if>">
    Delete
</a>