@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cites and Poscodes'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCS04_PostCodes as select from zcs04_postcode
{
    key postcode       as postcode,
        city       as city    
}
