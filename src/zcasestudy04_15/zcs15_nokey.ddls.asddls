@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test no key'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcs15_nokey as select from zcs04_copy
{

    medium as Medium,
    mvalue1 as Mvalue1,
    mvalue2 as Mvalue2,
    fax as Fax,
    phone as Phone,
    email as Email,
    memo as Memo,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
