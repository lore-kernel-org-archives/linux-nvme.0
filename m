From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Fri, 19 Jan 2018 04:37:39 -0800
Subject: [PATCH 3/6] mpt3sas: Introduce API's to get BAR0 mapped buffer
 address.
In-Reply-To: <1516365462-14708-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1516365462-14708-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1516365462-14708-4-git-send-email-suganath-prabu.subramani@broadcom.com>

For MPI Endpoint/Mcpu, Driver should double buffer data buffer/sgl's.
 This is normally copied from host to internal memory of IOC by
 DMA engine of PCI Device. Since the interface to DMA from host
 to mCPU is not present for Mcpu/MPI Endpoint device,
 Driver does double copy of those buffer directly to the mCPU
 memory region via BAR-0 region.

 Introduced API's to calculate and return BAR0 mapped
 host buffer's physical and virtual address for the provided smid.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 93 +++++++++++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index c0a1c0f..dc289c0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -126,6 +126,99 @@ module_param_call(mpt3sas_fwfault_debug, _scsih_set_fwfault_debug,
 	param_get_int, &mpt3sas_fwfault_debug, 0644);
 
 /**
+ * _base_get_chain - Calculates and Returns virtual chain address
+ *			 for the provided smid in BAR0 space.
+ *
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @sge_chain_count: Scatter gather chain count.
+ *
+ * @Return: chain address.
+ */
+static inline void *
+_base_get_chain(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+		u8 sge_chain_count)
+{
+	void *base_chain, *chain_virt;
+	u16 cmd_credit = ioc->facts.RequestCredit + 1;
+
+	base_chain  = (void *)ioc->chip + MPI_FRAME_START_OFFSET +
+		(cmd_credit * ioc->request_sz) +
+		REPLY_FREE_POOL_SIZE;
+	chain_virt = base_chain + (smid * ioc->facts.MaxChainDepth *
+			ioc->request_sz) + (sge_chain_count * ioc->request_sz);
+	return chain_virt;
+}
+
+/**
+ * _base_get_chain_phys - Calculates and Returns physical address
+ *			in BAR0 for scatter gather chains, for
+ *			the provided smid.
+ *
+ * @ioc: per adapter object
+ * @smid: system request message index
+ * @sge_chain_count: Scatter gather chain count.
+ *
+ * @Return - Physical chain address.
+ */
+static inline void *
+_base_get_chain_phys(struct MPT3SAS_ADAPTER *ioc, u16 smid,
+		u8 sge_chain_count)
+{
+	void *base_chain_phys, *chain_phys;
+	u16 cmd_credit = ioc->facts.RequestCredit + 1;
+
+	base_chain_phys  = (void *)ioc->chip_phys + MPI_FRAME_START_OFFSET +
+		(cmd_credit * ioc->request_sz) +
+		REPLY_FREE_POOL_SIZE;
+	chain_phys = base_chain_phys + (smid * ioc->facts.MaxChainDepth *
+			ioc->request_sz) + (sge_chain_count * ioc->request_sz);
+	return chain_phys;
+}
+
+/**
+ * _base_get_buffer_bar0 - Calculates and Returns BAR0 mapped Host
+ *			buffer address for the provided smid.
+ *			(Each smid can have 64K starts from 17024)
+ *
+ * @ioc: per adapter object
+ * @smid: system request message index
+ *
+ * @Returns - Pointer to buffer location in BAR0.
+ */
+
+static void *
+_base_get_buffer_bar0(struct MPT3SAS_ADAPTER *ioc, u16 smid)
+{
+	u16 cmd_credit = ioc->facts.RequestCredit + 1;
+	// Added extra 1 to reach end of chain.
+	void *chain_end = _base_get_chain(ioc,
+			cmd_credit + 1,
+			ioc->facts.MaxChainDepth);
+	return chain_end + (smid * 64 * 1024);
+}
+
+/**
+ * _base_get_buffer_phys_bar0 - Calculates and Returns BAR0 mapped
+ *		Host buffer Physical address for the provided smid.
+ *		(Each smid can have 64K starts from 17024)
+ *
+ * @ioc: per adapter object
+ * @smid: system request message index
+ *
+ * @Returns - Pointer to buffer location in BAR0.
+ */
+static void *
+_base_get_buffer_phys_bar0(struct MPT3SAS_ADAPTER *ioc, u16 smid)
+{
+	u16 cmd_credit = ioc->facts.RequestCredit + 1;
+	void *chain_end_phys = _base_get_chain_phys(ioc,
+			cmd_credit + 1,
+			ioc->facts.MaxChainDepth);
+	return chain_end_phys + (smid * 64 * 1024);
+}
+
+/**
  *  mpt3sas_remove_dead_ioc_func - kthread context to remove dead ioc
  * @arg: input argument, used to derive ioc
  *
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 897394d..2529d25 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -120,6 +120,8 @@
 #define MPT3SAS_NVME_QUEUE_DEPTH	128
 #define MPT_NAME_LENGTH			32	/* generic length of strings */
 #define MPT_STRING_LENGTH		64
+#define MPI_FRAME_START_OFFSET		256
+#define REPLY_FREE_POOL_SIZE		512 /*(32 maxcredix *4)*(4 times)*/
 
 #define MPT_MAX_CALLBACKS		32
 
-- 
2.5.5
