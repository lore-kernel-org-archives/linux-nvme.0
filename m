Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17AC3F2D1
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1181F24673
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sKim8d8c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxcOLHOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1181F24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NhxVxsdjA8vfKv/b/Ev5gJR2UOQ+J9Mfu55usCoH+j8=; b=sKim8d8cgW8jKK
	NgHGLirsfHEwz5hFm36oNupOtsdf/+TQKe6ED/oQC8cBj0h6VoGXGDAX0Ok1IVWwQJ706Vd1rARp/
	rBKQpmUVdtwfKsVGbpYc+UA050xsv5yPM2dUTkHUNdXfIgXeMNdSoRhOBK7KB9KIctfS9RWa+3B9C
	cO272JIgvUdX2eLAzGEbXkAeMTX5it2gUgrbbVxb1FRwunB/CvyJx5yzCx5EN6kVHVJnYNJkfRL5x
	T5BC+4/pxH3lj94MSDtJZMFhRH/RgcQ9fmb+zxttEm4vp6QMF5Nd/MXwHrq9YLZFI20qbv4klUkHe
	FlbJhjroc2HeVqSWaAMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9YVx-0000JW-Iq; Wed, 04 Mar 2020 18:13:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9YVq-0000FU-DM
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 18:12:55 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BB5032465D;
 Wed,  4 Mar 2020 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583345574;
 bh=vFYlJgeUdMlpIyIq8jWedykXrECzp1M+l5WCMAKLt3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jxcOLHOLs8Kid249isxoBEkfjEFu8qBUWSwq7QvY5NT8fjisJqXOhHPCqZ/qFrGAw
 2jbUadEiZnNMw08geHan0grxwps32H+httsMoaK4UO8BtJ4fIdTCuCKUNR1aYpBWFk
 cAQxeu0Uvl0n1RuIsQxiAQ67RxrBQ5bk1rlDvNLs=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCHv2 1/3] nvme-pci: Remove tag from process cq
Date: Wed,  4 Mar 2020 10:12:44 -0800
Message-Id: <20200304181246.481835-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304181246.481835-1-kbusch@kernel.org>
References: <20200304181246.481835-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_101254_486308_A3E85420 
X-CRM114-Status: GOOD (  13.87  )
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

The only user for tagged completion was for timeout handling. That user,
though, really only cares if the timed out command is completed, which
we can safely check within the timeout handler.

Remove the tag check to simplify completion handling.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cdc9b6149d38..98d8ddd7aa0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,14 +989,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 }
 
 static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
-				  u16 *end, unsigned int tag)
+				  u16 *end)
 {
 	int found = 0;
 
 	*start = nvmeq->cq_head;
 	while (nvme_cqe_pending(nvmeq)) {
-		if (tag == -1U || nvmeq->cqes[nvmeq->cq_head].command_id == tag)
-			found++;
+		found++;
 		nvme_update_cq_head(nvmeq);
 	}
 	*end = nvmeq->cq_head;
@@ -1017,7 +1016,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	 * the irq handler, even if that was on another CPU.
 	 */
 	rmb();
-	nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_process_cq(nvmeq, &start, &end);
 	wmb();
 
 	if (start != end) {
@@ -1040,7 +1039,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  * Poll for completions any queue, including those not dedicated to polling.
  * Can be called from any context.
  */
-static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
+static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	u16 start, end;
@@ -1053,11 +1052,11 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 	 */
 	if (test_bit(NVMEQ_POLLED, &nvmeq->flags)) {
 		spin_lock(&nvmeq->cq_poll_lock);
-		found = nvme_process_cq(nvmeq, &start, &end, tag);
+		found = nvme_process_cq(nvmeq, &start, &end);
 		spin_unlock(&nvmeq->cq_poll_lock);
 	} else {
 		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
-		found = nvme_process_cq(nvmeq, &start, &end, tag);
+		found = nvme_process_cq(nvmeq, &start, &end);
 		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 	}
 
@@ -1075,8 +1074,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq, &start, &end, -1);
-	nvme_complete_cqes(nvmeq, start, end);
+	found = nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	return found;
@@ -1253,7 +1251,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Did we miss an interrupt?
 	 */
-	if (nvme_poll_irqdisable(nvmeq, req->tag)) {
+	nvme_poll_irqdisable(nvmeq);
+	if (blk_mq_request_completed(req)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
@@ -1396,7 +1395,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 	else
 		nvme_disable_ctrl(&dev->ctrl);
 
-	nvme_poll_irqdisable(nvmeq, -1);
+	nvme_poll_irqdisable(nvmeq);
 }
 
 /*
@@ -1411,7 +1410,7 @@ static void nvme_reap_pending_cqes(struct nvme_dev *dev)
 	int i;
 
 	for (i = dev->ctrl.queue_count - 1; i > 0; i--) {
-		nvme_process_cq(&dev->queues[i], &start, &end, -1);
+		nvme_process_cq(&dev->queues[i], &start, &end);
 		nvme_complete_cqes(&dev->queues[i], start, end);
 	}
 }
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
