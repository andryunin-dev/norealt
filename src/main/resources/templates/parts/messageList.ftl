<#include "security.ftl">
<#--<div class="card-deck" id="message-list">-->
<div class="row">
    <#list messages as message>
    <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 ">
        <div class="card mb-3">
            <div>
                <#if message.filename?has_content>
                    <div class="view view-cascade overlay">
                        <a href="/message/${message.id}">
<#--                            <img src="/img/${message.author.id}/800X800_${message.filename}" width="100%">-->
                            <img src="/img/${message.filename}" width="100%">
                        </a>
                    </div>
                <#else>
                    <div class="view view-cascade overlay">
                        <img class="card-img-top" src="http://91.227.16.31/img/cam.jpg" width="100%">
                    </div>
                </#if>
            </div>

            <div class="card-body card-body-cascade text-center">
                <h4 class="card-title">
                    <strong>
                        <a href="/user-messages/${message.author.id!"null or missing"}">
                            ${message.authorName!"null or missing"}
                        </a>
                    </strong>
                </h4>
                <h6 class="font-weight-bold indigo-text py-2">Тема: ${message.tag}</h6>
                <p class="card-text">${message.text}</p>
            </div>

            <div class="card-footer text-muted text-center">
                id: ${message.id}
                <#if message.author.id == currentUserId || isAdmin>
                    <#include "edit_delete.ftl" />
                </#if>
            </div>

        </div>
    </div>
    <#else>
        No message
    </#list>

</div>
