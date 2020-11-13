Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A827C2D0E4
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 01:27:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322B216C4
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 01:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2RoXl/Xo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INrgM3QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E322B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mhw60kj4cA4mrouhqr/dAKecCfjE5Zsaqvb+pdcMRLI=; b=2RoXl/XoSBwKDPHPUJCvlWMXM
	NYx4EH7U2PEWt8RO+o8tqeodzlBKyWs6RRBLXYg2Ac9yxkiJe8Ioh1nbro7+1iEO06gnKstEOdUn8
	H8eiQnAQs+lBrH5gytxi5OHCX3net6w9ftMguNC7kULkxbricp/DUJUMjS4kr+w711s7c78SafXl9
	Ky85JIY3kIeKt3jNFiQ3voyuuAhpvht08rnW8xup5kqORyo9De//w00wVp/5HvvzCuIJLpar8eSdE
	lyer8PojVb3IMINiB2Y95v4tfNrzh5C6L8SJCKbtQXN7PBDutRVanSrIvC3RtKHqZbjCw89VUHNef
	r1k7/sqlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdNsU-0006la-7G; Fri, 13 Nov 2020 01:27:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdNsQ-0006l6-TI
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 01:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605230866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lV54YU+Y2Y4e+7PhqUzWDRed50pkkVt7/DClvgkkexc=;
 b=INrgM3QDep28fEi8LjpV/JUjzwt7ECDn/VpB3vnizvDcdkb6ZK2dO+huUMQ/ypYb148Lbj
 cFYhkvN0Y7GRj+mJDWAkUtSErokDVYtiU5NH/3ryQ2XTq6KcP6IhSsRl1481QuobFgPHCr
 Q6Mn/7sYR8ISYADzlxzS3ukelfmvtmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-slz7WspHMemeuUB_wBgjmg-1; Thu, 12 Nov 2020 20:27:41 -0500
X-MC-Unique: slz7WspHMemeuUB_wBgjmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD12107B467;
 Fri, 13 Nov 2020 01:27:39 +0000 (UTC)
Received: from T590 (ovpn-12-25.pek2.redhat.com [10.72.12.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E42605B4DA;
 Fri, 13 Nov 2020 01:27:26 +0000 (UTC)
Date: Fri, 13 Nov 2020 09:27:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
Message-ID: <20201113012722.GD1012796@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-4-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_202746_995240_96BC8C3F 
X-CRM114-Status: GOOD (  14.27  )
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
Cc: Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@redhat.com>,
 John Garry <john.garry@huawei.com>, Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From a519f421957a1205918e9bcc15087d15234e4e9f Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 12 Nov 2020 09:56:02 +0800
Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"

This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.

Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
locking' by nvme-loop's lock class, no need to apply dynamically
allocated lock class key, so revert commit b3c6a5997541("block: Fix a
lockdep complaint triggered by request queue flushing").

This way fixes horrible SCSI probe delay issue on megaraid_sas(host_tagset is 1),
and it is reported the whole probe may take more than half an hour. The reason
is that synchronize_rcu() is implied in lockdep_unregister_key() which is
called from each hctx's release handler, and some SCSI hosts can support
too many hw queues, meantime generic SCSI probe may synchronously create
and destroy lots of MQ request_queues for non-existent devices.

Another benefit is that lockdep doesn't maintain so many runtime lock class for
fq->mq_flush_lock which is per-hctx, then lock validation can be improved much.

Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- add more commit log

 block/blk-flush.c | 5 -----
 block/blk.h       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 657743524e15..c64f049226f6 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -69,7 +69,6 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
-#include <linux/lockdep.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -469,9 +468,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 	INIT_LIST_HEAD(&fq->flush_queue[1]);
 	INIT_LIST_HEAD(&fq->flush_data_in_flight);
 
-	lockdep_register_key(&fq->key);
-	lockdep_set_class(&fq->mq_flush_lock, &fq->key);
-
 	return fq;
 
  fail_rq:
@@ -486,7 +482,6 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 	if (!fq)
 		return;
 
-	lockdep_unregister_key(&fq->key);
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9..806fd6537295 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,7 +25,6 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
 
-	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
 
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
