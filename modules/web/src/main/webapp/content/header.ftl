<#include "/core.ftl">

<table style="height: 40px">
    <tr>
        <td align="left">
            <div class="header-logo">
                <a href="/" style="text-decoration: none !important;">
                    <img alt="logo" src="<@bg.ui.static "images/logo.png"/>" style="vertical-align: bottom"/>

                    <span class="first-letter">Э</span><span>ко</span><span
                        class="first-letter">Е</span><span>жка</span>
                </a>
            </div>
        </td>

        <td align="right" valign="middle">
            <div class="table-cell header-welcome">
            <#if member??>
                Добро Пожаловать,
                <a class="highlight" href="/privacy/view">${member.passport.username}</a>
            <#else>
                Добро Пожаловать!
                <a class="highlight" href="/account/signin">Войти</a>
            </#if>
            </div>

            <div class="table-cell header-links">
            <@bg.security.authorized "member">
                <a class="sample" style="color: gray; " href="/account/signout">Выйти</a>

                <div class="divider">|</div>
            </@bg.security.authorized>

            <@bg.security.authorized "moderator">
                <div><a href="/maintain/main">Поддержка</a></div>
                <div class="divider">|</div>
            </@bg.security.authorized>

                <div><a href="/assistance">Помощь</a></div>

                <div class="divider">|</div>
                <div><b><a href="/assistance/contacts#section2">Заказать обратный звонок</a></b><br><b>с 09:00 до
                    20:00</b></div>
            </div>
        </td>
    </tr>
</table>

