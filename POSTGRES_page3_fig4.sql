SELECT sum(dod.number_records), o.country, to_char(od.created, 'YYYY-MM') year_month FROM organization o
JOIN dataset d ON d.publishing_organization_key = o.key
JOIN dataset_occurrence_download dod ON d.key = dod.dataset_key
JOIN occurrence_download od ON od.key = dod.download_key
WHERE od.notification_addresses NOT LIKE '%@gbif.org' AND
  od.status='SUCCEEDED' AND od.created_by != 'nagios' AND o.country = 'US' AND date(od.created) BETWEEN '2014-07-01' AND '2015-06-30'
GROUP BY 2,3 ORDER BY 2,3