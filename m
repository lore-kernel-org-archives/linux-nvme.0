From: sbradshaw@micron.com (Sam Bradshaw)
Date: Tue, 17 Feb 2015 09:03:54 -0800
Subject: [PATCH] NVMe: Metadata and PI format support
In-Reply-To: <alpine.LNX.2.00.1502171449101.32385@localhost.lm.intel.com>
References: <1422670317-23420-1-git-send-email-keith.busch@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A99979435A@NTXBOIMBX02.micron.com>
 <alpine.LNX.2.00.1502171449101.32385@localhost.lm.intel.com>
Message-ID: <54E3747A.2000902@micron.com>


>> If there is interest in incorporating this support, we can provide
>> a patch on top of this that enables 16b/32b/64b metadata with PI and
>> supports PIL={0,1}
> 
> I would also like that to work. I was hoping to reuse the
> t10_pi_generate/verify functions for this. Those can work if the
> iter->prot_buf is incremented by the blk_intergity's tuple_size rather
> than just the 8-byte PI field.
> 
> That'd work with PIL=0, not sure what to do with PIL=1. Maybe we should
> just define our own functions for nvme even though they'd mostly be the
> same as the ones scsi uses.

We were unable to come up with an elegant solution that reused the 
t10_pi_generate/verify functions while also handling the PIL=1 case.  
So we defined our own functions. 

---
 drivers/block/nvme-core.c |  319 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h      |   22 +++
 2 files changed, 328 insertions(+), 13 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 23df65d..692eb31 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -38,6 +38,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/t10-pi.h>
