Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A361C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0km6a0VXEo0Vmk+SqkA3SPojQd2Ywn1h/MoUubxrqCI=; b=ThscvwrXvuWMmJihScm9HX5+RI
	htr4cFj+bmKeoUqwT/Wysfo+Xf2lKGHfF9+/dEUtegXM68e/Njl89h3OgdbCXNmm7jxh7tYdLvCHz
	jOhhE6Buyluzf+B3CwYLwEopuT5Y2VFpXoixgU9VRCG3Fp8q5n6aIHRp2hvrdWDQvv4qg59I0GbWc
	TpiHsWRwpAGkD/NZ7kg634qHs94gfssg4YwQYCk02UKvMqEe4HvXhU6KdZpGKufRD3GMKbc+DEPro
	22jImGOHYQURqk65MKyfbAU9DHLk3VvdLMmTLMXcMGmXxhteWC/vyAyIaBPRmiR31mEbwfZRTE7L4
	vn90Syww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6RK-00000008jIx-3key;
	Sat, 04 Jul 2026 19:54:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6RK-00000008jIJ-04B7
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:54:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BF1A44121E;
	Sat,  4 Jul 2026 19:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10431F000E9;
	Sat,  4 Jul 2026 19:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194853;
	bh=0km6a0VXEo0Vmk+SqkA3SPojQd2Ywn1h/MoUubxrqCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/wBVWgwL19E+QcaB+mep9VaSMkiERMX5Ma/Hf1iIo+RKJkjFV/v2LhlMDowdrwXF
	 4n4EERyJ/LLBE2CDuL4vJ+hsorhRXmo1QT8vw6dXLjR+PU7eIxPRi/w56ugdtHB3or
	 HRVVNX2wORrOQMJBKuXTtdGJsfADpeZOAop6eHwNyqNHU3sXSEv9lyPZviRIk6A1Vx
	 lS9a+Dqq2oIwxCn27ZIpwW+++XpUfwmiLsawTpJWroR6Y16G2AvqxjFqd1EomThPZv
	 YfJ6Rg4/BBknq+oJYmbVTQGNUv6JCfNezd/ZXNx3o0svUuCTNpxpTbnj7da8NY8sZX
	 TYoTKaCMdCZIg==
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
Subject: [RFC PATCH v1 13/17] bfq: avoid blkg lookup from locked cgroup update
Date: Sun,  5 Jul 2026 03:51:20 +0800
Message-ID: <20260704195124.1375075-14-yukuai@kernel.org>
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

bfq_bio_bfqg() is called while bfqd->lock is held from the merge and
request insertion paths. It walks bio->bi_blkg and its parent chain to
find the closest online BFQ group, and also updates bio->bi_blkg when
the original association points at an offline or otherwise unusable
blkg.

After missing blkg creation is protected by q->blkcg_mutex,
bio_associate_blkg_from_css() can sleep on lookup misses. BFQ must not
call it while holding bfqd->lock. The blkg BFQ wants is already known
from the existing bio->bi_blkg ancestry walk, so update bio->bi_blkg by
swapping references to that existing blkg directly instead of looking it
up again by css.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-cgroup.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 5c2faf56c8ef..06c4ec6d5e35 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -604,6 +604,16 @@ static void bfq_link_bfqg(struct bfq_data *bfqd, struct bfq_group *bfqg)
 	}
 }
 
+static void bfq_bio_update_blkg(struct bio *bio, struct blkcg_gq *blkg)
+{
+	if (bio->bi_blkg == blkg)
+		return;
+
+	blkg_get(blkg);
+	blkg_put(bio->bi_blkg);
+	bio->bi_blkg = blkg;
+}
+
 struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 {
 	struct blkcg_gq *blkg = bio->bi_blkg;
@@ -616,14 +626,13 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 		}
 		bfqg = blkg_to_bfqg(blkg);
 		if (bfqg->pd.online) {
-			bio_associate_blkg_from_css(bio, &blkg->blkcg->css, false);
+			bfq_bio_update_blkg(bio, blkg);
 			return bfqg;
 		}
 		blkg = blkg->parent;
 	}
-	bio_associate_blkg_from_css(bio,
-				&bfqg_to_blkg(bfqd->root_group)->blkcg->css,
-				false);
+	blkg = bfqg_to_blkg(bfqd->root_group);
+	bfq_bio_update_blkg(bio, blkg);
 	return bfqd->root_group;
 }
 
-- 
2.51.0


