From: rlnelson@google.com (Rob Nelson)
Date: Tue, 22 Jul 2014 10:15:14 -0700
Subject: NVMe Vendor Extension for Improved Virtualization
Message-ID: <CALu-fzs0aiN1mDMN29Fmt0MhrCRJALibUQ3dNYbg10+eZ+wW2Q@mail.gmail.com>

First off apologies for anything details that I'm missing here (really
my first foray into the open source world). Please let me know if I'm
missing something or need to reword.

This patch provides a mechanism to reduce the number of MMIO doorbell
writes for the NVMe driver. When running in a virtualized environment
like QEMU, the cost of an MMIO is quite hefy here. The main idea for
the patch is provide the device two memory location locations: 1) to
store the doorbell values so they can be lookup without the doorbell
MMIO write 2) to store an event index.
I believe the doorbell value is obvious, the event index not so much.
Similar to the Virtio specificaiton, the device (virtual device) can
tell the driver not to write MMIO unless you are writing past this
value.
FYI: doorbell values are written by the nvme driver (guest OS) and the
event index is written by the virtual device (host OS).

The patch implements a new admin command that will communicate where
these two memory locations reside. If the command fails, the nvme
driver will work as before without any optimizations.

Just to give an idea on the performance boost with the vendor
extension: Running fio [1], a stock NVMe driver I get about 200K read
IOPs with my vendor patch I get about 1000K read IOPs. This was
running with a null device i.e. the backing device simply returned
success on every read IO request.

[1] Running on a 4 core machine:
  fio --time_based --name=benchmark --runtime=30
--filename=/dev/nvme0n1 --nrfiles=1 --ioengine=libaio --iodepth=32
--direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs=4
--rw=randread --blocksize=4k --randrepeat=0

I have a public git repo here that contains the patch (I believe my
linux base line is 3.14.1 right now, so I'll need to fix that up but
I'd like to get comments now):
  https://github.com/rlnelson-git/linux-nvme

Contributions in this patch from:
 Eric Northup digitaleric at google.com
 Frank Swiderski fes at google.com
 Ted Tso tytso at google.com

----
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 51824d1..b2d3b45 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -48,6 +48,9 @@
 #define CQ_SIZE(depth)         (depth * sizeof(struct nvme_completion))
 #define ADMIN_TIMEOUT  (60 * HZ)

+/* Google Vendor ID is not in include/linux/pci_ids.h */
+#define PCI_VENDOR_ID_GOOGLE 0x1AE0
+
 static int nvme_major;
 module_param(nvme_major, int, 0);

@@ -95,6 +98,10 @@ struct nvme_queue {
        u8 cq_phase;
        u8 cqe_seen;
        u8 q_suspended;
+       u32* sq_doorbell_addr;
+       u32* sq_eventidx_addr;
+       u32* cq_doorbell_addr;
+       u32* cq_eventidx_addr;
        struct async_cmd_info cmdinfo;
        unsigned long cmdid_data[];
 };
@@ -116,6 +123,7 @@ static inline void _nvme_check_size(void)
        BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
        BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
        BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+       BUILD_BUG_ON(sizeof(struct nvme_doorbell_memory) != 64);
 }

 typedef void (*nvme_completion_fn)(struct nvme_dev *, void *,
@@ -272,6 +280,30 @@ void put_nvmeq(struct nvme_queue *nvmeq)
        put_cpu();
 }

