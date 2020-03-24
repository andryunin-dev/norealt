<#import "parts/common.ftl" as c>

<@c.page>

    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto text-center form p-0
    mt-xl-5 mt-lg-5 mt-md-5 mt-sm-5 mt-3 ">
        <form class="text-center p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3"
              method="post">

            <#if message??>
                <div class="alert alert-${messageRestorePass}" role="alert">
                    ${message}
                </div>
            </#if>

            <#assign messageAllert=messageRestorePass!"null"/>

            <#if messageAllert=="success" || messageAllert=="null">
            <p class="h4 mb-4">Восстановление пароля</p>

            <!-- Password -->
            <div class="mb-4">
                <input type="password" name="password" id="password"
                       class="form-control ${(passwordErrorRestore??)?string('is-invalid', '')}"
                       placeholder="Пароль">
                <#if passwordErrorRestore??>
                    <div class="invalid-feedback">
                        ${passwordErrorRestore}
                    </div>
                </#if>
            </div>

            <!-- Password2 -->
            <div class="mb-4">
                <input type="password" name="password2" id="password2"
                       class="form-control ${(password2ErrorRestore??)?string('is-invalid', '')}"
                       placeholder="Повторите пароль">
                <#if password2ErrorRestore??>
                    <div class="invalid-feedback">
                        ${password2ErrorRestore}
                    </div>
                </#if>
            </div>

            <!-- Sign in button -->
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button class="btn btn-info btn-block my-4" id="submit" type="submit" disabled>Сохранить</button>
            </#if>

        </form>
    </div>
    <script>
        bootstrapValidate('#password', 'max:255:Не более 255 символов!');
        bootstrapValidate('#password2', 'matches:#password:Пароли не совпадают!|max:255:Не более 255 символов!');
    </script>

</@c.page>