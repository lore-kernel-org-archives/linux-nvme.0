Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317CFCA9EC5
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GKW5xpKBD0VlTskii2gGoVx8+tNmEg/2KVphutWQLtM=; b=KiKkuU4rZ52YDzg+PpmNNjclgI
	wK1jJNfKjmMVsKPQK6KXMa6aNIp5P5N1BfMnCfBdnbX6rR+mCxJOpw9KJ1W6a/4wyexcZyZvmgqYz
	FL40oPguLu9R0NxR7VA2zRz/9Q62TyMNhFz+/gxgTMTtTQQHnZpPEnStqFL/yYgrrF1WMRzxBq2cS
	Bvomlu2vzrJu29z2f+1uUdcdLx56UXfRNSzmp9nEsrjJGlevv6TmvawIsdMpg6rJJXig/f8SKAtxl
	rQRyJVqOymiq9aEuVlpZlVpN+XSZS0mphgduVEIrytSCCYi/xPllyJfxzngyTpTdXG+xrGGczGScq
	CzWK1O8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8t-0000000BmVD-0pPK;
	Tue, 13 Oct 2026 02:21:27 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8p-0000000BmSZ-1DXk
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858079; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GKW5xpKBD0VlTskii2gGoVx8+tNmEg/2KVphutWQLtM=;
	b=dPmghGFfg+9w5JCF0XA3Qgn2qzkp2Xz0MNS8O/5ZPajZYMua5GxWUJajdFBjgHvpBot+Q+ORn5J2/llYvSw7Qu8+dt8SRbWFhkwZrOYL5OfpiMsS4UaQ6d4fPg5giX6kDdeO3hJkG4Yxz/40DemDT5/wtt3UxhsdVqBHKTZ8j4E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCk-8e1_1791858077;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCk-8e1_1791858077 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 02/11] block: add bdev_write_stream_granularity()
Date: Tue, 13 Oct 2026 10:21:00 +0800
Message-ID: <20261013022109.1507911-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192124_040343_96FE034B 
X-CRM114-Status: GOOD (  10.97  )
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

The write stream granularity queue limit is readable through the
queue_limits structure only.  Add a block device accessor next to
bdev_max_write_streams(), so that holders of a block device can read
it without going through the request queue.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 include/linux/blkdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b8..6eca09058dec6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1307,6 +1307,14 @@ static inline unsigned short bdev_max_write_streams(struct block_device *bdev)
 	return bdev_limits(bdev)->max_write_streams;
 }
 
+static inline unsigned int
+bdev_write_stream_granularity(struct block_device *bdev)
+{
+	if (bdev_is_partition(bdev))
+		return 0;
+	return bdev_limits(bdev)->write_stream_granularity;
+}
+
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	return q->limits.logical_block_size;
-- 
2.43.7


