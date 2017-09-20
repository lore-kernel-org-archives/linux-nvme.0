From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Sep 2017 13:48:42 -0400
Subject: [PATCH] nvme: set physical block size to value discovered in
 Identify Namespace
In-Reply-To: <20170920170605.42161-1-andrzej.jakowski@intel.com>
References: <20170920170605.42161-1-andrzej.jakowski@intel.com>
Message-ID: <20170920174842.GB1379@localhost.localdomain>

On Wed, Sep 20, 2017@10:06:05AM -0700, Andrzej Jakowski wrote:
> In old implementation physical block size exported by NVMe driver defaulted to
> logical block size. Existing NVMe SSDs very often
> Musze naprawic zeby brac pod uwage relative performance.

Dziekuje for the patch, but the change logs gotta be in English. :)

I think what you're wanting to say is:

  The physical block size will default to the logical block size unless
  otherwise specified. While NVMe doesn't provide a way to discover the
  physical block size, the format with best relative performance is a
  good indicator as to the underlying block size.

> +static u32 calc_pbs(struct nvme_id_ns *id)
> +{
> +	struct nvme_lbaf *lbaf_used;
> +	int i, max_id = 0;
> +	u8 ds = 0;
> +
> +	lbaf_used = &id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK];
> +	if (lbaf_used->rp == NVME_LBAF_RP_BEST)
> +		return (((u32)1) << lbaf_used->ds);
> +
> +	for (i = 0; i < id->nlbaf; i++) {
> +		if (id->lbaf[i].ms == 0 && id->lbaf[i].ds > ds &&
> +			id->lbaf[i].rp < lbaf_used->rp && id->lbaf[i].ds <= PAGE_SHIFT)
> +			max_id = i;
> +
> +		ds = id->lbaf[i].ds;
> +	}
> +
> +	if (id->lbaf[max_id].ds)
> +		return (((u32)1) << id->lbaf[max_id].ds);
> +	else
> +		return 0;
> +}

I think this can be a little clearner. How about:

static u32 calc_pbs(struct nvme_id_ns *id)
{
	int i;
	struct nvme_lbaf *best = &id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK];

	for (i = 0; i < id->nlbaf; i++)
		if (id->lbaf[i].rp <= best->rp &&
				id->lbaf[i].ds > best->lbaf.ds &&
				id->lbaf[i].ds <= PAGE_SHIFT)
			best = &id->lbaf[i];

	return 1 << best->ds;
}
