@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STATUS Domain'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED}
    
define view entity ZCS4_DStatus as select from 
  DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZDSTATUS04' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
      @Semantics.language: true
//  key language,
      value_low,     
      @Semantics.text: true
      text
}   
where language = $session.system_language
