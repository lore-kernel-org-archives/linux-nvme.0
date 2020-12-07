Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45C8C1B087
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E78C23440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E78C23440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wGP3JV0pLPCPmNuHzB8kQ9kT2vYuP7KcbpduGyN8UHY=; b=RDe58uDBwXRXxspyum0CGCDhL
	AOVl29crzQ8KzJMnm9BLniBILgunew/2YbJNIDgoo1t87lEDGhqVY2Ur9WJXMTq/BzKXydYpqsQsE
	AmhwWUuW4besJ5DZHBxnGN1YWW6BOQljFLrxuhK46pp193andZTiZJMel5qq5QtOnpgVmZubTNJCc
	pYwk2WRDYO2p0sbslGhLZCrhg6jO3pn5TbYOlNvF6Q3M24qyANgxZn/G6qPWYlNxVuuTc4ohC8uW9
	0lf7y5smS0be8tcFLUi/gTUaae0hZH46HyAuvTY7G+cSkp9LmX31rS4khqACPTdO62Syu/h7NzHSn
	yyXcFTyWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmGST-0005vU-2C; Mon, 07 Dec 2020 13:21:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSP-0005u0-3E
 for linux-nvme@merlin.infradead.org; Mon, 07 Dec 2020 13:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Onf2Push4rguxXZ1Ztu3vt8dSy5R2KexTj8GPT3owek=; b=gvjtxGFmxRD94KCiNQPbE61Z4O
 DGjMQpu2Lf0edVjAJPlLsfgAKT7oWhe4AqWd+56fmodjaN8Q4I2lqrZuhNkvYyanei+ZT6+hAO7GU
 u7wDsePMMeIarG9g1/qXd2EQL4SaIZE7sI7vBO13J1XNJBuft14vsC8nkhEQoIzsk/qSmoEzfVkbW
 ROY+XNX5NnFwp3mEL+9g2FhLM6cLEkVY9aZD/84ckobim3BUYN7VfcTRzx/omLCKjbjWUDmOCNySk
 g0BxrnPxrmG3I8ylq9TmMH77fQsZL59cipDZNvocXnjDB4ZEdrp8E4q4m9plwGctlMoIzxuL+t0q8
 9EHCxfsQ==;
Received: from [2001:4bb8:188:f36:4fd9:254f:b3b5:5284] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSN-0006PM-Ps; Mon, 07 Dec 2020 13:21:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] block: propagate BLKROSET on the whole device to all
 partitions
Date: Mon,  7 Dec 2020 14:19:16 +0100
Message-Id: <20201207131918.2252553-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207131918.2252553-1-hch@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Change the policy so that a BLKROSET on the whole device also affects
partitions.  To quote Martin K. Petersen:

It's very common for database folks to twiddle the read-only state of
block devices and partitions. I know that our users will find it very
counter-intuitive that setting /dev/sda read-only won't prevent writes
to /dev/sda1.

The existing behavior is inconsistent in the sense that doing:

permits writes. But:

<something triggers revalidate>

doesn't.

And a subsequent:

doesn't work either since sda1's read-only policy has been inherited
from the whole-disk device.

You need to do:

after setting the whole-disk device rw to effectuate the same change on
the partitions, otherwise they are stuck being read-only indefinitely.

However, setting the read-only policy on a partition does *not* require
the revalidate step. As a matter of fact, doing the revalidate will blow
away the policy setting you just made.

So the user needs to take different actions depending on whether they
are trying to read-protect a whole-disk device or a partition. Despite
using the same ioctl. That is really confusing.

I have lost count how many times our customers have had data clobbered
because of ambiguity of the existing whole-disk device policy. The
current behavior violates the principle of least surprise by letting the
user think they write protected the whole disk when they actually
didn't.

Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 878f94727aaa96..c214fcd25a05c9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1449,8 +1449,7 @@ EXPORT_SYMBOL(set_disk_ro);
 
 int bdev_read_only(struct block_device *bdev)
 {
-	return bdev->bd_read_only ||
-		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
+	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
 }
 EXPORT_SYMBOL(bdev_read_only);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
