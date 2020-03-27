<#import "parts/common.ftl" as c>

<@c.page>

    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto form p-0
    my-xl-5 my-lg-5 my-md-5 my-sm-5 my-3 ">
        <form method="post" class="p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3">

            <p class="h4 mb-3 text-center">Редактирование пользователя</p>

            <!-- id -->
            <div class="mb-2">
                <label for="id">ID</label>
                <input type="text" id="id" name="id" class="form-control" value="${user.id}" disabled>
            </div>

            <!-- Email -->
            <div class="mb-2">
                <label for="email">Электронная почта</label>
                <input type="text" id="email" name="email" class="form-control" value="${user.email!"null"}" disabled>
            </div>

            <!-- Username -->
            <div class="mb-2">
                <label for="username">Имя</label>
                <input type="text" id="username" name="username" class="form-control" value="${user.username!"null"}">
            </div>

            <!-- Phone -->
            <div class="mb-2">
                <label for="phone">Телефон</label>
                <input type="text" id="phone" name="phone" class="form-control" value="${user.phone!"null"}">
            </div>

            <!-- LastVisit -->
            <div class="mb-2">
                <label for="lastVisit">Последний визит</label>
                <input type="text" id="lastVisit" name="lastVisit" class="form-control" value="${user.lastVisit!"null"}" disabled>
            </div>

            <!-- Registration date -->
            <div class="mb-2">
                <label for="registrationDate">Дата регистрации</label>
                <input type="text" id="registrationDate" name="registrationDate" class="form-control" value="${user.registrationDate!"null"}" disabled>
            </div>

            <!-- Activation code -->
            <div class="mb-2">
                <label for="activation_code">Код активации</label>
                <input type="text" id="activation_code" name="activation_code" class="form-control" value="${user.activationCode!"null"}" disabled>
            </div>

            <!-- active -->
            <div class="mb-2">
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="active" name="active" <#if user.active == true>${user.active?string('checked', '')}</#if>>
                    <input type="hidden" name="active" value="false" />
                    <label class="custom-control-label" for="active">Статус активности профиля</label>
                </div>
            </div>

            <!-- Role -->
            <div class="mb-2">
            <#list roles as role>
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="${role}" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                    <label for="${role}" class="custom-control-label">${role}</label>
                </div>
            </#list>
            </div>

            <!-- Restore code -->
            <div class="mb-2">
                <label for="restoreCode">Код восстановления</label>
                <input type="text" id="restoreCode" name="restoreCode" class="form-control" value="${user.restoreCode!"null"}" disabled>
            </div>


            <input type="hidden" value="${user.id?c}" name="userId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button class="btn btn-info btn-block my-4" type="submit">Сохранить</button>

        </form>
    </div>

</@c.page>



