Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D924BC43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEWzTgA1po1hX1rYhrIp/cwjprJ8MLHYL8f16lSvCk4=; b=lB4gcjGvO0LOhRXwTAhgVpncLr
	/C6E4dLAPFRuqf1D6ReUxo2sB8Cb9QCU0TNJgp9x64aOaDpw77ZEyKVUfNK9wwylpV6YgFr583e1q
	YHsdxEcJDGRtuaH7yk1I9SA0DwNovi9jqf74hg6kPs2BzpHLjJpsr8HnepcfYwkLgOANlKeTQ/DOt
	MarskRQQlWiKUUppy3j81GCyCI5boYUkZZGAgaro+o/U9cOPnM5Am3kvMPItNcXkJq4Vzv9W7Yiwi
	TiMnaHpY7UBDOAsc2rcZhBa9fruM6cRzJxz2Xpqy9NHRgC6G9BEaN4aa12tACIkqeiW956xACtIa5
	j3cWlDrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6PB-00000008iXe-2I6S;
	Sat, 04 Jul 2026 19:52:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg6PB-00000008iXD-0M0c
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jul 2026 19:52:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 937E543991;
	Sat,  4 Jul 2026 19:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B1C1F00A3A;
	Sat,  4 Jul 2026 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194720;
	bh=xEWzTgA1po1hX1rYhrIp/cwjprJ8MLHYL8f16lSvCk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JINEA6c00skJHu9zlRvNX+FA16QvP7mcotl6mJOt7XUfQUPb8mLSl4rveDf/wbkFL
	 4nh7WqNa958naDV0x1GUFSZpU6zpkrBfQDsv2ouWJnlBWybSE2CCAdQZ2wBxQ8h3h/
	 PqcPcvlyBNBE5/jEHcW9jTSpK4Nu3FIvEgfSMFxpR7cJ0kxWevK5Sdfcm68wJ077YG
	 AvPyANALTYuXgfvXMXMkObu2wQ07oTueOOHyRHfag3m2nuDW+6yCNQ1WXCBPQ3JOL0
	 6rRO33VnV/fSbeKB6guedZthyoZFZoTuFgu5hc166uSZJV0cT6B1ETHgNe6YnVX4fD
	 /N/5GmJxaAwvA==
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
Subject: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios from requeue work
Date: Sun,  5 Jul 2026 03:51:08 +0800
Message-ID: <20260704195124.1375075-2-yukuai@kernel.org>
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
associate the bio with a blkg for the destination queue.  NVMe failover
can run from request completion context, and nvme_failover_req() also holds
head->requeue_lock with interrupts disabled while it steals bios from the
failed request.  Calling bio_set_dev() there is not safe once the helper is
allowed to sleep.

The requeue lock only protects head->requeue_list.  Keep the list
manipulation under that lock, but defer retargeting to nvme_requeue_work(),
which already drains the list from process context before resubmitting each
bio.  The bios remain private to the requeue list until the worker pops
them, so moving the device switch there preserves the existing retry flow
while avoiding a sleepable helper in completion context.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 drivers/nvme/host/multipath.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..76baa180ae1c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
-	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
 	atomic_long_inc(&ns->failover);
@@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next)
-		bio_set_dev(bio, ns->head->disk->part0);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
@@ -684,6 +681,7 @@ static void nvme_requeue_work(struct work_struct *work)
 		next = bio->bi_next;
 		bio->bi_next = NULL;
 
+		bio_set_dev(bio, head->disk->part0);
 		submit_bio_noacct(bio);
 	}
 }
-- 
2.51.0


