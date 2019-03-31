From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 31 Mar 2019 18:04:16 +0300
Subject: [PATCH 1/2] nvmet: make MDTS value configurable
In-Reply-To: <20190329120404.55637-2-hare@suse.de>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-2-hare@suse.de>
Message-ID: <3bfa0c56-91d1-a722-df92-1ed4744f04ad@mellanox.com>


On 3/29/2019 3:04 PM, Hannes Reinecke wrote:
> For testing the bio splitting algorithm it's useful to be able to
> modify the mdts value.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  3 +--
>   drivers/nvme/target/configfs.c  | 27 +++++++++++++++++++++++++++
>   drivers/nvme/target/nvmet.h     |  2 ++
>   3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 76250181fee0..1c4cb371fac8 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -311,8 +311,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   	/* we support multiple ports, multiples hosts and ANA: */
>   	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
>   
> -	/* no limit on data transfer sizes for now */
> -	id->mdts = 0;
> +	id->mdts = ctrl->subsys->mdts;

I think it's more of a ctrl/nvmet_port configuration than a subsystem.

For example if you have 2 HCAs, one is super strong and can transfer 
upto 8MB and the second is old model and can transfer upto 64KiB.

do

id->mdts = ctrl->ops->port_mdts(req->port);

and inside the implementation you can do

min_not_zero(max_port_hca_cap_in_mdts_units, mdts_configfs_val);

and it will fix the comment that is written above (we're not really 
unlimited).

this way we're using the low level device characteristics and also cover 
the bio split test.

thoughts ?


>   	id->cntlid = cpu_to_le16(ctrl->cntlid);
>   	id->ver = cpu_to_le32(ctrl->subsys->ver);
>   
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index adb79545cdd7..63b9991de79e 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -859,10 +859,37 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>   }
>   CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
>   
> +static ssize_t nvmet_subsys_attr_mdts_show(struct config_item *item,
> +					   char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%u\n", subsys->mdts);
> +}
> +
> +static ssize_t nvmet_subsys_attr_mdts_store(struct config_item *item,
> +					    const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	unsigned int mdts;
> +	int ret;
> +
> +	ret = kstrtou32(page, 0, &mdts);
> +	if (ret)
> +		return ret;
> +	down_write(&nvmet_config_sem);
> +	subsys->mdts = mdts;
> +	up_write(&nvmet_config_sem);
> +
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_mdts);
> +
>   static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_allow_any_host,
>   	&nvmet_subsys_attr_attr_version,
>   	&nvmet_subsys_attr_attr_serial,
> +	&nvmet_subsys_attr_attr_mdts,
>   	NULL,
>   };
>   
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 51e49efd7849..f05f069f83ea 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -217,6 +217,8 @@ struct nvmet_subsys {
>   	bool			allow_any_host;
>   
>   	u16			max_qid;
> +	u8			mdts;
> +	u8			mpsmin;


are you using mpsmin ?


>   
>   	u64			ver;
>   	u64			serial;
