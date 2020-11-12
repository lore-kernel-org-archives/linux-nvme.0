Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9263C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 07:56:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBFB204EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RToa4ltI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO6No4P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBFB204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zJB/P12JhEyzUQZzJcgWjf+IezfdflI/4ulTwEGTXj4=; b=RToa4ltIcNB/JWcxBQBYFde01
	BN6CMA33/DnV4Wop0fnkZ992TPe8sjSHj4A7/V0C9LIgC6KBzhbzNd0DmTpKHD92TZb3b4ZOi3kWc
	q6BofvHI7QFTeDfQy3oxPV0t4FVb47WWzABC449i5CU1sseS9vrJzvNUf3/iU9p8NlicVofTW6FYc
	OfLWfpQLRyJpr/geXM8CD1TQvrZ27BTJqQ2uH/YAnS/BWCjFgAaOY191JcY/mOEKjw+mhRgmDVZR+
	7xw2QfCsZZmZT9VLxQlsIHi0ybfoGrND+Urt4VVgbHZu1AB5c1IaktTU42qI4361PZhHgHlnE/1ep
	utlKfYWHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd7Sp-0007hJ-Ii; Thu, 12 Nov 2020 07:56:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd7Se-0007dy-TD
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 07:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605167764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEoa++yckJvX4gcWfT2MBofUbpK3jZSNs2PNG4vNnbQ=;
 b=CO6No4P+0/C0woic3BZ1BB6cjvIb4nFHsIVBxTIMkSRP+fszZ4J4yfTDXLQTN0DoaeYGu3
 HCu80Pu6XaZeXWku17wZOJTeqvxRNWQ6uEyZPziBlkqa5Nxk72fjpFFnkUkAX75uC+oOdN
 26evUGV0G39He7p2ix4r43Khbh08ozU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-Qy0ZrkkNMQmHW1aSSMJYhw-1; Thu, 12 Nov 2020 02:56:01 -0500
X-MC-Unique: Qy0ZrkkNMQmHW1aSSMJYhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87CA425F3;
 Thu, 12 Nov 2020 07:55:59 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 294CA5DA74;
 Thu, 12 Nov 2020 07:55:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
Date: Thu, 12 Nov 2020 15:55:26 +0800
Message-Id: <20201112075526.947079-4-ming.lei@redhat.com>
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_025605_048495_F70D3F42 
X-CRM114-Status: GOOD (  12.26  )
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
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.

Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
locking' by nvme-loop's lock class, no need to apply dynamically
allocated lock class key, so revert commit b3c6a5997541("block: Fix a
lockdep complaint triggered by request queue flushing").

This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
is reported the whole probe may take more than half an hour.

Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
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
