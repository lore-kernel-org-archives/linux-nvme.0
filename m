From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 1 Mar 2017 17:50:47 -0700
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <7d6b3b59-5cec-d73f-b65c-4d685ccc70f8@deltatee.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <4a867c32-ed29-bc98-c7cb-6315243e664a@deltatee.com>
 <b34d6872-35de-da6d-2d7f-8842642d3f21@deltatee.com>
 <20170301235854.GF2820@obsidianresearch.com>
 <7d6b3b59-5cec-d73f-b65c-4d685ccc70f8@deltatee.com>
Message-ID: <20170302005047.GA14301@obsidianresearch.com>

On Wed, Mar 01, 2017@05:23:38PM -0700, Logan Gunthorpe wrote:

> > That could help, but this would mean cdev would have to insert a shim
> > to grab locks around the various file ops.
> 
> Hmm, I was hoping something more along the lines of actually killing the
> processes instead of just shimming away fops.

That would probably make most cdev users unhappy, it is not what we
want in tpm or infiniband, for instance.

> > AFAIK TPM is correct and has been robustly tested now. We have a 'vtpm'
> > driver that agressively uses hot-unplug.
> 
> Switchtec is a bit more tricky because a) there's no upper level driver
> to handle things

Introducing a light split between 'the upper part that owns the cdev'
and 'the lower part that owns the hardware' makes things much easier
to understand in a driver and it becomes clearer where, eg, devm
actions should be linked (ie probably not to the cdev part)

> and b) userspace may be inside a wait_for_completion (via read or
> poll) that needs to be completed. If a so called 'cdev_kill' could
> actually just kill these processes it would be a bit easier.

For TPM, poll could be something like:

static unsigned int tpm_poll(struct file *filp,
                             struct poll_table_struct *wait)
{
   poll_wait(filp, &chip->poll_wait, wait);
   if (tpm_try_get_ops(chip)) {
          mask = chip->ops->driver_do_poll(...);
          tpm_put_ops(chip);
   } else 
          mask = POLLIN | POLLRDHUP | POLLOUT | POLLERR | POLLHUP;
   return mask;
}

And we would trigger chip->poll_wait in the unregister.

wait_for_completion is similar, drop the rwsem while sleeping, add
'ops = NULL' to the sleeping condition test, trigger the wait on
unregister then reacquire the rwsem and test ops on wake.

Jason
