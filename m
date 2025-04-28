Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A454DC369D3
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6PG4N+HFlGBbsabQ9hOpEuhNxJurVDVtAY0skbILru8=; b=AgTsjqbO5E8HCEwG4UvBA8VMj7
	79vKwrGHBEXDmPZTkmVRk6+cZL/hLqs+PLTwJmrGYWj0kWx9Qc9/LiXB4RDf0C//BsfJq/KpfI8j0
	6NUZQRUNJZRPRKaPgNIPICtHEHfUqQO1+5a0TaHp1R4yhBDHBcDLqIKwX9vZzoVsPzgGscE4AqqJ/
	/r/oKl8NK/h1OwoAU2IzgP8ZhLFsZs2IT3kKCd+10xn27a2OU79plxGC9hhl0fTmkCEa8pCamv23q
	WPjWjLjDa2tGePGVQEsTdsb42wjQPMdzq2OnFE6J4vGOA1fMveZrP7YaHn2N6Axg7/JTT5kzXDkVp
	1taxxMQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6n-0000000573F-3Sxn;
	Mon, 28 Apr 2025 06:36:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6f-0000000572y-2OJc
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:36:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 13D896115E;
	Mon, 28 Apr 2025 06:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220D5C4CEEA;
	Mon, 28 Apr 2025 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745822204;
	bh=tMZSTkFL5ulh0TCtARb1v83GJS76Oa62fKULPPYFF7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfibyZRKN4CfLRFuMzntTqde8F/Zxd2s6vNfmZqNcsGDqoW5eYpAHtx0c/e4xOPkO
	 SLu5W6zlHUxPs7Qwu23QlSkMZ9oeVsU2CvB1/cezskfYRgZgOZ/cL2idr7s4S5UYN5
	 nq+Kkj1MBwvK4UTHHYGoQOIzuwyjVo5fI/BevxDK2x+P/23PFkKusRwUNU6DWivtb+
	 9gpOxPgQr7dJz4okHIaE1AuKdDri2tpeiGx9mFGJpjTSs6i4fLgHEWGUZ4ofcQ67+L
	 H/0wEv/EVrg5kf45gY8gc1riXfqBiCxD2sLouUSZWof+t4AgDwKJWOMb3JZsDBIfz1
	 0VvWon/QY7I3A==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/4] fc_els: use 'union fc_tlv_desc'
Date: Mon, 28 Apr 2025 08:36:32 +0200
Message-Id: <20250428063635.125879-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250428063635.125879-1-hare@kernel.org>
References: <20250428063635.125879-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@kernel.org>

Introduce 'union fc_tlv_desc' to have a common structure for all FC
ELS TLV structures and avoid type casts.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c     |  67 ++++++-------
 drivers/scsi/scsi_transport_fc.c |  27 +++--
 include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
 3 files changed, 131 insertions(+), 128 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 375a879c31f1..4748c00f0f32 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -33,6 +33,7 @@
 #include <scsi/scsi_transport_fc.h>
 #include <uapi/scsi/fc/fc_fs.h>
 #include <uapi/scsi/fc/fc_els.h>
+#include <linux/nvme-fc-driver.h>
 
 #include "lpfc_hw4.h"
 #include "lpfc_hw.h"
@@ -3937,7 +3938,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 {
 	IOCB_t *irsp_iocb;
 	struct fc_els_edc_resp *edc_rsp;
-	struct fc_tlv_desc *tlv;
+	union fc_tlv_desc *tlv;
 	struct fc_diag_cg_sig_desc *pcgd;
 	struct fc_diag_lnkflt_desc *plnkflt;
 	struct lpfc_dmabuf *pcmd, *prsp;
@@ -4028,7 +4029,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			goto out;
 		}
 
-		dtag = be32_to_cpu(tlv->desc_tag);
+		dtag = be32_to_cpu(tlv->hdr.desc_tag);
 		switch (dtag) {
 		case ELS_DTAG_LNK_FAULT_CAP:
 			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
@@ -4043,7 +4044,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					sizeof(struct fc_diag_lnkflt_desc));
 				goto out;
 			}
-			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
+			plnkflt = &tlv->lnkflt;
 			lpfc_printf_log(phba, KERN_INFO,
 				LOG_ELS | LOG_LDS_EVENT,
 				"4617 Link Fault Desc Data: 0x%08x 0x%08x "
@@ -4070,7 +4071,7 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				goto out;
 			}
 
