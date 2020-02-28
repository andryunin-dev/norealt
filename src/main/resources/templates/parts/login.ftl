<#include "security.ftl">
<#macro login path isRegisterForm>
    <!-- Default form login -->
    <div class="card col-xl-6 col-lg-7 col-md-9 col-sm-12 mx-auto text-center form p-0
    mt-xl-5 mt-lg-5 mt-md-5 mt-sm-5 mt-3 ">
        <form class="text-center p-xl-5 p-lg-5 p-md-5 p-sm-5 py-4 px-3"
              action="${path}"
              method="post">

            <p class="h4 mb-4"><#if !isRegisterForm>Вход<#else>Регистрация</#if></p>

            <!-- Username -->
            <div class="mb-4">
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       id="defaultLoginFormEmail"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Имя пользователя" />
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>

            <!-- Email -->
            <#if isRegisterForm>
            <div class="mb-4">
                <input type="email" name="email" value="<#if user??>${user.email}</#if>"
                   id="defaultLoginFormEmail"
                   class="form-control ${(emailError??)?string('is-invalid', '')}"
                   placeholder="some@some.com">
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
            </#if>

            <!-- Password -->
            <div class="mb-4">
                <input type="password" name="password" id="defaultLoginFormPassword"
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
                <input type="password" name="password2" id="defaultLoginFormPassword2"
                       class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       placeholder="Повторите пароль">
                <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
            </#if>


            <#if !isRegisterForm>
            <div class="d-flex justify-content-around">
                <div>
                    <!-- Remember me -->
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="defaultLoginFormRemember">
                        <label class="custom-control-label" for="defaultLoginFormRemember">Запомнить пароль</label>
                    </div>
                </div>
                <div>
                    <!-- Forgot password -->
                    <a href="">Забыли пароль?</a>
                </div>
            </div>
            </#if>

            <!-- Sign in button -->
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button class="btn btn-info btn-block my-4" type="submit"><#if !isRegisterForm>Войти<#else>Зарегистрироваться</#if></button>

            <!-- Register -->
            <#if !isRegisterForm>
            <p>
                <a href="/registration">Зарегистрироваться</a>
            </p>
            </#if>


        </form>
    </div>
    <!-- Default form login -->
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <input type="submit" value="Sign Out" class="dropdown-item"/>
    </form>
</#macro>
