From: saurav.kashyap@qlogic.com (Saurav Kashyap)
Date: Thu, 3 Oct 2013 17:42:33 +0000
Subject: [PATCH RFC 59/77] qla2xxx: Update MSI/MSI-X interrupts
 enablement code
In-Reply-To: <54f6b89372f51cd27a6adf6ecc91b8bf6bb5ba74.1380703263.git.agordeev@redhat.com>
Message-ID: <F5D084D6342F9B479C34599BB0A03E4D8982E209@AVMB1.qlogic.org>

Acked-by: Saurav Kashyap <saurav.kashyap at qlogic.com>


>As result of recent re-design of the MSI/MSI-X interrupts enabling
>pattern this driver has to be updated to use the new technique to
>obtain a optimal number of MSI/MSI-X interrupts required.
>
>Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
>---
> drivers/scsi/qla2xxx/qla_isr.c |   18 +++++++++++-------
> 1 files changed, 11 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/scsi/qla2xxx/qla_isr.c
>b/drivers/scsi/qla2xxx/qla_isr.c
>index df1b30b..6c11ab9 100644
>--- a/drivers/scsi/qla2xxx/qla_isr.c
>+++ b/drivers/scsi/qla2xxx/qla_isr.c
>@@ -2836,16 +2836,20 @@ qla24xx_enable_msix(struct qla_hw_data *ha,
>struct rsp_que *rsp)
> 	for (i = 0; i < ha->msix_count; i++)
> 		entries[i].entry = i;
> 
>-	ret = pci_enable_msix(ha->pdev, entries, ha->msix_count);
>-	if (ret) {
>+	ret = pci_msix_table_size(ha->pdev);
>+	if (ret < 0) {
>+		goto msix_failed;
>+	} else {
> 		if (ret < MIN_MSIX_COUNT)
> 			goto msix_failed;
> 
>-		ql_log(ql_log_warn, vha, 0x00c6,
>-		    "MSI-X: Failed to enable support "
>-		    "-- %d/%d\n Retry with %d vectors.\n",
>-		    ha->msix_count, ret, ret);
>-		ha->msix_count = ret;
>+		if (ret < ha->msix_count) {
>+			ql_log(ql_log_warn, vha, 0x00c6,
>+			    "MSI-X: Failed to enable support "
>+			    "-- %d/%d\n Retry with %d vectors.\n",
>+			    ha->msix_count, ret, ret);
>+			ha->msix_count = ret;
>+		}
> 		ret = pci_enable_msix(ha->pdev, entries, ha->msix_count);
> 		if (ret) {
> msix_failed:
>-- 
>1.7.7.6
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
