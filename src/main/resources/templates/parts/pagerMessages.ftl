<#macro pager url messages totalpages min max page size group sort city countRooms>
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
                            <a class="page-link" href="${url}?size=${size?c}&amp;page=${(p-1)?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" tabindex="-1">${p}</a>
                        </li>
                    </#if>
                </#list>
            </ul>



            <ul class="pagination col justify-content-center">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Элементов:</a>
                </li>
                <#list [12, 24, 48, 96] as c>
                    <#if c == size>
                        <li class="page-item active">
                            <a class="page-link" href="#" tabindex="-1">${c}</a>
                        </li>
                    <#else>
                        <li class="page-item">
                            <a class="page-link" href="${url}?size=${c?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" tabindex="-1">${c}</a>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>

</#macro>
