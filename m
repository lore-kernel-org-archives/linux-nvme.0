Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EAC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20ojJh0db+c2m9puBHfg5KV64iY/6xj3vJRErkM0IFg=; b=nZNHqD+vRNd8ES4/ZaF8bxSCea
	NoPcBj44ZTfAh/ZCTDG1TfM+CMo4a+s0CeqEIjp0lna/T6na7VZ7Bfg1ftDDYMTimiwMevbdaWfNR
	lJ69A5iPugg84DmWxXzpPMozcufIlOZ7vt8+5mnexgZfKIkzOaUr7WL5j6MDW5XOLN81m7XII7nrS
	8oXeP2dnjjgbHW5IgImIDohVB4V+7MLVT/cSLAF/NKwaGJv2aMkZ1DAb/cAK24SAvCaJUfh2wICwi
	T8Sybclf2mS7ZE6puDmRw5Y10J1yPSZ7a+jdGDh2PWxpPbK5Q5ClF9uHj9zyWYN6Oq0Bs4k1Nw347
	R9f2OtOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIoA-00DnBy-2B;
	Wed, 13 Dec 2023 06:33:26 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIo7-00Dn8u-2G
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 06:33:25 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyP5LFX_1702449195;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyP5LFX_1702449195)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 14:33:19 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/5] nvmet: relocate the cntlid_ida to the internal of subsystem
Date: Wed, 13 Dec 2023 14:32:51 +0800
Message-Id: <1702449172-8920-5-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_223323_916356_1D6EC4E9 
X-CRM114-Status: GOOD (  10.42  )
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

As per the NVMe specification, the cntlid must be unique within an NVM
subsystem. Therefore, the cntlid_ida should be moved internally within
the subsystem.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c  | 8 ++++----
 drivers/nvme/target/nvmet.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d26aa30..c4cff43 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -21,7 +21,6 @@
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
-static DEFINE_IDA(cntlid_ida);
 
 struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
@@ -1425,7 +1424,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_changed_ns_list;
 
-	ret = ida_alloc_range(&cntlid_ida,
+	ret = ida_alloc_range(&subsys->cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
@@ -1486,7 +1485,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_destroy_auth(ctrl);
 
-	ida_free(&cntlid_ida, ctrl->cntlid);
+	ida_free(&subsys->cntlid_ida, ctrl->cntlid);
 
 	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
@@ -1598,6 +1597,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	xa_init(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
+	ida_init(&subsys->cntlid_ida);
 
 	return subsys;
 
@@ -1619,6 +1619,7 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	xa_destroy(&subsys->namespaces);
 	nvmet_passthru_subsys_free(subsys);
+	ida_destroy(&subsys->cntlid_ida);
 
 	kfree(subsys->subsysnqn);
 	kfree(subsys->model_number);
@@ -1692,7 +1693,6 @@ static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
-	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8aceb..af27243 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -291,6 +291,8 @@ struct nvmet_subsys {
 #ifdef CONFIG_BLK_DEV_ZONED
 	u8			zasl;
 #endif /* CONFIG_BLK_DEV_ZONED */
+
+	struct ida		cntlid_ida;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-- 
1.8.3.1


