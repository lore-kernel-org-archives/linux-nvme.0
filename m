From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 May 2015 15:06:43 +0000 (UTC)
Subject: [PATCH] NVMe: Automatic namespace rescan
In-Reply-To: <20150515143746.GA2729@linux.intel.com>
References: <1431633707-9265-1-git-send-email-keith.busch@intel.com>
 <20150515143746.GA2729@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1505151440220.15930@localhost.lm.intel.com>

On Fri, 15 May 2015, Matthew Wilcox wrote:
> On Thu, May 14, 2015@02:01:47PM -0600, Keith Busch wrote:
>> @@ -307,9 +307,16 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
>
> I don't think we want the dev_warn() and the dev_info() for the same event.
> How about ...
>
> 	if (status != NVME_SC_SUCCESS)
> 		return;
>
> 	switch (result & 0xff07) {
> 	case NVME_AER_NOTICE_NS_CHANGED:
> 		dev_info(nvmeq->q_dmadev, "rescanning\n");
> 		schedule_work(&nvmeq->dev->scan_work);
> 	default:
> 		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
> 	}
>
> with NVME_AER_NOTICE_NS_CHANGED being an enum with value 0x0002

Brilliant!

>> +static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned nsid)
>> +{
>> +	struct nvme_ns *ns;
>> +
>> +	list_for_each_entry(ns, &dev->namespaces, list)
>> +		if (ns->ns_id == nsid)
>> +			return ns;
>> +	return NULL;
>> +}
>
> Pondering if it's worth keeping the list sorted so we can break out early
> if the namespace isn't in the list?

The list is actually already sorted since this doesn't allow gaps in
NSIDs. If a namespace is not attached, the driver creates a 0 capacity
block device for it and appends it to the list, so it's always in
ascending order.

Is this a bad idea? Let's say a controller supports 128 namespaces,
but only NSID 128 is attached, we'd see 127 zero capacity /dev/nvme#n#
block devs.
