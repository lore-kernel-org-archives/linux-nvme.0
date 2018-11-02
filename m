From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 2 Nov 2018 10:16:21 -0700
Subject: [PATCH v3] nvme: make sure ns head inherits underlying device
 limits
In-Reply-To: <20181102054139.GA16212@lst.de>
References: <20181101160457.13391-1-sagi@grimberg.me>
 <20181102054139.GA16212@lst.de>
Message-ID: <7b322de4-020f-71ee-9660-a131305f7cee@grimberg.me>

>> @@ -1482,6 +1482,7 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
>>   static void nvme_update_disk_info(struct gendisk *disk,
>>   		struct nvme_ns *ns, struct nvme_id_ns *id)
>>   {
>> +	struct nvme_ns *n;
>>   	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
>>   	unsigned short bs = 1 << ns->lba_shift;
>>   
>> @@ -1506,6 +1507,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>   	else
>>   		set_disk_ro(disk, false);
>>   
>> +	list_for_each_entry_rcu(n, &ns->head->list, siblings)
>> +		blk_queue_stack_limits(disk->queue, n->queue);
> 
> I think this should only be done for ns->head_disk, nor the disks
> attached to the namespaces.

Well the siblings list would be empty for the namespaces themselves.

I could move this to the call site:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4325f1aeea1f..ff5d543624a4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1535,8 +1535,10 @@ static void __nvme_revalidate_disk(struct gendisk 
*disk, struct nvme_id_ns *id)
         if (ns->ndev)
                 nvme_nvm_update_nvm_info(ns);
  #ifdef CONFIG_NVME_MULTIPATH
-       if (ns->head->disk)
+       if (ns->head->disk) {
                 nvme_update_disk_info(ns->head->disk, ns, id);
+               blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+       }
  #endif
  }
--


>> @@ -2960,6 +2964,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>>   	if (ret)
>>   		goto out_cleanup_srcu;
>>   
>> +#ifdef CONFIG_NVME_MULTIPATH
>> +	blk_set_stacking_limits(&head->disk->queue->limits);
>> +#endif
> 
> And this should probably done in nvme_mpath_alloc_disk.

Yes, I can do that (the original version had it there but can't
remember why I decided to have it here instead).