+static inline int nvme_need_event(u16 event_idx, u16 new_idx, u16 old) {
+       /* Borrowed from vring_need_event */
+       return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
+}
+
+static void write_doorbell(u16 value, u32 __iomem* q_db,
+                          u32* db_addr, volatile u32* event_idx) {
+       u16 old_value;
+       if (!db_addr)
+               goto ring_doorbell;
+
+       old_value = *db_addr;
+       *db_addr = value;
+
+       rmb();
+       if (!nvme_need_event(*event_idx, value, old_value))
+               goto no_doorbell;
+
+ring_doorbell:
+       writel(value, q_db);
+no_doorbell:
+       return;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -286,9 +318,12 @@ static int nvme_submit_cmd(struct nvme_queue
*nvmeq, struct nvme_command *cmd)
        spin_lock_irqsave(&nvmeq->q_lock, flags);
        tail = nvmeq->sq_tail;
        memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+       if (nvmeq->sq_doorbell_addr)
+               wmb();
        if (++tail == nvmeq->q_depth)
                tail = 0;
-       writel(tail, nvmeq->q_db);
+       write_doorbell(tail, nvmeq->q_db,
+                      nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
        nvmeq->sq_tail = tail;
        spin_unlock_irqrestore(&nvmeq->q_lock, flags);
@@ -566,11 +601,13 @@ static int nvme_submit_discard(struct nvme_queue
*nvmeq, struct nvme_ns *ns,
        cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
        cmnd->dsm.nr = 0;
        cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+       if (nvmeq->sq_doorbell_addr)
+               wmb();

        if (++nvmeq->sq_tail == nvmeq->q_depth)
                nvmeq->sq_tail = 0;
-       writel(nvmeq->sq_tail, nvmeq->q_db);
-
+       write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+                      nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
        return 0;
 }

@@ -583,10 +620,13 @@ static int nvme_submit_flush(struct nvme_queue
*nvmeq, struct nvme_ns *ns,
        cmnd->common.opcode = nvme_cmd_flush;
        cmnd->common.command_id = cmdid;
        cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+       if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+               wmb();

        if (++nvmeq->sq_tail == nvmeq->q_depth)
                nvmeq->sq_tail = 0;
-       writel(nvmeq->sq_tail, nvmeq->q_db);
+       write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+                      nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);

        return 0;
 }
@@ -675,11 +715,14 @@ static int nvme_submit_bio_queue(struct
nvme_queue *nvmeq, struct nvme_ns *ns,
        cmnd->rw.length = cpu_to_le16((length >> ns->lba_shift) - 1);
        cmnd->rw.control = cpu_to_le16(control);
        cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+       if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+               wmb();

        nvme_start_io_acct(bio);
        if (++nvmeq->sq_tail == nvmeq->q_depth)
                nvmeq->sq_tail = 0;
-       writel(nvmeq->sq_tail, nvmeq->q_db);
+       write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+                      nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);

        return 0;

@@ -701,6 +744,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
        for (;;) {
                void *ctx;
                nvme_completion_fn fn;
+               if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+                       rmb();
                struct nvme_completion cqe = nvmeq->cqes[head];
                if ((le16_to_cpu(cqe.status) & 1) != phase)
                        break;
@@ -723,7 +768,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
        if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
                return 0;

-       writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+       write_doorbell(head, nvmeq->q_db + nvmeq->dev->db_stride,
+                      nvmeq->cq_doorbell_addr, nvmeq->cq_eventidx_addr);
        nvmeq->cq_head = head;
        nvmeq->cq_phase = phase;

@@ -943,6 +989,17 @@ int nvme_identify(struct nvme_dev *dev, unsigned
nsid, unsigned cns,
        return nvme_submit_admin_cmd(dev, &c, NULL);
 }

+int nvme_doorbell_memory(struct nvme_dev *dev) {
+       struct nvme_command c;
+
+       memset(&c, 0, sizeof(c));
+       c.doorbell_memory.opcode = nvme_admin_doorbell_memory;
+       c.doorbell_memory.prp1 = cpu_to_le64(dev->doorbell);
+       c.doorbell_memory.prp2 = cpu_to_le64(dev->eventidx);
+
+       return nvme_submit_admin_cmd(dev, &c, NULL);
+}
+
 int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
                                        dma_addr_t dma_addr, u32 *result)
 {
@@ -1167,6 +1224,14 @@ static struct nvme_queue
*nvme_alloc_queue(struct nvme_dev *dev, int qid,
        nvmeq->cq_vector = vector;
        nvmeq->qid = qid;
        nvmeq->q_suspended = 1;
+       if (dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE && qid != 0) {
+               nvmeq->sq_doorbell_addr = &dev->db_mem[qid * 2 *
dev->db_stride];
+               nvmeq->cq_doorbell_addr =
+                       &dev->db_mem[(qid * 2 + 1) * dev->db_stride];
+               nvmeq->sq_eventidx_addr = &dev->ei_mem[qid * 2 *
dev->db_stride];
+               nvmeq->cq_eventidx_addr =
+                       &dev->ei_mem[(qid * 2 + 1) * dev->db_stride];
+       }
        dev->queue_count++;

        return nvmeq;
@@ -1199,6 +1264,14 @@ static void nvme_init_queue(struct nvme_queue
*nvmeq, u16 qid)
        nvmeq->cq_head = 0;
        nvmeq->cq_phase = 1;
        nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+       if (dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE && qid != 0) {
+               nvmeq->sq_doorbell_addr = &dev->db_mem[qid * 2 *
dev->db_stride];
+               nvmeq->cq_doorbell_addr =
+                       &dev->db_mem[(qid * 2 + 1) * dev->db_stride];
+               nvmeq->sq_eventidx_addr = &dev->ei_mem[qid * 2 *
dev->db_stride];
+               nvmeq->cq_eventidx_addr =
+                       &dev->ei_mem[(qid * 2 + 1) * dev->db_stride];
+       }
        memset(nvmeq->cmdid_data, 0, extra);
        memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
        nvme_cancel_ios(nvmeq, false);
@@ -1959,6 +2032,15 @@ static int nvme_dev_add(struct nvme_dev *dev)
                goto out;
        }

+       if (pdev->vendor == PCI_VENDOR_ID_GOOGLE) {
+               res = nvme_doorbell_memory(dev);
+               if (res) {
+                       // Free memory and continue on.
+                       dma_free_coherent(&pdev->dev, 8192,
dev->db_mem, dev->doorbell);
+                       dma_free_coherent(&pdev->dev, 8192,
dev->ei_mem, dev->doorbell);
+               }
+       }
+
        ctrl = mem;
        nn = le32_to_cpup(&ctrl->nn);
        dev->oncs = le16_to_cpup(&ctrl->oncs);
@@ -1985,7 +2067,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
                                                        dma_addr + 4096, NULL);
                if (res)
                        memset(mem + 4096, 0, 4096);
-
                ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
                if (ns)
                        list_add_tail(&ns->list, &dev->namespaces);
@@ -1999,6 +2080,10 @@ static int nvme_dev_add(struct nvme_dev *dev)
        return res;
 }

