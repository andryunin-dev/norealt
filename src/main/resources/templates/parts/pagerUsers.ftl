<#macro pager url users totalpages min max page size group sort>
    <#if totalpages gt 7>
        <#assign
        totalPages = totalpages
        pageNumber = page + 1

        head = (pageNumber > 4)?then([1, -1], [1, 2, 3])
        tail = (pageNumber < totalPages - 3)?then([-1, totalPages], [totalPages - 2, totalPages - 1, totalPages])
        bodyBefore = (pageNumber > 4 && pageNumber < totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
        bodyAfter = (pageNumber > 2 && pageNumber < totalPages - 3)?then([pageNumber + 1, pageNumber + 2], [])

        body = head + bodyBefore + (pageNumber > 3 && pageNumber < totalPages - 2)?then([pageNumber], []) + bodyAfter + tail
        >
    <#else>
        <#assign body = 1..totalpages>
    </#if>
    <div class="container mt-3">
        <div class="row">
            <ul class="pagination col justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Страницы:</a>
                </li>
                <#list body as p>
                    <#if (p - 1) == page>
                        <li class="page-item active">
                            <a class="page-link" href="#" tabindex="-1">${p}</a>
                        </li>
                    <#elseif p == -1>
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">...</a>
                        </li>
                    <#else>
                        <li class="page-item">
                            <a class="page-link" href="${url}?min=${min?c}&max=${max?c}&size=${size?c}&page=${(p-1)?c}&group=${group}&sort=${sort}" tabindex="-1">${p}</a>
                        </li>
                    </#if>
                </#list>
            </ul>

            <ul class="pagination col justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Элементов:</a>
                </li>
                <#list [25, 50, 100, 500, 1000] as c>
                    <#if c == size>
                        <li class="page-item active">
                            <a class="page-link" href="#" tabindex="-1">${c}</a>
                        </li>
                    <#else>
                        <li class="page-item">
                            <a class="page-link" href="${url}?min=${min?c}&max=${max?c}&size=${c?c}&page=${page?c}&group=${group}&sort=${sort}" tabindex="-1">${c}</a>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>

</#macro>