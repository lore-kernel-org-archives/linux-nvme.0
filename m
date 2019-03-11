From: kbusch@kernel.org (Keith Busch)
Date: Mon, 11 Mar 2019 08:54:59 -0600
Subject: NVMe: Regression: write zeros corrupts ext4 file system
In-Reply-To: <20190311022441.GA16849@ming.t460p>
References: <20190311022441.GA16849@ming.t460p>
Message-ID: <20190311145457.GA10411@localhost.localdomain>

On Mon, Mar 11, 2019@10:24:42AM +0800, Ming Lei wrote:
> Hi,
> 
> It is observed that ext4 is corrupted easily by running some workloads
> on QEMU NVMe, such as:
> 
> 1) mkfs.ext4 /dev/nvme0n1
> 
> 2) mount /dev/nvme0n1 /mnt
> 
> 3) cd /mnt; git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 4) then the following error message may show up:
> 
> [ 1642.271816] EXT4-fs error (device nvme0n1): ext4_mb_generate_buddy:747: group 0, block bitmap and bg descriptor inconsistent: 32768 vs 23513 free clusters
> 
> Or fsck.ext4 will complain after running 'umount /mnt'
> 
> The issue disappears by reverting 6e02318eaea53eaafe6 ("nvme: add support for the
> Write Zeroes command").
> 
> QEMU version:
> 
> QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

In QEMU, blk_aio_pwrite_zeroes() takes bytes, but the nvme controller
thought it was blocks. Oops, that went by unnoticed till now!

We should fix QEMU (patch below). Question is, should we quirk driver 
for older versions too?

---
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7c8c63e8f5..e8fe8f1ddd 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -324,8 +324,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
-    uint64_t aio_slba = slba << (data_shift - BDRV_SECTOR_BITS);
-    uint32_t aio_nlb = nlb << (data_shift - BDRV_SECTOR_BITS);
+    uint64_t offset = slba << data_shift;
+    uint32_t count = nlb << data_shift;
 
     if (unlikely(slba + nlb > ns->id_ns.nsze)) {
         trace_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
@@ -335,7 +335,7 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     req->has_sg = false;
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
                      BLOCK_ACCT_WRITE);
-    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, aio_slba, aio_nlb,
+    req->aiocb = blk_aio_pwrite_zeroes(n->conf.blk, offset, count,
                                         BDRV_REQ_MAY_UNMAP, nvme_rw_cb, req);
     return NVME_NO_COMPLETE;
 }
--
