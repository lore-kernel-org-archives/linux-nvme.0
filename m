Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98FEC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:22:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5012E64F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5012E64F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gOQNN36anDqAiF31xV2mbIZiiK5yK556bfvLURzmFo=; b=FjYPJulT0sMJCztwWCUPMJxHu6
	/wTquBYeGtpmsyRgDNjZJmnGauHer+1pfITkt+sM405dikpaYHqN1MVk0fY2PNHCEFp+xZ5dDx9aC
	YEuMPv8eesTV61t2O0xm92tRJ6+jy61QH62x8JMjZSy7s3K4wxpiLvy1ANmx12BB7V7W+lqmn61sX
	hIv4iRfRfY/+My41SGVPSY4slaOH8AombM5nU1z/lG4hxx4volVXLf/i8reFLtbnwXnVBk0kv9VJT
	ChRLPHiMQbpI+HVMvxmoSOWI6VaVv2tpYL3uj22dheYYLklnNDAR6u1v8mVjEQsHSsMwAhHto6QRL
	YdXqJ71g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHn05-008aev-Ov; Thu, 04 Mar 2021 12:22:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHmzA-008aUM-OO
 for linux-nvme@desiato.infradead.org; Thu, 04 Mar 2021 12:21:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=b4BpOZlxV+QuFrMtFIU86VS53O4h6jrjVLfcomZ8ztA=; b=BRgh5RNuDQqNT8zFCvkey6EfvQ
 P5M+rPxuEVkyHxHJutq2X+h7tdwIEJyb6BjlpOGOEoO4JGHjV4XT/uP+kLDa8wVFqO2GoQh4k4RqV
 /dsBkSMq7qMZiblcLz2FhCF9P8NIzzGEqgpa3Zn46/pRuQgzX5MyzD7r1/udZIOfk6WWPgfJCfTfk
 qK2pVPVra+BQQuatoIcW0fR/rUkruDHuYqsb+nXAKgHQIZ99gcdjOo7SsG9tsZyP66LPRZsovCdWx
 aIIGDcUeZFydCTn3LuwkHfLUWv83U6bqPsVmbFHBKMO5EQ8GivLoue7AtCwbeQqSNrS3Mq4sdpJV5
 /51QRPvw==;
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHmyg-006z2V-Lo
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:21:42 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 854DA24352;
 Thu,  4 Mar 2021 04:20:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 854DA24352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1614860402;
 bh=srb5Vb2ueRAHp4t+HFxlbTF+4prF+ZqavV1+8P0nMg4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WmJsB400xXyVoKDokTAUZbRL5X7v3MtX61NYfDRFkg6HF1ucLByQP9zwFJsNqvAF6
 vIjOZGfCZopfTUyCWKws58RsK+487tmO9JRBC1M3Clf7TU5HihwD7Z1q0nYpitqb4b
 ULrn8EiiQi+rE0u+BzyrGFiWog1LwmR50nkhUzXs=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v8 14/16] lpfc: vmid: Adding qfpa and vmid timeout check in
 worker thread
Date: Thu,  4 Mar 2021 10:57:24 +0530
Message-Id: <1614835646-16217-15-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210304_122127_356624_26169A1F 
X-CRM114-Status: GOOD (  15.49  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch add the periodic check for issuing of qfpa command and vmid
timeout in the worker thread. The inactivity timeout check is added via
the timer function.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
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
index c4519f6349bc..c807302a782d 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -73,6 +73,7 @@ static void lpfc_unregister_fcfi_cmpl(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static int lpfc_fcf_inuse(struct lpfc_hba *);
 static void lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static void lpfc_check_inactive_vmid(struct lpfc_hba *phba);
+static void lpfc_check_vmid_qfpa_issue(struct lpfc_hba *phba);
 
 static int
 lpfc_valid_xpt_node(struct lpfc_nodelist *ndlp)
@@ -439,6 +440,32 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
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
@@ -759,6 +786,22 @@ lpfc_work_done(struct lpfc_hba *phba)
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
