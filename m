From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Oct 2015 14:29:48 +0000 (UTC)
Subject: [PATCH 3/5] block: nvme-core: simplify ida usage
In-Reply-To: <mqdsi5t7ezy.fsf@c203.arch.suse.de>
References: <cover.1443723136.git.lduncan@suse.com>
 <cover.1443723136.git.lduncan@suse.com>
 <cb1a4e9a77ed39c98072c70a0bebc9b98067852a.1443723136.git.lduncan@suse.com>
 <mqdsi5t7ezy.fsf@c203.arch.suse.de>
Message-ID: <alpine.LNX.2.00.1510081424210.27742@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Johannes Thumshirn wrote:
> Lee Duncan <lduncan at suse.com> writes:
>> Simplify ida index allocation and removal by
>> using the ida_simple_* helper functions.

Looks good to me. Just one comment:

>>  static void nvme_release_instance(struct nvme_dev *dev)
>>  {
>>  	spin_lock(&dev_list_lock);
>> -	ida_remove(&nvme_instance_ida, dev->instance);
>> +	ida_simple_remove(&nvme_instance_ida, dev->instance);
>>  	spin_unlock(&dev_list_lock);

No harm from taking the nvme spin lock here, but it's not necessary with
the simple interface.

> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
