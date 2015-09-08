From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 Sep 2015 21:29:54 +0000 (UTC)
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150904045439.GA10044@localhost.localdomain>
References: <20150825045412.GA20360@localhost.localdomain>
 <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>
 <20150901165554.GB12201@localhost.localdomain>
 <alpine.LNX.2.00.1509011717550.23840@localhost.lm.intel.com>
 <20150904045439.GA10044@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1509082123370.23840@localhost.lm.intel.com>

On Thu, 3 Sep 2015, Sujith Pandel wrote:
> :) Appreciate the way you and David are making me (a kernel newbie) interested to contribute more on this one.
> Hoping that this turns out to be my first kernel-patch!

Ha, I was only half-serious and would have submitted an attribute group
clean-up on the next sysfs I need to propose, but this looks pretty
good! :)

I'm wondering why you chose to add the device model number to sysfs since
this is available via other methods. Is it to maintain parity with scsi?

> +       result = nvme_create_sysfs_files(dev->device);
>        if (result)
>                goto put_dev;
>
> @@ -3208,6 +3246,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>        return 0;
>
>  put_dev:
> +       nvme_remove_sysfs_files(dev->device);

You don't need to remove the sysfs files if creating them was not
successful, so you shouldn't have to add this to the error out at this
label. We'd need to add a new label with this in the future if the driver
performs more tasks that could potentially fail, but this is the last
thing this section of code does, so no need to unwind this.
