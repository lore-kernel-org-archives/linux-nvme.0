From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Fri, 19 Jan 2018 04:37:42 -0800
Subject: [PATCH 6/6] mpt3sas: Introduce function to clone mpi reply.
In-Reply-To: <1516365462-14708-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1516365462-14708-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1516365462-14708-7-git-send-email-suganath-prabu.subramani@broadcom.com>

If the posted request has an error of any type, the IOC writes
a Reply message into a host-based system reply message frame.
This functions clone it in the BAR0 mapped region.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 0248058..fa13916 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -126,6 +126,32 @@ module_param_call(mpt3sas_fwfault_debug, _scsih_set_fwfault_debug,
 	param_get_int, &mpt3sas_fwfault_debug, 0644);
 
 /**
+ * _base_clone_reply_to_sys_mem - copies reply to reply free iomem
+ *				  in BAR0 space.
+ *
+ * @ioc: per adapter object
+ * @reply: reply message frame(lower 32bit addr)
+ * @index: System request message index.
+ *
+ * @Returns - Nothing
+ */
+static void
+_base_clone_reply_to_sys_mem(struct MPT3SAS_ADAPTER *ioc, U32 reply,
+		u32 index)
+{
+	/*
+	 * 256 is offset within sys register.
+	 * 256 offset MPI frame starts. Max MPI frame supported is 32.
+	 * 32 * 128 = 4K. From here, Clone of reply free for mcpu starts
+	 */
+	u16 cmd_credit = ioc->facts.RequestCredit + 1;
+	void *reply_free_iomem = (void *)ioc->chip + MPI_FRAME_START_OFFSET +
+		(cmd_credit * ioc->request_sz) + (index * sizeof(u32));
+
+	writel(cpu_to_le32(reply), reply_free_iomem);
+}
+
+/**
  * _base_clone_mpi_to_sys_mem - Writes/copies MPI frames
  *				to system/BAR0 region.
  *
@@ -1396,6 +1422,9 @@ _base_interrupt(int irq, void *bus_id)
 				    0 : ioc->reply_free_host_index + 1;
 				ioc->reply_free[ioc->reply_free_host_index] =
 				    cpu_to_le32(reply);
+				if (ioc->is_mcpu_endpoint)
+					_base_clone_reply_to_sys_mem(ioc, reply,
+						ioc->reply_free_host_index);
 				writel(ioc->reply_free_host_index,
 				    &ioc->chip->ReplyFreeHostIndex);
 			}
@@ -6244,8 +6273,11 @@ _base_make_ioc_operational(struct MPT3SAS_ADAPTER *ioc)
 	/* initialize Reply Free Queue */
 	for (i = 0, reply_address = (u32)ioc->reply_dma ;
 	    i < ioc->reply_free_queue_depth ; i++, reply_address +=
-	    ioc->reply_sz)
+	    ioc->reply_sz) {
 		ioc->reply_free[i] = cpu_to_le32(reply_address);
+		if (ioc->is_mcpu_endpoint)
+			_base_clone_reply_to_sys_mem(ioc, reply_address, i);
+	}
 
 	/* initialize reply queues */
 	if (ioc->is_driver_loading)
-- 
2.5.5
