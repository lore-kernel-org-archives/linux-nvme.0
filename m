Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E6E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjA/XcjTSFtkMiIGL1mViD853KKavTU9ifMZrEUBqJA=; b=DjQJBC1QPZhvDpzPy9Q5o91/9p
	k8BoAmrQU7eNRfjoJJEGEOCSgVhZJuEU+K8oA4ecvgH+I+PYfYfYkPZmV2eNdLUv613WkWiI3edSL
	P02KkRPMcV8CToVNbh5Cs8KRHE7vpMDgv/R2rRItj08FcR6nTebTv+F9Cj+Cyz4w8J93ak7mQXI/e
	QGJTa106ivr3vKEZbuPOic1ROqa7B+gT3GZmZ1MJzdr0RCjqlQvv4dzvg6k9oGJUB4gIipZ0dgvDZ
	A/MgdGr6J4n107HzmHcLn7NP840uCEytTJ0ZlYxFgDI6JaoSD4gr3A21It2dCNv2TyJqbUjNEA2+t
	d2XCB10A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AK-0000000F2jz-1vpu;
	Sat, 04 Jan 2025 13:26:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU4AE-0000000F2ha-1uUO
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 13:26:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B99A05C54B5;
	Sat,  4 Jan 2025 13:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5884C4CEDF;
	Sat,  4 Jan 2025 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997161;
	bh=2am3FapwRA8t0IL3zu3UkrLfm2C8ws46MF9QDum4EY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ets+EtRsm2yOvtZgSBvtRg44/RkWIIjTwc1QUHKg3FukZWGr5hBbeULLCDiyKvGzj
	 gsePPpSPaHYYgJ5EpCVw++oj2bi844ygJONT4r+UbloUhMaKXGOmW3Ap6KxmLiy09T
	 BFRInbln8ySSDa2eg8FozL/TjJokO/c90u17eueeWGfXCZnsNvpPmzUEFNqk3Dr+Vi
	 cuZDU65qIQuP0XoREtRLc7++Ahe8HTgxQQX/Yb4VX/nGbph6O8Kmt5jjpp7op4GYWS
	 QkUXnf53m9sfXBktIwjpJo16wa59D/PEFB3v2gQ6sD7vk1awUUBdTOjazidEqFIGN8
	 6qdB3ZkCxJC0A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue freeze and limits lock order
Date: Sat,  4 Jan 2025 22:25:21 +0900
Message-ID: <20250104132522.247376-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104132522.247376-1-dlemoal@kernel.org>
References: <20250104132522.247376-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_052602_575794_5298712B 
X-CRM114-Status: GOOD (  15.71  )
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

__blk_mq_update_nr_hw_queues() freezes a device queues during operation,
which also includes updating the BLK_FEAT_POLL feature flag for the
device queues using queue_limits_start_update() and
queue_limits_commit_update(). This call order thus creates an invalid
ordering of a queue freeze and queue limit locking which can lead to a
deadlock when the device driver must issue commands to probe the device
when revalidating its limits.

Avoid this issue by moving the update of the BLK_FEAT_POLL feature flag
out of the main queue remapping loop to the end of
__blk_mq_update_nr_hw_queues(), after the device queues have been
unfrozen.

Fixes: 8023e144f9d6 ("block: move the poll flag to queue_limits")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8ac19d4ae3c0..1f63067790c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5021,8 +5021,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		struct queue_limits lim;
-
 		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
@@ -5036,13 +5034,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			set->nr_hw_queues = prev_nr_hw_queues;
 			goto fallback;
 		}
-		lim = queue_limits_start_update(q);
-		if (blk_mq_can_poll(set))
-			lim.features |= BLK_FEAT_POLL;
-		else
-			lim.features &= ~BLK_FEAT_POLL;
-		if (queue_limits_commit_update(q, &lim) < 0)
-			pr_warn("updating the poll flag failed\n");
 		blk_mq_map_swqueue(q);
 	}
 
@@ -5059,6 +5050,22 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		struct queue_limits lim;
+		int ret;
+
+		lim = queue_limits_start_update(q);
+		if (blk_mq_can_poll(set))
+			lim.features |= BLK_FEAT_POLL;
+		else
+			lim.features &= ~BLK_FEAT_POLL;
+		blk_mq_freeze_queue(q);
+		ret = queue_limits_commit_update(q, &lim);
+		blk_mq_unfreeze_queue(q);
+		if (ret < 0)
+			pr_warn("updating the poll flag failed\n");
+	}
+
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
-- 
2.47.1


