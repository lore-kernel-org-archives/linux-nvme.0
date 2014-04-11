From: keith.busch@intel.com (Keith Busch)
Date: Fri, 11 Apr 2014 09:43:24 -0600 (MDT)
Subject: [PATCH] NVMe: Add more informative error messages
In-Reply-To: <20140411145643.GO5727@linux.intel.com>
References: <20140411145643.GO5727@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1404110932590.4731@AMR>

While we're doing this, can we change this print? I'm not sure what
a good opposite for "initialisation" is here. The spec calls a CC.EN
transition 1->0 a "reset" so going with that.

@@ -1358,7 +1358,8 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
  			return -EINTR;
  		if (time_after(jiffies, timeout)) {
  			dev_err(&dev->pci_dev->dev,
-				"Device not ready; aborting initialisation\n");
+				"Device not ready; aborting %s\n", enabled ?
+						"initialisation" : "reset");
  			return -ENODEV;
  		}
  	}

On Fri, 11 Apr 2014, Matthew Wilcox wrote:
> Help people diagnose what is going wrong at initialisation time by
> printing out which command has gone wrong and what the device returned.
>
> Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 313c0f0..f47fe7c 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2059,8 +2059,13 @@ static int set_queue_count(struct nvme_dev *dev, int count)
>
> 	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count, 0,
> 								&result);
> -	if (status)
> -		return status < 0 ? -EIO : -EBUSY;
> +	if (status < 0)
> +		return status;
> +	if (status > 0) {
> +		dev_err(&dev->pci_dev->dev, "Could not set queue count (%d)\n",
> +									status);
> +		return -EBUSY;
> +	}
> 	return min(result & 0xffff, result >> 16) + 1;
> }
>
> @@ -2196,6 +2201,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>
> 	res = nvme_identify(dev, 0, 1, dma_addr);
> 	if (res) {
> +		dev_err(&pdev->dev, "Identify Controller failed (%d)\n", res);
> 		res = -EIO;
> 		goto out;
> 	}
