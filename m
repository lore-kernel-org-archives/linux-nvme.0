From: keith.busch@intel.com (Keith Busch)
Date: Tue, 25 Aug 2015 23:32:59 +0000 (UTC)
Subject: [QEMU-NVME][CMB] Added CMBLOC and CMBSZ params to NVMe devices
In-Reply-To: <36F6EBABA23FEF4391AF72944D228901EB2F35D2@BBYEXM02.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D228901EB2F35D2@BBYEXM02.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1508252330020.3969@localhost.lm.intel.com>

On Tue, 25 Aug 2015, Stephen Bates wrote:
> In order to allow for more rigorous testing of the CMB feature in NVMe
> 1.2 we allow for more flexible setting of the CMBLOC and CMBSZ
> registers in NVMe drives. Refer to version 1.2 of the NVM Express
> standard for more information on these registers.
>
> Setting CMBSZ to something other than 0 (the default) will implement a
> CMB as per the other settings in those registers. Note certain invalid
> combinations exist and it is currently a case of buyer beware when you
> choose to implement a CMB.


If we're going to allow arbitrary CMBSZ, then RDS/WDS can be set, but
we need the IO path to accept these. AFAIK, the DMA helpers we're using
right now won't work with CMB based addresses.

I took a quick stab at a patch to bring read/write data CMBs into the
fold. This is compile tested only right now.

---
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2e4ac19..d55c25c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -254,19 +254,26 @@ static hwaddr nvme_discontig(uint64_t *dma_addr, uint16_t page_size,
      return dma_addr[prp_index] + index_in_prp * entry_size;
  }

-static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
-    uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov,
+        uint64_t prp1, uint64_t prp2, uint32_t len, NvmeCtrl *n)
  {
      hwaddr trans_len = n->page_size - (prp1 % n->page_size);
      trans_len = MIN(len, trans_len);
      int num_prps = (len >> n->page_bits) + 1;
+    bool cmb = false;

      if (!prp1) {
          return NVME_INVALID_FIELD | NVME_DNR;
+    } else if (n->cmb && prp1 >= n->ctrl_mem.addr &&
+                prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
+        cmb = true;
+        qsg->nsg = 0;
+        qemu_iovec_init(iov, num_prps);
+        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
+    } else {
+        pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
+        qemu_sglist_add(qsg, prp1, trans_len);
      }
-
-    pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
-    qemu_sglist_add(qsg, prp1, trans_len);
      len -= trans_len;
      if (len) {
          if (!prp2) {
@@ -301,7 +308,11 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
                  }

                  trans_len = MIN(len, n->page_size);
-                qemu_sglist_add(qsg, prp_ent, trans_len);
+                if (!cmb) {
+                    qemu_sglist_add(qsg, prp_ent, trans_len);
+                } else {
+                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
+                }
                  len -= trans_len;
                  i++;
              }
@@ -309,13 +320,21 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, uint64_t prp1, uint64_t prp2,
              if (prp2 & (n->page_size - 1)) {
                  goto unmap;
              }
-            qemu_sglist_add(qsg, prp2, len);
+            if (!cmb) {
+                qemu_sglist_add(qsg, prp2, len);
+            } else {
+                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
+            }
          }
      }
      return NVME_SUCCESS;

   unmap:
-    qemu_sglist_destroy(qsg);
+    if (!cmb) {
+        qemu_sglist_destroy(qsg);
+    } else {
+        qemu_iovec_destroy(iov);
+    }
      return NVME_INVALID_FIELD | NVME_DNR;
  }

