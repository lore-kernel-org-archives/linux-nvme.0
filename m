Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8A5C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9QDE+1P3Sur1yeYK6MJD0q30mdcMZTwEgdfcgwAg2hY=; b=DomJVgbJbyQpXwZ5X4t6kDbzVT
	wUBGpfagCTqOLz50ywEtFyps+RO1kVNgjWf3reKaEUNASE6j00VK4DCoH1Jw+Vq+GqIup6EUQYGOT
	V1wtJgoSk/oi0JPb2nRIVkVmFpwsnqQejBip2EEsC1hLX3k6WxfJj0C6zHjlltPosVq/bcYf3kG7t
	Nnr1drNXhmnPgPpFYrK5gVWs3OUGv4kKcX7wJfT27y/pjhEE9/M6dFcuQAhBgdnszVW2CRwKcCzM8
	OfAJJ3jfJx4IYiyP7qtJb1dTs3PM1FrMk1aZLC3B0sxElCDnH54n5XfZ883q4M0HHfqt39G9xc/hU
	WdUf/21Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRe-009yLS-2A;
	Mon, 18 Dec 2023 11:05:58 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFBRZ-009yGQ-2n
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:05:55 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VylU0a1_1702897543;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VylU0a1_1702897543)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 19:05:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [RFC PATCH 2/3] nvmet: rdma: utilize ib_device capability for setting max_queue_size
Date: Mon, 18 Dec 2023 19:05:32 +0800
Message-Id: <1702897533-49685-3-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_030554_084898_FE1479BE 
X-CRM114-Status: GOOD (  10.97  )
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

Respond with the smaller value between 1024 and the ib_device's
max_qp_wr as the RDMA max queue size.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/rdma.c | 7 ++++++-
 include/linux/nvme-rdma.h  | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 8a728c5..c3884dd 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2002,7 +2002,12 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 
 static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_sq *nvmet_sq)
 {
-	return NVME_RDMA_MAX_QUEUE_SIZE;
+	struct nvmet_rdma_queue *queue =
+		container_of(nvmet_sq, struct nvmet_rdma_queue, nvme_sq);
+	int max_qp_wr = queue->dev->device->attrs.max_qp_wr;
+
+	return (u16)min_t(int, NVMET_QUEUE_SIZE,
+			  max_qp_wr / (NVME_RDMA_SEND_WR_FACTOR + 1));
 }
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 4dd7e6f..c19858b 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -8,6 +8,8 @@
 
 #define NVME_RDMA_MAX_QUEUE_SIZE	128
 
+#define NVME_RDMA_SEND_WR_FACTOR 3  /* MR, SEND, INV */
+
 enum nvme_rdma_cm_fmt {
 	NVME_RDMA_CM_FMT_1_0 = 0x0,
 };
-- 
1.8.3.1


