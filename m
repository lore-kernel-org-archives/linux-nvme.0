Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A7C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pZXy6AjZjPC6H/SXIyE5VyyrzC96iMDRLk5+OuIek/c=; b=euPiIOC6eCGJWXb112363yNBM5
	es+vAkVpl+iUvyDRdD4WC2sp8Bu10oGVsgAlhF0V95SEw8kw6s329dvhTr5tq7QpRroRt2S4RLJEp
	ufGz1zBYGSEnzYrTqTGPiWsnDKWlmIQmeSSYzsaITwdfySf/epdUe955LY9Vw5u+OjKnWdBjvQaYW
	PDGXbZj1qk5yiBMZlxA+5gYFXJIvHshrkBRbDDjouHg1j9ryOYp0jugWfxOhfs9zZ7SBt72g9e+8y
	UNar3hGfRY2Plf6T++P7drCBELs86oXoaA2+ECV6/PeURR1sKkhGKcotcV0Ektq8IQHHwyllEEEmM
	Iu4Ar+fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEKg-00HAUR-28; Sat, 22 Jan 2022 11:13:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEJh-00HA87-Ek
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZXy6AjZjPC6H/SXIyE5VyyrzC96iMDRLk5+OuIek/c=;
 b=Q5LSABOojcG7kNLxrUXDsn/LOoFdHAnJzsb9spt2IQo3ATVJmbN0ZbfIJ3xRFA70NfM0ZK
 2v9EaIzhqE3YzI1/6p5f9zHVVLcojLzusCuEqCSAmwTJZgEvi86ADSWNpE5U4zPs2+stKW
 kuauCRZK1z1fIXKAOhdm8jNjU3oGb34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-VMuyXiscMfyyuedqexKhUA-1; Sat, 22 Jan 2022 06:12:15 -0500
X-MC-Unique: VMuyXiscMfyyuedqexKhUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFBEF2F47;
 Sat, 22 Jan 2022 11:12:13 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC14D7B9DC;
 Sat, 22 Jan 2022 11:12:12 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 07/13] block: move q_usage_counter release into
 blk_queue_release
Date: Sat, 22 Jan 2022 19:10:48 +0800
Message-Id: <20220122111054.1126146-8-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031221_596830_E42103EE 
X-CRM114-Status: GOOD (  13.44  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

After blk_cleanup_queue() returns, disk may not be released yet, so
probably bio may still be submitted and ->q_usage_counter may be
touched, so far this way seems safe, but not good from API's viewpoint.

Move the release ofq_usage_counter into blk_queue_release().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c  | 2 --
 block/blk-sysfs.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9477191b303..bcb4d982cd80 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -341,8 +341,6 @@ void blk_cleanup_queue(struct request_queue *q)
 		blk_mq_sched_free_rqs(q);
 	mutex_unlock(&q->sysfs_lock);
 
-	percpu_ref_exit(&q->q_usage_counter);
-
 	/* @q is and will stay empty, shutdown and put */
 	blk_put_queue(q);
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6f326b44fb00..5f14fd333182 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -780,6 +780,8 @@ static void blk_release_queue(struct kobject *kobj)
 
 	might_sleep();
 
+	percpu_ref_exit(&q->q_usage_counter);
+
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
-- 
2.31.1


