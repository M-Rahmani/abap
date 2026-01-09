@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Countries'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCS04_Countries as select from I_CountryText
  association [0..*] to zcs04_customers as _Customer on $projection.Country = _Customer.country
{
  key Country,
      //  key Language,
      CountryName,
      //    NationalityName,
      //    NationalityLongName,
      //    CountryShortName,
      //    /* Associations */
      //    _Country,
      //    _Language
      _Customer
}
where
  Language = $session.system_language
