<#include "security.ftl">

<div class="row ">
    <#list messages as message>
    <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 ">
        <div class="card mb-3">

            <!-- Card image -->
            <div>
                <#if message.filename?has_content>
                    <div class="view overlay">
                        <img class="card-img-top" src="/img/${message.filename}" width="100%">
                        <a href="/message/${message.id?c}">
                            <div class="mask rgba-white-slight"></div>
                        </a>
                    </div>
                <#else>
                    <div class="view overlay">
                        <img class="card-img-top" src="/static/img/cam.jpg" width="100%">
                        <a href="/message/${message.id?c}">
                            <div class="mask rgba-white-slight"></div>
                        </a>
                    </div>
                </#if>
            </div>

            <!-- Card content -->
            <div class="card-body card-body-cascade text-left">

                <#if message.price = "null" || message.price = "" || message.price?contains(" ")>
                    <h6 class="card-title"><strong>${message.price!""} р.</strong></h6>
                <#else >
                    <h6 class="card-title"><strong>${(message.price?number)?string(",##0")} р.</strong></h6>
                </#if>
                <p class="card-text mb-0"><strong class="indigo-text">${message.count_rooms!""}-к. ${message.object_type!""}</strong>
                    <strong class="black-text"> | ${message.square!""} м² | ${message.floor!""}/${message.num_storeys!""} эт.</strong></p>
                <p class="card-text mb-0">ул. ${message.street!""} д. ${message.house!""}</p>
                <p class="card-text"><strong class="black-text">г. ${message.city!""}</strong>
                    <#if message.author.id == currentUserId || isAdmin>
                        <#include "btn_edit_delete.ftl" />
                    </#if>
                </p>

            </div>

        </div>
    </div>
    <#else>
        No message
    </#list>

</div>
