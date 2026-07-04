Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BAFC43602
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=meOw3Z9Denlj5voe7/+ys0H168Jrgw9IPm8tzXoGU8w=; b=JFzi3UdujHcsikpAbUD98HOC3a
	51iof23iqzLJlPshsYczwr2DR1tjHB67wiwAFbpW54tfoZ1rFlgNIR7r2k8BPU8sUXJqc3sYriTob
	/PIghGEQ0I+fOnKBH42Mq32WW525+3q19gM3NviBtSMb6C2CM0V86y5IYBDposOkVAwMWMztNzG0h
	4KqWL7mxvu8JdLhTJQBOegFv06zVZQ5bWibhuQfKIOS3V1luzShAfSFh13Ba4c+6EhrghEYK9VyYV
	eRs1O+3ryxPMNI92SJwlbJmEcGyLE1Fk+gt35tXRM8stBQLGFF4QrXr43y2VSBNPV77VOocQH13uc
	yxm4BX7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6PO-00000008ibB-2kAV;
	Sat, 04 Jul 2026 19:52:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6PN-00000008iaH-2AFX
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:52:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 24B9E6136E;
	Sat,  4 Jul 2026 19:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D27A1F00A3D;
	Sat,  4 Jul 2026 19:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194731;
	bh=meOw3Z9Denlj5voe7/+ys0H168Jrgw9IPm8tzXoGU8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCleqOGY6Uz+hi0/zU6kBYPX4JkgvvTkKyjqWmrJU/2q9rYkqtbUxVTXZUz1xSr6L
	 JlZMHeED72uBZdY27eg8DN+RV7s7+2xWEZ3RAryRAU7nq29ggpFn5tMwvxwMMjeNeC
	 mtckbJ1SdrUm0/bbZ/P8Lm0QL/vgZkBHl/uNFw13H/ipHe3JABKjTjyIaxWjfxMpq0
	 xvwOV9dEQOqFe6kjXyzVGgd2olEOgdLFFbVZi+jdMeQkASR5axcoj9Wavfg7dth4F6
	 pIVd1jrnnBAGfy9bSJfMpiHv6km/k9d6SFU9bsMKxt2QwNEZ1a8CWPqmKK6fKqYwMn
	 QhvjMXXLC78wg==
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
Subject: [RFC PATCH v1 02/17] dm thin: avoid bio_set_dev under pool lock
Date: Sun,  5 Jul 2026 03:51:09 +0800
Message-ID: <20260704195124.1375075-3-yukuai@kernel.org>
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

bio_set_dev() is about to become explicitly sleepable because it can
associate the bio with a blkg for the destination queue.  pool_map()
calls bio_set_dev() while holding pool->lock with interrupts disabled,
which would be invalid once bio_set_dev() may sleep.

The lock is not needed in this map path.  The pool target is a singleton
mapping and pool_map() only reads pt->data_dev, which is a target-private
device reference acquired during construction and released during target
destruction.  It does not inspect or modify pool state protected by
pool->lock.

Remove the lock so the remap stays in the normal sleepable DM map context
while the data device pointer remains stable for the table lifetime.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/md/dm-thin.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 59392de7a477..358ed77ffb2b 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3438,14 +3438,11 @@ static int pool_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 static int pool_map(struct dm_target *ti, struct bio *bio)
 {
 	struct pool_c *pt = ti->private;
-	struct pool *pool = pt->pool;
 
 	/*
 	 * As this is a singleton target, ti->begin is always zero.
 	 */
-	spin_lock_irq(&pool->lock);
 	bio_set_dev(bio, pt->data_dev->bdev);
-	spin_unlock_irq(&pool->lock);
 
 	return DM_MAPIO_REMAPPED;
 }
-- 
2.51.0


