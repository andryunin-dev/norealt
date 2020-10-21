<#import "parts/common.ftl" as c>
<#import "parts/pagerMessages.ftl" as p>

<@c.page>

    <input type="hidden" id="max_price" name="max_price" value="${max_price?c}" />
    <input type="hidden" id="min_price" name="min_price" value="${min_price?c}" />
    <form class="form-group row" action="/main" method="get">
        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 px-4">
            <div class="row align-items-center">

                <input type="hidden" name="size" value="${size?c}" />
                <input type="hidden" name="page" value="${page?c}" />
                <input type="hidden" name="group" value="${group}" />
                <input type="hidden" name="sort" value="${sort}" />

                <div class="col-12 col-lg-7 col-sm-12">
                    <div id="slider-connect-messages"></div>
                </div>
                <div class="col-5 col-lg-2 col-sm-5">
                    <input type="number" class="form-control form-control-sm" name="min" id="input-min" />
                </div>
                <div class="col-5 col-lg-2 col-sm-5">
                    <input type="number" class="form-control form-control-sm" name="max" id="input-max" />
                </div>

                <#if city != " "><input type="hidden" name="city" value="${city}" /></#if>
                <#if countRooms != " "><input type="hidden" name="countRooms" value="${countRooms}" /></#if>

                <div class="col-1 col-lg-1 col-sm-1">
                    <button type="submit" class="btn btn-primary btn-sm px-3"><i class="fas fa-check" aria-hidden="true"></i></button>
                </div>

            </div>
        </div>
    </form>
    <script>
        window.onload = function() {

            var min = getAllUrlParams().min;
            var max = getAllUrlParams().max;

            var connectSlider = document.getElementById('slider-connect-messages');
            var max_price = document.getElementById('max_price').value;
            max_price = Number(max_price);
            var min_price = document.getElementById('min_price').value;
            min_price = Number(min_price);
            var newmin;
            var newmax;

            
            if (min === undefined) {
                newmin = min_price;
            } else {
                newmin = min;
            }

            if (max === undefined) {
                newmax = max_price;
            } else {
                newmax = max;
            }

            noUiSlider.create(connectSlider, {
                start: [newmin, newmax],
                connect: [false, true, false],
                keyboardSupport: true,
                margin: 1,
                step: 1,
                range: {
                    'min': min_price,
                    'max': max_price
                }
            });

            var inputMin = document.getElementById('input-min');
            var inputMax = document.getElementById('input-max');

            connectSlider.noUiSlider.on('update', function (values, handle) {

                var value = values[handle];

                if (handle) {
                    inputMax.value = Math.round(value);
                } else {
                    inputMin.value = Math.round(value);
                }
            });

            inputMin.addEventListener('change', function () {
                connectSlider.noUiSlider.set([this.value, null]);
            });

            inputMax.addEventListener('change', function () {
                connectSlider.noUiSlider.set([null, this.value]);
            });

        }
    </script>

    <div class="row">

        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-6">
            <div>
                Сортировать:
            </div>
            <select class="browser-default custom-select custom-select-sm" onchange="location = this.value;" id="sort-group">
                <option data-class="0" value="?size=${size?c}&amp;page=${page?c}&amp;group=id&amp;sort=desc<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>">По умолчанию</option>
                <option data-class="1" value="?size=${size?c}&amp;page=${page?c}&amp;group=price&amp;sort=asc<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >По цене, сначала дешевые</option>
                <option data-class="2" value="?size=${size?c}&amp;page=${page?c}&amp;group=price&amp;sort=desc<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >По цене, сначала дорогие</option>
                <option data-class="3" value="?size=${size?c}&amp;page=${page?c}&amp;group=postDate&amp;sort=asc<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >По дате, сначала старые</option>
                <option data-class="4" value="?size=${size?c}&amp;page=${page?c}&amp;group=postDate&amp;sort=desc<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >По дате, сначала новые</option>
            </select>
        </div>

        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-6">
            <div>
                Город:
            </div>
            <select class="browser-default custom-select custom-select-sm" onchange="location = this.value;" id="sort-city">
                <option data-class="0" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if countRooms != " ">&amp;countRooms=${countRooms}</#if>">Любой</option>
                <option data-class="1" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if>&amp;city=Саратов<#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >Саратов</option>
                <option data-class="2" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if>&amp;city=Энгельс<#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >Энгельс</option>
                <option data-class="3" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if>&amp;city=Балаково<#if countRooms != " ">&amp;countRooms=${countRooms}</#if>" >Балаково</option>
            </select>
        </div>

        <div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-6">
            <div>
                Квартира:
            </div>
            <select class="browser-default custom-select custom-select-sm" onchange="location = this.value;" id="sort-countRooms">
                <option data-class="0" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>">Любая</option>
                <option data-class="1" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=1" >1-к. квартира</option>
                <option data-class="2" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=2" >2-к. квартира</option>
                <option data-class="3" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=3" >3-к. квартира</option>
                <option data-class="4" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=4" >4-к. квартира</option>
                <option data-class="5" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=5" >5-к. квартира</option>
                <option data-class="6" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=6" >6-к. квартира</option>
                <option data-class="7" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=7" >7-к. квартира</option>
                <option data-class="8" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=8" >8-к. квартира</option>
                <option data-class="9" value="?size=${size?c}&amp;page=${page?c}&amp;group=${group}&amp;sort=${sort}<#if min != 0>&amp;min=${min?c}</#if><#if max != 2000000000>&amp;max=${max?c}</#if><#if city != " ">&amp;city=${city}</#if>&amp;countRooms=9" >9-к. квартира</option>
            </select>
        </div>

    </div>

    <div class="row">

        <div>
            <@p.pager url messages totalpages min max page size group sort city countRooms/>
        </div>

    </div>

    <div>Найдено <b>${totalelements?c}</b></div>

    <script type="text/javascript">
        $(document).ready(function() {
            var sort = getAllUrlParams().sort;

            var $container = $('.content');

            var $select1 = $('#sort-group');
            var $select2 = $('#sort-city');
            var $select3 = $('#sort-countRooms');

            var cookie1 = localStorage.getItem("s1");
            var cookie2 = localStorage.getItem("s2");
            var cookie3 = localStorage.getItem("s3");

            if (sort === undefined) {
                cookie1 = 0;
                cookie2 = 0;
                cookie3 = 0;
            }

            if (cookie1) {
                $select1.find('[data-class="' + cookie1 + '"]').attr('selected', 's1');
            }
            if (cookie2) {
                $select2.find('[data-class="' + cookie2 + '"]').attr('selected', 's2');
            }
            if (cookie3) {
                $select3.find('[data-class="' + cookie3 + '"]').attr('selected', 's3');
            }

            handleSelectValue1();
            handleSelectValue2();
            handleSelectValue3();

            $select1.on('change', handleSelectValue1);
            $select2.on('change', handleSelectValue2);
            $select3.on('change', handleSelectValue3);

            function handleSelectValue1() {
                var selectedClass = $select1.find(':selected').data('class');
                $container.toggleClass('column', selectedClass != 'line');
                localStorage.setItem("s1", selectedClass);
            }

            function handleSelectValue2() {
                var selectedClass = $select2.find(':selected').data('class');
                $container.toggleClass('column', selectedClass != 'line');
                localStorage.setItem("s2", selectedClass);
            }

            function handleSelectValue3() {
                var selectedClass = $select3.find(':selected').data('class');
                $container.toggleClass('column', selectedClass != 'line');
                localStorage.setItem("s3", selectedClass);
            }
        });
    </script>

    <script type="text/javascript" src="/static/js/getAllUrlParams.js"></script>

    <#include "parts/messageList.ftl" />

    <div class="row">

        <div>
            <@p.pager url messages totalpages min max page size group sort city countRooms/>
        </div>

    </div>

</@c.page>
