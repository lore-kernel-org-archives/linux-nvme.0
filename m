From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 7 May 2018 10:02:12 -0600
Subject: NVMe Poll CQ on timeout
In-Reply-To: <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <20180507160211.GE20686@localhost.localdomain>

On Mon, May 07, 2018@06:57:54AM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> Does anyone have any inputs ?

Hi,

I recall we did observe issues like this when legacy interrupts were
used, so the driver does try to use MSI/MSIx if possible.

The nvme_timeout() is called from the block layer when the driver didn't
provide a completion within the timeout (default is 30 seconds for IO,
60 seconds for admin).

This message you're seeing means the device did indeed post a completion
queue entry for the timed out command, but the driver believes it was
never notified via interrupt to check the completion queue.

This means either one of two things happened: the interrupt was raised
prior to the completion queue entry being written, or the interrupt was
never raised in the first place.

It might be possible to determine which if you can read the values from
/proc/irq/<irq#>/spurious and see if the "last_unhandled" aligns with
the expected completion time.

Thanks,
Keith

> > Hi,
> > 
> > We are testing NVMe cards on ARM64 platform, the card uses legacy
> > interrupts.
> > Intermittently we are hitting following case in drivers/nvme/host/pci.c
> >        /*
> >          * Did we miss an interrupt?
> >          */
> >         if (__nvme_poll(nvmeq, req->tag)) {
> >                 dev_warn(dev->ctrl.device,
> >                          "I/O %d QID %d timeout, completion polled\n",
> >                          req->tag, nvmeq->qid);
> >                 return BLK_EH_HANDLED;
> >         }
> > 
> > Can anyone tell when does nvme_timeout gets invoked ?
> > What does "Did we miss an interrupt mean" ? Does it mean host missing to
> > service a interrupt raised by EP card ?
> > 
> > Regards,
> > Bharat
