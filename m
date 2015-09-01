From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Tue, 1 Sep 2015 22:08:58 +0530
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150825153854.GA2862@linux.intel.com>
References: <20150825045412.GA20360@localhost.localdomain>
 <20150825153854.GA2862@linux.intel.com>
Message-ID: <20150901163850.GA12201@localhost.localdomain>

On Tue, Aug 25, 2015@10:38:54AM -0500, Matthew Wilcox wrote:
> > @@ -2360,6 +2360,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
> >  	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
> > +	dev->model[sizeof(ctrl->mn) - 1] = '\0';
> >  	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
> 
> You've overwritten the last byte of the model name with a NUL byte.  There
> could be useful information in that byte.

Agree with you on this. I will remove that statement.

> > +static ssize_t nvme_sysfs_model(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct nvme_dev *ndev = dev_get_drvdata(dev);
> > +
> > +	return sprintf(buf, "%s\n", ndev->model);
> 
> Instead, how about:
> 
> 	return sprintf(buf, "%.40s\n", ndev->model);

Can we use:
	return sprintf(buf, "%.*s\n", (int)sizeof(ndev->model), ndev->model); 

This way we need not hard-code the model attribute size in it.
Please let me know your thoughts on this.

Regards,
Sujith
