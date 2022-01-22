Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18844C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tqhve7JJhbDQBptqG2AcZsgYpgBMvqtn5u69ofC0wkI=; b=MlymYCChkbDBOcaToL4v3IoC3V
	ZRRAOHBscwiqZtP2sPWCj6UrPoFhx9cry6LG+WXDoBFtQy9lTD0nqaBOSBo+pQAJexe/57o1TkjZB
	Qk5hfyyRO10e1ehwuShrDcSuq/pw6VbVzANAOqwQjd9nJoPpy3QZ8Fkz5js2kL8w2mHytrLyUhiny
	lk6i0vAqKX0OO4obKtSMA2r9PgIxRPX3T9muUqbXNG5HJm8CtuLeLztaSj3WDJfFqaWMT3QGpw7v8
	39GwG+4xKWb7Ibmcb7VG9Dk9+ppXDXay8jwbXwdhYNaTU/B1QAxlaRLB4IKM02YV/ut3fz/oZRIhX
	woEoOEbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEMC-00HAvX-NR; Sat, 22 Jan 2022 11:14:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEK3-00HAG4-PQ
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:12:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqhve7JJhbDQBptqG2AcZsgYpgBMvqtn5u69ofC0wkI=;
 b=bXGbQOKD3SR8ls0dBsqB2uKDCTx1It9Z2diHO7DR4m3y0xHjLfWb9ezDCZqmSAoWkPi7PF
 kldGOmXFch5QnFvj6uBvUAY3PCMpYxdwg14E9TkPF2FEaAhXaAb+CAnzBgtdT4xqWl6kgJ
 YYRRxNUfROEQXNEowY4SVuUA3W9SPTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-9Rq3Ax0EPSiVOhMzJ1MIAA-1; Sat, 22 Jan 2022 06:12:39 -0500
X-MC-Unique: 9Rq3Ax0EPSiVOhMzJ1MIAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5501918397B3;
 Sat, 22 Jan 2022 11:12:38 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1481081300;
 Sat, 22 Jan 2022 11:12:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 10/13] block: add helper of disk_release_queue for release
 queue data for disk
Date: Sat, 22 Jan 2022 19:10:51 +0800
Message-Id: <20220122111054.1126146-11-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031243_958407_21AAC9AB 
X-CRM114-Status: GOOD (  14.53  )
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

Add one helper of disk_release_queue for releasing queue data for disk.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5bd7bcd6246e..a86027619683 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1085,6 +1085,20 @@ static const struct attribute_group *disk_attr_groups[] = {
 	NULL
 };
 
+static void disk_release_queue(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+
+	blk_mq_cancel_work_sync(q);
+
+	/*
+	 * Remove all references to @q from the block cgroup controller before
+	 * restoring @q->queue_lock to avoid that restoring this pointer causes
+	 * e.g. blkcg_print_blkgs() to crash.
+	 */
+	blkcg_exit_queue(q);
+}
+
 /**
  * disk_release - releases all allocated resources of the gendisk
  * @dev: the device representing this disk
@@ -1106,19 +1120,12 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	blk_mq_cancel_work_sync(disk->queue);
+	disk_release_queue(disk);
 
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
 
-	/*
-	 * Remove all references to @q from the block cgroup controller before
-	 * restoring @q->queue_lock to avoid that restoring this pointer causes
-	 * e.g. blkcg_print_blkgs() to crash.
-	 */
-	blkcg_exit_queue(disk->queue);
-
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
 	iput(disk->part0->bd_inode);	/* frees the disk */
-- 
2.31.1


