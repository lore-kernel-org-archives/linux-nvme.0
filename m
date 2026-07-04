Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2466C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZHOaqZ/LhOhHQYZrYbmcZFHexqdd2uvYRy06XraBRZw=; b=GenkQdhdkqb10KTlVC17yjavDG
	XULCGvreRBPabwwfqTu/VN/BwIK841XTdasIwwmP+PRQMHLpccQaJ1qEzU6Jhp9CnCGh2EYaiQmbj
	rXpsVWgpRpd5ZEyPghPHUs4gOaSyFLnRzzvfyPPb6+0faTLPLJnj5Je1rnIsqeP3/0mbegQFBxOKC
	OFVjm3RHwIdkP94Z9D5BL6bgzftjVwCUmPU3iJhVbylUCBg05mH+ri++gevizPLvljV1Z+fJa/yia
	tcbscqgmn7hc2H6GFS+MDRqeJJdQvmY+5zjF3sp2EZ2WSi18v8VQDt05mgFF/vhkD+gunuS8W3Q9b
	Ctwo9lWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Qr-00000008j9S-1s0W;
	Sat, 04 Jul 2026 19:53:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6Qp-00000008j93-2XS1
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:53:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1056A61373;
	Sat,  4 Jul 2026 19:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8EC1F00A3A;
	Sat,  4 Jul 2026 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194822;
	bh=ZHOaqZ/LhOhHQYZrYbmcZFHexqdd2uvYRy06XraBRZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYJLAz9VYwydHo4sD+p6eGMOD8kpwfPJtash7Ltij6VmKmwEyHRwoDKBdWdX3DqAS
	 n4qwbrhW32pOz0qBM+pR+OwA06+0/8Lxh3TMqAypDQKjqcLgziKaWlR/iRevm20zrp
	 1VPKHNmg45HWT2FZ8irnbc0fMwCgNTtekSIUjxoKXZ8Q/oCo95Q19im7QAMNGhTwHX
	 36XKdC6l5/vhmc1QiisH8s98dSAkp6KhllcyXZY0lQb9NJhpdnbtxX36t1hN+r9H9u
	 7SMMa4MnKT0JKPx1nWvMXTtUprjhiXMEL/43sSAby6/bnJivg7IO0oyPKPoDigpN4R
	 kcCfUOGMqAxQw==
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
Subject: [RFC PATCH v1 10/17] dm pcache: handle non-blocking bio clone init failure
Date: Sun,  5 Jul 2026 03:51:17 +0800
Message-ID: <20260704195124.1375075-11-yukuai@kernel.org>
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

dm-pcache may preallocate backing requests with GFP_NOWAIT and initialize
the embedded bio with bio_init_clone().  Non-blocking clone initialization
can now fail if cloning the blkg association would need to create a blkg.

Check the return value and free the preallocated request on failure so the
existing caller can retry through its GFP_NOIO preallocation path.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-pcache/backing_dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-pcache/backing_dev.c b/drivers/md/dm-pcache/backing_dev.c
index 7165fc0364bb..5bde289ec5d7 100644
--- a/drivers/md/dm-pcache/backing_dev.c
+++ b/drivers/md/dm-pcache/backing_dev.c
@@ -204,6 +204,7 @@ static struct pcache_backing_dev_req *req_type_req_alloc(struct pcache_backing_d
 	struct pcache_request *pcache_req = opts->req.upper_req;
 	struct pcache_backing_dev_req *backing_req;
 	struct bio *orig = pcache_req->bio;
+	int ret;
 
 	backing_req = mempool_alloc(&backing_dev->req_pool, opts->gfp_mask);
 	if (!backing_req)
@@ -211,13 +212,20 @@ static struct pcache_backing_dev_req *req_type_req_alloc(struct pcache_backing_d
 
 	memset(backing_req, 0, sizeof(struct pcache_backing_dev_req));
 
-	bio_init_clone(backing_dev->dm_dev->bdev, &backing_req->bio, orig, opts->gfp_mask);
+	ret = bio_init_clone(backing_dev->dm_dev->bdev, &backing_req->bio,
+			     orig, opts->gfp_mask);
+	if (ret)
+		goto free_backing_req;
 
 	backing_req->type = BACKING_DEV_REQ_TYPE_REQ;
 	backing_req->backing_dev = backing_dev;
 	atomic_inc(&backing_dev->inflight_reqs);
 
 	return backing_req;
+
+free_backing_req:
+	mempool_free(backing_req, &backing_dev->req_pool);
+	return NULL;
 }
 
 static struct pcache_backing_dev_req *kmem_type_req_alloc(struct pcache_backing_dev *backing_dev,
-- 
2.51.0


