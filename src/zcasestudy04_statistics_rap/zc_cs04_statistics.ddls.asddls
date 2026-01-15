@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS04_STATISTICS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS04_STATISTICS
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS04_STATISTICS
  association [1..1] to ZR_CS04_STATISTICS as _BaseEntity on $projection.INTERFNAME = _BaseEntity.INTERFNAME and $projection.CLASSNAME = _BaseEntity.CLASSNAME
{
  key Interfname,
  key Classname,
  Activstat,
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
