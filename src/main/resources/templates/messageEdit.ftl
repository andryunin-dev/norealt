<#import "parts/common.ftl" as c>

<@c.page>

    <h3 class="mb-3">Редактирование объявления</h3>

    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">

            <!-- file -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Текущее фото
                </label>
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-12 col-12 mb-2">
                    <#if message.filename?has_content>
                        <div class="view overlay">
                            <img class="card-img-top" src="/img/${message.filename}" width="100%">
                        </div>
                    <#else>
                        <div class="view overlay">
                            <img class="card-img-top" src="/static/img/cam.jpg" width="100%">
                        </div>
                    </#if>
                </div>
            </div>

            <!-- city -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Город
                </label>
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-12 col-12">
                    <select class="browser-default custom-select custom-select-sm" name="city" id="city">
                        <#if message??>
                            <option value="${message.city}" selected>${message.city}</option>
                        </#if>
                        <option value="Саратов">Саратов</option>
                        <option value="Энгельс">Энгельс</option>
                        <option value="Балаково">Балаково</option>
                    </select>
                </div>
            </div>

            <!-- street -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Улица
                </label>
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-12 col-12">
                    <input class="form-control form-control-sm" type="text" name="street" id="street" value="<#if message??>${message.street}</#if>">
                </div>
            </div>

            <!-- house -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Номер дома
                </label>
                <div class="col-xl-1 col-lg-1 col-md-2 col-sm-3 col-4">
                    <input class="form-control form-control-sm" type="text" name="house" id="house" value="<#if message??>${message.house}</#if>">
                </div>
            </div>

            <!-- object_type -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Тип объекта
                </label>
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-12 col-12">
                    <select class="browser-default custom-select custom-select-sm" name="object_type" id="object_type">
                        <option value="квартира" selected>Квартира</option>
                    </select>
                </div>
            </div>

            <!-- count_rooms -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Кол-во комнат
                </label>
                <div class="col-xl-1 col-lg-1 col-md-2 col-sm-3 col-4">
                    <select class="browser-default custom-select custom-select-sm" name="count_rooms" id="count_rooms">
                        <#if message??>
                            <option value="${message.count_rooms}" selected>${message.count_rooms}</option>
                        </#if>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                    </select>
                </div>
            </div>

            <!-- square -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Площадь
                </label>
                <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-7">
                    <div class="input-group input-group-sm ">
                        <input type="text" class="form-control" name="square" id="square" value="<#if message??>${message.square}</#if>">
                        <div class="input-group-append">
                            <span class="input-group-text">м²</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- floor -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Этаж
                </label>
                <div class="col-xl-1 col-lg-1 col-md-2 col-sm-3 col-4">
                    <select class="browser-default custom-select custom-select-sm" name="floor" id="floor">
                        <#if message??>
                        <option value="${message.floor}" selected>${message.floor}</option>
                        </#if>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                        <option value="32">32</option>
                        <option value="33">33</option>
                        <option value="34">34</option>
                        <option value="35">35</option>
                        <option value="36">36</option>
                        <option value="37">37</option>
                        <option value="38">38</option>
                        <option value="39">39</option>
                        <option value="40">40</option>
                    </select>
                </div>
            </div>

            <!-- num_storeys -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Этажность
                </label>
                <div class="col-xl-1 col-lg-1 col-md-2 col-sm-3 col-4">
                    <select class="browser-default custom-select custom-select-sm" name="num_storeys" id="num_storeys">
                        <#if message??>
                            <option value="${message.num_storeys}" selected>${message.num_storeys}</option>
                        </#if>
                        <option value="1" >1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                        <option value="25">25</option>
                        <option value="26">26</option>
                        <option value="27">27</option>
                        <option value="28">28</option>
                        <option value="29">29</option>
                        <option value="30">30</option>
                        <option value="31">31</option>
                        <option value="32">32</option>
                        <option value="33">33</option>
                        <option value="34">34</option>
                        <option value="35">35</option>
                        <option value="36">36</option>
                        <option value="37">37</option>
                        <option value="38">38</option>
                        <option value="39">39</option>
                        <option value="40">40</option>
                    </select>
                </div>
            </div>

            <!-- text -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Описание
                </label>
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-12 col-12 mb-2">
                    <textarea class="form-control form-control-sm" id="text" rows="7" name="text" ><#if message??>${message.text}</#if></textarea>
                    <#if textError??>
                        <div class="invalid-feedback mt-0 mb-2 ">
                            ${textError}
                        </div>
                    </#if>
                </div>
            </div>

            <!-- price -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Цена
                </label>
                <div class="col-xl-2 col-lg-2 col-md-3 col-sm-4 col-7">
                    <div class="input-group input-group-sm ">
                        <input type="text" class="form-control" name="price" id="price" value="<#if message??>${message.price}</#if>">
                        <div class="input-group-append">
                            <span class="input-group-text">руб.</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- file -->
            <div class="row">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">Новое фото
                </label>
                <div class="col-xl-6 col-lg-7 col-md-8 col-sm-12 col-12">
                    <div class="custom-file">
                        <input type="file" name="file" class="custom-file-input form-control-sm" id="customFileLang" lang="ru">
                        <label class="custom-file-label col-form-label-sm" for="customFileLang">Выберите файл</label>
                    </div>
                </div>
            </div>


            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="filename" value="<#if message??>${message.filename!"null or missing"}</#if>" />

            <div class="row mb-5">
                <label class="col-xl-2 col-lg-3 col-md-4 col-sm-12 col-12
                      col-form-label
                      pb-xl-2 pb-lg-2 pb-md-2 pb-sm-0 pb-0
                      text-xl-right text-lg-right text-md-right text-sm-left text-left">
                </label>
                <button id="submit-message-edit" type="submit" class="btn btn-info ">Сохранить</button>
            </div>

        </form>
    </div>

    <script>
        bootstrapValidate('#square', 'regex:^[0-9.]+$:Неверный формат|max:10:Не более 10 символов!');
        bootstrapValidate('#price', 'regex:^[0-9]+$:только целое число');
        bootstrapValidate('#text', 'min:5:Введите более 5 символов|max:2000:Не более 2000 символов!');
    </script>

</@c.page>