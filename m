Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3589C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mXJiwwaeOWgN5pHsCgD632laX9hPGfy7GVg2b2/T7js=; b=kAowD0DzzYTtlEshkejRYinyVU
	mRwnZoaBVZe7HcyWtgnurh6U5vsINYnArnttXhZPisnNZ0pLBDEKa+mnKjczXmVg81b7OXYwU/iBJ
	wDiXRue2tq+87uPsuv2sdZd8LopZs+LzzIFiFFFwNyqoc86eZSAzl5fRKsuifK6B5/IjNBH8oeHdG
	uAh/vuIakIqaTAyjlxZUvLzGuORlpaO27euLU36qTe0xfHdqzuGeoeeScy3t+ODrhwUwqpeTjdfZv
	OVBQnGUV1qmRE9+zpbhBabld7wvETmEjagL+2KPtJqJjVyg5EuPMjFlfT2rII9Sl+b+rEEVz3PoRZ
	rA2F62Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Py-00000008imp-0b0Z;
	Sat, 04 Jul 2026 19:52:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Pv-00000008imL-3f1C
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:52:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 91ADD4121E;
	Sat,  4 Jul 2026 19:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73361F000E9;
	Sat,  4 Jul 2026 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194767;
	bh=mXJiwwaeOWgN5pHsCgD632laX9hPGfy7GVg2b2/T7js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4lNN0dGzzywNRxaL6RbtTbW0krF8yl7KvNm1psx9S8v+EoFuxPY356jqfIV6HtoT
	 MRluYXHFNTfis30lYXNmexdz9HdrBxACIAIDGZpGXI/cko4cY0p+fvUq+dfd9OyHIS
	 kpqjkeT6Di+7DaVQJ3V9SZ8QxhwJXmMKwewHuS+ljc7PMoDVi6RlrDpgwTSnsPkvvS
	 Rw58JYOrk0fQHEuk1f6ps4AbBYosAKE41/Oae2Bn0pXS782aD8g/AnCznb3ktD8dKl
	 cXk/qoyh9YABGrlWysWaRk/IBvOJ5IPZKMtunTfBT5AUi9LMRjYb3V6SFzyay8NF3i
	 veottqF8gIpqA==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 05/17] block: add bio_alloc_atomic() for atomic bio users
Date: Sun,  5 Jul 2026 03:51:12 +0800
Message-ID: <20260704195124.1375075-6-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260704195124.1375075-1-yukuai@kernel.org>
References: <20260704195124.1375075-1-yukuai@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Yu Kuai <yukuai@fygo.io>

Add bio_alloc_atomic() for callers that need a GFP_ATOMIC bio from the
default bio set but cannot safely pass a bdev during allocation. The
helper returns an unattached bio, leaving callers to set bi_bdev and
attach blkcg state explicitly before submission.

Use the helper for virtio-pmem flush child bios and OCFS2 heartbeat I/O.
Both allocate bios from atomic paths and must avoid creating missing blkgs
once blkg creation is protected by q->blkcg_mutex. virtio-pmem clones the
parent bio's blkg association; OCFS2 binds heartbeat I/O to the root blkg.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/nvdimm/nd_virtio.c   |  8 ++++----
 fs/ocfs2/cluster/heartbeat.c | 15 ++++++++++++---
 include/linux/bio.h          |  6 ++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 4176046627be..13d1ed1c466c 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -115,13 +115,13 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 	 * parent bio. Otherwise directly call nd_region flush.
 	 */
 	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(bio->bi_bdev, 0,
-					      REQ_OP_WRITE | REQ_PREFLUSH,
-					      GFP_ATOMIC);
+		struct bio *child = bio_alloc_atomic(0,
+						REQ_OP_WRITE | REQ_PREFLUSH);
 
 		if (!child)
 			return -ENOMEM;
-		bio_clone_blkg_association(child, bio);
+		child->bi_bdev = bio->bi_bdev;
+			bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
 		bio_chain(child, bio);
 		submit_bio(child);
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index d12784aaaa4b..ec70f3b62837 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/bio.h>
+#include <linux/blk-cgroup.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/file.h>
@@ -519,16 +520,24 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	struct bio *bio;
 	struct page *page;
 
-	/* Testing has shown this allocation to take long enough under
+	/*
+	 * Testing has shown this allocation to take long enough under
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
-	 * all together. */
-	bio = bio_alloc(reg_bdev(reg), 16, opf, GFP_ATOMIC);
+	 * all together.
+	 *
+	 * Use the atomic bio allocation helper so bio_init() does not create a
+	 * missing blkg. Heartbeat IO is cluster-liveness IO, so account it to
+	 * the root blkcg instead.
+	 */
+	bio = bio_alloc_atomic(16, opf);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
 		goto bail;
 	}
+	bio->bi_bdev = reg_bdev(reg);
+	bio_associate_blkg_from_css(bio, blkcg_root_css);
 
 	/* Must put everything in 512 byte sectors for the bio... */
 	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..f7d94d37893f 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -366,6 +366,12 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 	return bio_alloc_bioset(bdev, nr_vecs, opf, gfp_mask, &fs_bio_set);
 }
 
+static inline struct bio *bio_alloc_atomic(unsigned short nr_vecs,
+					   blk_opf_t opf)
+{
+	return bio_alloc_bioset(NULL, nr_vecs, opf, GFP_ATOMIC, &fs_bio_set);
+}
+
 void submit_bio(struct bio *bio);
 
 extern void bio_endio(struct bio *);
-- 
2.51.0


