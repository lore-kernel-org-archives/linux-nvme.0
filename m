From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Sep 2017 18:02:08 +0300
Subject: [PATCH 3/3] nvmet-rdma: add module parameter for SRQ size
In-Reply-To: <1504609157-3004-4-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-4-git-send-email-maxg@mellanox.com>
Message-ID: <8bf8bd99-5601-24f3-0a6c-c27dd0124442@grimberg.me>


> Adjust SRQ size according to the expected load. Make sure the
> size is >= 256 to avoid lack of resources.

Why? who said that you cannot do with lower than that?

This is the painful part of srq, you never know how to
size it... I wish we could find a way to know...

> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 1b52080..34868ad 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -134,6 +134,16 @@ struct nvmet_rdma_device {
>   module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
>   MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
>   
> +static int srq_size_set(const char *val, const struct kernel_param *kp);
> +static const struct kernel_param_ops srq_size_ops = {
> +	.set = srq_size_set,
> +	.get = param_get_int,
> +};
> +
> +static int nvmet_rdma_srq_size = 4095;
> +module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
> +MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 4095)");
> +
>   static DEFINE_IDA(nvmet_rdma_queue_ida);
>   static LIST_HEAD(nvmet_rdma_queue_list);
>   static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
> @@ -150,6 +160,17 @@ struct nvmet_rdma_device {
>   
>   static struct nvmet_fabrics_ops nvmet_rdma_ops;
>   
> +static int srq_size_set(const char *val, const struct kernel_param *kp)
> +{
> +	int n = 0, ret;
> +
> +	ret = kstrtoint(val, 10, &n);
> +	if (ret != 0 || n < 256)
> +		return -EINVAL;
> +
> +	return param_set_int(val, kp);
> +}
> +
>   /* XXX: really should move to a generic header sooner or later.. */
>   static inline u32 get_unaligned_le24(const u8 *p)
>   {
> @@ -825,7 +846,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev, int index)
>   	if (!nsrq)
>   		return -ENOMEM;
>   
> -	srq_size = 4095;	/* XXX: tune */
> +	srq_size = nvmet_rdma_srq_size;
>   
>   	srq_attr.attr.max_wr = srq_size;
>   	srq_attr.attr.max_sge = 2;
> 

You need to check device max_srq_wr and also check max_srq_sge (and
please make sure its correctly set by drivers that support it).

Also you need to check minimum between the number of srqs you
want and device max_srq.
