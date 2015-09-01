From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Tue, 1 Sep 2015 22:25:58 +0530
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>
References: <20150825045412.GA20360@localhost.localdomain>
 <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>
Message-ID: <20150901165554.GB12201@localhost.localdomain>

On Tue, Aug 25, 2015@12:14:39PM -0500, Keith Busch wrote:
> On Mon, 24 Aug 2015, Sujith Pandel wrote:
> > +	result = device_create_file(dev->device, &dev_attr_model);
> > +	if (result) {
> > +		device_remove_file(dev->device, &dev_attr_reset_controller);
> > +		goto put_dev;
> > +	}
> 
> This isn't a very maintainable way to unwind on failure. A new label to
> 'goto' would be better.
> 
> But if we're going to have more than one sysfs entry, we can manage
> this easier using attribute groups instead. There are lots of examples
> in the kernel for this, like scsi_sysfs.c or blk-mq-sysfs.c

Since there are only two sysfs attributes here as of now,
I will be going with your former suggestion of using a new goto label.
Will this be okay:

+       result = device_create_file(dev->device, &dev_attr_model);
+       if (result)
+               goto remove_file;
+

+ remove_file:
+       device_remove_file(dev->device, &dev_attr_reset_controller);
  put_dev:

Please let me know. 
Will send the version-2 of this patch once you confirm.

Regards,
Sujith
