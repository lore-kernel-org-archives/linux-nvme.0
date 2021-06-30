Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF5C11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 10:04:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE6A61D0C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 10:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE6A61D0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NcGMcCNoyEsNb4kI4xvGb+JXHOp3WlKjZJbujbB33o4=; b=zL+HihhuA3iIxo
	XVOMxxeE5xEEBze4keFuZjvO+iJdGuGoamcaqXqIPr6A/4ETk+QwlNtJtZ4KjjhhtgeOtRyHGDLeR
	R+Az3vG9J9Dd70tOJCTLxlL5AHp7/aIBdkFDRyvCRaPN6OzZI3+ZXxZ3hnw67lpavUbfYReXZrkcV
	vak+R54/qbYVgBq1BoX1JwBx44yZCGPms2Uv146T8/QwL3jvpxiBCMwHYCTQ34xdgBAmv+DWjcnhy
	UO0YH46As9WOSQm9jLX1Zr0vIw2mz0dhjqRY8r+VNNJURplc8PChEWY5rD5szNjmJh4b0QqxjMzdy
	aanopMjHxMdaMWDpz/Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyX4O-00DYwI-BN; Wed, 30 Jun 2021 10:03:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyX4L-00DYvy-Ly
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 10:03:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 271F71FE60;
 Wed, 30 Jun 2021 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625047424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zQqwP8nQ9d/PpMi6FRBTsc/6S3sreiYX/DtOcbYh7So=;
 b=1Qv+plawI6gHA/gkH2yy+x+RSWnJYGsaPBJFRacFNtEH9RYcWDPcSKuKNI/9OoGw7OeOYn
 GR73x9aZyQ8cFlXgnFkFNDyOpUv11hLwurma37KFyeQlI7GDPLZYydx9rMU5u0wqS++Kiy
 mN08WoekrqS19pF/K1CKxhFS8Pp3LG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625047424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zQqwP8nQ9d/PpMi6FRBTsc/6S3sreiYX/DtOcbYh7So=;
 b=qINXigZFKCVBy5ViSPop96bcBkwjydKqZZuYYsQFWHXVkOP0Mx2z0uMCfkXIM5yFaX/wgP
 CZiVkCxrCdBIvJBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1D322A3B9B;
 Wed, 30 Jun 2021 10:03:44 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 0E5B15170CC2; Wed, 30 Jun 2021 12:03:44 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <daniel.wagner@suse.com>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Wen Xiong <wenxiong@us.ibm.com>,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-mq: don't allocate requests when all cpus in a hctx are
 offline
Date: Wed, 30 Jun 2021 12:03:42 +0200
Message-Id: <20210630100342.1100-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_030345_913572_84C4D65D 
X-CRM114-Status: GOOD (  12.44  )
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

When all CPUs in a hctx are offline in blk_mq_alloc_request_hctx() we should
not try to allocate the request, as we'll fail later on in blk_mq_get_tag() anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f11d4018ce2e..1622d0cabe3a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -468,13 +468,16 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	data.hctx = q->queue_hw_ctx[hctx_idx];
 	if (!blk_mq_hw_queue_mapped(data.hctx))
 		goto out_queue_exit;
+	ret = -EWOULDBLOCK;
+	/* all cpus in the hctx are offline, don't try to allocate a tag */
 	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
+	if (unlikely(cpu >= nr_cpu_ids))
+		goto out_queue_exit;
 	data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	if (!q->elevator)
 		blk_mq_tag_busy(data.hctx);
 
-	ret = -EWOULDBLOCK;
 	tag = blk_mq_get_tag(&data);
 	if (tag == BLK_MQ_NO_TAG)
 		goto out_queue_exit;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
