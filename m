Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD973C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:43:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239C861154
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239C861154
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nCgRyxVuTEGXWHsHz4yTGB9cPJYSFLa8g79zMzgp3nA=; b=QdvI8Vhqa+kBBKHQxMXkEJLEP7
	XLICkmS76wrdT1n+TDjENUMyS2bc8/RSRLLfEW9p5MbJKo54IY4npjfYSZq/g/wnZzCz01ENUjLFR
	mamKzfSkKyIKs3RiMAk+BA/wOgPU4H3NG1ZXrKaRSQYr6ZGgkdE3BtAB0YY9Cmlh07PZez+psUSDU
	aP4liohRkUB/q9M+RT8mH42/pyNYIsBByaCiB9O3k0RnCV/7LlarPjcJ3mX9RGc9ZnD9vT7oyi0GG
	qLRwRuWBy9YfgWm9kRKxjNKzs/HdIQZFuPWO9hwucFVFJcBRSD0Jyu8UrBOxAmojWuE8SCgkoe8aO
	qGCrFuaQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbcyV-002qUV-OF; Wed, 28 Apr 2021 05:43:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrP-002pcf-Dr
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 05:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ht/jgDs7u77Xeap5kC60YHip6AGbvc6eTr7HLE0GaLY=; b=1qWOux/+3nPHPq2DzkFjHgL5Dj
 HqjNjh7doOgD+mkkub4Rl2AxHpvit/DjB4/+jioUHXPgg5zlZWFAtbZuP+r+gClvykYeJdgRapLDr
 G3IeOxBL+uzC5dQEW/ypB4e8i3jcIyokJAXgrkbp0PEzro7dsnSst5TMqSBJBazCXD1/3TEhs0ODY
 eoStBOUHHGvGC5tT3LeKyzC4Tkz4lla0RlI9ZlflnDf6vlFRk9+6hmLNcWQ69pa6QmwJZF9W9fZmS
 8bwwGU/oWzub6IYOf9B1BR1qSgXfrUYilWkoX+84YFLu9QkztlkuF0PTKu1VgmmU8dlsZSc2SpArF
 sOpaRIvw==;
Received: from relay.smtp-ext.broadcom.com ([192.19.11.229])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrM-00HBjX-0t
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 05:35:42 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 5F73CE927F;
 Tue, 27 Apr 2021 22:27:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5F73CE927F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1619587644;
 bh=GwqqbqUaXlgRIum8rW5bucsuUv5+HN8geDLAf8yJJ2M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C4Yhb6zuc0n8u3nyFX352Yfoj095kbm/117Y0zzhhQgROtor4armLcy0Fdt+ime1n
 NivAZ+vc7vOwieixsgb0VMHRj+09fbtCGqKmMU4lHsEIuBbIFKqtKoWMGMpQzpGFCl
 7Kadpmn7oWd3N/r7HdphwwI6nPE0T9PX886tMuy4=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v10 05/13] lpfc: vmid: VMID params initialization
Date: Wed, 28 Apr 2021 04:04:49 +0530
Message-Id: <1619562897-14062-6-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_223540_329453_F8B68AA4 
X-CRM114-Status: GOOD (  13.78  )
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

This patch initializes the VMID parameters like the type of vmid, max
number of vmids supported and timeout value for the vmid registration
based on the user input.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v10:
No change

v9:
updated comments

v8:
No change

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
 drivers/scsi/lpfc/lpfc_attr.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 0975a8b252a0..21646af8eafd 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -6153,6 +6153,45 @@ LPFC_ATTR_RW(enable_dpp, 1, 0, 1, "Enable Direct Packet Push");
  */
 LPFC_ATTR_R(enable_mi, 1, 0, 1, "Enable MI");
 
+/*
+ * lpfc_max_vmid: Maximum number of VMs to be tagged. This is valid only if
+ * either vmid_app_header or vmid_priority_tagging is enabled.
+ *       4 - 255  = vmid support enabled for 4-255 VMs
+ *       Value range is [4,255].
+ */
+LPFC_ATTR_RW(max_vmid, LPFC_MIN_VMID, LPFC_MIN_VMID, LPFC_MAX_VMID,
+	     "Maximum number of VMs supported");
+
+/*
+ * lpfc_vmid_inactivity_timeout: Inactivity timeout duration in hours
+ *       0  = Timeout is disabled
+ * Value range is [0,24].
+ */
+LPFC_ATTR_RW(vmid_inactivity_timeout, 4, 0, 24,
+	     "Inactivity timeout in hours");
+
+/*
+ * lpfc_vmid_app_header: Enable App Header VMID support
+ *       0  = Support is disabled (default)
+ *       1  = Support is enabled
+ * Value range is [0,1].
+ */
+LPFC_ATTR_RW(vmid_app_header, LPFC_VMID_APP_HEADER_DISABLE,
+	     LPFC_VMID_APP_HEADER_DISABLE, LPFC_VMID_APP_HEADER_ENABLE,
+	     "Enable App Header VMID support");
+
+/*
+ * lpfc_vmid_priority_tagging: Enable Priority Tagging VMID support
+ *       0  = Support is disabled (default)
+ *       1  = Allow supported targets only
+ *       2  = Allow all targets
+ * Value range is [0,2].
+ */
+LPFC_ATTR_RW(vmid_priority_tagging, LPFC_VMID_PRIO_TAG_DISABLE,
+	     LPFC_VMID_PRIO_TAG_DISABLE,
+	     LPFC_VMID_PRIO_TAG_ALL_TARGETS,
+	     "Enable Priority Tagging VMID support");
+
 struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_nvme_info,
 	&dev_attr_scsi_stat,
@@ -6271,6 +6310,10 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_lpfc_enable_bbcr,
 	&dev_attr_lpfc_enable_dpp,
 	&dev_attr_lpfc_enable_mi,
+	&dev_attr_lpfc_max_vmid,
+	&dev_attr_lpfc_vmid_inactivity_timeout,
+	&dev_attr_lpfc_vmid_app_header,
+	&dev_attr_lpfc_vmid_priority_tagging,
 	NULL,
 };
 
@@ -7346,6 +7389,11 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_enable_hba_heartbeat_init(phba, lpfc_enable_hba_heartbeat);
 
 	lpfc_EnableXLane_init(phba, lpfc_EnableXLane);
+	/* VMID Inits */
+	lpfc_max_vmid_init(phba, lpfc_max_vmid);
+	lpfc_vmid_inactivity_timeout_init(phba, lpfc_vmid_inactivity_timeout);
+	lpfc_vmid_app_header_init(phba, lpfc_vmid_app_header);
+	lpfc_vmid_priority_tagging_init(phba, lpfc_vmid_priority_tagging);
 	if (phba->sli_rev != LPFC_SLI_REV4)
 		phba->cfg_EnableXLane = 0;
 	lpfc_XLanePriority_init(phba, lpfc_XLanePriority);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
