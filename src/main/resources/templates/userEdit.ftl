<#import "parts/common.ftl" as c>

<@c.page>



    <!-- Default form login -->
    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto form p-0
    my-xl-5 my-lg-5 my-md-5 my-sm-5 my-3 ">
        <form action="/user" method="post" class="p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3">

            <p class="h4 mb-4 text-center">Редактирование пользователя</p>

            <!-- id -->
            <div class="mb-4">
                <label for="id">Id</label>
                <input type="text" id="id" name="id" class="form-control" value="${user.id}" disabled>
            </div>

            <!-- Username -->
            <div class="mb-4">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control" value="${user.username!"null"}">
            </div>

            <!-- Email -->
            <div class="mb-4">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" class="form-control" value="${user.email!"null"}" disabled>
            </div>

            <!-- Activation code -->
            <div class="mb-4">
                <label for="activation_code">Activation code</label>
                <input type="text" id="activation_code" name="activation_code" class="form-control" value="${user.activationCode!"null"}" disabled>
            </div>



            <!-- active -->
            <div class="mb-4">
            <div class="custom-control custom-checkbox">
                <input type="checkbox" class="custom-control-input" id="active" name="active" <#if user.active == true>${user.active?string('checked', '')}</#if>>
                <input type="hidden" name="active" value="false" />
                <label class="custom-control-label" for="active">Статус активности профиля</label>
<#--                <#if user.active == true>-->
<#--                    <input type="checkbox" class="custom-control-input" id="active" name="active" value="${user.active}">-->
<#--                <#elseif user.active == false>-->
<#--                    <input type="checkbox" class="custom-control-input" id="active" value="unchecked">-->
<#--                </#if>-->

<#--                <input type="checkbox" class="custom-control-input" id="active" name="active" value="${user.active?then('checked', 'unchecked')}">-->





            </div>
            </div>

            <!-- Role -->
            <div class="mb-4">
            <#list roles as role>
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="${role}" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                    <label for="${role}" class="custom-control-label">${role}</label>
                </div>
            </#list>
            </div>




            <input type="hidden" value="${user.id}" name="userId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button class="btn btn-info btn-block my-4" type="submit">Сохранить</button>

        </form>
    </div>
    <!-- Default form login -->

<#--    <form action="/user" method="post">-->
<#--        <input type="text" name="username" value="${user.username}">-->
<#--        <#list roles as role>-->
<#--            <div class="custom-control custom-checkbox">-->
<#--                <input type="checkbox" class="custom-control-input" id="${role}" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>-->
<#--                <label for="${role}" class="custom-control-label">${role}</label>-->
<#--            </div>-->
<#--        </#list>-->
<#--        <input type="hidden" value="${user.id}" name="userId">-->
<#--        <input type="hidden" value="${_csrf.token}" name="_csrf">-->
<#--        <button type="submit">Save</button>-->
<#--    </form>-->

</@c.page>



