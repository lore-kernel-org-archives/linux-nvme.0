Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CEC47404
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 19:26:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A47320B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZsayZIPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A47320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kCdmZ5b+7wg6f5dNSMuWu4X6TdX7hukcDUc+ex+5Nz8=; b=ZsayZIPmjtoU9n
	6DWOSWStGPD3tkzCR12HLniZgyX11rpZeux8Xd4NXmH3/vuTvgRhmojv659p2TX4z1nbp6u/iBexp
	PGqsa78taZRgsI8vjwQRRAxd0cXQbzpP5/1NoihOVGy+iifskZNGDEW75NP392if7DBD3oyeI4hoj
	QNKmU4y2uiI16pJg/83TpbJvlRmq7HTAEJcfO/Af3MDMq/pKE4h9LOyjTqlG1XOP8d3MM7sF7r7zx
	kMGlmoH015Ed4oGTgu/Q8WK2Hdr8XTGHxdAmTDmSAa2O9/y2HzSsRYz0zjAZinmjpx02aiMoScFfg
	AS4hc9keUbz5/+x61j1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIHbM-0000KC-J0; Wed, 09 Oct 2019 19:26:25 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIHag-00085Q-JJ
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 19:25:45 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1iIHaa-0002gB-6e; Wed, 09 Oct 2019 13:25:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1iIHaZ-0003QP-4s; Wed, 09 Oct 2019 13:25:35 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed,  9 Oct 2019 13:25:28 -0600
Message-Id: <20191009192530.13079-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009192530.13079-1-logang@deltatee.com>
References: <20191009192530.13079-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com,
 maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v9 10/12] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_122543_013863_CFB350F6 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Instead of checking blk_rq_is_passthruough() for every call to
blk_do_io_stat(), don't set RQF_IO_STAT for passthrough requests.
This should be equivalent, and opens the possibility of passthrough
requests specifically requesting statistics tracking.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c | 2 +-
 block/blk.h    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..618814fcc8a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -319,7 +319,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->cmd_flags = op;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
-	if (blk_queue_io_stat(data->q))
+	if (blk_queue_io_stat(data->q) && !blk_rq_is_passthrough(rq))
 		rq->rq_flags |= RQF_IO_STAT;
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_HLIST_NODE(&rq->hash);
diff --git a/block/blk.h b/block/blk.h
index 47fba9362e60..6b7ebc2e61b8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -243,13 +243,12 @@ int blk_dev_init(void);
  *
  *	a) it's attached to a gendisk, and
  *	b) the queue had IO stats enabled when this request was started, and
- *	c) it's a file system request
+ *	c) it's a file system request (RQF_IO_STAT will not be set otherwise)
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
 	return rq->rq_disk &&
-	       (rq->rq_flags & RQF_IO_STAT) &&
-		!blk_rq_is_passthrough(rq);
+	       (rq->rq_flags & RQF_IO_STAT);
 }
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
