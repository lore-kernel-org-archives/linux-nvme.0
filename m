Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B139BC2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:06:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D481206FB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 21:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cGwhtFYO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jv7kZZzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D481206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D2jKr4cAOWyAOg9oPsQNlNdA01lNcfg5A/h3xQglWl0=; b=cGwhtFYOV6RUpPhrwirltO9Wgw
	8j0Kiclby5gexOBfayGZfKTu0GohTa50BOZIFJEGI59/M3BNURjZfZEsWlrFg4X3L4cc24kGoXyue
	oA9Eh5RGq8brnyaO0yWvWC06LMf6NzljW4icWnh+dBuSlZS0VmIDbA1q0KWNSNVpjhjSKfsLeeLKa
	Gk13E+QOoAUG1LycQO0j0Oj6wCRdnltZysCaDRr5Xzy2YtT7OIi85dYquS0hPiKgsJAWqnM2kDJRQ
	wl+hCE3x2rbnzmiz2iXb/xA758SecS+MzB6FqhHPnHI2z/bqKMnvBgFzHjTuOOFuK6i/dw1ZRNlKN
	FXWTMlbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKpUD-00019v-Fp; Tue, 22 Sep 2020 21:06:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKpUA-00018H-2N
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 21:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600808761; x=1632344761;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=auxqqImWBzwDw06PeW9nPF+cmbteqzwfnsqS9D9q7v4=;
 b=Jv7kZZzQWOwURplq3QSDgGqEHI7QgCvntErW4zowhyYbOB5aOswYkMb8
 7yAxZSyj+k+G0MUgHf+xU82amkKLJmQ/bCpyLSAe2Gz5JYj9cdmNQ/GVv
 /+RAL7l1xcRA/QKj2UBXIxumDj0gZUyXAazNiWvVT0ddLmcy4nzJihryo
 6aHIyKISRfdOPcBF1crlS3tgi5cJ6bF1rZpKy62BeF/whUTakhGyqX6r4
 M3GVYgmAOhdJu61H/viVXdGrcxtC50WH1E42NTYKXkeL2UM5QZsy6o3fa
 Fn8efHLd6VDOAb+oX9zg/oL6WCohGQCMlLjxQxd5ewxL8M6YdlEiYOEV+ g==;
IronPort-SDR: lnDkVVYiLpVkxEjPPt7aUWDNeSdYO10gEwBn0fsrQzm5q7lB4LI7Ayjcnexg4wtvXvoe/vlqOD
 Tf81dQYmGKPnCXPVQDq1dWYs5CfT5Ly3FLCOebXpslnx3VjMPqptxFI3khQs1f0FM77usF3J2h
 jP3LSzLvRPm55IAxMs9hgq5jkKDiYd2Ln81jwDGkS27569wWhO5j4mzsw1DBpRXSgtUYwPvXSp
 yL518ieU/+Cq8XAIxaUY9cuBJYZXSHrjiOLh8Bmfx9IG/kFsP8i3tEVeNu5Q5+jZVmItL30Gmp
 i+o=
X-IronPort-AV: E=Sophos;i="5.77,292,1596470400"; d="scan'208";a="257730075"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 05:06:00 +0800
IronPort-SDR: oL79eT0KU0DvTa9y3+Q3j7qnEKZflIoEg7u88RvJbQUEdcZWgBayH4aFJGoY5soQw1/7Cokm05
 B/FjmXGhGS7w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 13:52:08 -0700
IronPort-SDR: jfcXz3xAz8iHscp8m238e9XcbEt+pDTs5HQIJWDXiPjmhJib7m49dBZ4NXsqixEsHRjk9pns5X
 JYaF7UuZNlgg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Sep 2020 14:06:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH] nvme-core: use xarray for cel storing
Date: Tue, 22 Sep 2020 14:05:29 -0700
Message-Id: <20200922210529.4530-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_170602_321252_76C8AB5E 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When using linked list we have to open code the locking, search, and
destroy operations with the loops even if data structure doesn't fall
into the fast path.

One of the main advantage of having XArray to store, search, and remove
items is that it handles all the locking by itself, avoids the loops 
when using linked lists, provides clear API to replace the linked list's
search and destroy loops. 

This patch replaces the ctrl->cel list with XArray and removes :-

a. Extra code needed for the linked list for ctrl->cel item management
   such as nvme_find_cel().
b. Destroy loop in the nvme_free_ctrl().
c. Explicit insertion locking in the nvme_get_effects_log().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 31 ++++---------------------------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0d4713307724..5bf6399588a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3012,26 +3012,10 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
-static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
-{
-	struct nvme_cel *cel, *ret = NULL;
-
-	spin_lock_irq(&ctrl->lock);
-	list_for_each_entry(cel, &ctrl->cels, entry) {
-		if (cel->csi == csi) {
-			ret = cel;
-			break;
-		}
-	}
-	spin_unlock_irq(&ctrl->lock);
-
-	return ret;
-}
-
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
+	struct nvme_cel *cel = xa_load(&ctrl->cels, csi);
 	int ret;
 
 	if (cel)
@@ -3049,10 +3033,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 	}
 
 	cel->csi = csi;
-
-	spin_lock_irq(&ctrl->lock);
-	list_add_tail(&cel->entry, &ctrl->cels);
-	spin_unlock_irq(&ctrl->lock);
+	xa_store(&ctrl->cels, cel->csi, cel, GFP_KERNEL);
 out:
 	*log = &cel->log;
 	return 0;
@@ -4431,15 +4412,11 @@ static void nvme_free_ctrl(struct device *dev)
 	struct nvme_ctrl *ctrl =
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
-	struct nvme_cel *cel, *next;
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 
-	list_for_each_entry_safe(cel, next, &ctrl->cels, entry) {
-		list_del(&cel->entry);
-		kfree(cel);
-	}
+	xa_destroy(&ctrl->cels);
 
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4471,7 +4448,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
-	INIT_LIST_HEAD(&ctrl->cels);
+	xa_init(&ctrl->cels);
 	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1e6aaa710262..07bdbdc19fa0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -300,7 +300,7 @@ struct nvme_ctrl {
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
-	struct list_head cels;
+	struct xarray cels;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
