From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 17 Jul 2018 08:54:35 -0600
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180717134048.GA16134@lst.de>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-2-keith.busch@intel.com>
 <c0752e20-7d23-4b1f-b128-af952e3cf8da@grimberg.me>
 <20180716153721.GB26265@localhost.localdomain>
 <c52b671e-8ca5-aa04-9182-7a43014aed40@grimberg.me>
 <20180716171232.GC26265@localhost.localdomain>
 <20180717134048.GA16134@lst.de>
Message-ID: <20180717145435.GD26925@localhost.localdomain>

On Tue, Jul 17, 2018@03:40:48PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 16, 2018@11:12:33AM -0600, Keith Busch wrote:
> > On Mon, Jul 16, 2018@07:36:41PM +0300, Sagi Grimberg wrote:
> > > > The only reason we need this is because each namespace has its own
> > > > request queue with their own timeout work. We don't want all of these
> > > > scheduling multiple controller resets, so the sync here just ensures
> > > > that there is no active timeout work that's about to schedule another
> > > > reset while we're already resetting the controller.
> > > 
> > > But scheduling a reset while a reset is running should not succeed. You
> > > should not be able to change state RESETTING -> RESETTING
> > 
> > Timeout handlers call nvme_dev_disable prior to the reset schedule
> > attempt, which is the part that we want to prevent occuring concurrently
> > with an already scheduled reset.
> 
> Is there any good way we can get rid of these out of state machine
> nvme_dev_disable calls?  It might not be easy, but I think it is
> going to help us in the long run.

Possibly, I'll stare at this a bit more.
 
> I also think your original idea of a single work_struct per tag set
> for error handling might be a good idea.  This is similar to the
> per-host eh thread SCSI had forever, so it might also help SCSI by
> getting rid of that and running directly from the block timeout
> context.

Okay, I'll re-examine that option again. It gets a little messy with
the legacy request interface, but that's okay.
