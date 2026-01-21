@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STATUS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel:{
    resultSet.sizeCategory:#XS,
    usageType.serviceQuality: #X,
    usageType.sizeCategory: #S,
    usageType.dataClass: #MIXED
}
  
define view entity ZCS04_CStatus as select from ZCS4_DStatus
{
  key Status as Status,
      @Semantics.text: true
      text as Text
}

