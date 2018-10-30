From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 11:14:49 -0700
Subject: [PATCH] adjust serial number form u64 to u8[20]
In-Reply-To: <1540810606-17252-1-git-send-email-lijie34@huawei.com>
References: <1540810606-17252-1-git-send-email-lijie34@huawei.com>
Message-ID: <739c3b0a-25e5-bcdb-0589-a95d33ea3958@grimberg.me>


> -	memset(id->sn, ' ', sizeof(id->sn));
> -	bin2hex(id->sn, &ctrl->subsys->serial,
> -		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
> +	memcpy(id->sn, ctrl->subsys->sn, sizeof(id->sn));

Why not pad with zeroes?

>   static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>   					      const char *page, size_t count)
>   {
>   	struct nvmet_subsys *subsys = to_subsys(item);
> +	char sn[21];
> +
> +	if (sscanf(page, "%20s\n", sn) != 1)
> +	{
> +		return -EINVAL;
> +	}

No need for one-liner clause..

>   
>   	down_write(&nvmet_config_sem);
> -	sscanf(page, "%llx\n", &subsys->serial);
> +	memcpy_and_pad(subsys->sn, sizeof(subsys->sn), sn, strlen(sn), ' ');
>   	up_write(&nvmet_config_sem);
>   
>   	return count;
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 0acdff9..6bc8860 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1129,6 +1129,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   		enum nvme_subsys_type type)
>   {
>   	struct nvmet_subsys *subsys;
> +	u64	serial;
>   
>   	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>   	if (!subsys)
> @@ -1136,7 +1137,9 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   
>   	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
>   	/* generate a random serial number as our controllers are ephemeral: */
> -	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
> +	get_random_bytes(&serial, sizeof(serial));
> +	memset(subsys->sn, ' ', sizeof(subsys->sn));
> +	bin2hex(subsys->sn, &serial, min(sizeof(serial), sizeof(subsys->sn) / 2));

Why not simply get the random bytes directly to subsys->sn?

	get_random_bytes(subsys->sn, sizeof(subsys->sn));
