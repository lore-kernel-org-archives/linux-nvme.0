Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 03:33:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5561823888
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 03:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5561823888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vrvj6+R9yuT6esGKp2HUvHcYMWOBU9cartbuyCHHhvE=; b=Lv9rbERosl3lq1foO9S3NyMgv
	q4E3px8RKMEbkxyND6uKhOgkV/QLvtd/iOh8ovnZa5xWCXi1HKxsftMrFDjX3NlpvmFwGwIvMUfn5
	JRnggBKEwu9ZaXcmmQf8Q2CMTQl7BirF4JS/rIZCx1m1sFwPtHqpMxq1aABJ4Bw7WdHNY56scHOXy
	3R7ttel5QMMl9xdcq+3Q3RWRksFo1hMhwUjpM2Gb36nzHrgd9LTqVv/Vf1AdIhFKTSMqMVoranbkR
	KLq5Lcq4ohbmJLR1rKIy5GqmDteZcN9LDhBuugozbNjE5nC1XboNW5SN+DTnoUNBiCZb3cQBhUShQ
	nnl0g0pJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2QiR-0003xX-ML; Thu, 21 Jan 2021 03:32:59 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2QiL-0003ux-HS
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 03:32:55 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLnx80JpMzl7lZ;
 Thu, 21 Jan 2021 11:31:24 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 11:32:41 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 2/5] nvme-rdma: add clean action for failed reconnection
Date: Thu, 21 Jan 2021 11:32:37 +0800
Message-ID: <20210121033240.31906-3-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20210121033240.31906-1-lengchao@huawei.com>
References: <20210121033240.31906-1-lengchao@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_223253_916390_3D34F745 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A crash happens when inject failed reconnection.
If reconnect failed after start io queues, the queues will be unquiesced
and new requests continue to be delivered. Reconnection error handling
process directly free queues without cancel suspend requests. The
suppend request will time out, and then crash due to use the queue
after free.

Add sync queues and cancel suppend requests for reconnection error
handling.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/rdma.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cf6c49d09c82..d9d677c151af 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -912,12 +912,16 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_stop_queue;
+		goto out_quiesce_queue;
 
 	return 0;
 
+out_quiesce_queue:
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
@@ -994,8 +998,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 out_wait_freeze_timed_out:
 	nvme_stop_queues(&ctrl->ctrl);
+	nvme_sync_io_queues(&ctrl->ctrl);
 	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_connect_q:
+	nvme_cancel_tagset(&ctrl->ctrl);
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
@@ -1137,10 +1143,18 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	return 0;
 
 destroy_io:
-	if (ctrl->ctrl.queue_count > 1)
+	if (ctrl->ctrl.queue_count > 1) {
+		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
+		nvme_rdma_stop_io_queues(ctrl);
+		nvme_cancel_tagset(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, new);
+	}
 destroy_admin:
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, new);
 	return ret;
 }
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
