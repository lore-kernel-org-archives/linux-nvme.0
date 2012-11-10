From: Khosrow.Panah@idt.com (Panah, Khosrow)
Date: Sat, 10 Nov 2012 00:32:25 +0000
Subject: Linux-nvme Digest, Vol 8, Issue 3
In-Reply-To: <mailman.11.1352221203.2108.linux-nvme@lists.infradead.org>
References: <mailman.11.1352221203.2108.linux-nvme@lists.infradead.org>
Message-ID: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEEC01@corpmail1.na.ads.idt.com>

All,

Driver should check controller Identify data to validate Discard/TRIM command is supported prior to exporting this feature.


static int __devinit nvme_dev_add(struct nvme_dev *dev)
{
	.
	.
      memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
      memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
      memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
+	dev->cmd_support = ctrl->oncs;

}


static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
                        struct nvme_id_ns *id, struct nvme_lba_range_type *rt)
{
	.
	.
      queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+	If (dev->cmd_support & (1 << 2)) {
+		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
+		queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, ns->queue);
+	}


Khosrow



-----Original Message-----
From: linux-nvme-bounces@lists.infradead.org [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of linux-nvme-request@lists.infradead.org
Sent: Tuesday, November 06, 2012 9:00 AM
To: linux-nvme at lists.infradead.org
Subject: Linux-nvme Digest, Vol 8, Issue 3

Send Linux-nvme mailing list submissions to
	linux-nvme at lists.infradead.org

To subscribe or unsubscribe via the World Wide Web, visit
	http://merlin.infradead.org/mailman/listinfo/linux-nvme
or, via email, send a message with subject or body 'help' to
	linux-nvme-request at lists.infradead.org

You can reach the person managing the list at
	linux-nvme-owner at lists.infradead.org

When replying, please edit your Subject line so it is more specific than "Re: Contents of Linux-nvme digest..."


Today's Topics:

   1. Re: [PATCH] NVMe: Add discard support for capable devices
      (Matthew Wilcox)
   2. Re: [PATCH] NVMe: Add discard support for capable devices
      (Matthew Wilcox)
   3. RE: [PATCH] NVMe: Add discard support for capable devices
      (Busch, Keith)
   4. Re: [PATCH] NVMe: Free cmdid of nvme_submit_bio error
      (Matthew Wilcox)
   5. Re: [PATCH] NVMe: End queued bio requests when freeing queue
      (Matthew Wilcox)
   6. Re: [PATCH] NVMe: Set result from user admin command
      (Matthew Wilcox)
   7. Re: [PATCH] NVMe: Add result to nvme_get_features (Matthew Wilcox)
   8. Re: [PATCH] NVMe: Define SMART log (Matthew Wilcox)


----------------------------------------------------------------------

Message: 1
Date: Tue, 6 Nov 2012 11:10:08 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Add discard support for capable devices
Message-ID: <20121106161008.GA1736 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii

On Thu, Aug 02, 2012@12:59:04PM -0600, Keith Busch wrote:
> This adds discard support to block queues if the nvme device is 
> capable of deallocating blocks as indicated by the controller's 
> optional command support. A discard flagged bio request will submit an 
> NVMe deallocate Data Set Management command for the requested blocks.

Thanks for this.

> @@ -334,6 +335,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
>  		iod->offset = offsetof(struct nvme_iod, sg[nseg]);
>  		iod->npages = -1;
>  		iod->length = nbytes;
> +		iod->nents = 0;
>  	}
>  
>  	return iod;

Are you initialising nents here to prevent having to do so in nvme_submit_discard?  I think we're relying on undefined behaviour of
dma_unmap_sg() in bio_completion() -- ie to be a no-op when nents is 0.
Probably we should check it explicitly; ie:

	if (iod->nents)
		dma_unmap_sg(...);

