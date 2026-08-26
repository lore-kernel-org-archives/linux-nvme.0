Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B27AC61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 06:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:Content-Type:To:
	References:Message-Id:Subject:From:In-Reply-To:Content-Transfer-Encoding:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ikuFG/PjRl+tEVGm8h/uhZymzzHiw34XqavQX15+sI=; b=4iXyPNRpB00hJ46Dtg8DK0zDbf
	BMRMoLZjxXBLWZlSeck3tjcO6H0PWxfzidiFaW5sEfAZha/0UsSiGvZ1H6I/ObFYSg/MEl8qUF/hj
	tSRTkmoat4o6nGenCPb2HjXFRc4wDh/9RO2Lw0oLoPBEsG7W903Y91Rx6FtiQH/poYL4VzyB6+H42
	4oiNsFDBMaRrHhtPZMkmMudX2XWoZpJflbIuT0yz0b4IDXYF7cFahbX3iNPqniFaEe1KUWtZDCui3
	JTTbnS4pcSHySKJWV6ZFiYw3m5lywhvMebleI9x0q5Q6hqQVac3uCFX6dBOClzMRW8b9H3O0RJdvh
	ejKt/c0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz6wq-00000001xQH-0FzQ;
	Wed, 26 Aug 2026 06:17:20 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz6wn-00000001xPe-2HLf
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 06:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787725032; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=0ikuFG/PjRl+tEVGm8h/uhZymzzHiw34XqavQX15+sI=;
 b=loBPhmVZMPsOrseykj6WTPgk6tMSQQ8eMU4toM1WTgKBPvYLrFz3mbYUHNMuEE4/t3JpHx
 moQkudRmNlR0DqUixGUhcmEEvveMXoVpFgqKF/vAEWivGq43/AETLZIdaU2cx+7Q9Vyo2c
 rXC/ESLesc7XNPpgkU/liujtlesMb45TZMjYguIp8T4E5gqcR4fh09NTP/lq4cIKzL1HgR
 b2EdNjWfRMozknLy2kO1s2YRyXh03ZaJNKcUwCtW8Jm4XjtoetimfysXhsiY+eXn/y3Ab8
 KKQ/7stFRHYDXzbZZlWMRcUew7z9vCmwzSbn4g6qiOor388VHwVtG/O+HRpBhg==
Date: Wed, 26 Aug 2026 14:15:45 +0800
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260826061546.56006-1-changfengnan@bytedance.com>
From: "Fengnan Chang" <changfengnan@bytedance.com>
Subject: [PATCH v2 1/2] nvme-pci: return completion count from nvme_poll_cq
Message-Id: <20260826061546.56006-2-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
References: <20260826061546.56006-1-changfengnan@bytedance.com>
X-Lms-Return-Path: <lba+26a8e84e6+333fca+lists.infradead.org+changfengnan@bytedance.com>
To: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<jun1.zeng@intel.com>, <anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: <guzebing@bytedance.com>, "Fengnan Chang" <changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_231717_693459_E0BA52EA 
X-CRM114-Status: GOOD (  11.21  )
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

Return the number of completions consumed by nvme_poll_cq() instead of
a boolean. Existing callers still treat zero vs non-zero as before;
nvme_poll() keeps returning 0/1 via a bool local.

Extract nvme_irq_complete_batch() from nvme_irq() so the adaptive
handler in the next patch can reuse the batch completion path.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 drivers/nvme/host/pci.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b537..620d0430601e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1606,13 +1606,12 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
-			        struct io_comp_batch *iob)
+static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
+					struct io_comp_batch *iob)
 {
-	bool found = false;
+	unsigned int found = 0;
 
 	while (nvme_cqe_pending(nvmeq)) {
-		found = true;
 		/*
 		 * load-load control dependency between phase and the rest of
 		 * the cqe requires a full read memory barrier
@@ -1620,6 +1619,7 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 		dma_rmb();
 		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
+		found++;
 	}
 
 	if (found)
@@ -1627,17 +1627,22 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 	return found;
 }
 
+static irqreturn_t nvme_irq_complete_batch(struct io_comp_batch *iob,
+					   unsigned int completions)
+{
+	if (!completions)
+		return IRQ_NONE;
+	if (!rq_list_empty(&iob->req_list))
+		nvme_pci_complete_batch(iob);
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 	DEFINE_IO_COMP_BATCH(iob);
 
-	if (nvme_poll_cq(nvmeq, &iob)) {
-		if (!rq_list_empty(&iob.req_list))
-			nvme_pci_complete_batch(&iob);
-		return IRQ_HANDLED;
-	}
-	return IRQ_NONE;
+	return nvme_irq_complete_batch(&iob, nvme_poll_cq(nvmeq, &iob));
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
-- 
2.39.5 (Apple Git-154)

