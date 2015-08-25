From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 25 Aug 2015 11:38:54 -0400
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150825045412.GA20360@localhost.localdomain>
References: <20150825045412.GA20360@localhost.localdomain>
Message-ID: <20150825153854.GA2862@linux.intel.com>

On Tue, Aug 25, 2015@10:24:39AM +0530, Sujith Pandel wrote:
> @@ -2360,6 +2360,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  	dev->vwc = ctrl->vwc;
>  	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
>  	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
> +	dev->model[sizeof(ctrl->mn) - 1] = '\0';
>  	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
>  	if (ctrl->mdts)
>  		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);

You've overwritten the last byte of the model name with a NUL byte.  There
could be useful information in that byte.

> +/* Expose model name in sysfs */
> +static ssize_t nvme_sysfs_model(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_dev *ndev = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", ndev->model);

Instead, how about:

	return sprintf(buf, "%.40s\n", ndev->model);
