From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 15 May 2015 10:37:46 -0400
Subject: [PATCH] NVMe: Automatic namespace rescan
In-Reply-To: <1431633707-9265-1-git-send-email-keith.busch@intel.com>
References: <1431633707-9265-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150515143746.GA2729@linux.intel.com>

On Thu, May 14, 2015@02:01:47PM -0600, Keith Busch wrote:
> @@ -307,9 +307,16 @@ static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
>  
>  	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
>  		++nvmeq->dev->event_limit;
> -	if (status == NVME_SC_SUCCESS)
> -		dev_warn(nvmeq->q_dmadev,
> -			"async event result %08x\n", result);
> +	if (status == NVME_SC_SUCCESS) {
> +		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
> +		if ((result & 0x3) == NVME_AER_TYPE_NOTICE &&
> +		    ((result >> 8) & 0xff) == NVME_AER_INFO_NS_CHANGE) {
> +			struct nvme_dev *dev = nvmeq->dev;
> +			dev_info(nvmeq->q_dmadev,
> +				"namespace change event, rescan\n");
> +			schedule_work(&dev->scan_work);
> +		}
> +	}
>  }
>  
>  static void abort_completion(struct nvme_queue *nvmeq, void *ctx,

I don't think we want the dev_warn() and the dev_info() for the same event.
How about ...

	if (status != NVME_SC_SUCCESS)
		return;

	switch (result & 0xff07) {
	case NVME_AER_NOTICE_NS_CHANGED:
		dev_info(nvmeq->q_dmadev, "rescanning\n");
		schedule_work(&nvmeq->dev->scan_work);
	default:
		dev_warn(nvmeq->q_dmadev, "async event result %08x\n", result);
	}

with NVME_AER_NOTICE_NS_CHANGED being an enum with value 0x0002

> +static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned nsid)
> +{
> +	struct nvme_ns *ns;
> +
> +	list_for_each_entry(ns, &dev->namespaces, list)
> +		if (ns->ns_id == nsid)
> +			return ns;
> +	return NULL;
> +}

Pondering if it's worth keeping the list sorted so we can break out early
if the namespace isn't in the list?
