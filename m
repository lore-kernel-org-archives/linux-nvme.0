Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA8C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Jan 2022 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYSY5CHYNIA9hN8QVlij2GnIqK59IRJkhItz3wdmKVE=; b=PD82rnTOrXnrXiMLccdmlxJSme
	Sjz4ogcl9gqyz6SDDppRqLSMZXRH+huUTfhyfnshMnwZ/TNF9or/K528tU/ngOXGpVsrL5emxqy41
	RHALJsmmc9WTrberP+c64cLOOkLFtXpeDoTuUbuRYA0kyjWJsyq9ysuTvnyXZt/hTjpw/8IScG1py
	ehPjZYYPDNLVYmw2XzLF8UlaBB2J38AHetEdbRTmux6N39EM4IEf8EMS+EjMe/c3zlZVHji6furGz
	FH+CnTxHRiH8wrY+aut5G3X6oceDF4iuxklQW1VNJBUuxw58DPtEYHZUt8VG64ohEF4MFJflC1SR4
	Bjlhz7Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBEJ2-00H9wN-0I; Sat, 22 Jan 2022 11:11:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBEIy-00H9vS-0v
 for linux-nvme@lists.infradead.org; Sat, 22 Jan 2022 11:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642849895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYSY5CHYNIA9hN8QVlij2GnIqK59IRJkhItz3wdmKVE=;
 b=ZoTRaxH982hOWIA1zzDPBz/1GM7mc4XUg1hIwQdbpOdJWVccJf0Yq4foFppNGs8TvAkK+T
 wB5zSpDAVH4outb+nJuPl8VXmfe1Z6Hgbjfx+S36Ti70hTkfltzEYFVwpqdK+/Z2wa69KH
 0Gp1cski3LFNkSBWjplGEZEZKwwFKPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-jpdpLSJKOjeU72gf5C5rmA-1; Sat, 22 Jan 2022 06:11:29 -0500
X-MC-Unique: jpdpLSJKOjeU72gf5C5rmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B9191083F60;
 Sat, 22 Jan 2022 11:11:28 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC64E7316D;
 Sat, 22 Jan 2022 11:11:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 01/13] block: declare blkcg_[init|exit]_queue in private
 header
Date: Sat, 22 Jan 2022 19:10:42 +0800
Message-Id: <20220122111054.1126146-2-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220122_031136_161567_13B72DD2 
X-CRM114-Status: GOOD (  13.38  )
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

Both two functions are used by block core code only, so move the
declaration into private header of block layer.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h                | 8 ++++++++
 include/linux/blk-cgroup.h | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 8bd43b3ad33d..7b0f12260ae6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -406,6 +406,14 @@ extern int blk_iolatency_init(struct request_queue *q);
 static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
 #endif
 
+#ifdef CONFIG_BLK_CGROUP
+int blkcg_init_queue(struct request_queue *q);
+void blkcg_exit_queue(struct request_queue *q);
+#else
+static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
+static inline void blkcg_exit_queue(struct request_queue *q) { }
+#endif
+
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b4de2010fba5..d9dcd18d77f4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -182,8 +182,6 @@ extern bool blkcg_debug_stats;
 
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
-int blkcg_init_queue(struct request_queue *q);
-void blkcg_exit_queue(struct request_queue *q);
 
 /* Blkio controller policy registration */
 int blkcg_policy_register(struct blkcg_policy *pol);
@@ -637,8 +635,6 @@ static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_mem
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
 static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
 { return NULL; }
-static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
-static inline void blkcg_exit_queue(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_policy_unregister(struct blkcg_policy *pol) { }
 static inline int blkcg_activate_policy(struct request_queue *q,
-- 
2.31.1


