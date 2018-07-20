From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 20 Jul 2018 16:45:05 +0000
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180720162321.GG4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
 <20180720155646.GE4093@localhost.localdomain>
 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
 <20180720161240.GF4093@localhost.localdomain>
 <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
 <20180720162321.GG4093@localhost.localdomain>
Message-ID: <797120d19f5d15e7d98a3d2f90ce91ebf60690d7.camel@wdc.com>

On Fri, 2018-07-20@10:23 -0600, Keith Busch wrote:
> On Fri, Jul 20, 2018@04:20:01PM +0000, Bart Van Assche wrote:
> > On Fri, 2018-07-20@10:12 -0600, Keith Busch wrote:
> > > On Fri, Jul 20, 2018@04:03:18PM +0000, Bart Van Assche wrote:
> > > > On Fri, 2018-07-20@09:56 -0600, Keith Busch wrote:
> > > > > SCSI is the only block driver that wants this behavior. Moving it back
> > > > > to generic where it used to be breaks other block drivers.
> > > > 
> > > > That's new to me. What would break in the NVMe driver if the above change would be
> > > > present in the block layer?
> > > 
> > > This is what causes the block layer to lose completions, and most drivers
> > > don't want the kernel to lose their completions.
> > 
> > Hello Keith,
> > 
> > Have you considered to introduce a fourth state for block layer requests to
> > avoid that completions that occur while a timeout handler is in progress get
> > lost? That would avoid that completions get lost not only for the NVMe driver
> > but also for SCSI drivers. See e.g. the MQ_RQ_TIMED_OUT state in
> > https://www.mail-archive.com/linux-block at vger.kernel.org/msg22196.html
> 
> Yes, I've considered that, and I really want to use it, but scsi may
> still reference a freed request in scmd_eh_abort_handler that way.

I think that's a misunderstanding. If scsi_times_out() queues an abort
asynchronously then it tells the block layer through its return value that the
SCSI core still owns the request and hence that the block layer should ignore any
completions that occur until the SCSI core calls scsi_finish_command(). That
scsi_finish_command() will trigger a call to __blk_mq_end_request(). The
scsi_times_out() return value I was referring to is called BLK_EH_DONE today and
was called BLK_EH_NOT_HANDLED in kernel version v4.17.

This also means that I got the BLK_EH_NOT_HANDLED case wrong in "blk-mq: Rework
blk-mq timeout handling again": in that case concurrent a blk_mq_complete_request()
call should be ignored instead of triggering request completion.

Bart.
