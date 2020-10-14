Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED9C433E7
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 20:39:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE734207C3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TzNefQvK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="shm2wmd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE734207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/b5Xbd+8f5xGT5g0yGWzaeDJ3YTMDLS5I+Ixy+dH4hA=; b=TzNefQvK5Ek3XZUher5+6cTcK/
	KtzwF5I9Z1Fh3bYNUzhlQAVp2knZihBl9QcbVi9KMyumbC7IPeXg/0R/HjDxOrXpt/0t5uDyiFPlW
	Ij/xGcQPtRYN4v3uOPGrX+f2YrpSgIu2LmeWKolNNqwLWkSlOnTzrvu8+8Y6IiyZpQCUht9+l8DbW
	H18LcYQhhfF8Zb2muwpiWj8AXJNJmcb9CmALNlBY5RjvwZ/eHx6Cv3gODDSF/6Ernlzyw7q99cj/+
	yOa7oowAnLgEpt5+JWBel6BD1Ah7J4SV4tQAApbqeAQkDpMxhjit6jBgbUiuTcdy6FvOQdQMAl+we
	0Xhr2D+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSnXw-00016S-Ro; Wed, 14 Oct 2020 20:38:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSnXu-00015q-3z
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 20:38:51 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81B4D207C3;
 Wed, 14 Oct 2020 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602707927;
 bh=KuOjVu4HIawASXQVW4ugo43PChZYMqLkJcLOTM1I3m8=;
 h=From:To:Cc:Subject:Date:From;
 b=shm2wmd8ZrlYH0cfg3co9hiwuS0bBcklZq7cBT3ZCNgHFcRnwKj7p2OY+l9jiP3pX
 xlWTHa+dgPMx+GsV1jbcp9Nh2uvam1I/DcuKQOywoMWV0FVEPiCpqGF40BcvTrUemL
 DvT6rhna0eh06oEnLwK1MI4nRITjKXVwp6MiwxVc=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme: set passthrough command gendisk
Date: Wed, 14 Oct 2020 13:38:45 -0700
Message-Id: <20201014203845.1400053-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201014_163850_240273_05C51128 
X-CRM114-Status: GOOD (  12.28  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme event traces for IO commands are reporting the wrong QID
because we never set the request's gendisk. Set this parameter if the
passthrough command is being sent through an IO queue.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95ef4943d8bd..ab5921e824d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -894,9 +894,14 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags, bool poll)
 {
+	struct nvme_ns *ns = q->queuedata;
+	struct gendisk *disk = NULL;
 	struct request *req;
 	int ret;
 
+	if (ns)
+		disk = ns->disk;
+
 	req = nvme_alloc_request(q, cmd, flags, qid);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -910,9 +915,9 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	}
 
 	if (poll)
-		nvme_execute_rq_polled(req->q, NULL, req, at_head);
+		nvme_execute_rq_polled(req->q, disk, req, at_head);
 	else
-		blk_execute_rq(req->q, NULL, req, at_head);
+		blk_execute_rq(req->q, disk, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
