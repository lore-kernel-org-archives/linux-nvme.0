Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC8EC3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36B824673
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="chuz0dmD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0PlzzJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36B824673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=okVKUaT9obsnVB7zUUw3QobHzVNwtGZ7Bjx/P94wkWw=; b=chuz0dmDut/6Ia
	f+8Xa10eVNUtdBFf0jUOQuA4aqVzy6BG/VZFCSs7Cz9BQrzyWLVIDNI3Bl+p+p8wluHxcmbE8MH6B
	H3rAUcnfSmQ5MJCHOL+H2hSPJ1//8rvzIMdjiHCf1V89bneuGc6k4Gh54gdAT6yXAtnheVELVCpDk
	xW3+PUylKwUpBHXWpZlL5OKpvNM2iYoRoIMDaJupboSWxHGLsrcZQlo1TqlTgRhWAQ9WYHUNo4w0K
	hgl5hUn6upOpDkI+8Hg9rCOlKKss6PYM2N8jPgR4hImO/k7+5RX2KQw7W4xxr0UbtAhPr2uKGgj08
	BCX2iMfKDUgh6tvRpsCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9YWE-0000Xw-Db; Wed, 04 Mar 2020 18:13:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9YVr-0000Ft-00
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 18:12:56 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 561E624658;
 Wed,  4 Mar 2020 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583345574;
 bh=B3JJQaFy3RD1frmBJutSQYtl6Q1YFj/GJlWqeAjUduY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F0PlzzJVgx9ZQTakDKCZBjXjSxixB888fDqbdZXkSJJdJukPh3EEfKrUedy+pxySk
 qFEcUpyYKZZBXp2d68hpVug5F7mCeIAvaGAklLL0FnJiuLTBteRG7RcyUb7ZFSKh8z
 ODFDhHCMvV1ExAASCMW9+K37rBdArUOOjEXwDDVM=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCHv2 2/3] nvme-pci: Remove two-pass completions
Date: Wed,  4 Mar 2020 10:12:45 -0800
Message-Id: <20200304181246.481835-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304181246.481835-1-kbusch@kernel.org>
References: <20200304181246.481835-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_101255_071517_7331796F 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: Keith Busch <kbusch@kernel.org>, bijan.mottahedeh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Completion handling had been done in two steps: find all new completions
under a lock, then handle those completions outside the lock. This was
done to make the locked section as short as possible so that other
threads using the same lock wait less time.

The driver no longer shares locks during completion, and is in fact
lockless for interrupt driven queues, so the optimization no longer
serves its original purpose. Replace the two-pass completion queue
handler with a single pass that completes entries immediately.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 42 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98d8ddd7aa0f..02f22c63adcf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -971,15 +971,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	nvme_end_request(req, cqe->status, cqe->result);
 }
 
-static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
-{
-	while (start != end) {
-		nvme_handle_cqe(nvmeq, start);
-		if (++start == nvmeq->q_depth)
-			start = 0;
-	}
-}
-
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
 	if (++nvmeq->cq_head == nvmeq->q_depth) {
@@ -988,19 +979,17 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 	}
 }
 
-static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-				  u16 *end)
+static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 {
 	int found = 0;
 
-	*start = nvmeq->cq_head;
 	while (nvme_cqe_pending(nvmeq)) {
 		found++;
+		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
-	*end = nvmeq->cq_head;
 
-	if (*start != *end)
+	if (found)
 		nvme_ring_cq_doorbell(nvmeq);
 	return found;
 }
@@ -1009,21 +998,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 	irqreturn_t ret = IRQ_NONE;
-	u16 start, end;
 
 	/*
 	 * The rmb/wmb pair ensures we see all updates from a previous run of
 	 * the irq handler, even if that was on another CPU.
 	 */
 	rmb();
-	nvme_process_cq(nvmeq, &start, &end);
+	if (nvme_process_cq(nvmeq))
+		ret = IRQ_HANDLED;
 	wmb();
 
-	if (start != end) {
-		nvme_complete_cqes(nvmeq, start, end);
-		return IRQ_HANDLED;
-	}
-
 	return ret;
 }
 
@@ -1042,7 +1026,6 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
-	u16 start, end;
 	int found;
 
 	/*
@@ -1052,29 +1035,27 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	 */
 	if (test_bit(NVMEQ_POLLED, &nvmeq->flags)) {
 		spin_lock(&nvmeq->cq_poll_lock);
-		found = nvme_process_cq(nvmeq, &start, &end);
+		found = nvme_process_cq(nvmeq);
 		spin_unlock(&nvmeq->cq_poll_lock);
 	} else {
 		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
-		found = nvme_process_cq(nvmeq, &start, &end);
+		found = nvme_process_cq(nvmeq);
 		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 	}
 
-	nvme_complete_cqes(nvmeq, start, end);
 	return found;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
-	u16 start, end;
 	bool found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq, &start, &end);
+	found = nvme_process_cq(nvmeq);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -1406,13 +1387,10 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
  */
 static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 {
-	u16 start, end;
 	int i;
 
-	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
-		nvme_process_cq(&dev->queues[i], &start, &end);
-		nvme_complete_cqes(&dev->queues[i], start, end);
-	}
+	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
+		nvme_process_cq(&dev->queues[i]);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
