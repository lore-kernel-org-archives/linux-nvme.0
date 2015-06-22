From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 22 Jun 2015 10:48:05 -0400
Subject: [PATCH] NVMe: Use CMB for the SQ if available
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9D03A71F1@NTXBOIMBX02.micron.com>
References: <1434750357-29162-1-git-send-email-jonathan.derrick@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9D03A71F1@NTXBOIMBX02.micron.com>
Message-ID: <20150622144805.GC1971@linux.intel.com>

On Fri, Jun 19, 2015@10:47:04PM +0000, Sam Bradshaw (sbradshaw) wrote:
> > @@ -376,7 +394,12 @@ static int __nvme_submit_cmd(struct nvme_queue
> > *nvmeq, struct nvme_command *cmd)  {
> >  	u16 tail = nvmeq->sq_tail;
> > 
> > -	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> > +	if (nvmeq->cmb_mapped)
> > +		memcpy_toio(&nvmeq->sq_cmds[tail], cmd,
> > +				sizeof(*cmd));
> > +	else
> > +		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
> > +
> >  	if (++tail == nvmeq->q_depth)
> >  		tail = 0;
> >  	writel(tail, nvmeq->q_db);
> 
> I think a store fence is necessary between memcpy_toio() and the doorbell ring.
> This applies elsewhere in the patch as well.
> 
> For example, we've seen rare cases where Haswells do not emit the whole SQE out 
> of the write combine buffers before the doorbell write traverses PCIe.  Other 
> architectures may have a similar need.  

That isn't supposed to happen.  A write to an uncached area is supposed
to flush the WC buffers.  See section 11.3 in the Intel SDM volume 3:

   Write Combining (WC) ? System memory locations are not cached
   (as with uncacheable memory) and coherency is not enforced by
   the processor?s bus coherency protocol. Speculative reads are
   allowed. Writes may be delayed and combined in the write combining
   buffer (WC buffer) to reduce memory accesses. If the WC buffer is
   partially filled, the writes may be delayed until the next occurrence
   of a serializing event; such as, an SFENCE or MFENCE instruction,
   CPUID execution, a read or write to uncached memory, an interrupt
   occurrence, or a LOCK instruction execution.

Of course, any CPU may have errata, but I'd like something a little
stronger than the assertion above before we put in an explicit fence.
