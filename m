Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64603C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:43:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173FB61358
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 11:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173FB61358
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mFkfOc5W9BGB7o9Qsx04Kcb9QvGwQ5RcQO/hb7InyBo=; b=dfWPgDVBr5GmkC
	pNbunDTQWfY6jK8WcJeKDEejSBuAj9jWjryOER3BM72KOMaiiUnw/f8NY9HDw63HxdlRfF1VS/Jt7
	5ZVvGwPtFJapf74293IaDk7m3nc45SylBJUQf9QCSo/BT3pNcGsvYyrWjeskxEA+TQ8tEPxbODO8t
	cHAro6p+4vh57OZP55UZjqn8qwt950cwfVOAol5Cl1G+y3hc5M2aayalbGnc9SKkqAC7Fly8qwY97
	cgxLMdAF5XxpAy69VyddBfEKTyx9w0vnBvuNqDaz4H4HyW2VrXP4n5eakF8zah391doklQ3TSkQ+P
	1ipY5qSDMp1AYQvM6lRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqa8g-0085zX-Ot; Tue, 08 Jun 2021 11:43:22 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqZuO-00828y-M9
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 11:28:38 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id B47373C15E;
 Tue,  8 Jun 2021 04:28:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B47373C15E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1623151716;
 bh=CG21/rejGB3U6a1HnXZkrzbsvcd2zSYWfWKXgApyVD4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J768cys7B3JBrVoF5NPMD8aZMn/K0jKY4OjGoyYIV9xf9MLR31bZEe/fntAX4dKts
 h7Rv6DFlNmLLKu1nIWiqAWhTJKC5fsf0f/5WSpiSnynPdm2AyBsRR2IdIyAfLA8I/G
 SxlReRU5yOfXMitrVXMntL6cxo7ixwsCnIzl/ls0=
From: Muneendra Kumar <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v11 12/13] lpfc: vmid: Adding qfpa and vmid timeout check in
 worker thread
Date: Tue,  8 Jun 2021 10:05:55 +0530
Message-Id: <20210608043556.274139-13-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210608043556.274139-1-muneendra.kumar@broadcom.com>
References: <20210608043556.274139-1-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_042836_898072_0C9C942D 
X-CRM114-Status: GOOD (  16.94  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch add the periodic check for issuing of qfpa command and vmid
timeout in the worker thread. The inactivity timeout check is added via
the timer function.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v11:
No change

v10:
No change

v9:
No change

v8:
checked the function return value

v7:
No change

v6:
Added Forward declarations and removed unused variable

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 41a388aab1cf..8ffd2727f47f 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -73,6 +73,7 @@ static void lpfc_unregister_fcfi_cmpl(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static int lpfc_fcf_inuse(struct lpfc_hba *);
 static void lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static void lpfc_check_inactive_vmid(struct lpfc_hba *phba);
+static void lpfc_check_vmid_qfpa_issue(struct lpfc_hba *phba);
 
 static int
 lpfc_valid_xpt_node(struct lpfc_nodelist *ndlp)
@@ -428,6 +429,32 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 	return fcf_inuse;
 }
 
+static void lpfc_check_vmid_qfpa_issue(struct lpfc_hba *phba)
+{
+	struct lpfc_vport *vport;
+	struct lpfc_vport **vports;
+	int i;
+
+	vports = lpfc_create_vport_work_array(phba);
+	if (!vports)
+		return;
+
+	for (i = 0; i <= phba->max_vports; i++) {
+		if ((!vports[i]) && (i == 0))
+			vport = phba->pport;
+		else
+			vport = vports[i];
+		if (!vport)
+			break;
+
+		if (vport->vmid_flag & LPFC_VMID_ISSUE_QFPA) {
+			if (!lpfc_issue_els_qfpa(vport))
+				vport->vmid_flag &= ~LPFC_VMID_ISSUE_QFPA;
+		}
+	}
+	lpfc_destroy_vport_work_array(phba, vports);
+}
+
 /**
  * lpfc_sli4_post_dev_loss_tmo_handler - SLI4 post devloss timeout handler
  * @phba: Pointer to hba context object.
@@ -748,6 +775,22 @@ lpfc_work_done(struct lpfc_hba *phba)
 	if (ha_copy & HA_LATT)
 		lpfc_handle_latt(phba);
 
+	/* Handle VMID Events */
+	if (lpfc_is_vmid_enabled(phba)) {
+		if (phba->pport->work_port_events &
+		    WORKER_CHECK_VMID_ISSUE_QFPA) {
+			lpfc_check_vmid_qfpa_issue(phba);
+			phba->pport->work_port_events &=
+				~WORKER_CHECK_VMID_ISSUE_QFPA;
+		}
+		if (phba->pport->work_port_events &
+		    WORKER_CHECK_INACTIVE_VMID) {
+			lpfc_check_inactive_vmid(phba);
+			phba->pport->work_port_events &=
+			    ~WORKER_CHECK_INACTIVE_VMID;
+		}
+	}
+
 	/* Process SLI4 events */
 	if (phba->pci_dev_grp == LPFC_PCI_DEV_OC) {
 		if (phba->hba_flag & HBA_RRQ_ACTIVE)
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