+static int nvme_vendor_memory_size(struct nvme_dev *dev) {
+       return ((num_online_cpus() + 1) * 8 * dev->db_stride);
+}
+
 static int nvme_dev_map(struct nvme_dev *dev)
 {
        int bars, result = -ENOMEM;
@@ -2027,8 +2112,24 @@ static int nvme_dev_map(struct nvme_dev *dev)
        dev->db_stride = 1 << NVME_CAP_STRIDE(readq(&dev->bar->cap));
        dev->dbs = ((void __iomem *)dev->bar) + 4096;

+       if (pdev->vendor == PCI_VENDOR_ID_GOOGLE) {
+               int mem_size = nvme_vendor_memory_size(dev);
+               dev->db_mem = dma_alloc_coherent(&pdev->dev, mem_size,
&dev->doorbell, GFP_KERNEL);
+               if (!dev->db_mem) {
+                       result = -ENOMEM;
+                       goto unmap;
+               }
+               dev->ei_mem = dma_alloc_coherent(&pdev->dev, mem_size,
&dev->eventidx, GFP_KERNEL);
+               if (!dev->ei_mem) {
+                       result = -ENOMEM;
+                       goto dma_free;
+               }
+       }
+
        return 0;

+ dma_free:
+       dma_free_coherent(&pdev->dev, nvme_vendor_memory_size(dev),
dev->db_mem, dev->doorbell);
  unmap:
        iounmap(dev->bar);
        dev->bar = NULL;
@@ -2041,6 +2142,11 @@ static int nvme_dev_map(struct nvme_dev *dev)

 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
+       int mem_size = nvme_vendor_memory_size(dev);
+       if (!dev->db_mem)
+               dma_free_coherent(&dev->pci_dev->dev, mem_size,
dev->db_mem, dev->doorbell);
+       if (!dev->ei_mem)
+               dma_free_coherent(&dev->pci_dev->dev, mem_size,
dev->ei_mem, dev->eventidx);
        if (dev->pci_dev->msi_enabled)
                pci_disable_msi(dev->pci_dev);
        else if (dev->pci_dev->msix_enabled)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 69ae03f..3d7a085 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -97,6 +97,10 @@ struct nvme_dev {
        u16 oncs;
        u16 abort_limit;
        u8 initialized;
+       u32* db_mem;
+       dma_addr_t doorbell;
+       u32* ei_mem;
+       dma_addr_t eventidx;
 };

 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index e5ab622..879cc41 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -261,6 +261,7 @@ enum nvme_admin_opcode {
        nvme_admin_format_nvm           = 0x80,
        nvme_admin_security_send        = 0x81,
        nvme_admin_security_recv        = 0x82,
+        nvme_admin_doorbell_memory      = 0xC0,
 };

 enum {
@@ -382,6 +383,16 @@ struct nvme_format_cmd {
        __u32                   rsvd11[5];
 };

+struct nvme_doorbell_memory {
+       __u8                    opcode;
+       __u8                    flags;
+       __u16                   command_id;
+       __u32                   rsvd1[5];
+       __le64                  prp1;
+       __le64                  prp2;
+       __u32                   rsvd12[6];
+};
+
 struct nvme_command {
        union {
                struct nvme_common_command common;
@@ -395,6 +406,7 @@ struct nvme_command {
                struct nvme_format_cmd format;
                struct nvme_dsm_cmd dsm;
                struct nvme_abort_cmd abort;
+               struct nvme_doorbell_memory doorbell_memory;
        };
 };

@@ -427,6 +439,7 @@ enum {
        NVME_SC_INVALID_LOG_PAGE        = 0x109,
        NVME_SC_INVALID_FORMAT          = 0x10a,
        NVME_SC_BAD_ATTRIBUTES          = 0x180,
+        NVME_SC_DOORBELL_MEMORY_INVALID = 0x1C0,
        NVME_SC_WRITE_FAULT             = 0x280,
        NVME_SC_READ_ERROR              = 0x281,
        NVME_SC_GUARD_CHECK             = 0x282,

-- 
cheers, Rob