-			pcgd = (struct fc_diag_cg_sig_desc *)tlv;
+			pcgd = &tlv->cg_sig;
 			lpfc_printf_log(
 				phba, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 				"4616 CGN Desc Data: 0x%08x 0x%08x "
@@ -4125,10 +4126,8 @@ lpfc_cmpl_els_edc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 }
 
 static void
-lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_diag_lnkflt_desc *lft)
 {
-	struct fc_diag_lnkflt_desc *lft = (struct fc_diag_lnkflt_desc *)tlv;
-
 	lft->desc_tag = cpu_to_be32(ELS_DTAG_LNK_FAULT_CAP);
 	lft->desc_len = cpu_to_be32(
 		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_diag_lnkflt_desc));
@@ -4141,10 +4140,8 @@ lpfc_format_edc_lft_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 }
 
 static void
-lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+lpfc_format_edc_cgn_desc(struct lpfc_hba *phba, struct fc_diag_cg_sig_desc *cgd)
 {
-	struct fc_diag_cg_sig_desc *cgd = (struct fc_diag_cg_sig_desc *)tlv;
-
 	/* We are assuming cgd was zero'ed before calling this routine */
 
 	/* Configure the congestion detection capability */
@@ -4233,7 +4230,7 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
 	struct fc_els_edc *edc_req;
-	struct fc_tlv_desc *tlv;
+	union fc_tlv_desc *tlv;
 	u16 cmdsize;
 	struct lpfc_nodelist *ndlp;
 	u8 *pcmd = NULL;
@@ -4272,13 +4269,13 @@ lpfc_issue_els_edc(struct lpfc_vport *vport, uint8_t retry)
 	tlv = edc_req->desc;
 
 	if (cgn_desc_size) {
-		lpfc_format_edc_cgn_desc(phba, tlv);
+		lpfc_format_edc_cgn_desc(phba, &tlv->cg_sig);
 		phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
 		tlv = fc_tlv_next_desc(tlv);
 	}
 
 	if (lft_desc_size)
-		lpfc_format_edc_lft_desc(phba, tlv);
+		lpfc_format_edc_lft_desc(phba, &tlv->lnkflt);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 			 "4623 Xmit EDC to remote "
@@ -5823,7 +5820,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_hba  *phba = vport->phba;
 	struct fc_els_edc_resp *edc_rsp;
-	struct fc_tlv_desc *tlv;
+	union fc_tlv_desc *tlv;
 	struct lpfc_iocbq *elsiocb;
 	IOCB_t *icmd, *cmd;
 	union lpfc_wqe128 *wqe;
@@ -5867,10 +5864,10 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		FC_TLV_DESC_LENGTH_FROM_SZ(struct fc_els_lsri_desc));
 	edc_rsp->lsri.rqst_w0.cmd = ELS_EDC;
 	tlv = edc_rsp->desc;
-	lpfc_format_edc_cgn_desc(phba, tlv);
+	lpfc_format_edc_cgn_desc(phba, &tlv->cg_sig);
 	tlv = fc_tlv_next_desc(tlv);
 	if (lft_desc_size)
-		lpfc_format_edc_lft_desc(phba, tlv);
+		lpfc_format_edc_lft_desc(phba, &tlv->lnkflt);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
 			      "Issue EDC ACC:      did:x%x flg:x%lx refcnt %d",
@@ -9255,7 +9252,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 {
 	struct lpfc_hba  *phba = vport->phba;
 	struct fc_els_edc *edc_req;
-	struct fc_tlv_desc *tlv;
+	union fc_tlv_desc *tlv;
 	uint8_t *payload;
 	uint32_t *ptr, dtag;
 	const char *dtag_nm;
@@ -9298,7 +9295,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			goto out;
 		}
 
-		dtag = be32_to_cpu(tlv->desc_tag);
+		dtag = be32_to_cpu(tlv->hdr.desc_tag);
 		switch (dtag) {
 		case ELS_DTAG_LNK_FAULT_CAP:
 			if (bytes_remain < FC_TLV_DESC_SZ_FROM_LENGTH(tlv) ||
@@ -9313,7 +9310,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 					sizeof(struct fc_diag_lnkflt_desc));
 				goto out;
 			}