We're already relying on that behaviour for the case of submitting a flush without data, so can you split this into two patches; one that initialises iod->nents to 0 and checks it, then a second one that adds the discard functionality?

> @@ -505,6 +507,39 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
>  	return length;
>  }
>  
> +static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
> +		struct bio *bio, struct nvme_iod *iod, int cmdid) {
> +	struct nvme_dsm_range *range;
> +	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];

Could we have a comment somewhere (possibly here) about how we're reusing the prp small pool for this purpose instead of creating a special pool?
Maybe include the justification that it's not worth creating a new pool to dole out these 16-byte ranges.

> +	range = dma_pool_alloc(nvmeq->dev->prp_small_pool, GFP_ATOMIC,
> +							&iod->first_dma);
> +	if (range == NULL)
> +		return -ENOMEM;

Usual style is
	if (!range)

But ... we've got a problem here.  If this allocation fails, we leak the nvme_iod and the cmdid.  We need to change the code below (skip down to
[A]):

> +
> +	iod_list(iod)[0] = (__le64 *)range;

Brave.  I like it :-)

> +	iod->npages = 0;
> +
> +	range->cattr = cpu_to_le32(0);
> +	range->nlb = cpu_to_le32(bio->bi_size >> ns->lba_shift);
> +	range->slba = cpu_to_le64(bio->bi_sector >> (ns->lba_shift - 9));
> +
> +	memset(cmnd, 0, sizeof(*cmnd));
> +	cmnd->dsm.opcode = nvme_cmd_dsm;
> +	cmnd->dsm.command_id = cmdid;
> +	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
> +	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
> +	cmnd->dsm.nr = 0;
> +	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
> +
> +	if (++nvmeq->sq_tail == nvmeq->q_depth)
> +		nvmeq->sq_tail = 0;
> +	writel(nvmeq->sq_tail, nvmeq->q_db);
> +
> +	return 0;
> +}
> +
>  static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
>  								int cmdid)
>  {
> @@ -562,6 +597,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
>  	if (unlikely(cmdid < 0))
>  		goto free_iod;
>  
> +	if (bio->bi_rw & REQ_DISCARD)
> +		return nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);

[A] If this fails, we need to do this:

+	if (bio->bi_rw & REQ_DISCARD) {
+		result = nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
+		if (result)
+			goto free_iod;
+	}

Although ... now I'm looking at the failure path in nvme_submit_bio_queue(), isn't it the case that we'll leak cmdids if
nvme_map_bio() fails?  And in this case?  So I think we also need:

+ free_cmdid:
+	free_cmdid(nvmeq, cmdid, NULL);
  free_iod:	

And then change the 'goto free_iod' to 'goto free_cmdid'.

>  	if ((bio->bi_rw & REQ_FLUSH) && !psegs)
>  		return nvme_submit_flush(nvmeq, ns, cmdid);
>  
> @@ -1316,6 +1353,19 @@ static void nvme_put_ns_idx(int index)
>  	spin_unlock(&dev_list_lock);
>  }
>  
> +static void nvme_config_discard(struct nvme_ns *ns) {
> +	u32 logical_block_size = queue_logical_block_size(ns->queue);
> +	sector_t nr_sectors = get_capacity(ns->disk);
> +
> +	ns->queue->limits.discard_zeroes_data = 0;
> +	ns->queue->limits.discard_alignment = logical_block_size;
> +	ns->queue->limits.discard_granularity = logical_block_size;
> +	ns->queue->limits.max_discard_sectors = (u32)min_t(u64, nr_sectors,
> +								0xffffffff);

I don't think we need to set the limit to the maximum size of the block device ... I don't see any other driver doing this.  Just:

+	ns->queue->limits.max_discard_sectors = 0xffffffff;

should be fine (and delete the get_capacity() line).




------------------------------

Message: 2
Date: Tue, 6 Nov 2012 11:15:09 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Add discard support for capable devices
Message-ID: <20121106161509.GU4244 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii

On Tue, Nov 06, 2012@11:10:08AM -0500, Matthew Wilcox wrote:
> Although ... now I'm looking at the failure path in 
> nvme_submit_bio_queue(), isn't it the case that we'll leak cmdids if
> nvme_map_bio() fails?  And in this case?  So I think we also need:
> 
> + free_cmdid:
> +	free_cmdid(nvmeq, cmdid, NULL);
>   free_iod:	
> 
> And then change the 'goto free_iod' to 'goto free_cmdid'.

Never mind; just got to the patch where you fixed this :-)