+#include <linux/crc-t10dif.h>
 #include <linux/types.h>
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
@@ -449,6 +450,7 @@ static void nvme_dif_remap(struct request *req,
 	struct nvme_ns *ns = req->rq_disk->private_data;
 	struct bio_integrity_payload *bip;
 	struct t10_pi_tuple *pi;
+	int pi_sz = sizeof(struct t10_pi_tuple);
 	void *p;
 	u32 i, nlb, ts, phys, virt;
 
@@ -468,6 +470,11 @@ static void nvme_dif_remap(struct request *req,
 	nlb = (blk_rq_bytes(req) >> ns->lba_shift);
 	ts = ns->disk->integrity->tuple_size;
 
+	/* Adjust if metadata > 8b and PI is in last 8b of metadata */
+	if ((ns->ms > pi_sz) && !ns->pi_first)
+		p = (struct t10_pi_tuple *) ((char *) p + ns->ms
+							- pi_sz);
+
 	for (i = 0; i < nlb; i++, virt++, phys++) {
 		pi = (struct t10_pi_tuple *)p;
 		dif_swap(phys, virt, pi);
@@ -1944,6 +1951,183 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
 }
 
+/*
+ * Calculates CRC value for the data buffer of given len, and returns
+ * it in big-endian format
+ */
+static __be16 nvme_crc_fn(void *data, unsigned int len)
+{
+	return cpu_to_be16(crc_t10dif(data, len));
+}
+
+/*
+ * Calculates unified CRC value for the inputted crc and data buffer of given
+ * len, and returns it in big-endian format
+ */
+static __be16 nvme_crc_generic_fn(__u16 crc, void *data, unsigned int len)
+{
+	return cpu_to_be16(crc_t10dif_generic(crc, data, len));
+}
+
+static int nvme_generate(struct blk_integrity_iter *bix, csum_fn *fn, u8 ms,
+							u8 type, u8 first)
+{
+	struct t10_pi_tuple *pi = bix->prot_buf;
+	int i, pi_sz = sizeof(struct t10_pi_tuple);
+
+	/* Adjust if metadata > 8b and PI is in last 8b of metadata */
+	if ((ms > pi_sz) && (!first))
+		pi = (struct t10_pi_tuple *) ((char *) pi + ms - pi_sz);
+
+	for (i = 0; i < bix->data_size; i += bix->interval) {
+
+		pi->guard_tag = fn(bix->data_buf, bix->interval);
+
+		/*
+		 * Include metadata for CRC calc if PI is in last 8b
+		 * of metadata
+		 */
+		if ((ms > pi_sz) && (!first)) {
+			u8 *p = ((u8 *) pi - (ms - pi_sz));
+
+			memset(p, 0, ms - pi_sz);
+			pi->guard_tag = nvme_crc_generic_fn(
+						be16_to_cpu(pi->guard_tag),
+						p,
+						ms - pi_sz);
+		}
+
+		/*
+		 * 'seed' is a virtual start sector that we received, and
+		 * this func populates ref_tag based on it. The ref_tag will
+		 * be remapped with actual physical sector in nvme_dif_remap()
+		 */
+		if (type != NVME_NS_DPS_PI_TYPE3)
+			pi->ref_tag = cpu_to_be32(lower_32_bits(bix->seed));
+		else
+			pi->ref_tag = 0;
+
+		pi->app_tag = 0;
+		bix->data_buf += bix->interval;
+		bix->prot_buf += ms;
+		bix->seed++;
+		pi = (struct t10_pi_tuple *) ((char *) pi + ms);
+	}
+	return 0;
+}
+
+/* DEFINE_GENERATOR(ms, pi_type, pi_first) */
+DEFINE_GENERATOR(8, 1, 0);
+DEFINE_GENERATOR(8, 2, 0);
+DEFINE_GENERATOR(8, 3, 0);
+DEFINE_GENERATOR(16, 1, 0);
+DEFINE_GENERATOR(16, 1, 1);
+DEFINE_GENERATOR(16, 2, 0);
+DEFINE_GENERATOR(16, 2, 1);
+DEFINE_GENERATOR(16, 3, 0);
+DEFINE_GENERATOR(16, 3, 1);
+DEFINE_GENERATOR(32, 1, 0);
+DEFINE_GENERATOR(32, 1, 1);
+DEFINE_GENERATOR(32, 2, 0);
+DEFINE_GENERATOR(32, 2, 1);
+DEFINE_GENERATOR(32, 3, 0);
+DEFINE_GENERATOR(32, 3, 1);
+DEFINE_GENERATOR(64, 1, 0);
+DEFINE_GENERATOR(64, 1, 1);
+DEFINE_GENERATOR(64, 2, 0);
+DEFINE_GENERATOR(64, 2, 1);
+DEFINE_GENERATOR(64, 3, 0);
+DEFINE_GENERATOR(64, 3, 1);
+
+static int nvme_verify(struct blk_integrity_iter *bix, csum_fn *fn, u8 ms,
+							u8 type, u8 first)
+{
+	struct t10_pi_tuple *pi = bix->prot_buf;
+	int i, pi_sz = sizeof(struct t10_pi_tuple);
+	u16 csum;
+
+	/* If metadata > 8 bytes and PI is in last 8 bytes of metadata */
+	if ((ms > pi_sz) && (!first))
+		pi = (struct t10_pi_tuple *) ((char *) pi + ms - pi_sz);
+
+	for (i = 0; i < bix->data_size; i += bix->interval) {
+		/*
+		 * For type1 & type2, apptag == 0xffff means skip verification
+		 * For type3, apptag == 0xffff and reftag == 0xffffffff means
+		 * skip verification
+		 */
+		if (pi->app_tag == 0xffff) {
+			switch (type) {
+			case NVME_NS_DPS_PI_TYPE3:
+				if (pi->ref_tag != 0xffffffff)
+					break;
+			case NVME_NS_DPS_PI_TYPE1:
+			case NVME_NS_DPS_PI_TYPE2:
+				goto next;
+			}
+		}
+
+		csum = fn(bix->data_buf, bix->interval);
+
+		/* Update CRC if PI is in last 8 bytes of metadata */
+		if ((ms > pi_sz) && (!first)) {
+			csum = nvme_crc_generic_fn(
+					be16_to_cpu(csum),
+					((u8 *) pi - (ms - pi_sz)),
+					ms - pi_sz);
+		}
+
+		if (pi->guard_tag != csum) {
+			pr_err("%s: guard tag error at sector %llu "
+			       "(rcvd %04x, want %04x)\n", bix->disk_name,
+			       (unsigned long long)bix->seed,
+			       be16_to_cpu(pi->guard_tag), be16_to_cpu(csum));
+			return -EILSEQ;
+		}
+		/*
+		 * ref_tag would have been remapped with virtual sector values
+		 * by nvme_dif_remap(). So match it directly with 'seed'.
+		 */
+		if (be32_to_cpu(pi->ref_tag) !=
+			lower_32_bits(bix->seed)) {
+				pr_err("%s: ref tag error at location %llu "
+				       "(rcvd %u)\n", bix->disk_name,
+				       (unsigned long long)
+				       bix->seed, be32_to_cpu(pi->ref_tag));
+				return -EILSEQ;
+		}
+ next:
+		bix->data_buf += bix->interval;
+		bix->prot_buf += ms;
+		bix->seed++;
+		pi = (struct t10_pi_tuple *) ((char *) pi + ms);
+	}
+	return 0;
+}
+
+/* DEFINE_VERIFIER(ms, pi_type, pi_first) */
+DEFINE_VERIFIER(8, 1, 0);
+DEFINE_VERIFIER(8, 2, 0);
+DEFINE_VERIFIER(8, 3, 0);
+DEFINE_VERIFIER(16, 1, 0);
+DEFINE_VERIFIER(16, 1, 1);
+DEFINE_VERIFIER(16, 2, 0);
+DEFINE_VERIFIER(16, 2, 1);
+DEFINE_VERIFIER(16, 3, 0);
+DEFINE_VERIFIER(16, 3, 1);
+DEFINE_VERIFIER(32, 1, 0);
+DEFINE_VERIFIER(32, 1, 1);
+DEFINE_VERIFIER(32, 2, 0);
+DEFINE_VERIFIER(32, 2, 1);
+DEFINE_VERIFIER(32, 3, 0);
+DEFINE_VERIFIER(32, 3, 1);
+DEFINE_VERIFIER(64, 1, 0);
+DEFINE_VERIFIER(64, 1, 1);
+DEFINE_VERIFIER(64, 2, 0);
+DEFINE_VERIFIER(64, 2, 1);
+DEFINE_VERIFIER(64, 3, 0);
+DEFINE_VERIFIER(64, 3, 1);
+
 static int nvme_noop_verify(struct blk_integrity_iter *iter)
 {
 	return 0;
@@ -1960,22 +2144,130 @@ struct blk_integrity nvme_meta_noop = {
 	.verify_fn		= nvme_noop_verify,
 };
 
+/*
+ * Supports PI within metadata of size 8/16/32/64b formats.
+ * For rest of metadata formats, 'noop' functions are registered.
+ */
 static void nvme_init_integrity(struct nvme_ns *ns)
 {
-	struct blk_integrity integrity;
+	struct blk_integrity integrity = nvme_meta_noop;
 
-	switch (ns->pi_type) {
-	case NVME_NS_DPS_PI_TYPE3:
-		integrity = t10_pi_type3_crc;
+	switch (ns->ms) {
+	case NVME_8B_META:
+		integrity.name = "NVME_META_8B";
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+			integrity.generate_fn = nvme_gen_8_1_0;
+			integrity.verify_fn = nvme_ver_8_1_0;
+			break;
+		case NVME_NS_DPS_PI_TYPE2:
+			integrity.generate_fn = nvme_gen_8_2_0;
+			integrity.verify_fn = nvme_ver_8_2_0;
+			break;
+		case NVME_NS_DPS_PI_TYPE3:
+			integrity.generate_fn = nvme_gen_8_3_0;
+			integrity.verify_fn = nvme_ver_8_3_0;
+			break;
+		}
 		break;
-	case NVME_NS_DPS_PI_TYPE1:
-	case NVME_NS_DPS_PI_TYPE2:
-		integrity = t10_pi_type1_crc;
+	case NVME_16B_META:
+		integrity.name = "NVME_META_16B";
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_16_1_1;
+				integrity.verify_fn = nvme_ver_16_1_1;
+			} else {
+				integrity.generate_fn = nvme_gen_16_1_0;
+				integrity.verify_fn = nvme_ver_16_1_0;
+			}
+			break;
+		case NVME_NS_DPS_PI_TYPE2:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_16_2_1;
+				integrity.verify_fn = nvme_ver_16_2_1;
+			} else {
+				integrity.generate_fn =	nvme_gen_16_2_0;
+				integrity.verify_fn = nvme_ver_16_2_0;
+			}
+			break;
+		case NVME_NS_DPS_PI_TYPE3:
+			if (ns->pi_first) {
+				integrity.generate_fn =	nvme_gen_16_3_1;
+				integrity.verify_fn = nvme_ver_16_3_1;
+			} else {
+				integrity.generate_fn =	nvme_gen_16_3_0;
+				integrity.verify_fn = nvme_ver_16_3_0;
+			}
+			break;
+		}
 		break;
-	default:
-		integrity = nvme_meta_noop;
+	case NVME_32B_META:
+		integrity.name = "NVME_META_32B";
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_32_1_1;
+				integrity.verify_fn = nvme_ver_32_1_1;
+			} else {
+				integrity.generate_fn = nvme_gen_32_1_0;
+				integrity.verify_fn = nvme_ver_32_1_0;
+			}
+			break;
+		case NVME_NS_DPS_PI_TYPE2:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_32_2_1;
+				integrity.verify_fn = nvme_ver_32_2_1;
+			} else {
+				integrity.generate_fn = nvme_gen_32_2_0;
+				integrity.verify_fn = nvme_ver_32_2_0;
+			}
+			break;
+		case NVME_NS_DPS_PI_TYPE3:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_32_3_1;
+				integrity.verify_fn = nvme_ver_32_3_1;
+			} else {
+				integrity.generate_fn = nvme_gen_32_3_0;
+				integrity.verify_fn = nvme_ver_32_3_0;
+			}
+			break;
+		}
+		break;
+	case NVME_64B_META:
+		integrity.name = "NVME_META_64B";
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_64_1_1;
+				integrity.verify_fn = nvme_ver_64_1_1;
+			} else {
+				integrity.generate_fn = nvme_gen_64_1_0;
+				integrity.verify_fn = nvme_ver_64_1_0;
+			}
+			break;
+		case NVME_NS_DPS_PI_TYPE2:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_64_2_1;
+				integrity.verify_fn = nvme_ver_64_2_1;
+			} else {
+				integrity.generate_fn = nvme_gen_64_2_0;
+				integrity.verify_fn = nvme_ver_64_2_0;
+			}
+			break;
+		case NVME_NS_DPS_PI_TYPE3:
+			if (ns->pi_first) {
+				integrity.generate_fn = nvme_gen_64_3_1;
+				integrity.verify_fn = nvme_ver_64_3_1;
+			} else {
+				integrity.generate_fn = nvme_gen_64_3_0;
+				integrity.verify_fn = nvme_ver_64_3_0;
+			}
+			break;
+		}
 		break;
 	}
