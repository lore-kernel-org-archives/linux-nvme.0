From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Sat,  2 Dec 2017 02:19:26 -0800
Subject: [PATCH] mpt3sas: Remove unused variable requeue_event
Message-ID: <1512209966-27239-1-git-send-email-suganath-prabu.subramani@broadcom.com>

No Functional change just cleanup,
Removed variable requeue_event and made function as void.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 362f406..c71f964 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -7211,7 +7211,7 @@ _scsih_pcie_topology_change_event_debug(struct MPT3SAS_ADAPTER *ioc,
  * Context: user.
  *
  */
-static int
+static void
 _scsih_pcie_topology_change_event(struct MPT3SAS_ADAPTER *ioc,
 	struct fw_event_work *fw_event)
 {
@@ -7221,7 +7221,6 @@ _scsih_pcie_topology_change_event(struct MPT3SAS_ADAPTER *ioc,
 	u8 link_rate, prev_link_rate;
 	unsigned long flags;
 	int rc;
-	int requeue_event;
 	Mpi26EventDataPCIeTopologyChangeList_t *event_data =
 		(Mpi26EventDataPCIeTopologyChangeList_t *) fw_event->event_data;
 	struct _pcie_device *pcie_device;
@@ -7231,12 +7230,12 @@ _scsih_pcie_topology_change_event(struct MPT3SAS_ADAPTER *ioc,
 
 	if (ioc->shost_recovery || ioc->remove_host ||
 		ioc->pci_error_recovery)
-		return 0;
+		return;
 
 	if (fw_event->ignore) {
 		dewtprintk(ioc, pr_info(MPT3SAS_FMT "ignoring switch event\n",
 			ioc->name));
-		return 0;
+		return;
 	}
 
 	/* handle siblings events */
@@ -7244,10 +7243,10 @@ _scsih_pcie_topology_change_event(struct MPT3SAS_ADAPTER *ioc,
 		if (fw_event->ignore) {
 			dewtprintk(ioc, pr_info(MPT3SAS_FMT
 				"ignoring switch event\n", ioc->name));
-			return 0;
+			return;
 		}
 		if (ioc->remove_host || ioc->pci_error_recovery)
-			return 0;
+			return;
 		reason_code = event_data->PortEntry[i].PortStatus;
 		handle =
 			le16_to_cpu(event_data->PortEntry[i].AttachedDevHandle);
@@ -7316,7 +7315,6 @@ _scsih_pcie_topology_change_event(struct MPT3SAS_ADAPTER *ioc,
 			break;
 		}
 	}
-	return requeue_event;
 }
 
 /**
-- 
2.5.5
