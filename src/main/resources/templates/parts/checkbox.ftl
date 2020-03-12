<#macro formCheckbox path attributes="">
<@spring.bind path />
<#assign id="${spring.status.expression}">
<#assign status="${spring.stringStatusValue}">
<input type="hidden" name="_${id}" value="false" />
<input type="checkbox" id="${id}" name="${id}"
<#if spring.status.value>checked="checked"</#if>
${attributes}
<@spring.closeTag/>
</#macro>