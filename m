Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73DEC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcIBv8aRMHmZgFA6GHhrxP0tUugQH7OSTYm/46/aZzk=; b=TBcNRJziFjnPeOKMOOyxSJRWJS
	2BENtPND5Bc6IrZZUi3OW2hg2guhvGEtejblPNiPaQFH3m272Xh5PfbCVPBReVOLNZ0zQBPlAMZmy
	d33+pIQRNuFT/v1Tf6gWY7631Cb/KcYuHu/6TcJ5HWNveCxIFGrkXBO0bUZ4hUj0vp1ytWONmsLWU
	wxwvKp1oOe08lkKsi6rRKDZzwbFCN8uQh7yEXBk25/rth551pFLi6HcKXmKs5zPtBtVMLe3JP/VDh
	mxyA1EpNZLljbKhbbRpslloKuKBLklxjtuFoGh5418EnliBGS376bzufTWwUCf2LpoEELfGZDv3sM
	va1xIBHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OxJ-00AMuw-PQ; Sun, 25 Dec 2022 11:14:13 +0000
Received: from [88.128.92.76] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OJC-00A2d5-R6; Sun, 25 Dec 2022 10:32:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme: store the actual queue size in ctrl->sqsize
Date: Sun, 25 Dec 2022 11:32:33 +0100
Message-Id: <20221225103234.226794-4-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221225103234.226794-1-hch@lst.de>
References: <20221225103234.226794-1-hch@lst.de>
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

Convert from the strange on the wire 0s based value to a regular size
when reading the filed to avoid adjustments all over.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c   |  3 +--
 drivers/nvme/host/core.c    | 19 +++++++++++++++++--
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/fc.c      | 12 ++++++------
 drivers/nvme/host/pci.c     |  4 ++--
 drivers/nvme/host/rdma.c    | 23 +++++++++++------------
 drivers/nvme/host/tcp.c     | 12 ++++++------
 7 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e36aeb50b4edc1..073a1e8c021c14 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1080,8 +1080,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	writeq(anv->ioq.tcb_dma_addr,
 	       anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
 
-	anv->ctrl.sqsize =
-		APPLE_ANS_MAX_QUEUE_DEPTH - 1; /* 0's based queue depth */
+	anv->ctrl.sqsize = APPLE_ANS_MAX_QUEUE_DEPTH;
 	anv->ctrl.cap = readq(anv->mmio_nvme + NVME_REG_CAP);
 
 	dev_dbg(anv->dev, "Enabling controller now");
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cda1361e6d4fbb..f2b7bb8bcc31fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3242,7 +3242,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 		return ret;
 	}
 
-	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
+	/* CAP.MQES is 0s based */
+	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap) - 1, ctrl->sqsize);
 
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
 		ctrl->subsystem = NVME_CAP_NSSRC(ctrl->cap);
@@ -3505,9 +3506,18 @@ static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 nvme_show_int_function(cntlid);
 nvme_show_int_function(numa_node);
 nvme_show_int_function(queue_count);
-nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
 
+static ssize_t sqsize_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	/* Report the 0s based register value for historic reasons: */
+        return sysfs_emit(buf, "%d\n", ctrl->sqsize - 1);
+}
+static DEVICE_ATTR(sqsize, S_IRUGO, sqsize_show, NULL);
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -4897,7 +4907,12 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
+
+	/*
+	 * Leave an empty slot in the SQ to deal with queue wrap conditions.
+	 */
 	set->queue_depth = min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH - 1);
+
 	/*
 	 * Some Apple controllers requires tags to be unique across admin and
 	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ce27276f552dad..bb3c611136c90c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -464,7 +464,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = cpu_to_le16(qid);
-	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
+	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize - 1);
 
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4564f16a0b203c..81278750b8c45d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2922,11 +2922,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_cleanup_tagset;
 
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_delete_hw_queues;
 
@@ -2982,11 +2982,11 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 	}
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_free_io_queues;
 
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_delete_hw_queues;
 
@@ -3148,7 +3148,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 			"to maxcmd\n",
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
-		ctrl->ctrl.sqsize = opts->queue_size - 1;
+		ctrl->ctrl.sqsize = opts->queue_size;
 	}
 
 	ret = nvme_fc_init_aen_ops(ctrl);
@@ -3509,7 +3509,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 				lport->ops->max_hw_queues);
 	ctrl->ctrl.queue_count++;	/* +1 for admin queue */
 
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 	ctrl->ctrl.cntlid = 0xffff;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b13baccedb4a95..a621dd7a0a8efa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2335,7 +2335,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 				sizeof(struct nvme_command));
 		if (result > 0) {
 			dev->q_depth = result;
-			dev->ctrl.sqsize = result - 1;
+			dev->ctrl.sqsize = result;
 		} else {
 			dev->cmb_use_sqes = false;
 		}
@@ -2579,7 +2579,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
 			 dev->q_depth);
 	}
-	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
+	dev->ctrl.sqsize = dev->q_depth;
 
 	nvme_map_cmb(dev);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56dd..26306f7b80c2e9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -773,8 +773,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	}
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+		ret = nvme_rdma_alloc_queue(ctrl, i, ctrl->ctrl.sqsize);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -1059,24 +1058,24 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
-	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
+	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize) {
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
+			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize);
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
+	if (ctrl->ctrl.sqsize > NVME_RDMA_MAX_QUEUE_SIZE) {
 		dev_warn(ctrl->ctrl.device,
 			"ctrl sqsize %u > max queue size %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
-		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
+			ctrl->ctrl.sqsize, NVME_RDMA_MAX_QUEUE_SIZE);
+		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE;
 	}
 
-	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
+	if (ctrl->ctrl.sqsize > ctrl->ctrl.maxcmd) {
 		dev_warn(ctrl->ctrl.device,
 			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
-		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
+			ctrl->ctrl.sqsize, ctrl->ctrl.maxcmd);
+		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd;
 	}
 
 	if (ctrl->ctrl.sgls & (1 << 20))
@@ -1891,7 +1890,7 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		 * 1's based representation of sqsize.
 		 */
 		priv.hrqsize = cpu_to_le16(queue->queue_size);
-		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
+		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize - 1);
 	}
 
 	ret = rdma_connect_locked(queue->cm_id, &param);
@@ -2338,7 +2337,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b69b89166b6b96..37a96cbd8929db 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2047,16 +2047,16 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
-	if (opts->queue_size > ctrl->sqsize + 1)
+	if (opts->queue_size > ctrl->sqsize)
 		dev_warn(ctrl->device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			opts->queue_size, ctrl->sqsize + 1);
+			opts->queue_size, ctrl->sqsize);
 
-	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
+	if (ctrl->sqsize > ctrl->maxcmd) {
 		dev_warn(ctrl->device,
 			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->sqsize + 1, ctrl->maxcmd);
-		ctrl->sqsize = ctrl->maxcmd - 1;
+			ctrl->sqsize, ctrl->maxcmd);
+		ctrl->sqsize = ctrl->maxcmd;
 	}
 
 	if (ctrl->queue_count > 1) {
@@ -2562,7 +2562,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
-- 
2.35.1


