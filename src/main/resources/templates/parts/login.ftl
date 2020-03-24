<#include "security.ftl">
<#macro login path isRegisterForm>
    <!-- Default form login -->
    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto text-center form p-0
    mt-xl-5 mt-lg-5 mt-md-5 mt-sm-5 mt-3 ">
        <form class="text-center p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3"
              action="${path}"
              method="post">

            <p class="h4 mb-4"><#if !isRegisterForm>Вход<#else>Регистрация</#if></p>

            <#if isRegisterForm>
            <!-- Username -->
            <div class="mb-4">
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       id="username"
                       class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       placeholder="Имя" />
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
            </#if>

            <!-- Email -->
            <div class="mb-4">
                <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                   id="email"
                   class="form-control
<#--                        ${(emailError??)?string('is-invalid', '')}-->
                    "
                   placeholder="Электронная почта">
<#--                <#if emailError??>-->
<#--                    <div class="invalid-feedback">-->
<#--                        ${emailError}-->
<#--                    </div>-->
<#--                </#if>-->
            </div>

            <!-- Phone -->
            <#if isRegisterForm>
                <div class="mb-4">
                    <input type="text" name="phone" value="<#if user??>${user.phone}</#if>"
                           id="phone"
                           class="form-control ${(phoneError??)?string('is-invalid', '')}"
                           placeholder="Телефон">
                    <#if phoneError??>
                        <div class="invalid-feedback">
                            ${phoneError}
                        </div>
                    </#if>
                </div>
            </#if>

            <!-- Password -->
            <div class="mb-4">
                <input type="password" name="password" id="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Пароль">
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>

            <!-- Password2 -->
            <#if isRegisterForm>
            <div class="mb-4">
                <input type="password" name="password2" id="password2"
                       class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       placeholder="Повторите пароль">
                <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
            </#if>

            <!-- recaptcha -->
            <#if isRegisterForm>
            <div class="mb-4" id="recaptcha">
                <div class="g-recaptcha" data-sitekey="6LcjyMAUAAAAABy8qsBXe4ETeIRTq6SB2sF-RgiH"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
            </div>
            <div class="mb-4">
                Подтверждение регистрации будет отправлено на вашу почту.
            </div>
            </#if>

            <!-- Sign in button -->
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button class="btn btn-info btn-block my-4" id="submit" type="submit"><#if !isRegisterForm>Войти<#else>Зарегистрироваться</#if></button>

            <#if !isRegisterForm>
                <div class="d-flex justify-content-around">
                    <div>
                        <!-- Register -->
                        <a href="/registration">Зарегистрироваться</a>
                    </div>
                    <div>
                        <!-- Forgot password -->
                        <a href="/restore">Забыли пароль?</a>
                    </div>
                </div>
            </#if>
        </form>
    </div>
    <!-- Default form login -->
    <#if isRegisterForm>
        <!-- bootstrap-validate-settings -->
        <script>
            bootstrapValidate('#username', 'max:255:Не более 255 символов!');
            bootstrapValidate('#email', 'email:Введите корректный email.|max:255:Не более 255 символов!');
            bootstrapValidate('#password', 'max:255:Не более 255 символов!');
            bootstrapValidate('#password2', 'matches:#password:Пароли не совпадают!|max:255:Не более 255 символов!');
        </script>
    </#if>

    <#if !isRegisterForm>
        <!-- bootstrap-validate-settings -->
        <script>
            bootstrapValidate('#email', 'email:Введите корректный email.|max:255:Не более 255 символов!');
            bootstrapValidate('#password', 'max:255:Не более 255 символов!');
        </script>
    </#if>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="submit" value="Выход" class="dropdown-item"/>
    </form>
</#macro>
