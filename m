From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 6 Nov 2012 11:10:08 -0500
Subject: [PATCH] NVMe: Add discard support for capable devices
In-Reply-To: <1343933944-32726-1-git-send-email-keith.busch@intel.com>
References: <1343933944-32726-1-git-send-email-keith.busch@intel.com>
Message-ID: <20121106161008.GA1736@linux.intel.com>

On Thu, Aug 02, 2012@12:59:04PM -0600, Keith Busch wrote:
> This adds discard support to block queues if the nvme device is capable
> of deallocating blocks as indicated by the controller's optional command
> support. A discard flagged bio request will submit an NVMe deallocate
> Data Set Management command for the requested blocks.

Thanks for this.

> @@ -334,6 +335,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t gfp)
>  		iod->offset = offsetof(struct nvme_iod, sg[nseg]);
>  		iod->npages = -1;
>  		iod->length = nbytes;
> +		iod->nents = 0;
>  	}
>  
>  	return iod;

Are you initialising nents here to prevent having to do so in
nvme_submit_discard?  I think we're relying on undefined behaviour of
dma_unmap_sg() in bio_completion() -- ie to be a no-op when nents is 0.
Probably we should check it explicitly; ie:

	if (iod->nents)
		dma_unmap_sg(...);

We're already relying on that behaviour for the case of submitting a
flush without data, so can you split this into two patches; one that
initialises iod->nents to 0 and checks it, then a second one that adds
the discard functionality?

> @@ -505,6 +507,39 @@ static int nvme_map_bio(struct device *dev, struct nvme_iod *iod,
>  	return length;
>  }
>  
> +static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
> +		struct bio *bio, struct nvme_iod *iod, int cmdid)
> +{
> +	struct nvme_dsm_range *range;
> +	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];

Could we have a comment somewhere (possibly here) about how we're reusing
the prp small pool for this purpose instead of creating a special pool?
Maybe include the justification that it's not worth creating a new pool
to dole out these 16-byte ranges.

> +	range = dma_pool_alloc(nvmeq->dev->prp_small_pool, GFP_ATOMIC,
> +							&iod->first_dma);
> +	if (range == NULL)
> +		return -ENOMEM;

Usual style is
	if (!range)

But ... we've got a problem here.  If this allocation fails, we leak the
nvme_iod and the cmdid.  We need to change the code below (skip down to
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

Although ... now I'm looking at the failure path in
nvme_submit_bio_queue(), isn't it the case that we'll leak cmdids if
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
> +static void nvme_config_discard(struct nvme_ns *ns)
> +{
> +	u32 logical_block_size = queue_logical_block_size(ns->queue);
> +	sector_t nr_sectors = get_capacity(ns->disk);
> +
> +	ns->queue->limits.discard_zeroes_data = 0;
> +	ns->queue->limits.discard_alignment = logical_block_size;
> +	ns->queue->limits.discard_granularity = logical_block_size;
> +	ns->queue->limits.max_discard_sectors = (u32)min_t(u64, nr_sectors,
> +								0xffffffff);

I don't think we need to set the limit to the maximum size of the block
device ... I don't see any other driver doing this.  Just:

+	ns->queue->limits.max_discard_sectors = 0xffffffff;

should be fine (and delete the get_capacity() line).
