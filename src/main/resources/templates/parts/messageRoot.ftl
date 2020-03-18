<#list messages as message>
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="row">

                    <div class="col-8">
                        <!-- Card image -->
                        <#if message.filename?has_content>
                            <div class="view overlay">
                                <img class="card-img-top" src="/img/${message.filename}" width="100%">
                            </div>
                        <#else>
                            <div class="view overlay">
                                <img class="card-img-top" src="http://91.227.16.31/img/cam.jpg" width="100%">
                            </div>
                        </#if>

                        <#--                        <div class="view overlay">-->
                        <#--                            <img class="card-img-top" src="/img/${message.author.id}/<#if message.filename?has_content>${message.filename}<#else>cam.jpg</#if>">-->
                        <#--                        </div>-->
                    </div>

                    <div class="col-4">
                        <!-- Card content -->
                        <div class="card-body">

                            <!-- Title -->
                            <h4 class="card-title">
                                <a href="/user-messages/${message.author.id!"null or missing"}">
                                    ${message.authorName!"null or missing"}
                                </a>
                            </h4>
                            <hr>
                            <!-- Text -->
                            <h6 class="font-weight-bold indigo-text py-2">Тема: ${message.tag}</h6>
                            <hr>
                            <p class="card-text">${message.text}</p>

                        </div>
                    </div>


                </div>

                <!-- Card footer -->
                <div class="rounded-bottom mdb-color lighten-3 text-center pt-3">

                    <ul class="list-unstyled list-inline font-small">
                        <li class="list-inline-item pr-2 white-text">
                            id: ${message.id}
                            <#if message.author.id == currentUserId || isAdmin>

                                <#include "btn_edit_delete.ftl" />

                            </#if>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

<#else>
    No message
</#list>
