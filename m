Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7965C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 08:04:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584616136F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 08:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 584616136F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bEn4CwoFjv27EsXRwzB4Hj+B5vj83tpGvOsphP1B8bE=; b=q9Cim1YsmPx6LU
	3bzjd2yfVJ3O4O/YhVzVqLEAQ79v9xyL09L1Rez6IRLdArcgE+80I3iZ6yu0WJ/2tdcNIxz83bs+z
	TQQdaFiy1NHE4lCpbRw5uXorKiwOkFawSW732g+W/OYy+8Pb4d45PT9r6W17M5u4tLDbdY2Z2P1I2
	mAgfrH9ODQvh3wqBEf04ZBGuTS75oJQQJjQOkpzZj4sOHjwrAKNucv8d+C3zG6DI5KHjqgt1i4dxX
	GtpS7grBUqHgKOs7Umx84KIpK+xW6kdk9+kqkIurolvRw2GEXeerld5dRHjfFjdpMdCf/shuDl0BT
	a7aDkhFLzigY4tRIueHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI4vb-00FqZV-0Q; Mon, 23 Aug 2021 08:03:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI4uv-00FqMs-R1
 for linux-nvme@bombadil.infradead.org; Mon, 23 Aug 2021 08:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=oSQjEP5R+jtCgGIe8w5p+KGOxkPH8yqAikAOK4AxgUM=; b=jgGoudaq5nbvek9nWeYiVv+HkS
 2DIXN6H+77dZGlUUqLhZEr1AQPyYtlrpMBn3Xbcfg6Ix5VRfktMFAx2GxRcnA1VYCEWrMBl/8tO4n
 10pTftgdjTDvaHWwRuZhWymYCzLXC9DPalbC7NLF1qbzVpZfEdTO2fzGX22FZD+6n98RK2naO8aix
 O0N0T6H8v+eYpI0pNY0pbvJFwQ8IedQU/jvMEFBoWHFCu7EEjaD4Wn6Nh/sFfVCGc/bLLtcUKXwoF
 MIbBWEOoW00IQxRgob3UuuhuRK+5IQTfiLt9cRfvV5GIEWfXu+TfRR9U1dDMiiMLSDDDMNkyYz/zO
 w+1jMY0A==;
Received: from [2001:4bb8:193:fd10:c6e8:3c08:6f8b:cbf0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI4uG-009SMI-Mb; Mon, 23 Aug 2021 08:02:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: set QUEUE_FLAG_NOWAIT
Date: Mon, 23 Aug 2021 10:02:07 +0200
Message-Id: <20210823080207.711362-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme multipathing code just dispatches bios to one of the blk-mq
based paths and never blocks on its own, so set QUEUE_FLAG_NOWAIT
to support REQ_NOWAIT bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d390f14b8bb6..c77dfe28df67 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -480,6 +480,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 			ctrl->subsys->instance, head->instance);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
+
 	/* set to a default value of 512 until the disk is validated */
 	blk_queue_logical_block_size(head->disk->queue, 512);
 	blk_set_stacking_limits(&head->disk->queue->limits);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
