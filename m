Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43516C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04552084C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QcKaAgxd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV70oNCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04552084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fZjzoXO5eDqHQ7sKfC0nynwqadmTBLI8iugiklEa9Cs=; b=QcKaAgxdxF9GjG+CpvsfzRFpz
	1HC0nMicHExjh2I9y4piLOXe/sUHYaY0Th0+a+Cs654Ldn4rsGJzFKMWIJHhwQRTiGoT0x8TwAK1q
	TqJVMyyq0Nub1iVe1Ey9xcmrISEqniM1GIyd0GU9SphzGJ0VtjuzGkHEY3W/u72WAnTDghs44DQlx
	7TCEk5Z+XM8D8XshhDeuZqZePRHHjbrFAgtkBueiHXuacUW4BPaMdlHG6xxOQXuOyGVRCb3m7Yb2T
	JyTwJqKDAW0VwMaQWOHK0WmlmNOiVshA3oIiStmqqIwFioieytWfupAGC+YRrm1woKaqdyd5bhp2t
	g1zu06LnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTQin-0006cW-Tj; Fri, 16 Oct 2020 14:28:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTQim-0006bm-B9
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 14:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602858519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NEORNZ83ko/42dG+WK88K6XSXli8mWtOAjrChHKcpM=;
 b=YV70oNCN27eE69ZlvYqee+L4wZtNxufpA8vZ9PYaLv36GinevFxIS93BCrQz4vSS3ixMFD
 hPjKf6bPND1ZdXADJW8Kz2ueHBPfxtJhyjuxTGvgKknMK2vGUZJbO/t7EmFWb9ocQveRS8
 Q11rLYNHQxGxQB77C8ypAaBHKQDUfyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-Q12u0JCjM-KMX_3yLKqJig-1; Fri, 16 Oct 2020 10:28:35 -0400
X-MC-Unique: Q12u0JCjM-KMX_3yLKqJig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 675871007465;
 Fri, 16 Oct 2020 14:28:34 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD52455766;
 Fri, 16 Oct 2020 14:28:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/4] blk-mq: check rq->state explicitly in
 blk_mq_tagset_count_completed_rqs
Date: Fri, 16 Oct 2020 22:28:08 +0800
Message-Id: <20201016142811.1262214-2-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_102840_417303_AB16A1B8 
X-CRM114-Status: GOOD (  15.87  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

blk_mq_tagset_count_completed_rqs() is called from
blk_mq_tagset_wait_completed_request() for draining requests to be
completed remotely. What we need to do is to see request->state to
switch to non-MQ_RQ_COMPLETE.

So check MQ_RQ_COMPLETE explicitly in blk_mq_tagset_count_completed_rqs().

Meantime mark flush request as IDLE in its .end_io() for aligning to
end normal request because flush request may stay in inflight tags in case
of !elevator, so we need to change its state into IDLE.

Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c  | 2 ++
 block/blk-mq-tag.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c73d99..31a2ae04d3f0 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -231,6 +231,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		return;
 	}
 
+	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
+
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..10ff8968b93b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -367,7 +367,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 {
 	unsigned *count = data;
 
-	if (blk_mq_request_completed(rq))
+	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 		(*count)++;
 	return true;
 }
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