-			plnkflt = (struct fc_diag_lnkflt_desc *)tlv;
+			plnkflt = &tlv->lnkflt;
 			lpfc_printf_log(phba, KERN_INFO,
 				LOG_ELS | LOG_LDS_EVENT,
 				"4626 Link Fault Desc Data: x%08x len x%x "
@@ -9350,7 +9347,7 @@ lpfc_els_rcv_edc(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 			phba->cgn_sig_freq = lpfc_fabric_cgn_frequency;
 
 			lpfc_least_capable_settings(
-				phba, (struct fc_diag_cg_sig_desc *)tlv);
+				phba, &tlv->cg_sig);
 			break;
 		default:
 			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
@@ -9946,9 +9943,8 @@ lpfc_display_fpin_wwpn(struct lpfc_hba *phba, __be64 *wwnlist, u32 cnt)
  * This function processes a Link Integrity FPIN event by logging a message.
  **/
 static void
-lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_fn_li_desc *li)
 {
-	struct fc_fn_li_desc *li = (struct fc_fn_li_desc *)tlv;
 	const char *li_evt_str;
 	u32 li_evt, cnt;
 
@@ -9977,9 +9973,8 @@ lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
  * This function processes a Delivery FPIN event by logging a message.
  **/
 static void
-lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_fn_deli_desc *del)
 {
-	struct fc_fn_deli_desc *del = (struct fc_fn_deli_desc *)tlv;
 	const char *del_rsn_str;
 	u32 del_rsn;
 	__be32 *frame;
@@ -10015,9 +10010,8 @@ lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
  * This function processes a Peer Congestion FPIN event by logging a message.
  **/
 static void
-lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_fn_peer_congn_desc *pc)
 {
-	struct fc_fn_peer_congn_desc *pc = (struct fc_fn_peer_congn_desc *)tlv;
 	const char *pc_evt_str;
 	u32 pc_evt, cnt;
 
@@ -10054,10 +10048,9 @@ lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
  * to the upper layer or 0 to indicate don't deliver it.
  **/
 static int
-lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_fn_congn_desc *cgn)
 {
 	struct lpfc_cgn_info *cp;
-	struct fc_fn_congn_desc *cgn = (struct fc_fn_congn_desc *)tlv;
 	const char *cgn_evt_str;
 	u32 cgn_evt;
 	const char *cgn_sev_str;
@@ -10160,7 +10153,7 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 {
 	struct lpfc_hba *phba = vport->phba;
 	struct fc_els_fpin *fpin = (struct fc_els_fpin *)p;
-	struct fc_tlv_desc *tlv, *first_tlv, *current_tlv;
+	union fc_tlv_desc *tlv, *first_tlv, *current_tlv;
 	const char *dtag_nm;
 	int desc_cnt = 0, bytes_remain, cnt;
 	u32 dtag, deliver = 0;
@@ -10185,7 +10178,7 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 		return;
 	}
 
-	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
+	tlv = &fpin->fpin_desc[0];
 	first_tlv = tlv;
 	bytes_remain = fpin_length - offsetof(struct fc_els_fpin, fpin_desc);
 	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
@@ -10193,22 +10186,22 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 	/* process each descriptor separately */
 	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
 	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
-		dtag = be32_to_cpu(tlv->desc_tag);
+		dtag = be32_to_cpu(tlv->hdr.desc_tag);
 		switch (dtag) {
 		case ELS_DTAG_LNK_INTEGRITY:
-			lpfc_els_rcv_fpin_li(phba, tlv);
+			lpfc_els_rcv_fpin_li(phba, &tlv->li);
 			deliver = 1;
 			break;
 		case ELS_DTAG_DELIVERY:
-			lpfc_els_rcv_fpin_del(phba, tlv);
+			lpfc_els_rcv_fpin_del(phba, &tlv->deli);
 			deliver = 1;
 			break;
 		case ELS_DTAG_PEER_CONGEST:
-			lpfc_els_rcv_fpin_peer_cgn(phba, tlv);
+			lpfc_els_rcv_fpin_peer_cgn(phba, &tlv->peer_congn);
 			deliver = 1;
 			break;
 		case ELS_DTAG_CONGESTION:
-			deliver = lpfc_els_rcv_fpin_cgn(phba, tlv);
+			deliver = lpfc_els_rcv_fpin_cgn(phba, &tlv->congn);
 			break;
 		default:
 			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
@@ -10221,12 +10214,12 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 			return;
 		}
 		lpfc_cgn_update_stat(phba, dtag);
-		cnt = be32_to_cpu(tlv->desc_len);
+		cnt = be32_to_cpu(tlv->hdr.desc_len);
 
 		/* Sanity check descriptor length. The desc_len value does not
 		 * include space for the desc_tag and the desc_len fields.
 		 */
-		len -= (cnt + sizeof(struct fc_tlv_desc));
+		len -= (cnt + sizeof(struct fc_tlv_desc_hdr));
 		if (len < 0) {
 			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
 			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 082f76e76721..a62636c6f708 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -750,13 +750,12 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
  *
  */
 static void
-fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
+fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_fn_li_desc *li_desc)
 {
 	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
-	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
 	u16 event_type = be16_to_cpu(li_desc->event_type);
 	u64 wwpn;
 
@@ -799,12 +798,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
  */
 static void
 fc_fpin_delivery_stats_update(struct Scsi_Host *shost,
-			      struct fc_tlv_desc *tlv)
+			      struct fc_fn_deli_desc *dn_desc)
 {
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
-	struct fc_fn_deli_desc *dn_desc = (struct fc_fn_deli_desc *)tlv;
 	u32 reason_code = be32_to_cpu(dn_desc->deli_reason_code);
 
 	rport = fc_find_rport_by_wwpn(shost,
@@ -830,13 +828,11 @@ fc_fpin_delivery_stats_update(struct Scsi_Host *shost,
  */
 static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
-				struct fc_tlv_desc *tlv)
+				struct fc_fn_peer_congn_desc *pc_desc)
 {
 	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
-	struct fc_fn_peer_congn_desc *pc_desc =
-	    (struct fc_fn_peer_congn_desc *)tlv;
 	u16 event_type = be16_to_cpu(pc_desc->event_type);
 	u64 wwpn;
 
@@ -876,10 +872,9 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
  */
 static void
 fc_fpin_congn_stats_update(struct Scsi_Host *shost,
-			   struct fc_tlv_desc *tlv)
+			   struct fc_fn_congn_desc *congn)
 {
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
-	struct fc_fn_congn_desc *congn = (struct fc_fn_congn_desc *)tlv;
 
 	fc_cn_stats_update(be16_to_cpu(congn->event_type),
 			   &fc_host->fpin_stats);
@@ -899,32 +894,32 @@ fc_host_fpin_rcv(struct Scsi_Host *shost, u32 fpin_len, char *fpin_buf,
 		u8 event_acknowledge)
 {
 	struct fc_els_fpin *fpin = (struct fc_els_fpin *)fpin_buf;
-	struct fc_tlv_desc *tlv;
+	union fc_tlv_desc *tlv;
 	u32 bytes_remain;
 	u32 dtag;
 	enum fc_host_event_code event_code =
 		event_acknowledge ? FCH_EVT_LINK_FPIN_ACK : FCH_EVT_LINK_FPIN;
 
 	/* Update Statistics */
-	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
+	tlv = &fpin->fpin_desc[0];
 	bytes_remain = fpin_len - offsetof(struct fc_els_fpin, fpin_desc);
 	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
 
 	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
 	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
-		dtag = be32_to_cpu(tlv->desc_tag);
+		dtag = be32_to_cpu(tlv->hdr.desc_tag);
 		switch (dtag) {
 		case ELS_DTAG_LNK_INTEGRITY:
-			fc_fpin_li_stats_update(shost, tlv);
+			fc_fpin_li_stats_update(shost, &tlv->li);
 			break;
 		case ELS_DTAG_DELIVERY:
-			fc_fpin_delivery_stats_update(shost, tlv);
+			fc_fpin_delivery_stats_update(shost, &tlv->deli);
 			break;
 		case ELS_DTAG_PEER_CONGEST:
-			fc_fpin_peer_congn_stats_update(shost, tlv);
+			fc_fpin_peer_congn_stats_update(shost, &tlv->peer_congn);
 			break;
 		case ELS_DTAG_CONGESTION:
-			fc_fpin_congn_stats_update(shost, tlv);
+			fc_fpin_congn_stats_update(shost, &tlv->congn);
 		}
 
 		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
diff --git a/include/uapi/scsi/fc/fc_els.h b/include/uapi/scsi/fc/fc_els.h
index 16782c360de3..aceabd31ee88 100644
--- a/include/uapi/scsi/fc/fc_els.h
+++ b/include/uapi/scsi/fc/fc_els.h
@@ -253,12 +253,12 @@ enum fc_ls_tlv_dtag {
 
 
 /*
- * Generic Link Service TLV Descriptor format
+ * Generic Link Service TLV Descriptor header
  *
  * This structure, as it defines no payload, will also be referred to
  * as the "tlv header" - which contains the tag and len fields.
  */
-struct fc_tlv_desc {
+struct fc_tlv_desc_hdr {
 	__be32		desc_tag;	/* Notification Descriptor Tag */
 	__be32		desc_len;	/* Length of Descriptor (in bytes).
 					 * Size of descriptor excluding
@@ -267,36 +267,6 @@ struct fc_tlv_desc {
 	__u8		desc_value[];  /* Descriptor Value */
 };
 
-/* Descriptor tag and len fields are considered the mandatory header
- * for a descriptor
- */
-#define FC_TLV_DESC_HDR_SZ	sizeof(struct fc_tlv_desc)
-
-/*
- * Macro, used when initializing payloads, to return the descriptor length.
- * Length is size of descriptor minus the tag and len fields.
- */
-#define FC_TLV_DESC_LENGTH_FROM_SZ(desc)	\
-		(sizeof(desc) - FC_TLV_DESC_HDR_SZ)
-
-/* Macro, used on received payloads, to return the descriptor length */
-#define FC_TLV_DESC_SZ_FROM_LENGTH(tlv)		\
-		(__be32_to_cpu((tlv)->desc_len) + FC_TLV_DESC_HDR_SZ)
-
-/*
- * This helper is used to walk descriptors in a descriptor list.
- * Given the address of the current descriptor, which minimally contains a
- * tag and len field, calculate the address of the next descriptor based
- * on the len field.
- */
-static inline void *fc_tlv_next_desc(void *desc)
-{
-	struct fc_tlv_desc *tlv = desc;
-
-	return (desc + FC_TLV_DESC_SZ_FROM_LENGTH(tlv));
-}
-
-
 /*
  * Link Service Request Information Descriptor
  */
@@ -1094,19 +1064,6 @@ struct fc_fn_congn_desc {
 	__u8		resv[3];	/* reserved - must be zero */
 };
 
-/*
- * ELS_FPIN - Fabric Performance Impact Notification
- */
-struct fc_els_fpin {
-	__u8		fpin_cmd;	/* command (0x16) */
-	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
-	__be32		desc_len;	/* Length of Descriptor List (in bytes).
-					 * Size of ELS excluding fpin_cmd,
-					 * fpin_zero and desc_len fields.
-					 */
-	struct fc_tlv_desc	fpin_desc[];	/* Descriptor list */
-};
-
 /* Diagnostic Function Descriptor - FPIN Registration */
 struct fc_df_desc_fpin_reg {
 	__be32		desc_tag;	/* FPIN Registration (0x00030001) */
@@ -1125,33 +1082,6 @@ struct fc_df_desc_fpin_reg {
 					 */
 };
 
-/*
- * ELS_RDF - Register Diagnostic Functions
- */
-struct fc_els_rdf {
-	__u8		fpin_cmd;	/* command (0x19) */
-	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
-	__be32		desc_len;	/* Length of Descriptor List (in bytes).
-					 * Size of ELS excluding fpin_cmd,
-					 * fpin_zero and desc_len fields.
-					 */
-	struct fc_tlv_desc	desc[];	/* Descriptor list */
-};
-
-/*
- * ELS RDF LS_ACC Response.
- */
-struct fc_els_rdf_resp {
-	struct fc_els_ls_acc	acc_hdr;
-	__be32			desc_list_len;	/* Length of response (in
-						 * bytes). Excludes acc_hdr
-						 * and desc_list_len fields.
-						 */
-	struct fc_els_lsri_desc	lsri;
-	struct fc_tlv_desc	desc[];	/* Supported Descriptor list */
-};
-
-
 /*
  * Diagnostic Capability Descriptors for EDC ELS
  */
@@ -1221,6 +1151,65 @@ struct fc_diag_cg_sig_desc {
 	struct fc_diag_cg_sig_freq	rcv_signal_frequency;
 };
 
+/*
+ * Generic Link Service TLV Descriptor format
+ *
+ * This structure, as it defines no payload, will also be referred to
+ * as the "tlv header" - which contains the tag and len fields.
+ */
+union fc_tlv_desc {
+	struct fc_tlv_desc_hdr hdr;
+	struct fc_els_lsri_desc lsri;
+	struct fc_fn_li_desc li;
+	struct fc_fn_deli_desc deli;
+	struct fc_fn_peer_congn_desc peer_congn;
+	struct fc_fn_congn_desc congn;
+	struct fc_df_desc_fpin_reg fpin_reg;
+	struct fc_diag_lnkflt_desc lnkflt;
+	struct fc_diag_cg_sig_desc cg_sig;
+};
+
+/* Descriptor tag and len fields are considered the mandatory header
+ * for a descriptor
+ */
+#define FC_TLV_DESC_HDR_SZ	sizeof(struct fc_tlv_desc_hdr)
+
+/*
+ * Macro, used when initializing payloads, to return the descriptor length.
+ * Length is size of descriptor minus the tag and len fields.
+ */
+#define FC_TLV_DESC_LENGTH_FROM_SZ(desc)	\
+		(sizeof(desc) - FC_TLV_DESC_HDR_SZ)
+
+/* Macro, used on received payloads, to return the descriptor length */
+#define FC_TLV_DESC_SZ_FROM_LENGTH(tlv)		\
+		(__be32_to_cpu((tlv)->hdr.desc_len) + FC_TLV_DESC_HDR_SZ)
+
+/*
+ * This helper is used to walk descriptors in a descriptor list.
+ * Given the address of the current descriptor, which minimally contains a
+ * tag and len field, calculate the address of the next descriptor based
+ * on the len field.
+ */
+static inline union fc_tlv_desc *fc_tlv_next_desc(union fc_tlv_desc *desc)
+{
+	return (union fc_tlv_desc *)((u8 *)desc + FC_TLV_DESC_SZ_FROM_LENGTH(desc));
+}
+
+
+/*
+ * ELS_FPIN - Fabric Performance Impact Notification
+ */
+struct fc_els_fpin {
+	__u8		fpin_cmd;	/* command (0x16) */
+	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
+	__be32		desc_len;	/* Length of Descriptor List (in bytes).
+					 * Size of ELS excluding fpin_cmd,
+					 * fpin_zero and desc_len fields.
+					 */
+	union fc_tlv_desc	fpin_desc[];	/* Descriptor list */
+};
+
 /*
  * ELS_EDC - Exchange Diagnostic Capabilities
  */
@@ -1231,10 +1220,37 @@ struct fc_els_edc {
 					 * Size of ELS excluding edc_cmd,
 					 * edc_zero and desc_len fields.
 					 */
-	struct fc_tlv_desc	desc[];
+	union fc_tlv_desc	desc[];
 					/* Diagnostic Descriptor list */
 };
 
+/*
+ * ELS_RDF - Register Diagnostic Functions
+ */
+struct fc_els_rdf {
+	__u8		fpin_cmd;	/* command (0x19) */
+	__u8		fpin_zero[3];	/* specified as zero - part of cmd */
+	__be32		desc_len;	/* Length of Descriptor List (in bytes).
+					 * Size of ELS excluding fpin_cmd,
+					 * fpin_zero and desc_len fields.
+					 */
+	union fc_tlv_desc	desc[];	/* Descriptor list */
+};
+
+/*
+ * ELS RDF LS_ACC Response.
+ */
+struct fc_els_rdf_resp {
+	struct fc_els_ls_acc	acc_hdr;
+	__be32			desc_list_len;	/* Length of response (in
+						 * bytes). Excludes acc_hdr
+						 * and desc_list_len fields.
+						 */
+	struct fc_els_lsri_desc	lsri;
+	union fc_tlv_desc	desc[];	/* Supported Descriptor list */
+};
+
+
 /*
  * ELS EDC LS_ACC Response.
  */
@@ -1245,9 +1261,8 @@ struct fc_els_edc_resp {
 						 * and desc_list_len fields.
 						 */
 	struct fc_els_lsri_desc	lsri;
-	struct fc_tlv_desc	desc[];
+	union fc_tlv_desc	desc[];
 				    /* Supported Diagnostic Descriptor list */
 };
 
-
 #endif /* _FC_ELS_H_ */
-- 
2.35.3


