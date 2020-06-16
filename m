Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F04C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 09:35:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E9620707
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 09:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQ86w+Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E9620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N+i46L5/2KvAmRVB1uR/SxiTRddNwCUYmduGp0QEz0Y=; b=IQ86w+Ts1eQmAI
	g5/EMTsQAefxhRYWcUA3XaQpYWVBaUb0xi5SwXMDZtJ4/V74VEoatbLBKRzZlt8VgNoS/72lGJqIW
	CGJAgMuzngdqv1YMxQ0ySNV1E3KhxW52h5sG0ksT9tyIfo3yXUrPNKbstb4tPRoVYNE/qa2itqGIm
	vVrqMrpvOWB8lojPHWZI4XkqzohCq/hTHl8JfrkmJ1NQlHU3LQJgrC0eZpLsRvobeT94BEoRYdiqm
	K8HjiAAMhF/EkPH0r31fKbzqIDtZ/JVToeT5uqvYqSp12AV+gqRmrk+BapJOXZbjvAkpZMqlN2cTg
	osvMT6Zl8ZUVUY3PLwOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jl7zk-0006yd-2p; Tue, 16 Jun 2020 09:35:04 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jl7zG-0006YP-PP
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 09:34:40 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 16 Jun 2020 12:34:26 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05G9YPqp030330;
 Tue, 16 Jun 2020 12:34:26 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, james.smart@broadcom.com
Subject: [PATCH 5/5 v2] nvme-loop: initialize tagset numa value to the value
 of the ctrl
Date: Tue, 16 Jun 2020 12:34:25 +0300
Message-Id: <20200616093425.169309-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200616093425.169309-1-maxg@mellanox.com>
References: <20200616093425.169309-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_023435_316546_3CF41CEE 
X-CRM114-Status: UNSURE (   7.30  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com,
 shlomin@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Both admin's and drive's tagsets should be set according the numa
node of the controller.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0d54e73..6344e73 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -340,7 +340,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
-	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
+	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
 	ctrl->admin_tag_set.driver_data = ctrl;
@@ -512,7 +512,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 	ctrl->tag_set.ops = &nvme_loop_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
-	ctrl->tag_set.numa_node = NUMA_NO_NODE;
+	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
 		NVME_INLINE_SG_CNT * sizeof(struct scatterlist);
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
