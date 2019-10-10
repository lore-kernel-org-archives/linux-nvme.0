Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1D0ECE58E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:30:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94B920B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g5/ulNw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94B920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6TK+qSxIfTl94QwXbILNm6lZMtYHVFUMw3dM3Dj4bV8=; b=g5/ulNw4TxJ0c511d19z8TM6fF
	EpVcPfTLU0s8g6sXZpc3NiDj/5gxjvxMlaV+qpmk3b+Q5rcXufpiaRWbeYzzNR97CFkzFjZ5bvf3j
	zE1wP+lGUnzWPU8pMlWt8HOqFswMnuN/QbG73B9yrHJsy9g/GDqhzWqMiRaIzaZ4/NTcmKpYzsO1R
	8GYiGIWohlg6dLFrbqgLc981/jz89ugNzhdg9NCUeqC8pbvbwA9UZMOE+spsHKCK0W74sm8IGNMPr
	ibA3jR4fsbgvASNBrhPnm88rRZ4U6lxGfAsaoEBjSv3hGbXdPD94y7T49x3q9UfO+A139x4f/W7JU
	pprOaxZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIYWK-0007ju-Uq; Thu, 10 Oct 2019 13:30:20 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIYUX-00057v-KH
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 13:28:34 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 10 Oct 2019 15:28:20 +0200
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9ADSKfI006526;
 Thu, 10 Oct 2019 16:28:20 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Subject: [PATCH 1/8] nvme: Introduce nvme_is_aen_req function
Date: Thu, 10 Oct 2019 16:28:13 +0300
Message-Id: <1570714100-15520-2-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1570714100-15520-1-git-send-email-maxg@mellanox.com>
References: <1570714100-15520-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_062830_061791_789792DC 
X-CRM114-Status: UNSURE (   8.37  )
X-CRM114-Notice: Please train this message.
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
Cc: israelr@mellanox.com, james.smart@broadcom.com, shlomin@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

This function improves code readability and reduces code duplication.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/nvme.h   | 5 +++++
 drivers/nvme/host/pci.c    | 3 +--
 drivers/nvme/host/rdma.c   | 4 ++--
 drivers/nvme/host/tcp.c    | 4 ++--
 drivers/nvme/target/loop.c | 4 ++--
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 38a83ef5..6fa2b6e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,6 +445,11 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 	put_device(ctrl->device);
 }
 
+static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
+{
+	return (!qid && command_id >= NVME_AQ_BLK_MQ_DEPTH);
+}
+
 void nvme_complete_rq(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 78e4038..f8f76a9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -967,8 +967,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvmeq->qid == 0 &&
-			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
+	if (unlikely(nvme_is_aen_req(nvmeq->qid, cqe->command_id))) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4d28016..154fa4e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1501,8 +1501,8 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_rdma_queue_idx(queue) == 0 &&
-			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH))
+	if (unlikely(nvme_is_aen_req(nvme_rdma_queue_idx(queue),
+				     cqe->command_id)))
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 385a521..124fda6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -491,8 +491,8 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_tcp_queue_id(queue) == 0 &&
-	    cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH))
+	if (unlikely(nvme_is_aen_req(nvme_tcp_queue_id(queue),
+				     cqe->command_id)))
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 748a39f..bd1f81f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -102,8 +102,8 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_loop_queue_idx(queue) == 0 &&
-			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
+	if (unlikely(nvme_is_aen_req(nvme_loop_queue_idx(queue),
+				     cqe->command_id))) {
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	} else {
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
