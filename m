Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32328CCF2E5
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 03:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GKW5xpKBD0VlTskii2gGoVx8+tNmEg/2KVphutWQLtM=; b=DFX8KF59q4lmDy2ecZKIOyddl1
	sjYY4mE2ftsh6ZRmBQKcx1bwyODyeTPXIzJUuOGqo61aD8aZy6Hz4nw1Ha+AKu5qVLD2xgo4/Oivj
	PIp6/xKQtRl7mQ7b9BseO3gkK6H2P9lOEsHkcKQOMLz1hySqV4ZRrM8UlC3+MfteoMetn3uwR3Y7K
	hEDjv/xLkBwVrMOOqJ1lMo5ryGuNrlyG+rNajhC6g43z9l4leX0x9Ne90/34PC6DdmZjRbT7h3kVr
	NhdLrvXffyz2YbG75KbaGge/eQ87zUSXJXDhPPEjcf8j2gXmG/V8iOXHx1VUCs8DtQlLIZJ2mYQJW
	2WhNgJ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAx-00000006Xf4-1ceY;
	Mon, 19 Oct 2026 03:36:39 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIeAu-00000006Xce-0nsc
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 03:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792380992; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GKW5xpKBD0VlTskii2gGoVx8+tNmEg/2KVphutWQLtM=;
	b=tDBEYBtSgayhsc7OQzB0F+QlK2zhqt+11umX5nRubor0WcaqV/oSo+j5MSz0nhx9Tt9APb5BOaH/WygCDiZ/FfsTpcLJqQZs0i7jvofLrFzhl4DvNfrcpDllsG+JTtdq66G9x4fv1oN6gZwLatmiO5+zfE8N11IKpMqlAdK+FJk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD-ZCM-_1792380991;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD-ZCM-_1792380991 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 11:36:31 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 02/11] block: add bdev_write_stream_granularity()
Date: Mon, 19 Oct 2026 11:36:15 +0800
Message-ID: <20261019033624.402337-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019033624.402337-1-kanie@linux.alibaba.com>
References: <20261019033624.402337-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_203636_702524_8BB9AF9E 
X-CRM114-Status: GOOD (  11.41  )
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