------------------------------

Message: 3
Date: Tue, 6 Nov 2012 16:19:58 +0000
From: "Busch, Keith" <keith.busch@intel.com>
To: Matthew Wilcox <willy at linux.intel.com>
Cc: "linux-nvme at lists.infradead.org" <linux-nvme at lists.infradead.org>
Subject: RE: [PATCH] NVMe: Add discard support for capable devices
Message-ID:
	<B58D82457FDA0744A320A2FC5AC253B9162BBEBC at FMSMSX105.amr.corp.intel.com>
	
Content-Type: text/plain; charset="us-ascii"

Yes, though I should have made this patch dependent on the cmdid patch so I could use the right error handling here. I'll submit an update to reflect this and your other comments. Thanks for the review, I very much appreciate the feedback.

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy at linux.intel.com]
> Sent: Tuesday, November 06, 2012 9:15 AM
> To: Busch, Keith
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Add discard support for capable devices
> 
> On Tue, Nov 06, 2012@11:10:08AM -0500, Matthew Wilcox wrote:
> > Although ... now I'm looking at the failure path in 
> > nvme_submit_bio_queue(), isn't it the case that we'll leak cmdids if
> > nvme_map_bio() fails?  And in this case?  So I think we also need:
> >
> > + free_cmdid:
> > +	free_cmdid(nvmeq, cmdid, NULL);
> >   free_iod:
> >
> > And then change the 'goto free_iod' to 'goto free_cmdid'.
> 
> Never mind; just got to the patch where you fixed this :-)



------------------------------

Message: 4
Date: Tue, 6 Nov 2012 11:32:13 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Free cmdid of nvme_submit_bio error
Message-ID: <20121106163213.GB1736 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii


Fixed it slightly differently (changed free_cmdid() to allow for fn to be NULL).  But I kept your attribution and added an explanation.




------------------------------

Message: 5
Date: Tue, 6 Nov 2012 11:34:51 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: End queued bio requests when freeing queue
Message-ID: <20121106163451.GC1736 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii

On Mon, Aug 20, 2012@02:57:49PM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>

THanks, applied.  I wrote another changelog :-)



------------------------------

Message: 6
Date: Tue, 6 Nov 2012 11:45:42 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Set result from user admin command
Message-ID: <20121106164542.GD1736 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii

On Fri, Sep 21, 2012@10:49:05AM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Thanks, applied.  Wrote another changelog :-)



------------------------------

Message: 7
Date: Tue, 6 Nov 2012 11:47:29 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Add result to nvme_get_features
Message-ID: <20121106164729.GE1736 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii

On Fri, Sep 21, 2012@10:52:13AM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Thanks, applied, with another changelog :-)



------------------------------

Message: 8
Date: Tue, 6 Nov 2012 11:54:13 -0500
From: Matthew Wilcox <willy@linux.intel.com>
To: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Define SMART log
Message-ID: <20121106165413.GF1736 at linux.intel.com>
Content-Type: text/plain; charset=us-ascii

On Wed, Sep 26, 2012@12:49:27PM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

> +	NVME_SMART_CRIT_VOLITILE_MEMORY	= 1 << 4,

Thanks, applied.  I corrected the spelling of 'Volatile'.



------------------------------

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme


End of Linux-nvme Digest, Vol 8, Issue 3
****************************************
