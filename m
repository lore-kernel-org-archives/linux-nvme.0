Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D3C02190
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFSrhKXQAn/0XPDpA62pxidD+Tv5AnoZhErzPyfoWPM=; b=WJzTEr99b46X9m9ZKYg+Fc+P/K
	cr2TRs8IIkv1oQrWv6TeZdVcyztQKiopYffillFSIacPxfBBWhP0WPB8mv2wT8vauHbWa9G1RJVDc
	cJOxEJ+xyYeE0eGp+ygtewT4WBkHzLnqILLKrXknjH28lRfJyVWzHhTjmC5ADBQ2S+X7S28unCbtO
	p7QkxC6/9iV7TFWhBBuGaNzJxKqXa5O3uqzGaq0VUWcoTJllSJ+mV7RG3u8UydD3MhngUfLFS6jx3
	B0oVZBDrB7hdtOkztGXjeo/hjI70dlL+GlLmwETYXeT/40PWAZMWMoxmb3Ow+oQ4G4w4UDHig8B97
	2tM/o+9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcofB-00000005MMk-1X6u;
	Tue, 28 Jan 2025 16:42:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcoYV-00000005LR8-1lHA
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 16:35:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BE4495C60C9;
	Tue, 28 Jan 2025 16:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C93C4CEF1;
	Tue, 28 Jan 2025 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738082114;
	bh=IzcjVmVuBIS5G+lZmSs0a5GGbYPjcP4YaCwLUAG7tcs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GD1PYUpHYnlAZu3zZ/6p+BZILmWYaepfLpRpIKfx8nX8dptXveZR7XoMs+ecIjCos
	 qKO4pt7udVedW1+j+yzidTTMfU4XB/i62ghejeHSp47cV723LHSSXUfkVyHGDc0ul3
	 uqCuk/KRuM5EX2P9Ss/jBQwkcfXrJ6/RZb9iCdrLPd/J3Gljfz74if4mquWKebijwd
	 lJWr9ayvSDuU+MO4CRgs3uZ/sK2yH2DJPIfYbvNd+Qi+SyRJeG7xyfm3+PSWJyK3Ac
	 YyxcaDwtR/QKUWUYhkY+ODss1J8BR3y5ShcUYEDQdmIiXeW+qQs0vkWv/lYxAgpZS0
	 Kk37shHCBcr+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 28 Jan 2025 17:34:48 +0100
Subject: [PATCH 3/3] blk-mq: fix wait condition for tagset wait completed
 check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
In-Reply-To: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <ming.lei@redhat.com>
Cc: James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_083515_518739_14E79B77 
X-CRM114-Status: GOOD (  12.92  )
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

blk_mq_tagset_count_completed_reqs returns the number of completed
requests. The only user of this function is
blk_mq_tagset_wait_completed_request which wants to know how many
request are not yet completed. Thus return the number of in flight
requests and terminate the wait loop when there is no inflight request.

Fixes: f9934a80f91d ("blk-mq: introduce blk_mq_tagset_wait_completed_request()")
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-tag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b9f417d980b46d54b74dec8adcb5b04e6a78635c..3ce46afb65e3c3de9f11ca440bf0f335f21d0998 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -450,11 +450,11 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-static bool blk_mq_tagset_count_completed_rqs(struct request *rq, void *data)
+static bool blk_mq_tagset_count_inflight_rqs(struct request *rq, void *data)
 {
 	unsigned *count = data;
 
-	if (blk_mq_request_completed(rq))
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		(*count)++;
 	return true;
 }
@@ -472,7 +472,7 @@ void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
 		unsigned count = 0;
 
 		blk_mq_tagset_busy_iter(tagset,
-				blk_mq_tagset_count_completed_rqs, &count);
+				blk_mq_tagset_count_inflight_rqs, &count);
 		if (!count)
 			break;
 		msleep(5);

-- 
2.48.1


