From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 7 Jun 2017 12:47:09 +0800
Subject: [PATCH v5 9/9] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170606143617.32143-10-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
 <20170606143617.32143-10-jthumshirn@suse.de>
Message-ID: <1e6c06b6-4aec-d2bf-5361-7b656b64dc22@huawei.com>

Hi,Johannes

On 2017/6/6 22:36, Johannes Thumshirn wrote:
> Allow overriding the announced NVMe Version of a via configfs.

> +static ssize_t nvmet_subsys_version_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	int major, minor, tertiary;
> +	int ret;
> +
> +
> +	ret = sscanf(page, "%d.%d.%d\n", &major, &minor, &tertiary);
> +	if (ret != 2 && ret != 3)
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	subsys->ver = NVME_VS(major, minor, tertiary);

tertiary variable is not initialized, which could induce garbage info if ret = 2

> +++ b/include/linux/nvme.h
> @@ -1070,4 +1070,8 @@ struct nvme_completion {
>  #define NVME_VS(major, minor, tertiary) \
>  	(((major) << 16) | ((minor) << 8) | (tertiary))
>  
> +#define NVME_MAJOR(ver)		((ver) >> 16)
> +#define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
> +#define NVME_TERTIARY(ver)	((ver) & 0xff)the above line could be aligned with the preceding two lines

Except for those above, others looks good for me.

Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>
