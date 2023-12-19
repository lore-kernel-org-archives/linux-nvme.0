Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D844C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RF4funJdY3I5L1hyz6Yl7X0EJ4ldV9FC9zZdBbPXrU=; b=vd6+6KOVoC4qBYul3LeAMShjvn
	MP5H0lKIv8PL1iiM1yNrm6XVVqlQmQqhe9vDc2BuGyxtn5TruswsC9pJ9nnwiCA9T2HleApKRctKr
	Q3O1Wmfl2uH7FOOan6jIiGdlLX1k60915bNU/ZxP6N/vAcgGsSDvTitJTqAv/DMfwbzKB7ZiXk5BQ
	mNlFNwVvL44vkkghq7DrLpyWojOeVuzFKkn1/Io5y+LIgijkLFoxhckubO85p+UPQGroZ0kxGm+3b
	uP2bGRFwXXw1KREwZtT58YrFWnK2DzJR8rqKsNasqKT8hWtxfA8SkZ2g1kAvSjHekb06e7vpJNdC4
	lol42yoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUan-00D6mH-1P;
	Tue, 19 Dec 2023 07:32:41 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUak-00D6lN-2a
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 07:32:40 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VypwY7n_1702971150;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VypwY7n_1702971150)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 15:32:35 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kbusch@kernel.org,
	kch@nvidia.com,
	axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [RFC PATCH V2 1/2] nvmet: rdma: utilize ib_device capability for setting max_queue_size
Date: Tue, 19 Dec 2023 15:32:24 +0800
Message-Id: <1702971145-111009-2-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_233238_995501_62CFDE01 
X-CRM114-Status: GOOD (  12.84  )
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
 drivers/nvme/target/rdma.c | 17 ++++++++++++++++-
 include/linux/nvme-rdma.h  |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca..d546203 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2002,7 +2002,22 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 
 static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
 {
-	return NVME_RDMA_MAX_QUEUE_SIZE;
+	struct nvmet_rdma_queue *queue;
+	struct nvmet_port *nport = ctrl->port;
+	int max_qp_wr = 0;
+
+	/* Here nvmet_ctrl's port is already set. */
+	mutex_lock(&nvmet_rdma_queue_mutex);
+	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
+		if (queue->port == nport) {
+			max_qp_wr = queue->dev->device->attrs.max_qp_wr;
+			break;
+		}
+	}
+	mutex_unlock(&nvmet_rdma_queue_mutex);
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


