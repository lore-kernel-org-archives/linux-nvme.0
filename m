Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DC2C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 04:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B4B2074F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 04:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SZYBo6yE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J9Vin9Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B4B2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=J1NpYYenuiWIZ+kr7f2PkcVfRkKRPf6tL3gPUCcd50A=; b=SZYBo6yERejLQE
	w+X9fQHWTmW5oe6RWuDbzm/s6LpUaBD3t5GV7i+HcDM7VONAxyakdhEVwaLjUSyQJDbyPUs6ROzdJ
	jjGuW5qTjVgg1D1aInPWcYeYmfyv9oO/MvVu7W9fkrm2h5wPOrtJWrRVZCPNGOF6b1ztUk2hHIY+1
	kTgOaKllcheJ2Mhjjjk5Z6gbRVL2RuL5H3pMlx2cAnad0WV3NKdNdCsLOMsl6Ow15uQhonUs9byNE
	srhn9fnPkyfRP5J1AzUOewCVi+056DChOn6BxprV1Km4S1iDCqDkvKrRlG5YB5uTs57D2Xncjlnaj
	nUCK1GawANGLjQJn7Tzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM295-0001zN-7c; Wed, 08 Apr 2020 04:16:59 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM28u-0001ip-6w
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 04:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586319408; x=1617855408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nsV+avJbm6nRfvInPjU6S6jndiW7tihwT3tCaAPB2m0=;
 b=J9Vin9Wx2eyIix6kUs7tSMcvYjcWL+odPtIO2DqUtaRl6Fek7R94XOF9
 onWAnR4bQuUbK9+RA46kAf9LceRNGIDjK9QGBCCL0cXg8TzwMeElhvKsA
 czVZCvz+oPRYqSoSpTmMZ/wDKe0SIdLqnscKJ4SWkrGAODVvFtE/W03Vw
 lDdg5DS48qYEyS0wXuWwd7fUv1XCSpatja92OAH3HWBLfbFHoNJdQA80a
 iYWSnbEu42qGkbgfWs+km8I6iYveLjSkwVgK3iNda4JldywPHfLYB6bDr
 me09leFdeMnz27eFyAIRk64siJN3JlSBg7W3UaI9HjpCpThVOzqxk+nS8 A==;
IronPort-SDR: jFRyEWPc+PECaOp6Pj1Kj2mYK6RMMXEGADL2SZj6m0mt4gIC+kkSFz1TJYK2ZQG2lU+sCZQGYa
 iYa36QhKF7H1z7pUPfKUXuxAl7aczAyEtb0ohuhlaytcWWyGMXZ3V5qcZiYJNhRbn6f+Co9fkE
 JkqK77FqvyjD46qrxhNGGWDjP0Mcss6oAuANEl7cQA2rSdJkwp8x+2bHBhHpJR4GvIFBaGsMpU
 bRhBN2m5fCxEKB+mqez9mkaa+O+mTDUOZ/4HbNLMAvFHQODoM/tT03SoBbRM/K/xsy0cHKBlHh
 +6o=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; d="scan'208";a="136283908"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 12:16:48 +0800
IronPort-SDR: 9qdEmy/Xb8d8ioPe7Wubfr7i7K1wqevN/G2nkP/dkir9h81Z4EjnyEHC7NI+jFXkgOPVoBbbae
 XmEmv3mWvhkV3ZHjkIEgYj6yrx5HGeqs2uwhs1n3Is92UXxrF9ZVuj81dAnwo3js8KLfuVjf26
 ItUSIc87HmnFbzRaq0u+U8p3hRIskNFCAy9EDuOYk4FMgG8wmdGwo6FXwbMfq67lbc5erCGFZB
 ik+XQNP+08UPW7bHhQdyOEfVyUFfuTApllUHLUhyuLfv/Y16I7r7kbTSbEstpU49HboxXOikE2
 r94dkvGIqpB1ITU7qSSl4vLo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 21:07:29 -0700
IronPort-SDR: yO/SorZeNx5vojVUVlh1qjcO7L1xhu5oZ35VXyHBObN2WTfHTa3o7ByWqfWimX/FWEFbEMOyhc
 y7GBa5EEQ4VldjtZuSgoVsNSRY1qplEffbIH6LS8uK/emAqhSS+2D0E4M9AacK962ddyHtcGU1
 5ANtzolzU6GOVHiwga+ifOwxsEnok4wxhdqUMaF37wQh8e9PfoQVkZNox9GPvTrozLLoHKT1Qf
 09c/aplHvsjbvEVWHaq3yTUg26YzW0ya1YRyL3d6amOlRMmZoTx6SnIC1ErWfkZuU2lx6NIa7j
 mp4=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2020 21:16:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Date: Tue,  7 Apr 2020 21:16:33 -0700
