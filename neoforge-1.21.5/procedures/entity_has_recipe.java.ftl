<#include "mcelements.ftl">
(${input$entity} instanceof ServerPlayer _playerHasRecipe${cbi} && _playerHasRecipe${cbi}.getRecipeBook().contains(ResourceKey.create(Registries.RECIPE, ${toResourceLocation(input$recipe)})))