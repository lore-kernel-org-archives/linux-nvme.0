Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C2C4CECE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 12:48:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA076206FA
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 12:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KF8XVTTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA076206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dOepg6m9qTu3SyFCRkC0h/VapVYsUs5U7P6TM0yiIW0=; b=KF8
	XVTTTXfdlipe4ISuWPHpVDguH7GVNzFmD35rX7qCWDiTpituT+C5syXW2hsbE9eUjj5h/sHs1uQFn
	zfhi3Yxhx0998JmHTAzjTg2/MHAJBxKO5cVVbXTmsnrtotMgw3xoWKOiygPx8HlshZ9ijNxOQb+gm
	hxCEfnXuWKrru9+x1eZ8kAsyn5CL1NR6AuUJ50STTh7AAC+mOiWV8/Ak5WVeAUGuoVxTEWRWzWMQu
	QN/WC32VW7Q5deBXNfN5M3Ohr/mev/JKSmSDT5UgQMERqmTyJrKFKq4UE+vozfkshXmSK8rpHbpwM
	vhCQIuDfYgSbzB4zY9B4YK8jDOtExLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCjjo-0005yu-2D; Fri, 13 Mar 2020 12:48:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCjjl-0005yY-RZ
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 12:48:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 98EDBAD26;
 Fri, 13 Mar 2020 12:48:24 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme/fc: use real sqsize as argument when connecting queues
Date: Fri, 13 Mar 2020 13:48:08 +0100
Message-Id: <20200313124808.39320-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200313_054826_035434_304AC3F6 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When creating queues we should be passing in the real sqsize number,
and not increasing it by one just so that the function has to
substract it again.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0cbc4a703359..f76325a47578 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1211,7 +1211,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 				sizeof(struct fcnvme_lsdesc_cr_assoc_cmd));
 
 	assoc_rqst->assoc_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
-	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize - 1);
+	assoc_rqst->assoc_cmd.sqsize = cpu_to_be16(qsize);
 	/* Linux supports only Dynamic controllers */
 	assoc_rqst->assoc_cmd.cntlid = cpu_to_be16(0xffff);
 	uuid_copy(&assoc_rqst->assoc_cmd.hostid, &ctrl->ctrl.opts->host->id);
@@ -1326,7 +1326,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 				sizeof(struct fcnvme_lsdesc_cr_conn_cmd));
 	conn_rqst->connect_cmd.ersp_ratio = cpu_to_be16(ersp_ratio);
 	conn_rqst->connect_cmd.qid  = cpu_to_be16(queue->qnum);
-	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize - 1);
+	conn_rqst->connect_cmd.sqsize = cpu_to_be16(qsize);
 
 	lsop->queue = queue;
 	lsreq->rqstaddr = conn_rqst;
@@ -2484,11 +2484,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 		goto out_free_tag_set;
 	}
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_cleanup_blk_queue;
 
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_delete_hw_queues;
 
@@ -2539,11 +2539,11 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->ctrl.queue_count == 1)
 		return 0;
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_free_io_queues;
 
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize);
 	if (ret)
 		goto out_delete_hw_queues;
 
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