Message-Id: <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_211648_310968_B6D2748B 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: ailiop@suse.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The change of size detection on the target should generate the AEN to
the host. Right now there is no mechanism that allows us to add
callbacks for the block and file backend so that we will get the
notification for change of the size for block device and file backend.
This patch adds a simple per namespace thread that checks for the size
change and generates AEN when needed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c   |  5 +----
 drivers/nvme/target/core.c        | 34 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  9 +++++++-
 drivers/nvme/target/io-cmd-file.c | 15 +++++++++-----
 drivers/nvme/target/nvmet.h       |  6 ++++--
 5 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ba01d8e6e9c9..1e4ce77f1ac4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -468,10 +468,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (!ns)
 		goto done;
 
-	if (ns->bdev)
-		nvmet_bdev_ns_revalidate(ns);
-	else
-		nvmet_file_ns_revalidate(ns);
+	nvmet_ns_revalidate(ns);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 576de773b4db..d851b8da0ef0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -9,6 +9,7 @@
 #include <linux/rculist.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
+#include <linux/delay.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -514,6 +515,33 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
+bool nvmet_ns_revalidate(struct nvmet_ns *ns)
+{
+	if (ns->bdev)
+		return nvmet_bdev_ns_revalidate(ns);
+
+	return nvmet_file_ns_revalidate(ns);
+}
+
+static int nvmet_ns_resize_thread(void *data)
+{
+	struct nvmet_ns *ns = (struct nvmet_ns *) data;
+
+	while (!kthread_should_park()) {
+		if (nvmet_ns_revalidate(ns)) {
+			mutex_lock(&ns->subsys->lock);
+			nvmet_ns_changed(ns->subsys, ns->nsid);
+			mutex_unlock(&ns->subsys->lock);
+		}
+		schedule();
+		/* XXX: use better sleep wakeup mechanism */
+		msleep(100);
+	}
+
+	kthread_parkme();
+	return 0;
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -572,6 +600,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
+	ns->resize_thread = kthread_create(nvmet_ns_resize_thread, ns,
+					  "nvmet_ns_resize%s/%d",
+					  ns->device_path, ns->nsid);
+	wake_up_process(ns->resize_thread);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
@@ -593,6 +625,8 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	if (!ns->enabled)
 		goto out_unlock;
 
+	kthread_park(ns->resize_thread);
+	kthread_stop(ns->resize_thread);
 	ns->enabled = false;
 	list_del_rcu(&ns->dev_link);
 	if (ns->nsid == subsys->max_nsid)
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0427e040e3dd..e4791e57d397 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -75,9 +75,16 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
-void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 {
+	bool change;
+
+	mutex_lock(&ns->subsys->lock);
+	change = ns->size != i_size_read(ns->bdev->bd_inode) ? true : false;
 	ns->size = i_size_read(ns->bdev->bd_inode);
+	mutex_unlock(&ns->subsys->lock);
+
+	return change;
 }
 
 static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 14364383d2fe..01d3d150585d 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -80,15 +80,20 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	return ret;
 }
 
-void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
+	struct path *f_path = &ns->file->f_path;
+	bool change = false;
 	struct kstat stat;
 
-	if (vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
-			AT_STATX_FORCE_SYNC))
-		return;
+	mutex_lock(&ns->subsys->lock);
+	if (vfs_getattr(f_path, &stat, STATX_SIZE, AT_STATX_FORCE_SYNC) == 0) {
+		change = ns->size != stat.size ? true : false;
+		ns->size = stat.size;
+	}
+	mutex_unlock(&ns->subsys->lock);
 
-	ns->size = stat.size;
+	return change;
 }
 
 static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a3ffdcca4efb..3236eae00cae 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -54,6 +54,7 @@ struct nvmet_ns {
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
 	struct file		*file;
+	struct task_struct	*resize_thread;
 	bool			readonly;
 	u32			nsid;
 	u32			blksize_shift;
@@ -487,8 +488,9 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
-void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
-void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
