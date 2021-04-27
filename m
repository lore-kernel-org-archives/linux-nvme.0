Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD642C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:41:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E23261418
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E23261418
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Avu4G3jpgBE6sq0/hI+xkzndgDg/o9qcCE7zITHsWqU=; b=JIr9Hga0WexSWLe69GgtXjU1Ay
	tvZBF4V8a7XsCdjiyqTkfBL6ma87RoszQ4V2ys9XuoIk1cbpy8QTYx55R0xLGEyOhBpSqVYspEYRl
	5m5s7SY2v/NtaYX8VzLwL9rhsGV7pKFMIwbnNgjR0Uwr4a635QdphdK3NIyBA8xuT8s+HYp5+KQ+o
	tUM8/U4JtNxXdTP/gdAgoTf1n/KkES8lH2m5na2E4qQEq1SvqaIACyc2drT2vZopx7we5EepytzxV
	rNrz7kJSDLHbbCPKsgK6OSLQR+XBpMmHnQGx1e3eHbMwO0A3eB+YLLWbt2CWe7u1zEbgcfQss+rJn
	s6XmShEA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbcvr-002qCb-Rj; Wed, 28 Apr 2021 05:40:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrN-002pcT-PD
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 05:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=He088d2g1GxLFuVelZd5DheqHwnavXUH/ZfNvtV0GVQ=; b=UerRFzDhgXRRhlQIlkUNywcA+v
 K4UZvX5F82QKsDBU4rB0jN+4aztFlbUbPHZEVgK03zJk9LXonXoZ1mH6SJrTzHqlcBNfA0KpUD11T
 fYRN/WgqieYcVy6Eu6RTp4T4V9RNbXufr3ITaeR31yb0gJdZ4EQhQcCNOPhqaUOgoxXpcnWcf6rVd
 gr9wdy0rbO+k4ew+HHIbX3VoxAtDygVE4dWYeDCHxWBtY9WNIHE0o/GoxxTCZ+HHUKMSTedSioiEY
 1XkiorP79uL6pYenwq4pg60JMTuz5bzH0TkuHJClIGyAWyME4uqihZ8lMoClyeD5ELIaHLZTSt4IU
 JH1H/J/Q==;
Received: from saphodev.broadcom.com ([192.19.11.229]
 helo=relay.smtp-ext.broadcom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrK-00HBhy-GR
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 05:35:40 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 6228D30E92;
 Tue, 27 Apr 2021 22:27:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6228D30E92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1619587657;
 bh=Zs1VoJ2QFpjVkHfavT8dq+bS2QLucnaHhCZ0emcILsk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rC8LkPLPoaD9B9Nn9gEAfzVKWWIl4pgI4LSvSp2J9zSe4KSbD2aT3hsJQ2UPoNxZZ
 omC7KxO5mMc/X96S8ZzcVuZHhtxGBvLSrDHE5Q++7UUDt7a23Mljx8FwuZSaq6kfR1
 f4EDFoOnzdqzD3ubKRPM+iFxCtwVPmCM4M4UVaeQ=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v10 10/13] lpfc: vmid: Appends the vmid in the wqe before
 sending
Date: Wed, 28 Apr 2021 04:04:54 +0530
Message-Id: <1619562897-14062-11-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_223538_714477_79674B08 
X-CRM114-Status: GOOD (  12.74  )
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

This patch adds the vmid in wqe before sending out the request.
The type of vmid depends on the configured type and is checked before
being appended.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v10:
Removed redudant code

v9:
No change

v8:
Modified the log messages

v7:
No change

v6:
No change

v5:
Modified the comments

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_sli.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 23fb896aa260..b16f38f87710 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9760,6 +9760,8 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 				*pcmd == ELS_CMD_RSCN_XMT ||
 				*pcmd == ELS_CMD_FDISC ||
 				*pcmd == ELS_CMD_LOGO ||
+				*pcmd == ELS_CMD_QFPA ||
+				*pcmd == ELS_CMD_UVEM ||
 				*pcmd == ELS_CMD_PLOGI)) {
 				bf_set(els_req64_sp, &wqe->els_req, 1);
 				bf_set(els_req64_sid, &wqe->els_req,
@@ -10322,6 +10324,18 @@ __lpfc_sli_issue_fcp_io_s4(struct lpfc_hba *phba, uint32_t ring_number,
 		bf_set(wqe_wqes, &wqe->generic.wqe_com, 0);
 	}
 
+	/* add the VMID tags as per switch response */
+	if (unlikely(piocb->iocb_flag & LPFC_IO_VMID)) {
+		if (phba->pport->vmid_priority_tagging) {
+			bf_set(wqe_ccpe, &wqe->fcp_iwrite.wqe_com, 1);
+			bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
+					(piocb->vmid_tag.cs_ctl_vmid));
+		} else {
+			bf_set(wqe_appid, &wqe->fcp_iwrite.wqe_com, 1);
+			bf_set(wqe_wqes, &wqe->fcp_iwrite.wqe_com, 1);
+			wqe->words[31] = piocb->vmid_tag.app_id;
+		}
+	}
 	rc = lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
 	return rc;
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
