<#include "mcitems.ftl">
(world instanceof ServerLevel _level${cbi} && _level${cbi}.recipeAccess().getRecipeFor(RecipeType.SMELTING, new SingleRecipeInput(${mappedMCItemToItemStackCode(input$item, 1)}), _level${cbi}).isPresent())