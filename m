From: james.smart@broadcom.com (James Smart)
Date: Tue, 21 Aug 2018 14:01:53 -0700
Subject: [PATCH 3/4] nvme: implement 'discovery' sysfs entry and discovery
 uevents
In-Reply-To: <20180821134329.69577-4-hare@suse.de>
References: <20180821134329.69577-1-hare@suse.de>
 <20180821134329.69577-4-hare@suse.de>
Message-ID: <d14d3245-cdaa-647e-b4a8-c1a6f889ed35@broadcom.com>



On 8/21/2018 6:43 AM, Hannes Reinecke wrote:
> When establishing a connection to the discovery controller with the
> 'async-connect' option the cli has no means of actually getting the
> discovery log page entries.
> This patch implements a 'discovery' sysfs attribute for the controller
> which holds the information of the discovery log page. Additionally
> an uevent is generated for each discovery log page entry.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/core.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |   1 +
>   2 files changed, 163 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd8ec1dd9219..358be6d217d9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2325,6 +2325,133 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> +static int nvme_get_discovery_log(struct nvme_ctrl *ctrl)
> +{
> +	int ret, disc_log_len = 4096;
> +
> +retry:
> +	if (!ctrl->discovery)
> +		ctrl->discovery = kzalloc(disc_log_len, GFP_KERNEL);
> +
> +	if (!ctrl->discovery)
> +		return 0;
> +
> +	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_DISC, 0,
> +			   ctrl->discovery, disc_log_len, 0);
> +	if (ret) {
> +		kfree(ctrl->discovery);
> +		ctrl->discovery = NULL;
> +		return ret;
> +	}
> +	if (ctrl->discovery->numrec > 3 && disc_log_len == 4096) {
> +		disc_log_len = (ctrl->discovery->numrec + 1) * 1024;
> +		kfree(ctrl->discovery);
> +		ctrl->discovery = NULL;
> +		goto retry;

This is missing logic to detect a change in GENCTR and restart the log read.


> +	}
> +	return ret;
> +}
> +
> ...
> +static int nvme_configure_discovery(struct nvme_ctrl *ctrl)
> +{
> +	int ret = 0;
> +
> +	if (!ctrl->opts || !ctrl->opts->discovery_nqn)
> +		return 0;
> +
> +	if (!ctrl->opts->async_connect)
> +		return 0;

I don't understand why async_connect parameter means anything in this 
context...? why is this looked at?

is it strictly to avoid delay while reading the discovery log ?? I don't 
know that waiting for yet another command or two is a big deal, so I 
would think just proceeding with reading the discovery log is fine.

> +
> +	ret = nvme_get_discovery_log(ctrl);
> +	if (!ret && ctrl->discovery) {
> +		int i;
> +		struct nvmf_disc_rsp_page_entry *entry =
> +			ctrl->discovery->entries;
> +
> +		for (i = 0; i < ctrl->discovery->numrec; i++) {
> +			nvme_discovery_uevent(ctrl, entry);
> +			entry++;
> +		}
> +	}
> +	return ret;
> +}
> +
>   /*
>    * Initialize the cached copies of the Identify data and various controller
>    * register in our nvme_ctrl structure.  This should be called as soon as
> @@ -2491,6 +2618,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = nvme_configure_discovery(ctrl);
> +	if (ret < 0)
> +		return ret;
> +
>   	ctrl->identified = true;
>   
>   	return 0;
> @@ -2825,6 +2956,32 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
>   }
>   static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
>   
> +static ssize_t nvme_discovery_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvmf_disc_rsp_page_entry *entry;
> +	int i;
> +	ssize_t len = 0;
> +
> +	if (!ctrl->discovery)
> +		return -EINVAL;
> +
> +	entry = ctrl->discovery->entries;
> +	for (i = 0; i < ctrl->discovery->numrec; i++) {
> +		len += snprintf(buf, PAGE_SIZE,
> +				"trtype %d adrfam %d traddr %s "
> +				"trsvcid %s portid %d subnqn %s\n",
> +				entry->trtype, entry->adrfam, entry->traddr,
> +				entry->trsvcid, le16_to_cpu(entry->portid),
> +				entry->subnqn);
> +		entry++;
> +	}
> +	return len;
> +}
> +static DEVICE_ATTR(discovery, S_IRUGO, nvme_discovery_show, NULL);
> +

I really don't like that it's reporting a cached log. ? It may be 
completely inconsistent with what's on the discovery controller now 
(consider a nvmetcli done then a reconfig done). ?? There may not even 
be connectivity to the discovery controller at the time the sysfs entry 
is read - so validity to the content is in question.? I would much 
rather have the attribute read the log then display contents - so it's 
always current.??? Of course that does make it interesting if you read 
it while the controller is paused doing a reconnect.


>   static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reset_controller.attr,
>   	&dev_attr_rescan_controller.attr,
> @@ -2836,6 +2993,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_transport.attr,
>   	&dev_attr_subsysnqn.attr,
>   	&dev_attr_address.attr,
> +	&dev_attr_discovery.attr,
>   	&dev_attr_state.attr,
>   	NULL
>   };
> @@ -2850,7 +3008,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>   		return 0;
>   	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
>   		return 0;
> -
> +	if (a == &dev_attr_discovery.attr && ctrl->opts &&
> +	    !ctrl->opts->discovery_nqn)
> +		return 0;
>   	return a->mode;
>   }
>   
> @@ -3496,6 +3656,7 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
>   	kfree(ctrl->effects);
> +	kfree(ctrl->discovery);
>   	nvme_mpath_uninit(ctrl);
>   
>   	if (subsys) {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb4a2003c097..8a4ed46b986b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -199,6 +199,7 @@ struct nvme_ctrl {
>   	unsigned long quirks;
>   	struct nvme_id_power_state psd[32];
>   	struct nvme_effects_log *effects;
> +	struct nvmf_disc_rsp_page_hdr *discovery;
>   	struct work_struct scan_work;
>   	struct work_struct async_event_work;
>   	struct delayed_work ka_work;
