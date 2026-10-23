Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E8606A31E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=z3lRk92n;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lvNBtNFG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0fTzlDvfAp5L1yBHP6Hrs7VySIWJ+6xVLe/GeeedsiY=; b=z3lRk92nIgA1W6
	/XCMg6u6ubNGhVzdfB/3NlkR0sFoy/uZLSAyrm7IR2KegVHDr+vYmgQ1BxQ3D6jamZuqcltkpcqab
	VZGnHOrndQ70VKFd8ZV+XgPhm5LOgQ5dV4dOeEHS9hSyl+2g2zEUahilXvX0BPxggZoXUSDNppkdc
	T2rFJjCqJD9fsXV7r/WR3129Y6Zu+YMv0V7edcaGp/F8WoXYZXh6L4dvjuSAA7T4eD3xwySptRr2u
	Jx9FV1H2fkqE2ri7PSm4fRVqJiwuPRKJ5JJjXLqXnuMrZV7skSK6MFytcvat0qCv+2zxroNjPVvuZ
	a/BFous+MZoi0NTVQzwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF7-0000000FqoZ-1n7c;
	Fri, 23 Oct 2026 08:03:13 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAEz-0000000FqiX-3J8n
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742582; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0fTzlDvfAp5L1yBHP6Hrs7VySIWJ+6xVLe/GeeedsiY=;
	b=lvNBtNFG493Ol1ANM5FUPPYQaN635Zg2/4fwUG+nXASvzzfF/7AYh3vJo3QyeNWUOeY5Arbiysc/5QMoH718vHTrWnOctRht4kIbrwqM3U5H/s9Utfyy92YkTfdtQKPBUs3sOscfm1//+c5ZE1Fe1lT4XmhsAaBKSKGYGeD5WjA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLNnFV_1792742581;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLNnFV_1792742581 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:03:01 +0800
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
Date: Fri, 23 Oct 2026 16:02:42 +0800
Message-ID: <20261023080251.2606443-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023080251.2606443-1-kanie@linux.alibaba.com>
References: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010306_018648_FCF4007A 
X-CRM114-Status: GOOD (  10.84  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The write stream granularity queue limit is readable through the
queue_limits structure only.  Add a block device accessor next to
bdev_max_write_streams(), so that holders of a block device can read
it without going through the request queue.

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


