From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 1 Mar 2017 16:58:54 -0700
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <b34d6872-35de-da6d-2d7f-8842642d3f21@deltatee.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <4a867c32-ed29-bc98-c7cb-6315243e664a@deltatee.com>
 <b34d6872-35de-da6d-2d7f-8842642d3f21@deltatee.com>
Message-ID: <20170301235854.GF2820@obsidianresearch.com>

On Wed, Mar 01, 2017@03:49:04PM -0700, Logan Gunthorpe wrote:

> Seems to me like an elegant solution would be to implement a 'cdev_kill'
> function which could kill all the processes using a cdev. Thus, during
> an unbind, a driver could call it and be sure that there are no users
> left and it can safely allow the devres unwind to continue. Then no
> difficult and racy 'alive' flags would be necessary and it would be much
> easier on drivers.

That could help, but this would mean cdev would have to insert a shim
to grab locks around the various file ops.

> > 3) A couple of drivers drivers/char/tpm doesn't seem to have any
> > protection at all and appears like they would continue to use io
> > operations even after the they may get unmapped because the char device
> > persists.

AFAIK TPM is correct and has been robustly tested now. We have a 'vtpm'
driver that agressively uses hot-unplug.

Firstly, TPM correctly tracks krefs on the 'chip', so the pointer is
always valid.

Next, anytime someone has a 'chip' pointer and wants to execute a TPM
operation they have to call tpm_try_get_ops and hold that lock for the
duration of their usage. Internally it does this:

        down_read(&chip->ops_sem);
        if (!chip->ops)
                goto out_lock; // FAILURE

In the cdev fops case this will cause the fop to return EPIPE if it
fails. cdev holds this read side lock while it is running TPM commands
inside the driver.

This meshes with this code called by tpm_chip_unregister():

        down_write(&chip->ops_sem);
        chip->ops = NULL;
        up_write(&chip->ops_sem);

tpm_chip_unregister uses this to provide a strong fence guarentee to
the driver. After tpm_chip_unregister return:
 - Nothing is running in a TPM ops callback currently
 - Nothing will ever call a TPM ops callback in future

This allows the TPM drivers to be trivial: call tpm_chip_unregister(),
kill the IRQ, and unmap the io resource, unload the module code.

TPM drivers cannot associate HW resources to the 'chip' struct device,
as it is unwound and devm triggered *during* tpm_chip_unregister and
does not enjoy the strong fence guarantee.

infiniband has a similar 'strong fence' unregister function. I think
it is best-practice for subsystem design to provide that because
drivers will never get it right on their own :(

Both infiniband and TPM have the 'detach' flavour of unplug where the
user is not forced to close their open cdevs. For simpler cases you
can just wait for all cdevs to close with a simple rwsem, much like
sysfs does already during device_del.

Jason
