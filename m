Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B1C10DCE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 12:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E01206FA
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 12:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAhYgWtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E01206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lXfzagD4FGWBNQ/PajdBTTMXHx9WRTEjnmnn/bXQqa4=; b=bAh
	YgWtO5gcYXtT94LiQExuhlHZuNmogN2pmtHZOb7iezWdnaAqMs3X4zV/ObWT2XSlymvABZVf4QgDh
	aOOmoEvqjq0Pdx/GP32YKJxrRfOqojLt0wmsFtsXEK924LSczt0d9cVgfMRPKePdk/LZvAXIcA11s
	xNWnnU8mVGQBH7VCIYwWIyFFC30mR0H9c61dhmMImQdHSHuT7jnUPaKnDLtzQmibpjJZiX36HPgRw
	99CbSU0VrLdWn0xU7V3pJfuXREfNhqhAxMBQX3gXOV+bqYDb+PfTdshrzDLpVG42i6acoS/AaEi3o
	InmE8VzmwtWadarfDdJwQF5Qu0GnjsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCjft-0002eq-Pt; Fri, 13 Mar 2020 12:44:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCjfr-0002eX-5H
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 12:44:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 302C4B0AE;
 Fri, 13 Mar 2020 12:44:18 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: stop mad sqsize increasing and decreasing
Date: Fri, 13 Mar 2020 13:44:10 +0100
Message-Id: <20200313124410.39193-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200313_054423_492102_162CB2AD 
X-CRM114-Status: GOOD (  18.40  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The NVMe spec only states:

"One slot in each queue is not available for use due to Head and
Tail entry pointer definition."

It does not say that the actual queue size needs to decremented
by one, it just means that we'll have to leave one slot free.
So kill the mad decreasing and increasing of sqsize, leave it
at the specified size, and only decrement the tagset by one to
ensure we leave one slot free.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/fc.c      | 10 +++++-----
 drivers/nvme/host/pci.c     |  6 +++---
 drivers/nvme/host/rdma.c    | 23 +++++++++--------------
 drivers/nvme/host/tcp.c     | 16 ++++++++--------
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2a6c8190eeb7..90f8199e5b6c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -375,7 +375,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = 0;
-	cmd.connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
+	cmd.connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH);
 
 	/*
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5a70ac395d53..0cbc4a703359 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2461,7 +2461,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_fc_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
+	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size - 1;
 	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
 	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
@@ -2702,13 +2702,13 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
 
-	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
+	if (opts->queue_size > ctrl->ctrl.sqsize) {
 		/* warn if sqsize is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl sqsize %u, reducing "
 			"to sqsize\n",
-			opts->queue_size, ctrl->ctrl.sqsize + 1);
-		opts->queue_size = ctrl->ctrl.sqsize + 1;
+			opts->queue_size, ctrl->ctrl.sqsize);
+		opts->queue_size = ctrl->ctrl.sqsize;
 	}
 
 	ret = nvme_fc_init_aen_ops(ctrl);
@@ -3115,7 +3115,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 				lport->ops->max_hw_queues);
 	ctrl->ctrl.queue_count++;	/* +1 for admin queue */
 
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 	ctrl->ctrl.cntlid = 0xffff;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6fa0c7bb96c..b72a4160a5fb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1585,7 +1585,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.ops = &nvme_mq_admin_ops;
 		dev->admin_tagset.nr_hw_queues = 1;
 
-		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
+		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH - 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
@@ -2298,9 +2298,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap),
 				io_queue_depth);
-	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
+	dev->ctrl.sqsize = dev->q_depth; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e85c5cacefd..7c2aa50188c4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -702,7 +702,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+				ctrl->ctrl.sqsize);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -740,7 +740,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_mq_ops;
-		set->queue_depth = nctrl->sqsize + 1;
+		set->queue_depth = nctrl->sqsize - 1;
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
@@ -998,17 +998,17 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
-	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
+	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize) {
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
+			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize);
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
@@ -1603,13 +1603,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	 */
 	if (priv.qid == 0) {
 		priv.hrqsize = cpu_to_le16(NVME_AQ_DEPTH);
-		priv.hsqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
+		priv.hsqsize = cpu_to_le16(NVME_AQ_DEPTH);
 	} else {
-		/*
-		 * current interpretation of the fabrics spec
-		 * is at minimum you make hrqsize sqsize+1, or a
-		 * 1's based representation of sqsize.
-		 */
 		priv.hrqsize = cpu_to_le16(queue->queue_size);
 		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
 	}
@@ -2019,7 +2014,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 814ea2317f4e..8837411c222f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1554,7 +1554,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_tcp_mq_ops;
-		set->queue_depth = nctrl->sqsize + 1;
+		set->queue_depth = nctrl->sqsize - 1;
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = NUMA_NO_NODE;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
@@ -1641,7 +1641,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i,
-				ctrl->sqsize + 1);
+				ctrl->sqsize);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -1912,16 +1912,16 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
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
@@ -2364,7 +2364,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
-	ctrl->ctrl.sqsize = opts->queue_size - 1;
+	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
