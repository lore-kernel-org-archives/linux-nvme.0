From: guanjx09@163.com (Guan Junxiong)
Date: Sun, 6 May 2018 11:23:05 +0800
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180504112845.38820-6-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
Message-ID: <d7222294-1fb6-2253-4b07-0f95c4794615@163.com>



On Friday, May 04, 2018 07:28 PM, Hannes Reinecke wrote:
> +static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +
> +	switch (ns->ana_state & 0x0f) {
> +	case NVME_ANA_STATE_OPTIMIZED:
> +		return sprintf(buf, "optimized\n");
> +	case NVME_ANA_STATE_NONOPTIMIZED:
> +		return sprintf(buf, "non-optimized\n");
> +	case NVME_ANA_STATE_INACCESSIBLE:
> +		return sprintf(buf, "inaccessible\n");
> +	case NVME_ANA_STATE_PERSISTENT_LOSS:
> +		return sprintf(buf, "persistent-loss\n");
> +	case NVME_ANA_STATE_CHANGE_STATE:
> +		return sprintf(buf, "change-state\n");
> +	default:
> +		return sprintf(buf, "<reserved>\n");
> +	}
> +}
> +static DEVICE_ATTR_RO(ana_state);
> +
> +static ssize_t ana_group_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = dev_to_disk(dev)->private_data;

Nick:   dev_to_disk(dev)->private_data  -->  nvme_get_ns_from_dev(dev);


Except this, IMO, it looks good.

Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>
