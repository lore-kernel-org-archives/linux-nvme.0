From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 27 Mar 2013 18:51:31 -0400
Subject: [PATCH v3 7/7] NVMe: End-to-end data protection
In-Reply-To: <1363966604-5482-1-git-send-email-keith.busch@intel.com>
References: <1363966604-5482-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130327225131.GI4671@linux.intel.com>

On Fri, Mar 22, 2013@09:36:44AM -0600, Keith Busch wrote:
> Registers a DIF capable nvme namespace with block integrity.

I'm assuming I can't apply this until Martin has applied 1-5?  But I
can apply 6 safely?

> @@ -692,6 +718,29 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
>  								GFP_ATOMIC);
>  	cmnd->rw.slba = cpu_to_le64(bio->bi_sector >> (ns->lba_shift - 9));
>  	cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
> +
> +	if (ns->ms) {
> +		if (ns->pi_type) {
> +			control |= NVME_RW_PRINFO_PRCHK_GUARD;
> +			if (ns->pi_type != NVME_NS_DPS_PI_TYPE3) {
> +				control |= NVME_RW_PRINFO_PRCHK_REF;
> +				cmnd->rw.reftag = cpu_to_le32(
> +					(bio->bi_sector >> (ns->lba_shift - 9)) &
> +					0xffffffff);
> +			}
> +		}

Mmpf.  Sets off my "overly long lines" trigger.  The indentation is
deep, but I don't see a nice way to reduce it.  I notice we have the
'bio->bi_sector >> (ns->lba_shift - 9)' idiom in two places already in
the driver, and this adds a third.  There's also a place in the SCSI
emulation code that gets the shifting slightly wrong.  Probably harmless,
but clearly it's time to compute this in a macro.

How does this look?

+				u32 block = nvme_block_nr(ns, bio->bi_sector);
+				control |= NVME_RW_PRINFO_PRCHK_REF;
+				cmnd->rw.reftag = cpu_to_le32(block);

Along with the suitable:

static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
{
	return (sector >> (ns->lba_shift - 9));
}

in linux/nvme.h?

> +		if (bio_integrity(bio)) {
> +				iod->meta_dma =
> +					dma_map_single(nvmeq->q_dmadev,
> +						bio->bi_integrity->bip_buf,
> +						bio->bi_integrity->bip_size,
> +						dma_dir);
> +				cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);

Indentation gone wild?  Should be:

+		if (bio_integrity(bio)) {
+			iod->meta_dma = dma_map_single(nvmeq->q_dmadev,
+						bio->bi_integrity->bip_buf,
+						bio->bi_integrity->bip_size,
+						dma_dir);
+			cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);

Right?
