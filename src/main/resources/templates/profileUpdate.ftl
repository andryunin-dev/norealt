<#import "parts/common.ftl" as c>

<@c.page>

    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto form p-0
    my-xl-5 my-lg-5 my-md-5 my-sm-5 my-3 ">
        <form method="post" class="p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3">

            <#if message??>
                <div class="alert alert-${messageUpdateUserProfile}" role="alert">
                    ${message}
                </div>
            </#if>

            <p class="h4 mb-3 text-center">Редактирование пользователя</p>

            <!-- Email -->
            <div class="mb-2">
                <label for="email">Электронная почта</label>
                <input type="text" id="email" name="email" class="form-control" value="${(user.email)!""}" disabled>
            </div>

            <!-- Username -->
            <div class="mb-2">
                <label for="username">Имя</label>
                <input type="text" id="username" name="username"
                       class="form-control ${(usernameErrorEmpty??)?string('is-invalid', '')}"
                       value="${(user.username)!""}">
                <#if usernameErrorEmpty??>
                    <div class="invalid-feedback">
                        ${usernameErrorEmpty}
                    </div>
                </#if>
            </div>

            <!-- Phone -->
            <div class="mb-2">
                <label for="phone">Телефон</label>
                <input type="text" id="phone" name="phone"
                       class="form-control ${(phoneErrorEmpty??)?string('is-invalid', '')}"
                       value="${(user.phone)!""}">
                <#if phoneErrorEmpty??>
                    <div class="invalid-feedback">
                        ${phoneErrorEmpty}
                    </div>
                </#if>
            </div>

            <!-- LastVisit -->
            <div class="mb-2">
                <label for="lastVisit">Последний визит</label>
                <input type="text" id="lastVisit" name="lastVisit" class="form-control" value="${(user.lastVisit)!"null"}" disabled>
            </div>

            <!-- Registration date -->
            <div class="mb-2">
                <label for="registrationDate">Дата регистрации</label>
                <input type="text" id="registrationDate" name="registrationDate" class="form-control" value="${(user.registrationDate)!"null"}" disabled>
            </div>


            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button class="btn btn-info btn-block my-4" type="submit">Сохранить</button>

            <div class="d-flex justify-content-around">
                <div>
                    <!-- Edit password -->
                    <a href="/profile/password_update">Изменить пароль</a>
                </div>
            </div>

        </form>
    </div>

</@c.page>



