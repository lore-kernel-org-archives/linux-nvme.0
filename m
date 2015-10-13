From: hch@infradead.org (hch@infradead.org)
Date: Tue, 13 Oct 2015 05:26:08 -0700
Subject: Block integrity registration update
In-Reply-To: <1444701214.9780.23.camel@intel.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444696266.9780.13.camel@intel.com>
 <1444701214.9780.23.camel@intel.com>
Message-ID: <20151013122608.GA18816@infradead.org>

On Tue, Oct 13, 2015@01:53:34AM +0000, Williams, Dan J wrote:
> ...i.e. that we're destroying the integrity profile while i/o is still
> in flight.  As far as I can see any driver that calls
> blk_integrity_unregister() before blk_cleanup_queue() can hit this.  
> 
> However, with the change to static allocation I'm not sure why a driver
> would ever need to call blk_integrity_unregister() in its shutdown path.

It shouldn't.

> It seems this would only be necessary for disabling integrity at run
> time, but it can only do it safely when the queue is known to be idle.

Yes.  And even for that case we should a) only clear ->flags not the
whole integrity profile (and fix blk_integrity_revalidate to check the
right thing) and b) clear flags before calling blk_integrity_revalidate.

> Is there a way to solve this without the generic blk_freeze_queue()
> implementation? [1].  The immediate fix for libnvdimm is to just stop
> calling blk_integrity_unregister().

Seems like only nvme ever updates the profile, and nvme is blk-mq
only. 
