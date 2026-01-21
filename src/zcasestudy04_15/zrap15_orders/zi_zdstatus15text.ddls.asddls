@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status Texts'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.dataCategory: #TEXT

define view entity zi_zdstatus15Text as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
       p_domain_name: 'ZDSTATUS04'
     )
{
@Semantics.language: true -- Указываем, что это язык
  key language,
      
      key domain_name,
      key value_position,
      
      @ObjectModel.text.element: [ 'text' ] -- Привязываем код к тексту
      value_low,

      @Semantics.text: true -- ТЕПЕРЬ ДОЛЖНО РАБОТАТЬ
      text
}
