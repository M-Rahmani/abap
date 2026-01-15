@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS04_CUSTOMIZE'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CS04_CUSTOMIZE
  as select from ZCS04_CUSTOMIZE
{
  key c_id as CID,
  cname as Cname,
  cvalue as Cvalue,
  validfrom as Validfrom,
  validto as Validto,
  active as Active,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
