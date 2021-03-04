Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C902C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:28:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE2C64F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE2C64F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPITVxCIeAuts/c6CXEcK3I+Et7MWo7T6RpnnKOhRKU=; b=cb0G4N+l8KhGbnkDEZQZT2X4XE
	xsiD7b9xoJNvBn5eyO+OFz13yr3vn3mj5t7E7PisrZwTlz2lW9lFUX8zrNv2ZAlpHqBz/MPIEzsJb
	GBj7elxaicP8v/4o5CfwUMOVb2qezcJX8MHBqGGtHOuSFStaLBvDO5cwLwsrr1YUbWbhaUH2gqRDz
	8wxNuZlAoW+4phgC8ieX1+m8/JTBoqzkgIMiLLuSZd73ClVMCliZ7SUD1YWnwLtGx6M9R4tZXCySX
	lQWEToM8HuxwZy40pl1rjTRExWjxh3rth5bzpixVNGd93f2pYdmHE95Zkv0PnI1c+V0uVxvBcKo6P
	vwCm1TuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHn58-008bhd-RW; Thu, 04 Mar 2021 12:27:55 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn4J-008bWd-Hi
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:27:09 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 0A90822590;
 Thu,  4 Mar 2021 04:19:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0A90822590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1614860398;
 bh=iNcyFJyTKjzxYkDx4WW/6UuGlOCZHy6l9mGwuCR9nUQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jpbdIXgTeWb9aAkAQz6jGO2urf0vsUzz6HpYvUSqwORVSi8ytIpvFFBzyVq4vcSOf
 IixLzu5bF3TS00fTW9ub7/PzIewzo6tPX8ufGIEWqhpdSO+nDDiYGaVu/bDHyFk+zR
 OwOeBrO904hozhiwhALqtdzgyvBMNqLU/hu6yOYQ=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v8 06/16] lpfc: vmid: Forward declarations for APIs
Date: Thu,  4 Mar 2021 10:57:16 +0530
Message-Id: <1614835646-16217-7-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
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

This patch contains the forward declarations of commonly used APIs which
are used outside the scope of the file.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v8:
modify function declaration

v7:
No change

v6:
No change

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_crtn.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index a0aad4896a45..6a73819d9b6b 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -608,3 +608,14 @@ extern unsigned long lpfc_no_hba_reset[];
 extern union lpfc_wqe128 lpfc_iread_cmd_template;
 extern union lpfc_wqe128 lpfc_iwrite_cmd_template;
 extern union lpfc_wqe128 lpfc_icmnd_cmd_template;
+
+/* vmid interface */
+int lpfc_vmid_uvem(struct lpfc_vport *vport, struct lpfc_vmid *vmid, bool ins);
+uint32_t lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport);
+int lpfc_vmid_cmd(struct lpfc_vport *vport,
+		  int cmdcode, struct lpfc_vmid *vmid);
+int lpfc_vmid_hash_fn(const char *vmid, int len);
+struct lpfc_vmid *lpfc_get_vmid_from_hastable(struct lpfc_vport *vport,
+					      uint32_t hash, uint8_t *buf);
+void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
+int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
