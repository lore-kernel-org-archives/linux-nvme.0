From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Jun 2019 09:23:36 +0200
Subject: [PATCH v2 2/3] nvme: enable to inject errors into admin commands
In-Reply-To: <1559483421-11361-3-git-send-email-akinobu.mita@gmail.com>
References: <1559483421-11361-1-git-send-email-akinobu.mita@gmail.com>
 <1559483421-11361-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190604072336.GC15680@lst.de>

>  	struct nvme_fault_inject *fault_inject = NULL;
>  	u16 status;
>  
> -	/*
> -	 * make sure this request is coming from a valid namespace
> -	 */
>  	if (disk) {
>  		struct nvme_ns *ns = disk->private_data;
>  
>  		if (ns)
>  			fault_inject = &ns->fault_inject;


Not new in this code, but how could ns ever be NULL here?

> @@ -257,6 +266,8 @@ struct nvme_ctrl {
>  	 */
>  	struct thermal_zone_device *tzdev[9];
>  #endif

Looks like this series seem to be based on the thermal zone series.

> -struct nvme_fault_inject {
> -#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> -	struct fault_attr attr;
> -	struct dentry *parent;
> -	bool dont_retry;	/* DNR, do not retry */
> -	u16 status;		/* status code */
> -#endif

It would be nicer to already move it up earlier when you change the ifdef
guared.

Otherwise the whole series looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
