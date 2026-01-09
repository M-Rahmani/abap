@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS04_POSTCODE'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS04_POSTCODE
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS04_POSTCODE
  association [1..1] to ZR_CS04_POSTCODE as _BaseEntity on $projection.POSTCODE = _BaseEntity.POSTCODE
{
  key Postcode,
  City,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
