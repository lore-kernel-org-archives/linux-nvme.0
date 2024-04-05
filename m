Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A340ECD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/vzdR7czz6HXdzwYxPLtTJtPMRYKX3Rt/aEZ6hKtj0=; b=O28RjSfeqLBbfetgBM/OzSGRHi
	QqQz3JWlBmEKY4kw90dkl2AzdS4mHohfOtC6wtQwe9iiGI+qpawxPg1xEDfJAH52agcDPkBkYZVp5
	Lp1Sm4wWNr3jpa823sFvezg34bElouTGudYhkFtZdchR0Yx1/RRGqPIgHeeb7MGMSk6qY62abJWTw
	om+WE0ZaJ5GJXVeu3euXnEAcdeZoryuvWnVUsyMGOBE2amgitVX/c9FTTGSmmhP6651MUVWKaYyq3
	m9N1KQoq/lMowt+zKgWxWzlt1VX8NS8g1AoDeto1zP2g0Iw9Mff9tkfeGQUMJBCjJLIVJo/tVvmfm
	SeR14DGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSV-00000005LR0-1Wdv;
	Fri, 05 Apr 2024 05:49:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPj-00000005Bfh-2hJM
	for linux-nvme@bombadil.infradead.org;
	Fri, 05 Apr 2024 04:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=T/vzdR7czz6HXdzwYxPLtTJtPMRYKX3Rt/aEZ6hKtj0=; b=nfO7BNJ6ydhGF54V/wKlr9r0Fa
	hgRMifiWA9gWqFuWS3wKFpwEzvs8YPETCDvY0YfBQ260MFmPiY+MgUFjWxrDi0YV8+p/9VfG1lxEI
	MhvRdOqAaITHiO48N7vgtsU0mfNuMaUvG+hoVAyuwrVH9pgPL6JgHWtDBdUe06bUN58FwBMWfXNBc
	OarbJhSBhegMBA6YR65xt8NoA0PYp1DK2TIrvbW5pnb5Pq6g++OzaydYj4GnPDUELUswPZLKpRsuS
	i4I8NKbxE/ZOc7pJZaG74coT+Wn+JOnnk7naEwC/+Tr2UG2+SrnICLesph3c1uheCyjuP8ZXDWkKU
	QY3mqjzQ==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPf-00000005PNh-26Mr
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 19170CE35E4;
	Fri,  5 Apr 2024 04:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C212C43390;
	Fri,  5 Apr 2024 04:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292166;
	bh=VKiSnLPkfeC6hr2erMafTGjaDdalcdYRnXEQ/jmfxWA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DRexTCTHkyQrUt0e+SNe6U6akIl8SQj8mkceD3NTv3T5zRzn8DkUD4EDTP3/ccDkF
	 sYJewhOcEcu+6wGGLdWo84O3Xxp0J7flm8olccYLl4jf74ZrMbk64bNcwpv2+ZsMB5
	 pswdqC+zqBDN8HNsev5jt4aeVMYf3nPGAgMuR55Qj1uEx6wbuw2BcFL8Dq6dcNqymM
	 plfJUpa8eXEwxbqcj9FipEBUS72ejin1rMqqsu+KAhz3LJ35+DdZJMkmLmQiC0wq8/
	 BRqmwgPWP7q/fF0FjYmow9YJqa8TKSASCpj3tY7opOTLmIAEc3js+y02Kc6XBb4hq6
	 qB1wCXYJgQ7mg==
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
Subject: [PATCH v6 25/28] block: Replace zone_wlock debugfs entry with zone_wplugs entry
Date: Fri,  5 Apr 2024 13:42:04 +0900
Message-ID: <20240405044207.1123462-26-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_054252_260441_A9151D6A 
X-CRM114-Status: GOOD (  16.48  )
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
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
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
index a06d7f7a54c7..44699b431ad0 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1808,17 +1808,34 @@ EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
 
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


