Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD53CD1294
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gwylf9TBaIKNNv/itpn/iFaYxpS9dxdSL039ecb6I0o=; b=sqLHOYn2heVDiC4V5veRFWy78T
	eQFQtASDpSRQ/jDoWzXDwhS9/CIATJ679JSvjmrpESK2LxUNKb3FLBuQtDFxk1upF12OOsQwSFsGu
	YrOW+WUFyzXcXiM0oCDe7b3Rh+Fr1K9tDQMOTE5W7h+ceYxRgksv/orzFxv7k2PyAvVYiA+286wuU
	OkBjPT4+i4z77IVwLo/lQ2lTqmmJDdl9eczXW941r35PuUt/bkrGONDC5NcLblSLF7aJ4GALIlLhC
	EsYCOL+SPHwLHwJQltrKXAvjPs96uOiFrP0XPEdA/8zMh/c29j6hPnFSx9GrNIcOCOYHe6/mC0O3U
	6InsnWNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxFG-0000000FIgF-3DlC;
	Wed, 03 Apr 2024 09:49:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDW-0000000Ez7A-0OJp
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Apr 2024 08:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=Gwylf9TBaIKNNv/itpn/iFaYxpS9dxdSL039ecb6I0o=; b=j4B7usPZjFN3SDZHWmh4HHM+EM
	Jx0JaaylzkACaA3lDy2sv3FCuguhkGPDWWXOjO5itZXBS5hhS4Z+NItbE9G5GiDXFEKZROHm03Fmy
	+yLxWg996LsJL1kScF2Xx2n2/u4XL9N+JcSNYYV7/YnbBb71M5v9fqUqbqHgZSIob62zeuyDjtZpT
	3NIQjBx/4Bu9e9yGZzMpv9OsigCPdjuL5C9aUTQoHBAMP/lzt2JnuRMVpLq/obB3p8Eyf1WrOUB6c
	a3EAlgT9yStg7AJJy793oL92U3wP2ryOdIPZb79u+rhIzmAuEBqP3yKC48XlFu3ErRTHGnIG8BilT
	h+sWwGZA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDS-000000046Ou-1W2U
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0C33B6134B;
	Wed,  3 Apr 2024 08:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90435C43399;
	Wed,  3 Apr 2024 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133809;
	bh=sMuCJ0nj8poHWFAKZ1D0EChr/dsmLO2uNOiBZkGo+8Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UphjgocW5F/mFflDMQ8qtnEBbS1NLf5fJDNLfvolHI5HW6R3qOo1hdxWGC0AhYx8h
	 PsYEmCXQQRnDMOcyvUv2WrMq79EOs05yLPoLsKxosw53SgY/OTnDIGlfuxcYlrI3zV
	 c9ZWwgbTs1WMck2emA/Eo+lcXEjHfu0Y2Nfm9G8bYhD2TyhjMiPI0xNdZeyF341O9F
	 vgpaOarwRypsLwosuGMzRcJfkkf12xBKi/srokTeq19DD3Q+7n30RUZYVHU8LnypZ5
	 lzZlYJlVg5VTA0GZywRBcGsq1PwAawBx/IA/PaWttZ278Ix32CN1wZ6lOhnBq/rbhg
	 iv/7LGqfz98Xg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 25/28] block: Replace zone_wlock debugfs entry with zone_wplugs entry
Date: Wed,  3 Apr 2024 17:42:44 +0900
Message-ID: <20240403084247.856481-26-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_094330_789113_51169AEF 
X-CRM114-Status: GOOD (  16.62  )
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

In preparation to completely remove zone write locking, replace the
"zone_wlock" mq-debugfs entry that was listing zones that are
write-locked with the zone_wplugs entry which lists the zones that
currently have a write plug allocated.

The write plug information provided is: the zone number, the zone write
plug flags, the zone write plug write pointer offset and the number of
BIOs currently waiting for execution in the zone write plug BIO list.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-debugfs.c |  2 +-
 block/blk-mq-debugfs.h |  4 ++--
 block/blk-zoned.c      | 31 ++++++++++++++++++++++++-------
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 94668e72ab09..ca1f2b9422d5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -160,7 +160,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
 	{ "pm_only", 0600, queue_pm_only_show, NULL },
 	{ "state", 0600, queue_state_show, queue_state_write },
-	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
+	{ "zone_wplugs", 0400, queue_zone_wplugs_show, NULL },
 	{ },
 };
 
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 3ebe2c29b624..c80e453e3014 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -84,9 +84,9 @@ static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 #endif
 
 #if defined(CONFIG_BLK_DEV_ZONED) && defined(CONFIG_BLK_DEBUG_FS)
-int queue_zone_wlock_show(void *data, struct seq_file *m);
+int queue_zone_wplugs_show(void *data, struct seq_file *m);
 #else
-static inline int queue_zone_wlock_show(void *data, struct seq_file *m)
+static inline int queue_zone_wplugs_show(void *data, struct seq_file *m)
 {
 	return 0;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 66cbf4ca3882..2478775fb9d6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1806,17 +1806,34 @@ EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
 
 #ifdef CONFIG_BLK_DEBUG_FS
 
-int queue_zone_wlock_show(void *data, struct seq_file *m)
+int queue_zone_wplugs_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
-	unsigned int i;
+	struct gendisk *disk = q->disk;
+	struct blk_zone_wplug *zwplug;
+	unsigned int zwp_wp_offset, zwp_flags;
+	unsigned int zwp_zone_no, zwp_ref;
+	unsigned int zwp_bio_list_size, i;
+	unsigned long flags;
 
-	if (!q->disk->seq_zones_wlock)
-		return 0;
+	rcu_read_lock();
+	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
+		hlist_for_each_entry_rcu(zwplug,
+					 &disk->zone_wplugs_hash[i], node) {
+			spin_lock_irqsave(&zwplug->lock, flags);
+			zwp_zone_no = zwplug->zone_no;
+			zwp_flags = zwplug->flags;
+			zwp_ref = atomic_read(&zwplug->ref);
+			zwp_wp_offset = zwplug->wp_offset;
+			zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
+			spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	for (i = 0; i < q->disk->nr_zones; i++)
-		if (test_bit(i, q->disk->seq_zones_wlock))
-			seq_printf(m, "%u\n", i);
+			seq_printf(m, "%u 0x%x %u %u %u\n",
+				   zwp_zone_no, zwp_flags, zwp_ref,
+				   zwp_wp_offset, zwp_bio_list_size);
+		}
+	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.44.0


