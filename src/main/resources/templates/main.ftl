<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <@l.logout />
    <span><a href="/user">User list</a></span>
    <form method="post" enctype="multipart/form-data">
        <input type="text" name="text" placeholder="Введите сообщение" />
        <input type="text" name="tag" placeholder="Тэг">
        <input type="file" name="file">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button type="submit">Добавить</button>
    </form>

    <div>Список сообщений</div>

    <form method="get" action="/main">
        <input type="text" name="filter" value="${filter?ifExists}" placeholder="Поиск по тегу">
        <#--        <input type="hidden" name="_csrf" value="${_csrf.token}" />-->
        <button type="submit">Найти</button>
    </form>

    <form method="get" action="/main">
        <input type="text" name="filter2" value="${filter2?ifExists}" placeholder="Поиск по тексту">
        <#--        <input type="hidden" name="_csrf" value="${_csrf.token}" />-->
        <button type="submit">Найти</button>
    </form>

    <#list messages as message>
        <div>
            <b>${message.id}</b>
            <span>${message.text}</span>
            <i>${message.tag}</i>
            <strong>${message.authorName}</strong>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}">
                </#if>
            </div>
        </div>
    <#else>
        No message
    </#list>
</@c.page>