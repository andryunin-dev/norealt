<div class="row mx-0 px-0 mb-3">

    <div class="col-xl-8 col-lg-8 col-md-8 col-sm-12 px-1 pb-1">
        <#list messages as message>
            <!-- Card -->
            <div class="card">

                <!-- Card image -->
                <#if message.filename?has_content>
                    <div class="view overlay">
                        <img class="card-img-top" src="/img/${message.filename}" width="100%">
                    </div>
                <#else>
                    <div class="view overlay">
                        <img class="card-img-top" src="/static/img/cam.jpg" width="100%">
                    </div>
                </#if>

                <!-- Card content -->
                <div class="card-body">

                    <h4 class="card-title mt-2">${message.count_rooms!""}-комн. ${message.object_type!""}, ${message.square!""} м², ${message.floor!""}/${message.num_storeys!""} этаж</h4>
                    <hr>

                    <#if message.price = "null" || message.price = "" || message.price?contains(" ")>
                        <h4 class="card-title">${message.price!""} р.</h4>
                    <#else >
                    <h4 class="card-title">${(message.price?number)?string(",##0")} р.</h4>
                    </#if>

                    <p class="card-text">г. ${message.city!""} ул. ${message.street!""} д. ${message.house!""}</p>

                    <hr>
                    <h4 class="card-title"><a>Описание</a></h4>

                    <p class="card-text">${message.text}</p>

                </div>

            </div>
            <!-- Card -->
        <#else>
            No message
        </#list>
    </div>

    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 px-1">
        <#list messages as message>
            <!-- Card -->
            <div class="card testimonial-card">

                <!-- Background color -->
                <div class="card-up blue-gradient"></div>

                <!-- Avatar -->
                <div class="avatar mx-auto white">
                    <img src="/static/img/icon-user.png" class="rounded-circle">
                </div>

                <!-- Content -->
                <div class="card-body">
                    <!-- Name -->
                    <h4 class="card-title">
                        <a href="/user-messages/${message.author.id!"null or missing"}">
                            ${message.authorName!"null or missing"}
                        </a>
                    </h4>
                    <hr>

                    <h7 class="card-title">
                        <a href="/user-messages/${message.author.id?c!"null or missing"}">
                            Другие объявления пользователя
                        </a>
                    </h7>

                    <hr>
                    <p>№ объявления: ${(message.id)!""}</p>
                    <p>Опубликовано: ${(message.post_date)!""}</p>
                    <p><#if message.author.id == currentUserId || isAdmin>
                            <#include "btn_edit_delete.ftl" />
                        </#if></p>

                    <hr>
                    <h4><span class="badge badge-pill light-blue"><i class="fas fa-phone"></i> ${(user.phone)!""}</span></h4>

                </div>

            </div>
            <!-- Card -->

        <#else>
            No message
        </#list>
    </div>

</div>
