Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8545C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMLr4oSSvAjbOxODE6vnuC4TP1HpMIvUzIZbx9+TN5I=; b=i9UjQspD6VAy7OrbVKGP1KBHSl
	ZFrHalcQlRVaOINl3dB71C8m4/yKz/LtHX8iLkcAqaYOIHiVlrO86df4IQc70Kti32zUVu5YX4WPG
	zigbbJ5DXDMD+uPZD2k2khZ3kKuAXB7tf1+lGsoY/7cBvJfCBeMcZZKmxFUEJOEzoCY6cknlhNcZp
	PIrgZWEfaoEPn5LMcDk2/g4rfaYFeS0nIieZqJzL3szMVjxuFhPbljbxVZydXUOJIOA7iqCZOEn8v
	Gz+GGQhkP1ob4DSvBU2BPYDPK42FfCwNIW7JTPZT+5Er1QbuhQs6bNSXa0RypXb8o3xxtN4xBWAHD
	Jnw3UT/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRf-009yLr-1h;
	Mon, 18 Dec 2023 11:05:59 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRa-009yE3-0k
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:05:56 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VylU0Yw_1702897538;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VylU0Yw_1702897538)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 19:05:42 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 1/3] nvmet: change get_max_queue_size param to nvmet_sq
Date: Mon, 18 Dec 2023 19:05:31 +0800
Message-Id: <1702897533-49685-2-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_030554_410800_CB97775D 
X-CRM114-Status: GOOD (  10.37  )
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

The max queue size is an atrribute private to each transport,
use nvmet_sq to let transport get it's own private queue and
port.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c  | 6 +++---
 drivers/nvme/target/nvmet.h | 2 +-
 drivers/nvme/target/rdma.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165..1efd46b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1213,7 +1213,7 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new)
 	mutex_unlock(&ctrl->lock);
 }
 
-static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
+static void nvmet_init_cap(struct nvmet_ctrl *ctrl, struct nvmet_sq *nvmet_sq)
 {
 	/* command sets supported: NVMe command set: */
 	ctrl->cap = (1ULL << 37);
@@ -1223,7 +1223,7 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
 	if (ctrl->ops->get_max_queue_size)
-		ctrl->cap |= ctrl->ops->get_max_queue_size(ctrl) - 1;
+		ctrl->cap |= ctrl->ops->get_max_queue_size(nvmet_sq) - 1;
 	else
 		ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 
@@ -1411,7 +1411,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
-	nvmet_init_cap(ctrl);
+	nvmet_init_cap(ctrl, req->sq);
 	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
 
 	ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8aceb..ba8ed2e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -352,7 +352,7 @@ struct nvmet_fabrics_ops {
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
-	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
+	u16 (*get_max_queue_size)(const struct nvmet_sq *nvmet_sq);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca..8a728c5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2000,7 +2000,7 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 	return NVMET_RDMA_MAX_MDTS;
 }
 
-static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
+static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_sq *nvmet_sq)
 {
 	return NVME_RDMA_MAX_QUEUE_SIZE;
 }
-- 
1.8.3.1


