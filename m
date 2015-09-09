From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Wed, 9 Sep 2015 10:16:39 +0530
Subject: [PATCH] NVMe:Expose model attribute in sysfs
In-Reply-To: <alpine.LNX.2.00.1509082123370.23840@localhost.lm.intel.com>
References: <20150825045412.GA20360@localhost.localdomain>
 <alpine.LNX.2.00.1508251510330.3969@localhost.lm.intel.com>
 <20150901165554.GB12201@localhost.localdomain>
 <alpine.LNX.2.00.1509011717550.23840@localhost.lm.intel.com>
 <20150904045439.GA10044@localhost.localdomain>
 <alpine.LNX.2.00.1509082123370.23840@localhost.lm.intel.com>
Message-ID: <20150909044630.GA11728@localhost.localdomain>

On Tue, Sep 08, 2015@04:29:54PM -0500, Keith Busch wrote:
> I'm wondering why you chose to add the device model number to sysfs since
> this is available via other methods. Is it to maintain parity with scsi?

Yes. scsi devices show model and vendor details as device attributes in sysfs.
Needed these two from nvme also.

> > +       result = nvme_create_sysfs_files(dev->device);
> >        if (result)
> >                goto put_dev;
> >
> > @@ -3208,6 +3246,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >        return 0;
> >
> >  put_dev:
> > +       nvme_remove_sysfs_files(dev->device);
> 
> You don't need to remove the sysfs files if creating them was not
> successful, so you shouldn't have to add this to the error out at this
> label. We'd need to add a new label with this in the future if the driver
> performs more tasks that could potentially fail, but this is the last
> thing this section of code does, so no need to unwind this.

Ok, I will make the change and send version-2 of the patch.
Thanks!

Regards,
Sujith
