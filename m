Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947D606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LMowlpNd;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=RY642jJx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YbtNFKaTfIrINCihukEzVPCu2ZcfrropFZOLn6Sh9CI=; b=LMowlpNdYC0NJi
	MPiOm9iJ5SBBXVNwk38sDy2xli7b7tyMth0FYDWjO2Ztn9jdwLA8O+2IhRNjifK/EF/fgfNHdaSih
	ZqFWQbRozovQXrjnzG5aLQn+/LIZs1UKS/6quWtZ0Tx3/VGamJsBOBrqPYS3GNycwgTyvfyW0BK6V
	kVxVe47PylYYNd24Xwk88jcINhzbmVYzlKO1ldn71o/5HJfuoPieCU2zB7cCK3kxiELl6bkilDkqL
	qCVO5OJoo7qxNHSwHUWlL0DnSX49I3pADR4s7RDgWYEQtJJlHN2K6QA1hvg/PmoQ+FlIzrK+q7Dr8
	ErEsQoDVnDpH1hPtbQQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFu-000000099H8-0bLf;
	Thu, 29 Oct 2026 12:29:18 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFq-000000099Dr-35sl
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276950; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YbtNFKaTfIrINCihukEzVPCu2ZcfrropFZOLn6Sh9CI=;
	b=RY642jJx3gZD1HmzrliiSybTpUwAUEsb0uNREV6mdJaYt9IExxRhq9Cz+8feTUQFKSJVi0JgV15DpK1GDvZbkCwtbg85U96YWtKu1nM9Y8WWXgBrUvGg2OesZ+zxg1qbnJYMqTey9QVON3Jv/nLSTcp7/Cg7iMBcpxa1cSGiZtI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjOybA_1793276949;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjOybA_1793276949 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:10 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 02/12] block: add bdev_write_stream_granularity()
Date: Thu, 29 Oct 2026 20:28:23 +0800
Message-ID: <20261029122833.284572-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052914_950134_B8804889 
X-CRM114-Status: GOOD (  10.97  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 4f7905c3412b..6eca09058dec 100644
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


