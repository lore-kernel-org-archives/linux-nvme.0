From: keith.busch@intel.com (Keith Busch)
Date: Mon, 30 Dec 2013 08:55:30 -0700 (MST)
Subject: [PATCH RFC 3/5] NVMe: Asynchronous device scan support
In-Reply-To: <20131230135025.GI4945@linux.intel.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-4-git-send-email-santoshsy@gmail.com>
 <20131230135025.GI4945@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1312300757360.4958@AMR>

On Mon, 30 Dec 2013, Matthew Wilcox wrote:
> On Mon, Dec 30, 2013@03:57:18PM +0530, Santosh Y wrote:
>> This patch provides asynchronous device enumeration
>> capability. The 'probe' need not wait until the namespace scanning is
>> complete.
>
> I'm very interested in having something like this, except I don't think
> it's complete.  You don't seem to handle the cases where the device
> is shut down in the middle of an async scan.  Also, the only piece you
> seem to make async is the calls to add_disk(), which are surely not the
> timeconsuming parts of the scan.  I would think the time consuming parts
> are sending the IDENTIFY commands, which you don't make async.

Surprisingly, add_disk is the by far longest part. It does several dozen
blocking reads to check for a known partitions. The identifies don't
become measurable until you have several hundred namespaces but that
time is just noise compared to 'add_disk'.

I started on a generic block patch that makes 'add_disk' non-blocking. I
can see about cleaning that up and posting to the block mailing list
for consideration.

>> Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
>> Signed-off-by: Santosh Y <santoshsy at gmail.com>
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index 8a02135..cd37335 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -17,6 +17,9 @@
>>   */
>>
>>  #include <linux/nvme.h>
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +#include <linux/async.h>
>> +#endif
>>  #include <linux/bio.h>
>>  #include <linux/bitops.h>
>>  #include <linux/blkdev.h>
>> @@ -2115,8 +2118,10 @@ static int nvme_dev_add(struct nvme_dev *dev)
>>  		if (ns)
>>  			list_add_tail(&ns->list, &dev->namespaces);
>>  	}
>> +#ifndef CONFIG_BLK_DEV_NVME_HP
>>  	list_for_each_entry(ns, &dev->namespaces, list)
>>  		add_disk(ns->disk);
>> +#endif
>>  	res = 0;
>>
>>   out:
>> @@ -2546,6 +2551,19 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
>>  	nvme_dev_reset(dev);
>>  }
>>
>> +#ifdef CONFIG_BLK_DEV_NVME_HP
>> +static void nvme_async_add(void *data, async_cookie_t cookie)
>> +{
>> +	struct nvme_dev *dev = (struct nvme_dev *)data;
>> +	struct nvme_ns *ns;
>> +
>> +	list_for_each_entry(ns, &dev->namespaces, list)
>> +		add_disk(ns->disk);
>> +	if (!test_bit(NVME_HOT_REM, &dev->hp_flag))
>> +		dev->initialized = 1;
>> +}
>> +#endif
>> +
>>  static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>  	int result = -ENOMEM;
>> @@ -2595,14 +2613,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (result)
>>  		goto remove;
>>
>> -	dev->initialized = 1;
>> -	kref_init(&dev->kref);
>> -
>>  #ifdef CONFIG_BLK_DEV_NVME_HP
>> +	async_schedule(nvme_async_add, dev);
>>  	if (!pdev->is_added)
>>  		dev_info(&pdev->dev,
>>  			"Device 0x%x is on-line\n", pdev->device);
>> +#else
>> +	dev->initialized = 1;
>>  #endif
>> +	kref_init(&dev->kref);
>> +
>>  	return 0;
>>
>>   remove:
>> --
>> 1.8.3.2
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>
