From: keith.busch@intel.com (Keith Busch)
Date: Tue, 25 Aug 2015 17:14:39 +0000 (UTC)
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150825045412.GA20360@localhost.localdomain>
References: <20150825045412.GA20360@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>

On Mon, 24 Aug 2015, Sujith Pandel wrote:
> +	result = device_create_file(dev->device, &dev_attr_model);
> +	if (result) {
> +		device_remove_file(dev->device, &dev_attr_reset_controller);
> +		goto put_dev;
> +	}

This isn't a very maintainable way to unwind on failure. A new label to
'goto' would be better.

But if we're going to have more than one sysfs entry, we can manage
this easier using attribute groups instead. There are lots of examples
in the kernel for this, like scsi_sysfs.c or blk-mq-sysfs.c
