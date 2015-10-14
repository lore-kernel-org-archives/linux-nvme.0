From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Oct 2015 16:03:00 +0000 (UTC)
Subject: [PATCH 8/8] nvme: move chardev and sysfs interface to common code
In-Reply-To: <1444633811-28319-9-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-9-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510141557220.27742@localhost.lm.intel.com>

On Mon, 12 Oct 2015, Christoph Hellwig wrote:
> +static ssize_t nvme_sysfs_reset(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = ctrl->ops->reset_ctrl(ctrl);
> +	if (ret < 0)
> +		return ret;
> +	return count;
> +}
> +static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);

...

> +int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> +		const struct nvme_ctrl_ops *ops, u16 vendor,
> +		unsigned long quirks)
> +{
...
> +	get_device(ctrl->device);
> +	dev_set_drvdata(ctrl->device, dev);

To match the controller extraction in nvme_sysfs_reset, change the above to:

+	dev_set_drvdata(ctrl->device, ctrl);

> +	ret = device_create_file(ctrl->device, &dev_attr_reset_controller);
