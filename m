From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Nov 2015 11:59:06 -0800
Subject: [PATCH] NVMe: Split shutdown work
Message-ID: <20151123195906.GB18448@infradead.org>

Hi Keith,

thanks - we should indeed try to shutdown the controller first.  The
code looks godo in general, but a few comments:

> @@ -1510,11 +1512,12 @@ static int set_queue_count(struct nvme_dev *dev, int count)
>  
>  	status = nvme_set_features(&dev->ctrl, NVME_FEAT_NUM_QUEUES, q_count, 0,
>  								&result);
> -	if (status < 0)
> -		return status;
> -	if (status > 0) {
> -		dev_err(dev->dev, "Could not set queue count (%d)\n", status);
> -		return 0;
> +	if (status) {
> +		bool enabled = pci_is_enabled(to_pci_dev(dev->dev));
> +
> +		dev_err(dev->dev, "Could not set queue count (%d) enabled:%d\n",
> +								status, enabled);
> +		return enabled ? 0 : -ENODEV;
>  	}
>  	return min(result & 0xffff, result >> 16) + 1;
>  }

I would really like to move set_queue_count to common code, and in fact
a patch to do that is in my NVMe target/loop driver series.

Can we instead handled this in the caller, and to do that change
the signature so that it always returns the status from
nvme_set_features as the return value, and instead gets a pass by
reference argument for the queue count?

> +	if (dev->bar) {
> +		queue_work(nvme_workq, &dev->shutdown_work);
> +		flush_work(&dev->shutdown_work);
> +	}

These synchronous workqueue calls always make my a bit nervous.
This is fine for now, but I'd love to have a single threaded workqueue
per controller that handles reset / shutdown and everything the kthread
handles in the long run.  I'm happy to do the work for that once your
patch is in.
