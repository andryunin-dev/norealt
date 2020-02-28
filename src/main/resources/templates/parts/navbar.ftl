<#include "security.ftl">
<#import "login.ftl" as l>

<!--Navbar -->
<nav class="navbar navbar-expand-lg fixed-top navbar-dark blue-gradient">
    <div class="container">

        <a class="navbar-brand" href="/">No Realt</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-555"
                aria-controls="navbarSupportedContent-555" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent-555">

            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/">Главная</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/main">Messages</a>
                </li>
                <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/user">User List</a>
                </li>
                </#if>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-555" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">Dropdown
                    </a>
                    <div class="dropdown-menu dropdown-info" aria-labelledby="navbarDropdownMenuLink-555">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                    </div>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto nav-flex-icons">



                <#if user??>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-555" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">${name}
                        </a>

                        <div class="dropdown-menu dropdown-menu-lg-right  dropdown-info"
                             aria-labelledby="navbarDropdownMenuLink-55">
                            <a class="dropdown-item" href="/user/profile">Profile</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <a class="dropdown-item" href="#">Something else here</a>
                            <@l.logout />
                        </div>
                    </li>
                </#if>

                <#if user??>
                    <li class="nav-item">
                        <a class="btn btn-info btn-sm btn-rounded waves-effect waves-light" href="/messageAdd" role="button">Новое объявление</a>
                    </li>
                </#if>

                <#if !user??>
                    <li class="nav-item">
                        <a class="nav-link" href="/registration">Регистрация</a>
                    </li>
                </#if>

                <#if !user??>
                    <li class="nav-item">
                        <a class="nav-link" href="/login">Вход</a>
                    </li>
                </#if>
            </ul>

        </div>

    </div>
</nav>
<nav class="navbar navbar-expand-lg navbar-dark blue-gradient">
    <div class="container">
        <a class="navbar-brand" href="/">No Realt</a>
    </div>
</nav>
<!--/.Navbar -->
