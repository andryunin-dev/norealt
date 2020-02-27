<div class="form-group mt-3">
    <form method="get" action="/main">
        <input type="text" name="filter2" class="form-control" value="${filter2?ifExists}" placeholder="Поиск по тексту">
    </form>
</div>

<div class="form-group mt-3">
    <form method="get" action="/main">
        <input type="text" name="filter" class="form-control" value="${filter?ifExists}" placeholder="Поиск по теме">
        <#--        <button type="submit" class="btn btn-primary ml-2">Найти</button>-->
    </form>
</div>