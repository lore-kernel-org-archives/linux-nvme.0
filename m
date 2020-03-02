Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECCC3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 19:46:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EC024673
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 19:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UBAVGtpE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyleZpg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EC024673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xD8gnRzl8srDaSCMNWNQ0OIHL5s7cx2s/Z/YkKbVypQ=; b=UBAVGtpEpqbAZp
	NCvpFuLwT0hNgaQS+clbPV4m/dwnrMVDHjYY63ARY7FFtMQ4GLp4sJzhNGmRnkQvsf3sH6TGZ3WGc
	MwsCUydr6aiMYvus3WZ2pTlqNLavMUz8DMcEs8ys+FIWCl+usXco0CDqiHcp4Ashi7qpzcWwtIlkb
	hH5V/KZ63yLhOT/pXdojz+biQremzkt7gMyRo0WoRXz/rcuf1A+Vx2fefyGOkJZEznWr7LIxoyPQr
	OphVR0vWeIBaQKQpFTLPxrIFAPIlBkJmac8am9iktp1EXOyDviE5wmR83N7BekO3+uWkXclMvNEDw
	9YXrspSP/O0OyfQlyctg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8r1V-0000k6-Ow; Mon, 02 Mar 2020 19:46:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8r1C-0000Pc-RY
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 19:46:24 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF62E2465D;
 Mon,  2 Mar 2020 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583178382;
 bh=5xYx/NLTQuFbEQPJGYbNJUumTsrt59aM8zfhy+KdmD8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TyleZpg9F8Wp/NLMxvgf7O2r3RrkLajQZg0It+WPuzL2a/JUvxWzoJvdNO0w+lGVu
 dvmuIp0T5kiEnS7r6hFj1cFdpDlHyKMHzpwXOeiQk6CIMtnxyKYpylvazSzp4iG7yQ
 vTsX9AY+eR3DQZAsUC2Dr6gXkcSTcMRqJX2DrWnY=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 1/2] nvme-pci: Remove tag from process cq
Date: Mon,  2 Mar 2020 11:46:15 -0800
Message-Id: <20200302194616.2432-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302194616.2432-1-kbusch@kernel.org>
References: <20200302194616.2432-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_114622_942368_8B4CE69F 
X-CRM114-Status: GOOD (  13.26  )
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
 drivers/nvme/host/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index da392b50f73e..db84283f2a5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -991,14 +991,13 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
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
+		++found;
 		nvme_update_cq_head(nvmeq);
 	}
 	*end = nvmeq->cq_head;
@@ -1019,7 +1018,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	 * the irq handler, even if that was on another CPU.
 	 */
 	rmb();
-	nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_process_cq(nvmeq, &start, &end);
 	wmb();
 
 	if (start != end) {
@@ -1042,7 +1041,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  * Poll for completions any queue, including those not dedicated to polling.
  * Can be called from any context.
  */
-static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
+static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	u16 start, end;
@@ -1055,11 +1054,11 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
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
 
@@ -1077,7 +1076,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
-	found = nvme_process_cq(nvmeq, &start, &end, -1);
+	found = nvme_process_cq(nvmeq, &start, &end);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
 	nvme_complete_cqes(nvmeq, start, end);
@@ -1255,7 +1254,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Did we miss an interrupt?
 	 */
-	if (nvme_poll_irqdisable(nvmeq, req->tag)) {
+	if (nvme_poll_irqdisable(nvmeq) &&
+	    blk_mq_request_completed(req)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
@@ -1398,7 +1398,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 	else
 		nvme_disable_ctrl(&dev->ctrl);
 
-	nvme_poll_irqdisable(nvmeq, -1);
+	nvme_poll_irqdisable(nvmeq);
 }
 
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
@@ -2238,7 +2238,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 		/* handle any remaining CQEs */
 		if (opcode == nvme_admin_delete_cq &&
 		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
-			nvme_poll_irqdisable(nvmeq, -1);
+			nvme_poll_irqdisable(nvmeq);
 
 		sent--;
 		if (nr_queues)
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
