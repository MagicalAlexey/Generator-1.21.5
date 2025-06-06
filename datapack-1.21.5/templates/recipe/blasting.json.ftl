<#-- @formatter:off -->
<#include "../mcitems.ftl">
{
    "type": "minecraft:blasting",
    <#if data.group?has_content>"group": "${data.group}",</#if>
    "category": "${data.cookingBookCategory?lower_case}",
    "experience": ${data.xpReward},
    "cookingtime": ${data.cookingTime},
    "ingredient": "${mappedMCItemToRegistryName(data.blastingInputStack, true)}",
    "result": {
        ${mappedMCItemToItemObjectJSON(data.blastingReturnStack, "id")}
    }
}
<#-- @formatter:on -->