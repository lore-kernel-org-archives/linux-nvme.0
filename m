Return-Path: <SRS0=sPWJ=AQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443B4C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:59:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1536F20737
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Jul 2020 07:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q0h5+BXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1536F20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OSeLZt6IhdbyRR1O6cwt9v9iMY2lfzJa4NRypDpP6H0=; b=q0h5+BXd9U65Pt9uvv/m0q09o
	aQ5yd/zCgAOQGS7yLOZWPrLk/vBn7tOiadoWmRJrOS4ZjBlh/mvOY5ch+9+Xxa3NlvhFQnpPF2ehy
	B8HNKIZZar5niUbDA9jfOnTa1izGDzT006z9uqocU6y7NMvdwG08CWMMqI/iYFs0pdFVNQmGcPYRj
	NPfEwvYOgqYTR99+/0YTAcU2VSvlTnXV15QHOKhP/YTxlfdWKBzgmCDtlOkpk7ZhsJR9DPsNsQnz6
	vxc+rR5ww6e9zmzhm0B/O0Z03fg5ur2qQBlLRVb0YHcofaKnKR335hq3WaSSb9S1HP9VZgkTRqkhb
	frUdsvQjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jrzYt-0006Rz-33; Sun, 05 Jul 2020 07:59:43 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrzYq-0006Qx-2K
 for linux-nvme@lists.infradead.org; Sun, 05 Jul 2020 07:59:40 +0000
Received: by mail-pf1-f195.google.com with SMTP id x72so6272464pfc.6
 for <linux-nvme@lists.infradead.org>; Sun, 05 Jul 2020 00:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vl8owt2ml+c3d2mWNfIzzh1Ey0nvoPqMTlB1aSQySFw=;
 b=TKhXuyhwoVDKUDTcPUD2iCEl4DNXiY2SJHZ5hUfZNqxTIbecTH9kfzU0w5KJRP9L8o
 kPEKo2XPWw7PpOh6w6/2UypFXDQ7BzxJ/VmgCXE9GNUW267wzlEhLjgEVQ18gU37OrOG
 tBnx/mLc5qqL4DRDkqzdlF8exN6QYRIykJkftfnxHhNETgqqz9TpMmd5BNldOqaGxiXL
 d/520NE6SH5L9SYMPOBMBG87Cr5KaFcOOQ6w7xlG+CPRMpedpNDrSeMICWkZZy/54hXn
 T15+YD4Y3I8VB3YtPti9627lL1sa9GoaefoBHGimkMpEsSUwABWjRAdGGhHxbokSlEX7
 lM2g==
X-Gm-Message-State: AOAM533RwyTV978j0CYYOXRgrW5ycr4dtNs4qwaHatQCiFrrho1O3fcN
 NoV4pupROD+OLEiv5nFqrE4kpD57
X-Google-Smtp-Source: ABdhPJw4HqUnT7l2jJIkkIQqCYrQkNSOrGBzLtBOkb4F4Ry5CNzg6YdA7MSA0NwTS+N5gkB+5/mnDg==
X-Received: by 2002:a62:27c4:: with SMTP id n187mr6073027pfn.208.1593935978489; 
 Sun, 05 Jul 2020 00:59:38 -0700 (PDT)
Received: from localhost.localdomain (068-186-033-250.biz.spectrum.com.
 [68.186.33.250])
 by smtp.gmail.com with ESMTPSA id k26sm16133228pgt.90.2020.07.05.00.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 00:59:37 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 rfc 1/3] nvme: split nvme_remove_namespaces
Date: Sun,  5 Jul 2020 00:59:33 -0700
Message-Id: <20200705075935.506535-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200705075935.506535-1-sagi@grimberg.me>
References: <20200705075935.506535-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200705_035940_173919_33C1362F 
X-CRM114-Status: GOOD (  14.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In controller deletion we will need to add a state transition
after we flush the namespace scanning, and continue to the
namespace removal afterwards. Hence, split nvme_remove_namespaces
so that we can add this change only in the nvme_do_delete_ctrl
call site.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 29 ++++++++++++++++++++---------
 drivers/nvme/host/nvme.h |  3 ++-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 509bf4e1d423..f1bb2a522cf0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4091,16 +4091,8 @@ static void nvme_scan_work(struct work_struct *work)
 	up_write(&ctrl->namespaces_rwsem);
 }
 
-/*
- * This function iterates the namespace list unlocked to allow recovery from
- * controller failure. It is up to the caller to ensure the namespace list is
- * not modified by scan work while this function is executing.
- */
-void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
+void nvme_prep_remove_namespaces(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns, *next;
-	LIST_HEAD(ns_list);
-
 	/*
 	 * make sure to requeue I/O to all namespaces as these
 	 * might result from the scan itself and must complete
@@ -4119,6 +4111,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_prep_remove_namespaces);
+
+void nvme_do_remove_namespaces(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns, *next;
+	LIST_HEAD(ns_list);
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
@@ -4127,6 +4126,18 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
 }
+EXPORT_SYMBOL_GPL(nvme_do_remove_namespaces);
+
+/*
+ * This function iterates the namespace list unlocked to allow recovery from
+ * controller failure. It is up to the caller to ensure the namespace list is
+ * not modified by scan work while this function is executing.
+ */
+void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
+{
+	nvme_prep_remove_namespaces(ctrl);
+	nvme_do_remove_namespaces(ctrl);
+}
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
 static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 85d76981b66e..f184ae623f12 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -530,7 +530,8 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
-
+void nvme_prep_remove_namespaces(struct nvme_ctrl *ctrl);
+void nvme_do_remove_namespaces(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
