<#import "parts/common.ftl" as c>

<@c.page>

    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto text-center form p-0
    mt-xl-5 mt-lg-5 mt-md-5 mt-sm-5 mt-3 ">
        <form class="text-center p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3"
              method="post">

            <#if message??>
                <div class="alert alert-${messageRestore}" role="alert">
                    ${message}
                </div>
            </#if>

            <p class="h4 mb-4">Восстановление пароля</p>

            <!-- Email -->
            <div class="mb-4">
                <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                       id="email"
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       placeholder="Электронная почта">
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>

            <!-- Sign in button -->
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button class="btn btn-info btn-block my-4" type="submit">Сбросить пароль</button>

        </form>
    </div>

</@c.page>