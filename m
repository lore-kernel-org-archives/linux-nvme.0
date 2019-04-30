From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 30 Apr 2019 21:30:40 +0000
Subject: [PATCH 2/2] nvme: mark nvme_core_init and nvme_core_exit static
References: <20190430153833.9011-1-hch@lst.de>
 <20190430153833.9011-2-hch@lst.de>
Message-ID: <SN6PR04MB4527AC70AF3A55476B74743E863A0@SN6PR04MB4527.namprd04.prod.outlook.com>

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 4/30/19 8:39 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   drivers/nvme/host/nvme.h | 3 ---
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e970c5adee28..cd16d98d1f1a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3904,7 +3904,7 @@ static inline void _nvme_check_size(void)
>   }
>   
>   
> -int __init nvme_core_init(void)
> +static int __init nvme_core_init(void)
>   {
>   	int result = -ENOMEM;
>   
> @@ -3956,7 +3956,7 @@ int __init nvme_core_init(void)
>   	return result;
>   }
>   
> -void __exit nvme_core_exit(void)
> +static void __exit nvme_core_exit(void)
>   {
>   	ida_destroy(&nvme_subsystems_ida);
>   	class_destroy(nvme_subsys_class);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 527d64545023..5ee75b5ff83f 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -577,7 +577,4 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
>   	return dev_to_disk(dev)->private_data;
>   }
>   
> -int __init nvme_core_init(void);
> -void __exit nvme_core_exit(void);
> -
>   #endif /* _NVME_H */
> 
