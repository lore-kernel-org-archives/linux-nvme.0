Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFF1C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 01:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S5EmzhQ3o5zBq2rwlkv69UQPkpanKz6KgpenHCk86Gk=; b=4JJgQE4g2cXpkvu0Z6dvc+YpRP
	fSyNx87/3Rtz1U6wu6SvVFYwwPjaMAcKZJobIr96DoY99VVXIAs6eBpR94vWd18HfBbUiWZ73W5c0
	wFDLg9RNZRsmsU4kW4YEE9XtbLB7FYlXaS79W/HXejjD0oRKwOzuSMqiVGxrnSyhwgf3+pJf2BZut
	w11SaWf46P2hj4meyw/Qf2GWeXwqNa7WrYz6eOCvyYrLG4TkFqMuWSnoWjLTa1UgcL2lzvv5tW6Hv
	xHdfT03VCjPrbaP3llKFUf0fSeK8kj9HQEb7HsMP1Jwv0mRRKSCkfVsPXkr/R9O+9BdASpde+BnOb
	ot1eG8ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaSW6-00H9Vj-KH; Tue, 20 Sep 2022 01:57:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaSW3-00H9Ta-MT
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 01:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663639057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S5EmzhQ3o5zBq2rwlkv69UQPkpanKz6KgpenHCk86Gk=;
	b=g7s7BQebZIcFaohBAa1FAu2t9CgPL7apgWJPvevk8dZnM2YKqQarnHzvwS15P7/HTDNK2S
	h3FbGxF+6fXJNiSFUj02uGtaBht372Ao1wyLQby49D8vFiBEyOuuqQ8khK8vy+o8ioHwvr
	jISIp+GJzbbQZ3kOsNnfC1NM//r1XKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-6T5MYfgeNqaQ6CDNsArrtA-1; Mon, 19 Sep 2022 21:57:33 -0400
X-MC-Unique: 6T5MYfgeNqaQ6CDNsArrtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52838833941;
	Tue, 20 Sep 2022 01:57:33 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27B8017583;
	Tue, 20 Sep 2022 01:57:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: don't wait freeze during resetting
Date: Tue, 20 Sep 2022 09:57:19 +0800
Message-Id: <20220920015719.1840164-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_185739_843260_C1AE7C16 
X-CRM114-Status: GOOD (  14.70  )
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

First it isn't necessary to call nvme_wait_freeze during reset.
For nvme-pci, if tagset isn't allocated, there can't be any inflight
IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.

Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
while requests are in progress"), it is fine to unfreeze queue without
draining inflight IOs.

Also both nvme-rdma and nvme-tcp's timeout handler provides forward
progress if the controller state isn't LIVE, so it is fine to drop
the timeout function of nvme_wait_freeze_timeout().

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/apple.c |  1 -
 drivers/nvme/host/pci.c   |  1 -
 drivers/nvme/host/rdma.c  | 13 -------------
 drivers/nvme/host/tcp.c   | 13 -------------
 4 files changed, 28 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..9cd02b57fc85 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1126,7 +1126,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	anv->ctrl.queue_count = nr_io_queues + 1;
 
 	nvme_start_queues(&anv->ctrl);
-	nvme_wait_freeze(&anv->ctrl);
 	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 	nvme_unfreeze(&anv->ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..985b216907fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		if (!dev->ctrl.tagset)
 			nvme_pci_alloc_tag_set(dev);
 		else
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..beb0d1a6a84d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -986,15 +986,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(&ctrl->ctrl);
-		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
-		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
 		nvme_unfreeze(&ctrl->ctrl);
@@ -1002,10 +993,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	return 0;
 
-out_wait_freeze_timed_out:
-	nvme_stop_queues(&ctrl->ctrl);
-	nvme_sync_io_queues(&ctrl->ctrl);
-	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	nvme_cancel_tagset(&ctrl->ctrl);
 	if (new)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d5871fd6f769..49d9bef806f9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1920,15 +1920,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
-		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
 			ctrl->queue_count - 1);
 		nvme_unfreeze(ctrl);
@@ -1936,10 +1927,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	return 0;
 
-out_wait_freeze_timed_out:
-	nvme_stop_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	nvme_cancel_tagset(ctrl);
 	if (new)
-- 
2.31.1


