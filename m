From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Fri, 19 Jan 2018 04:37:37 -0800
Subject: [PATCH 1/6] mpt3sas: Add PCI device ID for Andromeda.
In-Reply-To: <1516365462-14708-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1516365462-14708-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1516365462-14708-2-git-send-email-suganath-prabu.subramani@broadcom.com>

Add device ID and flag for Andromeda/MPI Emdpont.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h |  1 +
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 ++++++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index ee11710..0ad88de 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -524,6 +524,7 @@ typedef struct _MPI2_CONFIG_REPLY {
 #define MPI2_MFGPAGE_DEVID_SAS2308_1                (0x0086)
 #define MPI2_MFGPAGE_DEVID_SAS2308_2                (0x0087)
 #define MPI2_MFGPAGE_DEVID_SAS2308_3                (0x006E)
+#define MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP           (0x02B0)
 
 /*MPI v2.5 SAS products */
 #define MPI25_MFGPAGE_DEVID_SAS3004                 (0x0096)
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 789bc42..897394d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1336,6 +1336,7 @@ struct MPT3SAS_ADAPTER {
 	u32		ring_buffer_offset;
 	u32		ring_buffer_sz;
 	u8		is_warpdrive;
+	u8		is_mcpu_endpoint;
 	u8		hide_ir_msg;
 	u8		mfg_pg10_hide_flag;
 	u8		hide_drives;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 74fca18..bde3c6f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10335,6 +10335,7 @@ _scsih_determine_hba_mpi_version(struct pci_dev *pdev)
 	case MPI2_MFGPAGE_DEVID_SAS2308_1:
 	case MPI2_MFGPAGE_DEVID_SAS2308_2:
 	case MPI2_MFGPAGE_DEVID_SAS2308_3:
+	case MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP:
 		return MPI2_VERSION;
 	case MPI25_MFGPAGE_DEVID_SAS3004:
 	case MPI25_MFGPAGE_DEVID_SAS3008:
@@ -10412,11 +10413,18 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ioc->hba_mpi_version_belonged = hba_mpi_version;
 		ioc->id = mpt2_ids++;
 		sprintf(ioc->driver_name, "%s", MPT2SAS_DRIVER_NAME);
-		if (pdev->device == MPI2_MFGPAGE_DEVID_SSS6200) {
+		switch (pdev->device) {
+		case MPI2_MFGPAGE_DEVID_SSS6200:
 			ioc->is_warpdrive = 1;
 			ioc->hide_ir_msg = 1;
-		} else
+			break;
+		case MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP:
+			ioc->is_mcpu_endpoint = 1;
+			break;
+		default:
 			ioc->mfg_pg10_hide_flag = MFG_PAGE10_EXPOSE_ALL_DISKS;
+			break;
+		}
 		break;
 	case MPI25_VERSION:
 	case MPI26_VERSION:
@@ -10845,6 +10853,8 @@ static const struct pci_device_id mpt3sas_pci_table[] = {
 		PCI_ANY_ID, PCI_ANY_ID },
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_3,
 		PCI_ANY_ID, PCI_ANY_ID },
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP,
+		PCI_ANY_ID, PCI_ANY_ID },
 	/* SSS6200 */
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SSS6200,
 		PCI_ANY_ID, PCI_ANY_ID },
-- 
2.5.5
