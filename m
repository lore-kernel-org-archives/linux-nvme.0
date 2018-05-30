From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 01:05:57 +0300
Subject: [PATCH 06/17] nvme: Add WARN in case fabrics ctrl was set with
 wrong metadata caps
In-Reply-To: <20180528072405.GG5618@lst.de>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-7-git-send-email-maxg@mellanox.com>
 <20180528072405.GG5618@lst.de>
Message-ID: <20ba37ea-aff1-ed21-6988-561a6c9ec3f3@grimberg.me>


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index d8254b4..c605bb3 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1419,9 +1419,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>   	blk_queue_physical_block_size(disk->queue, bs);
>>   	blk_queue_io_min(disk->queue, bs);
>>   
>> -	if (ns->ms && !ns->ext &&
>> -	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
>> -		nvme_init_integrity(disk, ns->ms, ns->pi_type);
>> +	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)) {
>> +		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || !ns->ext)
>> +			nvme_init_integrity(disk, ns->ms, ns->pi_type);
>> +	}
>>   	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
>>   		capacity = 0;
>>   	set_capacity(disk, capacity);
>> @@ -1445,6 +1446,18 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>>   	ns->noiob = le16_to_cpu(id->noiob);
>>   	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
>>   	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
>> +
>> +	/*
>> +	 * For Fabrics, only metadata as part of extended data LBA is supported.
>> +	 * Reduce the metadata size in case of a spec violation.
>> +	 */
>> +	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_FABRICS)) {
>> +		if (!ns->ext) {
>> +			WARN_ON_ONCE(1);
>> +			ns->ms = 0;
>> +		}
>> +	}
> 
> Should we just reject the probe instead of papering over it?

Yes I think we should, we can't really go ahead with this namespace as
if nothing happened...