@@ -323,31 +342,48 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
      uint64_t prp1, uint64_t prp2)
  {
      QEMUSGList qsg;
+    QEMUIOVector iov;
+    uint16_t status = NVME_SUCCESS;

-    if (nvme_map_prp(&qsg, prp1, prp2, len, n)) {
+    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
          return NVME_INVALID_FIELD | NVME_DNR;
      }
-    if (dma_buf_write(ptr, len, &qsg)) {
+    if (qsg.nsg > 0) {
+        if (dma_buf_write(ptr, len, &qsg)) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
          qemu_sglist_destroy(&qsg);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    } else {
+        if (qemu_iovec_from_buf(&iov, 0, ptr, len) != len) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_iovec_destroy(&iov);
      }
-    qemu_sglist_destroy(&qsg);
-    return NVME_SUCCESS;
+    return status;
  }

  static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
      uint64_t prp1, uint64_t prp2)
  {
      QEMUSGList qsg;
+    QEMUIOVector iov;
+    uint16_t status = NVME_SUCCESS;

-    if (nvme_map_prp(&qsg, prp1, prp2, len, n)) {
+    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
          return NVME_INVALID_FIELD | NVME_DNR;
      }
-    if (dma_buf_read(ptr, len, &qsg)) {
+    if (qsg.nsg > 0) {
+        if (dma_buf_read(ptr, len, &qsg)) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
          qemu_sglist_destroy(&qsg);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    } else {
+        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
+            status = NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_iovec_destroy(&iov);
      }
-    return NVME_SUCCESS;
+    return status;
  }

  static void nvme_post_cqe(NvmeCQueue *cq, NvmeRequest *req)
@@ -508,7 +544,11 @@ static void nvme_rw_cb(void *opaque, int ret)
          }
      }

-    qemu_sglist_destroy(&req->qsg);
+    if (req->qsg.nsg) {
+        qemu_sglist_destroy(&req->qsg);
+    } else {
+        qemu_iovec_destroy(&req->iov);
+    }
      nvme_enqueue_req_completion(cq, req);
  }

@@ -558,7 +598,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
          return NVME_UNRECOVERED_READ;
      }

-    if (nvme_map_prp(&req->qsg, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
          nvme_set_error_page(n, req->sq->sqid, cmd->cid, NVME_INVALID_FIELD,
              offsetof(NvmeRwCmd, prp1), 0, ns->id);
          return NVME_INVALID_FIELD | NVME_DNR;
@@ -570,10 +610,16 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
      req->ns = ns;

      dma_acct_start(n->conf.blk, &req->acct, &req->qsg, req->is_write ?
-        BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
-    req->aiocb = req->is_write ?
-        dma_blk_write(n->conf.blk, &req->qsg, aio_slba, nvme_rw_cb, req) :
-        dma_blk_read(n->conf.blk, &req->qsg, aio_slba, nvme_rw_cb, req);
+            BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
+    if (req->qsg.nsg > 0) {
+        req->aiocb = req->is_write ?
+            dma_blk_write(n->conf.blk, &req->qsg, aio_slba, nvme_rw_cb, req) :
+            dma_blk_read(n->conf.blk, &req->qsg, aio_slba, nvme_rw_cb, req);
+    } else {
+        req->aiocb = req->is_write ?
+            blk_aio_writev(n->conf.blk, aio_slba, &req->iov, data_size >> 9, nvme_rw_cb, req) :
+            blk_aio_readv(n->conf.blk, aio_slba, &req->iov, data_size >> 9, nvme_rw_cb, req);
+    }

      return NVME_NO_COMPLETE;
  }
@@ -662,7 +708,7 @@ static uint16_t nvme_compare(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
              offsetof(NvmeRwCmd, nlb), nlb, ns->id);
          return NVME_INVALID_FIELD | NVME_DNR;
      }
-    if (nvme_map_prp(&req->qsg, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
          nvme_set_error_page(n, req->sq->sqid, cmd->cid, NVME_INVALID_FIELD,
              offsetof(NvmeRwCmd, prp1), 0, ns->id);
          return NVME_INVALID_FIELD | NVME_DNR;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 3c0fda9..9d3070d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -716,6 +716,7 @@ typedef struct NvmeRequest {
      NvmeCqe                 cqe;
      BlockAcctCookie         acct;
      QEMUSGList              qsg;
+    QEMUIOVector            iov;
      QTAILQ_ENTRY(NvmeRequest)entry;
  } NvmeRequest;

--
