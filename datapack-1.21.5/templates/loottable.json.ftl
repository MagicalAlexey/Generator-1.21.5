<#include "mcitems.ftl">
<#function hasToolContext>
  <#return data.type == "Block" || data.type == "Fishing" || data.type == "Generic">
</#function>
{
  "type": "minecraft:${data.type?lower_case?replace(" ", "_")}",
  "pools": [
    <#list data.pools as pool>
        {
          <#if pool.minrolls == pool.maxrolls>
          "rolls": ${pool.minrolls},
          <#else>
          "rolls": {
            "min": ${pool.minrolls},
            "max": ${pool.maxrolls}
          },
          </#if>
          <#if pool.hasbonusrolls>
              <#if pool.minbonusrolls == pool.maxbonusrolls>
              "bonus_rolls": ${pool.minbonusrolls},
              <#else>
              "bonus_rolls": {
                "min": ${pool.minbonusrolls},
                "max": ${pool.maxbonusrolls}
              },
              </#if>
          </#if>
          "entries": [
            <#list pool.entries as entry>
              {
                <#assign item = mappedMCItemToRegistryName(entry.item)>
                <#if entry.item.isAir() || item == "minecraft:air">
                "type": "minecraft:empty",
                <#else>
                "type": "minecraft:${entry.type}",
                "name": "${item}",
                </#if>
                "weight": ${entry.weight},
                <#if entry.silkTouchMode == 1 && hasToolContext()>
                "conditions": [
                  {
                    "condition": "minecraft:match_tool",
                    "predicate": {
                      "predicates": {
                        "minecraft:enchantments": [
                          {
                            "enchantments": "minecraft:silk_touch",
                            "levels": {
                              "min": 1
                            }
                          }
                        ]
                      }
                    }
                  }
                ],
                <#elseif entry.silkTouchMode == 2 && hasToolContext()>
                "conditions": [
                  {
                    "condition": "minecraft:inverted",
                    "term": {
                      "condition": "minecraft:match_tool",
                      "predicate": {
                        "predicates": {
                          "minecraft:enchantments": [
                            {
                              "enchantments": "minecraft:silk_touch",
                              "levels": {
                                "min": 1
                              }
                            }
                          ]
                        }
                      }
                    }
                  }
                ],
                </#if>
                "functions": [
                  {
                    "function": "minecraft:set_count",
                    "count": {
                      "min": ${entry.minCount},
                      "max": ${entry.maxCount}
                    }
                  }
                  <#if entry.minEnchantmentLevel != 0 || entry.maxEnchantmentLevel != 0>
                  ,{
                    "function": "minecraft:enchant_with_levels",
                    "levels": {
                      "min": ${entry.minEnchantmentLevel},
                      "max": ${entry.maxEnchantmentLevel}
                    }
                  }
                  </#if>
                  <#if entry.explosionDecay>
                  ,{
                    "function": "minecraft:explosion_decay"
                  }
                  </#if>
                  <#if entry.affectedByFortune && hasToolContext()>
                  ,{
                    "function": "minecraft:apply_bonus",
                    "enchantment": "minecraft:fortune",
                    "formula": "minecraft:ore_drops"
                  }
                  </#if>
                ]
              }
                <#if entry?has_next>,</#if>
            </#list>
          ]
        }<#if pool?has_next>,</#if>
    </#list>
  ],
  "random_sequence": "${data.getNamespace()}:${data.getName()}"
}
