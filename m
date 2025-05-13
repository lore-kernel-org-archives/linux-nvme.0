Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B1C3ABC9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGUlh3EM9fqg1L8bTydgBuuJKu4NKbryUIRbd8/K9m0=; b=oS03f1tyarpzzLDFkfd6QCc4Zs
	DCik/Gmgm9/na/amtf4DPSFvQj6Ug8vB4iy0GMIJaS7c5acfiQ32wqMcf9p6dW6T8MEVKyE8DzRce
	n6yCll0bo7LumZh49NbUkLtYhQG8Q6uEEsDPD0KMfls73SWztXWu+tsPEgRd/bZzxQTEwxSGS7ion
	XfzzHQD4XGgKCPgC2Tt/vuy5k4EHSA/DgqK6p41Kkxz8Lce4oH2t6VoEAHXCrXxai55EpfOx7e8sE
	gJGqZhr3gOU5BIOHHZkPayGXbmmYIHZY9PygM2dikxEFGXwxtFamqoP18iLjrKaYQnIbbh4ncCU2c
	NccRg3lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjcx-0000000BYzT-40iW;
	Tue, 13 May 2025 07:00:35 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjcw-0000000BYyI-3zH4;
	Tue, 13 May 2025 07:00:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH 2/7] nvme-pci: store aborted state in flags variable
Date: Tue, 13 May 2025 09:00:18 +0200
Message-ID: <20250513070025.830930-3-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513070025.830930-1-hch@lst.de>
References: <20250513070025.830930-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Leon Romanovsky <leon@kernel.org>

Instead of keeping dedicated "bool aborted" variable, let's reuse
newly introduced flags variable and save space.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 24f5292a349b..51430f5e6a66 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -230,6 +230,12 @@ union nvme_descriptor {
 	__le64			*prp_list;
 };
 
+/* bits for iod->flags */
+enum nvme_iod_flags {
+	/* this command has been aborted by the timeout handler */
+	IOD_ABORTED		= 1U << 0,
+};
+
 /*
  * The nvme_iod describes the data in an I/O.
  *
@@ -239,7 +245,7 @@ union nvme_descriptor {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
-	bool aborted;
+	u8 flags;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small
 				   pool in use */
 	unsigned int dma_len;	/* length of single DMA segment mapping */
@@ -984,7 +990,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
-	iod->aborted = false;
+	iod->flags = 0;
 	iod->nr_allocations = -1;
 	iod->sgt.nents = 0;
 	iod->meta_sgt.nents = 0;
@@ -1551,7 +1557,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * returned to the driver, or if this is the admin queue.
 	 */
 	opcode = nvme_req(req)->cmd->common.opcode;
-	if (!nvmeq->qid || iod->aborted) {
+	if (!nvmeq->qid || (iod->flags & IOD_ABORTED)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
@@ -1564,7 +1570,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
-	iod->aborted = true;
+	iod->flags |= IOD_ABORTED;
 
 	cmd.abort.opcode = nvme_admin_abort_cmd;
 	cmd.abort.cid = nvme_cid(req);
-- 
2.47.2


