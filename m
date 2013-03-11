From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Mon, 11 Mar 2013 17:11:04 -0500
Subject: [PATCH 3/4] NVMe: End-to-end data protection
In-Reply-To: <1362443063-18994-4-git-send-email-y>
Message-ID: <OF3535E1B1.74C282ED-ON86257B2B.0078E2F3-86257B2B.0079DD3B@hgst.com>

Is this correct:
> +/*
> + * Valid formats must have either no meta-data, or meta-data equal to 
the DIF
> + * size and formatted for protection information. The driver has no use 
for
> + * meta-data for any other purpose.
> + */

This patch fails nvme_alloc_ns() if there is meta data, but data 
protection is not enabled.

Are there valid use cases where the driver passes through the meta-data to 
and from the controller, without generating  or verifying? Is it possible 
for applications to provided there own meta-data?


David Darrington




 

"Linux-nvme" <linux-nvme-bounces at lists.infradead.org> wrote on 03/04/2013 
06:24:22 PM:

> From: Keith Busch <keith.busch at intel.com>
> 
> Registers a DIF capable nvme namespace with block integrity.
> 
> Most of this is a copy from sd_dif.c, which I understand parts may be
> pulled into a kernel library that can be used from nvme and other 
drivers
> in the future, but will be copied here until then.
> 
> If the meta-data is a separate buffer, the driver will verify and
> calcuate the data integrity on reads and writes and supply a meta-data
> in the command buffer for this.  The NVMe PRACT field is set to have the
> controller generate DIF on writes and strip it on reads for lba formats
> that interleave the meta-data with the block data. LBA formats that the
> driver cannot deal with will not create a block device for that 
namespace.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme.c |  258 
> +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/nvme.h |   29 +++++-
>  2 files changed, 280 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
> index 00b4063..ff524c0 100644
> --- a/drivers/block/nvme.c
> +++ b/drivers/block/nvme.c
> @@ -20,6 +20,7 @@
>  #include <linux/bio.h>
>  #include <linux/bitops.h>
>  #include <linux/blkdev.h>
> +#include <linux/crc-t10dif.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> @@ -94,6 +95,8 @@ struct nvme_ns {
> 
>     int ns_id;
>     int lba_shift;
> +   int pi_type;
> +   int extended;
>  };
> 
>  /*
> @@ -158,6 +161,189 @@ static struct nvme_cmd_info 
> *nvme_cmd_info(struct nvme_queue *nvmeq)
>     return (void *)&nvmeq->cmdid_data[BITS_TO_LONGS(nvmeq->q_depth)];
>  }
> 
> +/*
> + * Data Integrity Field tuple.
> + */
> +struct sd_dif_tuple {
> +       __be16 guard_tag;   /* Checksum */
> +       __be16 app_tag;      /* Opaque storage */
> +       __be32 ref_tag;      /* Target LBA or indirect LBA */
> +};
> +
> +static void sd_dif_type1_generate(struct blk_integrity_exchg *bix)
> +{
> +   void *buf = bix->data_buf;
> +   struct sd_dif_tuple *sdt = bix->prot_buf;
> +   sector_t sector = bix->sector;
> +   unsigned int i;
> +
> +   for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
> +      sdt->guard_tag = cpu_to_be16(crc_t10dif(buf, bix->sector_size));
> +      sdt->ref_tag = cpu_to_be32(sector & 0xffffffff);
> +      sdt->app_tag = 0;
> +
> +      buf += bix->sector_size;
> +      sector++;
> +   }
> +}
> +
> +static int sd_dif_type1_verify(struct blk_integrity_exchg *bix)
> +{
> +   void *buf = bix->data_buf;
> +   struct sd_dif_tuple *sdt = bix->prot_buf;
> +   sector_t sector = bix->sector;
> +   unsigned int i;
> +   __u16 csum;
> +
> +   for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
> +      /* Unwritten sectors */
> +      if (sdt->app_tag == 0xffff)
> +         return 0;
> +
> +      if (be32_to_cpu(sdt->ref_tag) != (sector & 0xffffffff)) {
> +         printk(KERN_ERR
> +                "%s: ref tag error on sector %lu (rcvd %u)\n",
> +                bix->disk_name, (unsigned long)sector,
> +                be32_to_cpu(sdt->ref_tag));
> +         return -EIO;
> +      }
> +
> +      csum = cpu_to_be16(crc_t10dif(buf, bix->sector_size));
> +      if (sdt->guard_tag != csum) {
> +         printk(KERN_ERR "%s: guard tag error on sector %lu " \
> +                "(rcvd %04x, data %04x)\n", bix->disk_name,
> +                (unsigned long)sector,
> +                be16_to_cpu(sdt->guard_tag), be16_to_cpu(csum));
> +         return -EIO;
> +      }
> +
> +      buf += bix->sector_size;
> +      sector++;
> +   }
> +
> +   return 0;
> +}
> +
> +static void sd_dif_type1_set_tag(void *prot, void *tag_buf, 
> unsigned int sectors)
> +{
> +   struct sd_dif_tuple *sdt = prot;
> +   u8 *tag = tag_buf;
> +   unsigned int i, j;
> +
> +   for (i = 0, j = 0 ; i < sectors ; i++, j += 2, sdt++) {
> +      sdt->app_tag = tag[j] << 8 | tag[j+1];
> +      BUG_ON(sdt->app_tag == 0xffff);
> +   }
> +}
> +
> +static void sd_dif_type1_get_tag(void *prot, void *tag_buf, 
> unsigned int sectors)
> +{
> +   struct sd_dif_tuple *sdt = prot;
> +   u8 *tag = tag_buf;
> +   unsigned int i, j;
> +
> +   for (i = 0, j = 0 ; i < sectors ; i++, j += 2, sdt++) {
> +      tag[j] = (sdt->app_tag & 0xff00) >> 8;
> +      tag[j+1] = (sdt->app_tag & 0xff);
> +   }
> +}
> +
> +static struct blk_integrity sd_dif_type1_integrity = {
> +   .name      = "T10-DIF-TYPE1-CRC",
> +   .generate_fn   = sd_dif_type1_generate,
> +   .verify_fn   = sd_dif_type1_verify,
> +   .set_tag_fn   = sd_dif_type1_set_tag,
> +   .get_tag_fn   = sd_dif_type1_get_tag,
> +   .tuple_size   = sizeof(struct sd_dif_tuple),
> +   .tag_size   = sizeof(u16),
> +};
> +
> +static void sd_dif_type3_generate(struct blk_integrity_exchg *bix)
> +{
> +   void *buf = bix->data_buf;
> +   struct sd_dif_tuple *sdt = bix->prot_buf;
> +   unsigned int i;
> +
> +   for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
> +      sdt->guard_tag = cpu_to_be16(crc_t10dif(buf, bix->sector_size));
> +      sdt->ref_tag = 0;
> +      sdt->app_tag = 0;
> +
> +      buf += bix->sector_size;
> +   }
> +}
> +
> +static int  sd_dif_type3_verify(struct blk_integrity_exchg *bix)
> +{
> +   void *buf = bix->data_buf;
> +   struct sd_dif_tuple *sdt = bix->prot_buf;
> +   sector_t sector = bix->sector;
> +   unsigned int i;
> +   __u16 csum;
> +
> +   for (i = 0 ; i < bix->data_size ; i += bix->sector_size, sdt++) {
> +      /* Unwritten sectors */
> +      if (sdt->app_tag == 0xffff && sdt->ref_tag == 0xffffffff)
> +         continue;
> +
> +      csum = cpu_to_be16(crc_t10dif(buf, bix->sector_size));
> +
> +      if (sdt->guard_tag != csum) {
> +         printk(KERN_ERR "%s: guard error on sector %lu" \
> +            "(rcvd:%04x data:%04x)\n", bix->disk_name,
> +            (unsigned long) sector,
> +            be16_to_cpu(sdt->guard_tag), be16_to_cpu(csum));
> +         return -EIO;
> +      }
> +
> +      buf += bix->sector_size;
> +      sector++;
> +   }
> +
> +   return 0;
> +}
> +
> +static void sd_dif_type3_set_tag(void *prot, void *tag_buf, 
> unsigned int sectors)
> +{
> +   struct sd_dif_tuple *sdt = prot;
> +   u8 *tag = tag_buf;
> +   unsigned int i, j;
> +
> +   for (i = 0, j = 0 ; i < sectors ; i++, j += 6, sdt++) {
> +      sdt->app_tag = tag[j] << 8 | tag[j+1];
> +      sdt->ref_tag = tag[j+2] << 24 | tag[j+3] << 16 |
> +         tag[j+4] << 8 | tag[j+5];
> +   }
> +}
> +
> +static void sd_dif_type3_get_tag(void *prot, void *tag_buf, 
> unsigned int sectors)
> +{
> +   struct sd_dif_tuple *sdt = prot;
> +   u8 *tag = tag_buf;
> +   unsigned int i, j;
> +
> +   for (i = 0, j = 0 ; i < sectors ; i++, j += 2, sdt++) {
> +      tag[j] = (sdt->app_tag & 0xff00) >> 8;
> +      tag[j+1] = (sdt->app_tag & 0xff);
> +      tag[j+2] = (sdt->ref_tag & 0xff000000) >> 24;
> +      tag[j+3] = (sdt->ref_tag & 0xff0000) >> 16;
> +      tag[j+4] = (sdt->ref_tag & 0xff00) >> 8;
> +      tag[j+5] = (sdt->ref_tag & 0xff);
> +      BUG_ON(sdt->app_tag == 0xffff || sdt->ref_tag == 0xffffffff);
> +   }
> +}
> +
> +
> +static struct blk_integrity sd_dif_type3_integrity = {
> +   .name      = "T10-DIF-TYPE3-CRC",
> +   .generate_fn   = sd_dif_type3_generate,
> +   .verify_fn   = sd_dif_type3_verify,
> +   .set_tag_fn   = sd_dif_type3_set_tag,
> +   .get_tag_fn   = sd_dif_type3_get_tag,
> +   .tuple_size   = sizeof(struct sd_dif_tuple),
> +   .tag_size   = sizeof(u16) + sizeof(u32),
> +};
> +
>  /**
>   * alloc_cmdid() - Allocate a Command ID
>   * @nvmeq: The queue that will be used for this command
> @@ -313,6 +499,9 @@ struct nvme_iod {
>     int nents;      /* Used in scatterlist */
>     int length;      /* Of data, in bytes */
>     dma_addr_t first_dma;
> +   dma_addr_t meta_dma;
> +   unsigned int meta_size;
> +   enum dma_data_direction dma_dir;
>     struct scatterlist sg[0];
>  };
> 
> @@ -344,6 +533,7 @@ nvme_alloc_iod(unsigned nseg, unsigned nbytes, gfp_t 
gfp)
>        iod->npages = -1;
>        iod->length = nbytes;
>        iod->nents = 0;
> +      iod->meta_size = 0;
>     }
> 
>     return iod;
> @@ -364,6 +554,9 @@ static void nvme_free_iod(struct nvme_dev *dev, 
> struct nvme_iod *iod)
>        dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
>        prp_dma = next_prp_dma;
>     }
> +   if (iod->meta_size)
> +      dma_unmap_single(&dev->pci_dev->dev, iod->meta_dma,
> +               iod->meta_size, iod->dma_dir);
>     kfree(iod);
>  }
> 
> @@ -649,6 +842,7 @@ static int nvme_submit_bio_queue(struct 
> nvme_queue *nvmeq, struct nvme_ns *ns,
>        cmnd->rw.opcode = nvme_cmd_read;
>        dma_dir = DMA_FROM_DEVICE;
>     }
> +   iod->dma_dir = dma_dir;
> 
>     result = nvme_map_bio(nvmeq, iod, bio, dma_dir, psegs);
>     if (result <= 0)
> @@ -661,6 +855,27 @@ static int nvme_submit_bio_queue(struct 
> nvme_queue *nvmeq, struct nvme_ns *ns,
>                          GFP_ATOMIC);
>     cmnd->rw.slba = cpu_to_le64(bio->bi_sector >> (ns->lba_shift - 9));
>     cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
> +
> +   if (ns->pi_type) {
> +      control |= NVME_RW_PRINFO_PRCHK_GUARD;
> +      if (ns->pi_type != NVME_NS_DPS_PI_TYPE3) {
> +         control |= NVME_RW_PRINFO_PRCHK_REF;
> +         cmnd->rw.reftag = cpu_to_le32(
> +               (bio->bi_sector >> (ns->lba_shift - 9)) &
> +               0xffffffff);
> +      }
> +      if (bio_integrity(bio)) {
> +         iod->meta_dma = dma_map_single(nvmeq->q_dmadev,
> +                  bio->bi_integrity->bip_buf,
> +                  bio->bi_integrity->bip_size,
> +                  dma_dir);
> +         iod->meta_size = bio->bi_integrity->bip_size;
> +         cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> +      } else {
> +         control |= NVME_RW_PRINFO_PRACT;
> +      }
> +   }
> +
>     cmnd->rw.control = cpu_to_le16(control);
>     cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> 
> @@ -1404,16 +1619,46 @@ static void nvme_put_ns_idx(int index)
>     spin_unlock(&dev_list_lock);
>  }
> 
> +static void nvme_ns_register_pi(struct nvme_ns *ns)
> +{
> +   struct blk_integrity *integrity;
> +   if (ns->pi_type == NVME_NS_DPS_PI_TYPE3)
> +      integrity = &sd_dif_type3_integrity;
> +   else
> +      integrity = &sd_dif_type1_integrity;
> +   blk_integrity_register(ns->disk, integrity);
> +}
> +
> +/*
> + * Valid formats must have either no meta-data, or meta-data equal to 
the DIF
> + * size and formatted for protection information. The driver has no use 
for
> + * meta-data for any other purpose.
> + */
> +static int nvme_check_pi_format(struct nvme_id_ns *id)
> +{
> +   int lbaf = id->flbas & NVME_NS_FLBAS_LBAF_MASK;
> +   int ms = id->lbaf[lbaf].ms;
> +   if (id->dps & NVME_NS_DPS_PI_MASK && ms == sizeof(struct 
sd_dif_tuple))
> +      return id->dps & NVME_NS_DPS_PI_MASK;
> +   else if (ms)
> +      return -1;
> +   return 0;
> +}
> +
>  static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
>           struct nvme_id_ns *id, struct nvme_lba_range_type *rt)
>  {
>     struct nvme_ns *ns;
>     struct gendisk *disk;
> -   int lbaf;
> +   int lbaf, pi_type;
> 
>     if (rt->attributes & NVME_LBART_ATTRIB_HIDE)
>        return NULL;
> 
> +   pi_type = nvme_check_pi_format(id);
> +   if (pi_type < 0)
> +      return NULL;
> +
>     ns = kzalloc(sizeof(*ns), GFP_KERNEL);
>     if (!ns)
>        return NULL;
> @@ -1428,6 +1673,10 @@ static struct nvme_ns *nvme_alloc_ns(struct 
> nvme_dev *dev, int nsid,
>     ns->dev = dev;
>     ns->queue->queuedata = ns;
> 
> +   ns->pi_type = pi_type;
> +   if (pi_type)
> +      ns->extended = id->flbas & NVME_NS_FLBAS_LBA_EXTENDED;
> +
>     disk = alloc_disk(NVME_MINORS);
>     if (!disk)
>        goto out_free_queue;
> @@ -1603,8 +1852,11 @@ static int __devinit nvme_dev_add(struct nvme_dev 
*dev)
>        if (ns)
>           list_add_tail(&ns->list, &dev->namespaces);
>     }
> -   list_for_each_entry(ns, &dev->namespaces, list)
> +   list_for_each_entry(ns, &dev->namespaces, list) {
>        add_disk(ns->disk);
> +      if (!ns->extended && ns->pi_type)
> +         nvme_ns_register_pi(ns);
> +   }
> 
>     goto out;
> 
> @@ -1629,6 +1881,8 @@ static int nvme_dev_remove(struct nvme_dev *dev)
> 
>     list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
>        list_del(&ns->list);
> +      if (!ns->extended && ns->pi_type)
> +         blk_integrity_unregister(ns->disk);
>        del_gendisk(ns->disk);
>        nvme_ns_free(ns);
>     }
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 4fa3b0b..ee0a1f6 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -130,11 +130,25 @@ struct nvme_id_ns {
>  };
> 
>  enum {
> -   NVME_NS_FEAT_THIN   = 1 << 0,
> -   NVME_LBAF_RP_BEST   = 0,
> -   NVME_LBAF_RP_BETTER   = 1,
> -   NVME_LBAF_RP_GOOD   = 2,
> -   NVME_LBAF_RP_DEGRADED   = 3,
> +   NVME_NS_FEAT_THIN      = 1 << 0,
> +   NVME_NS_MC_EXTENDED      = 1 << 0,
> +   NVME_NS_MC_SEPARATE      = 1 << 1,
> +   NVME_NS_FLBAS_LBA_EXTENDED   = 1 << 4,
> +   NVME_NS_FLBAS_LBAF_MASK      = 0xf,
> +   NVME_NS_DPC_PI_LAST      = 1 << 4,
> +   NVME_NS_DPC_PI_FIRST      = 1 << 3,
> +   NVME_NS_DPC_PI_TYPE3      = 1 << 2,
> +   NVME_NS_DPC_PI_TYPE2      = 1 << 1,
> +   NVME_NS_DPC_PI_TYPE1      = 1 << 0,
> +   NVME_NS_DPS_PI_FIRST      = 1 << 3,
> +   NVME_NS_DPS_PI_MASK      = 0x7,
> +   NVME_NS_DPS_PI_TYPE1      = 1,
> +   NVME_NS_DPS_PI_TYPE2      = 2,
> +   NVME_NS_DPS_PI_TYPE3      = 3,
> +   NVME_LBAF_RP_BEST      = 0,
> +   NVME_LBAF_RP_BETTER      = 1,
> +   NVME_LBAF_RP_GOOD      = 2,
> +   NVME_LBAF_RP_DEGRADED      = 3,
>  };
> 
>  struct nvme_smart_log {
> @@ -244,6 +258,11 @@ enum {
>     NVME_RW_DSM_LATENCY_LOW      = 3 << 4,
>     NVME_RW_DSM_SEQ_REQ      = 1 << 6,
>     NVME_RW_DSM_COMPRESSED      = 1 << 7,
> +   NVME_RW_PRINFO_PRACT      = 1 << 13,
> +   NVME_RW_PRINFO_PRCHK_GUARD   = 1 << 12,
> +   NVME_RW_PRINFO_PRCHK_APP   = 1 << 11,
> +   NVME_RW_PRINFO_PRCHK_REF   = 1 << 10,
> +
>  };
> 
>  /* Admin commands */
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
