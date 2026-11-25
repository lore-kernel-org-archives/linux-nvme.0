Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE5606A323
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Rfrau2tw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBNtzGeE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=FDoWZygGPJ8gp6HUDVUVvD5gk/0H57YgQ+c+YTAiUds=; b=Rfrau2twmj75SSLxbSsiSDSsm5
	EWq0bTgxbPwmxmk+eD44XhdIxxxIrZd33OJjQSwCDG8+l4wcKOxG4piXXjuEF5EjAzhS2hng8dNrZ
	+qSYy/oaCVfTWlDuHtocnuKDVG645xhKy85wbKSEBfq5t32ppoihfblR9GEEuyL4fT7gCDfbcqreH
	vfrMiXMEFwtuITtw4uQPqbfDqABAGVJxsPa0qXLXgJGNdLChPoW20ENUb8VQkQchKPvAYy5rD08Rf
	G9HRR5R1uAiVnLNS61x6MRusGTNkRFLfuKiX7eeIt36GSGEnZfZwkiWl2Ts2qejZJ9HcIE3bmQrEo
	uDM9wiZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDok-0000000A7oD-0Qrx;
	Wed, 25 Nov 2026 14:17:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDoj-0000000A7o2-0nJ5
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:17:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E26440C43;
	Wed, 25 Nov 2026 14:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B271F000C4;
	Wed, 25 Nov 2026 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616267;
	bh=FDoWZygGPJ8gp6HUDVUVvD5gk/0H57YgQ+c+YTAiUds=;
	h=From:To:Cc:Subject:Date;
	b=QBNtzGeELzAnlhYpVaik4lvVxXhR1uNPkJ+pJ+IHgwrIr0zi6lbIpkIplDx094FDF
	 CtktH86QXDUnHd9BRaLo/F7sxj/D8urYeWLLH6oH9xV0qaYKZ1bgwAEZK3fQ6ua6B6
	 db6n0T17UY6hYhn9Kw0IrF5QQDkU+H6wYSfkRI2tBjTIwwAluEET3XU/QnK9QARmSw
	 ckwZPazyaOFxq1NLOnrjz+XVC5TZKN58+JX/herBNgdM4Z5XUGTsuIKKqsby1BQc2f
	 qVMddr+OyvNQHz/7YVMlSJ5cp0uLvNqi4g3WneqnXvSED0p9/byXhcZubG+SKhJBvF
	 tVjq1oPdY9p/Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-rdma: use current network namespace
Date: Wed, 25 Nov 2026 15:17:37 +0100
Message-ID: <20261125141737.2383-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Creating the connection manager in the initial network namespace
will result in expected issues when running with network namespaces.
So capture the current network namespace when setting up the
connection manager to ensure we're accessing the right information.

Fixes: 711023071960 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/rdma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 32189fdfc0f5..76b4cba80b36 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -133,6 +133,7 @@ struct nvme_rdma_ctrl {
 
 	u32			max_fr_pages;
 
+	struct net		*net;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
 
@@ -595,8 +596,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
-			RDMA_PS_TCP, IB_QPT_RC);
+	queue->cm_id = rdma_create_id(ctrl->net, nvme_rdma_cm_handler,
+			queue, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(queue->cm_id)) {
 		dev_info(ctrl->ctrl.device,
 			"failed to create CM ID: %ld\n", PTR_ERR(queue->cm_id));
@@ -2288,6 +2289,8 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
+	ctrl->net = get_net(current->nsproxy->net_ns);
+
 	/*
 	 * Safe to init list while allocating ctrl object.
 	 */
@@ -2303,7 +2306,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
 
-	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+	ret = inet_pton_with_scope(ctrl->net, AF_UNSPEC,
 			opts->traddr, opts->trsvcid, &ctrl->addr);
 	if (ret) {
 		pr_err("malformed address passed: %s:%s\n",
@@ -2312,7 +2315,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
-		ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+		ret = inet_pton_with_scope(ctrl->net, AF_UNSPEC,
 			opts->host_traddr, NULL, &ctrl->src_addr);
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
@@ -2354,6 +2357,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 out_kfree_queues:
 	kfree(ctrl->queues);
 out_free_ctrl:
+	put_net(ctrl->net);
 	kfree(ctrl);
 	return ERR_PTR(ret);
 }
-- 
2.51.0