+
 	integrity.tuple_size = ns->ms;
 	blk_integrity_register(ns->disk, &integrity);
 	blk_queue_max_integrity_segments(ns->queue, 1);
@@ -1987,7 +2279,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_id_ns *id;
 	dma_addr_t dma_addr;
-	int lbaf, pi_type, old_ms;
+	int lbaf, pi_type, old_ms, pi_first;
 	unsigned short bs;
 
 	id = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
@@ -2017,16 +2309,17 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		ns->lba_shift = 9;
 	bs = 1 << ns->lba_shift;
 
-	/* XXX: PI implementation requires metadata equal t10 pi tuple size */
-	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
-					id->dps & NVME_NS_DPS_PI_MASK : 0;
+	pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	pi_first = (id->dps & NVME_NS_DPS_PI_FIRST) >> 3;
 
 	if (disk->integrity && (ns->pi_type != pi_type || ns->ms != old_ms ||
 				bs != queue_logical_block_size(disk->queue) ||
+				ns->pi_first != pi_first ||
 				(ns->ms && id->flbas & NVME_NS_FLBAS_META_EXT)))
 		blk_integrity_unregister(disk);
 
 	ns->pi_type = pi_type;
+	ns->pi_first =  pi_first;
 	blk_queue_logical_block_size(ns->queue, bs);
 
 	if (ns->ms && !disk->integrity && (disk->flags & GENHD_FL_UP) &&
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e1fcea0..05cd302 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -122,6 +122,7 @@ struct nvme_ns {
 	int lba_shift;
 	int ms;
 	int pi_type;
+	int pi_first; /* PI location in metadata. Whether first or last 8b*/
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
@@ -148,6 +149,27 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return (sector >> (ns->lba_shift - 9));
 }
 
+#define NVME_8B_META    8
+#define NVME_16B_META   16
+#define NVME_32B_META   32
+#define NVME_64B_META   64
+
+#define DEFINE_GENERATOR(m, t, f) GENERATOR(m, t, f, _)
+#define DEFINE_VERIFIER(m, t, f)  VERIFIER(m, t, f, _)
+
+#define GENERATOR(m, t, f, u)						      \
+	static int nvme_gen_##m##u##t##u##f(struct blk_integrity_iter *bix)   \
+	{								      \
+		return nvme_generate(bix, nvme_crc_fn, m, t, f);	      \
+	}
+#define VERIFIER(m, t, f, u)						      \
+	static int nvme_ver_##m##u##t##u##f(struct blk_integrity_iter *bix)   \
+	{                                                                     \
+		return nvme_verify(bix, nvme_crc_fn, m, t, f);                \
+	}
+
+typedef __u16 (csum_fn) (void*, unsigned int);
+
 /**
  * nvme_free_iod - frees an nvme_iod
  * @dev: The device that the I/O was submitted to
-- 
1.7.1
