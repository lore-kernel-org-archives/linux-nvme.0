From: tomwu@mellanox.com (Tom Wu)
Date: Tue, 6 Aug 2019 10:49:03 +0000
Subject: [PATCH] nvmet: fix data units read and written counters in SMART
 log
In-Reply-To: <8cbab0aa-51c7-b33a-46a3-5a85debc023c@grimberg.me>
References: <1564970259-12279-1-git-send-email-tomwu@mellanox.com>
 <8cbab0aa-51c7-b33a-46a3-5a85debc023c@grimberg.me>
Message-ID: <dedb990d-ef45-0cd9-b662-e98b911fe45a@mellanox.com>

Hi, Sagi

when you say I can 'modifying the actual retrieval', you are try to 
suggest that I can do the changes as below, right?

--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -81,9 +81,11 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req 
*req,
 ??????????????? goto out;

 ??????? host_reads = part_stat_read(ns->bdev->bd_part, ios[READ]);
-?????? data_units_read = part_stat_read(ns->bdev->bd_part, sectors[READ]);
+?????? data_units_read = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
+?????????????? sectors[READ]), 1000);
 ??????? host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
-?????? data_units_written = part_stat_read(ns->bdev->bd_part, 
sectors[WRITE]);
+?????? data_units_written = DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part,
+?????????????? sectors[WRITE]), 1000);

 ??????? put_unaligned_le64(host_reads, &slog->host_reads[0]);
 ??????? put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
@@ -112,10 +114,10 @@ static u16 nvmet_get_smart_log_all(struct 
nvmet_req *req,
 ??????????????????????? continue;
 ??????????????? host_reads += part_stat_read(ns->bdev->bd_part, ios[READ]);
 ??????????????? data_units_read +=
-?????????????????????? part_stat_read(ns->bdev->bd_part, sectors[READ]);
+ DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part, sectors[READ]), 1000);
 ??????????????? host_writes += part_stat_read(ns->bdev->bd_part, 
ios[WRITE]);
 ??????????????? data_units_written +=
-?????????????????????? part_stat_read(ns->bdev->bd_part, sectors[WRITE]);
+ DIV_ROUND_UP(part_stat_read(ns->bdev->bd_part, sectors[WRITE]), 1000);

 ??????? }

On 8/6/2019 2:24 AM, Sagi Grimberg wrote:
>
>> diff --git a/drivers/nvme/target/admin-cmd.c 
>> b/drivers/nvme/target/admin-cmd.c
>> index 9f72d51..acbadbe 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -85,6 +85,9 @@ static u16 nvmet_get_smart_log_nsid(struct 
>> nvmet_req *req,
>> ????? host_writes = part_stat_read(ns->bdev->bd_part, ios[WRITE]);
>> ????? data_units_written = part_stat_read(ns->bdev->bd_part, 
>> sectors[WRITE]);
>> ? +??? data_units_read = DIV_ROUND_UP(data_units_read, 1000);
>> +??? data_units_written = DIV_ROUND_UP(data_units_written, 1000);
>> +
>
> How about either modifying the actual retrieval or move the fixups 
> right next to the initial setting...
