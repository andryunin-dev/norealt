<#import "parts/common.ftl" as c>

<@c.page>

    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto form p-0
    my-xl-5 my-lg-5 my-md-5 my-sm-5 my-3 ">
        <form method="post" class="p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3">

            <p class="h4 mb-3 text-center">Смена пароля</p>

            <!-- Old Password -->
            <div class="mb-4">
                <input type="password" name="old_password" id="old_password"
                       class="form-control ${(old_passwordErrorUpdate??)?string('is-invalid', '')}"
                       placeholder="Старый пароль">
                <#if old_passwordErrorUpdate??>
                    <div class="invalid-feedback">
                        ${old_passwordErrorUpdate}
                    </div>
                </#if>
            </div>

            <!-- Password -->
            <div class="mb-4">
                <input type="password" name="password" id="password"
                       class="form-control ${(passwordErrorUpdate??)?string('is-invalid', '')}"
                       placeholder="Новый пароль">
                <#if passwordErrorUpdate??>
                    <div class="invalid-feedback">
                        ${passwordErrorUpdate}
                    </div>
                </#if>
            </div>

            <!-- Password2 -->
            <div class="mb-4">
                <input type="password" name="password2" id="password2"
                       class="form-control ${(password2ErrorUpdate??)?string('is-invalid', '')}"
                       placeholder="Повторите новый пароль">
                <#if password2ErrorUpdate??>
                    <div class="invalid-feedback">
                        ${password2ErrorUpdate}
                    </div>
                </#if>
            </div>


            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button class="btn btn-info btn-block my-4" type="submit">Сохранить</button>

        </form>
    </div>

</@c.page>



