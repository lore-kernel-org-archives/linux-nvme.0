Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D5C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:22:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584C461004
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 20:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584C461004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0O0P1OM6PCWjXe3aRtxFw6EkL9pLTImaLamxMn+mf34=; b=L9bvsqOMTBQvtMeqciXJXJq3Yi
	P44YikyqOa0ZyS8UyBGOO3YkEAkEsvodgLTW3v7VfQwV2Ny+7otB7Yd6e9C5iUeZzPeZJA19ZGhgG
	V0FBHVNetErs281pF4kJy6MSUdnXK80KQ6PX25GIqxjHWfdX2WKtC+umShq+gfr6LnPBBD04Nx1AD
	4NYCPu1ZFe85aH5pnsJpFEUcDrqDm5qQPC0mqyyF4cdzVNm0xfpfO6EfU4c3MlwO0p2R0w4we4H7z
	mIJ/utrsUn/1G2IjfJXZAy4ce8/3PFv/OWTNMC5k7LWYb48soq/gLdzCz4SBD0wGkNAq1DXDCiZEk
	c2+es8UA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkBf1-0011V4-Hz; Fri, 21 May 2021 20:22:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkBeZ-0011Na-AH
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 20:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=EX2i9AWWCGofdWMYmRvF5O3IU9Y9iGDjWreOvh2b7ds=; b=KcjSoAr6IOflGKPJcntEVWihcs
 jxWGRGKpnskh/nN/ZzWNtf9OjCURflAO1ik+xrccedrhqwRvgDowxDS3JTuzZ0d5F34SdeWy+CA+h
 ZJ3Jr6WAspRcj+DKTe30h1i89SBS6VXaMHgfRHt0ZQcnbvCfITc+NE84afP5wS74HloHMUtVYUfC1
 RbLl8g3YsWGkGSg3TdNK9BO+/RJ33rfos0/wqe61YzdFsz5XsxYEV0bVa1NiEEwc7NwLoYNYb90zl
 igaW1PEWDJZSDgKn9FbPsUrzhVc4NlYkcxw7XIB5GNKxgNB969PKAl8rueMaKxG6+okt0lPTabGQN
 QDOc7nuQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkBeW-00HPNf-9f
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 20:21:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CE436138C;
 Fri, 21 May 2021 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621628508;
 bh=7fKyXomK4hFiDm2INagcL6+HlGVnAnxLwG9I5Nn7FtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PcGK2RiIJrNTsOOLSed3MaAUH2+FdMZQOwcKqN8ViR9wqIf0KQGnXGHcWv7D18Tnp
 c5X/7ztoyXzLVqcnhbDnXHbAEyXfKFHEaJzUcVYK60QSoMIPQ0f7PGIbENCpgH5SPe
 pJbIr0m7ELXTXC+JrgJsn23EsJVX5XtKBLkeuD9gQH+uAW3hanEZwPdqnVfE9CF7oi
 h5lbqkmt6RsFHHCDbmrV3/LEXCV5vtg15KYTtxbVBn4X4iWDOzhSOfzYTWCya6PGH6
 DMIeXNhxyTbMSChZNQuZlh21lKDs7O0UrL3atS+utHznlwsUUNvb8/xJ6XJ9iNgaFK
 4naUPBqEOMziA==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/4] block: support polling through blk_execute_rq
Date: Fri, 21 May 2021 13:21:42 -0700
Message-Id: <20210521202145.3674904-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210521202145.3674904-1-kbusch@kernel.org>
References: <20210521202145.3674904-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_132148_371012_77766830 
X-CRM114-Status: GOOD (  10.44  )
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

Poll for completions if the request's hctx is a polling type.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Moved blk_execute_rq's poll handling into a small helper function

 block/blk-exec.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index beae70a0e5e5..38f88552aa31 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -63,6 +63,19 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
 
+static bool blk_rq_is_poll(struct request *rq)
+{
+	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
+}
+
+static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
+{
+	do {
+		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
+		cond_resched();
+	} while (!completion_done(wait));
+}
+
 /**
  * blk_execute_rq - insert a request into queue for execution
  * @bd_disk:	matching gendisk
@@ -83,7 +96,10 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
-	if (hang_check)
+
+	if (blk_rq_is_poll(rq))
+		blk_rq_poll_completion(rq, &wait);
+	else if (hang_check)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
