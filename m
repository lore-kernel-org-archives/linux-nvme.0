From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 02 Oct 2015 12:15:45 +0200
Subject: [PATCH 3/5] block: nvme-core: simplify ida usage
In-Reply-To: <cb1a4e9a77ed39c98072c70a0bebc9b98067852a.1443723136.git.lduncan@suse.com>
 (Lee Duncan's message of "Thu, 1 Oct 2015 11:59:07 -0700")
References: <cover.1443723136.git.lduncan@suse.com>
 <cover.1443723136.git.lduncan@suse.com>
 <cb1a4e9a77ed39c98072c70a0bebc9b98067852a.1443723136.git.lduncan@suse.com>
Message-ID: <mqdsi5t7ezy.fsf@c203.arch.suse.de>

Lee Duncan <lduncan at suse.com> writes:

> Simplify ida index allocation and removal by
> using the ida_simple_* helper functions.
>
> Signed-off-by: Lee Duncan <lduncan at suse.com>
> ---
>  drivers/block/nvme-core.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index d1d6141920d3..d354a3391e4a 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2713,18 +2713,10 @@ static DEFINE_IDA(nvme_instance_ida);
>  
>  static int nvme_set_instance(struct nvme_dev *dev)
>  {
> -	int instance, error;
> +	int instance;
>  
> -	do {
> -		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
> -			return -ENODEV;
> -
> -		spin_lock(&dev_list_lock);
> -		error = ida_get_new(&nvme_instance_ida, &instance);
> -		spin_unlock(&dev_list_lock);
> -	} while (error == -EAGAIN);
> -
> -	if (error)
> +	instance = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
> +	if (instance < 0)
>  		return -ENODEV;
>  
>  	dev->instance = instance;
> @@ -2734,7 +2726,7 @@ static int nvme_set_instance(struct nvme_dev *dev)
>  static void nvme_release_instance(struct nvme_dev *dev)
>  {
>  	spin_lock(&dev_list_lock);
> -	ida_remove(&nvme_instance_ida, dev->instance);
> +	ida_simple_remove(&nvme_instance_ida, dev->instance);
>  	spin_unlock(&dev_list_lock);
>  }

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
