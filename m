Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE15E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKSXgKPbc7+7uy5GODIswmTSRS81Ky42NLQWqgmNN6c=; b=IxSEPS6aORWqiSIlNxwR9a47ej
	pbLzYbU9V3MX8u+y6RDwnT9BOwXK7lJFj7U+WgWGHJZ63MIl74TK092JdtfNE2hQJaC1Win4qGVIY
	M0mZWvtMjTOQZq1I3O9CYBS15PQEFhKT7SlpOARxOmk3W0WTSD7ca11knqj82QhlS5AJF4kAEVK+n
	MEdASkL+LGat46qk4JBr061oOwsE9dvAFcLEDgdUQtiOpKcdO2INRqVWRTCINXVqIpf9iHHWs/Ysi
	fGpSg0v8K61Ph34FI4i/xoiuvR3A1RHRXGC2BMuJ93JCNzPRennL4/P5OhawUI4NEoZuTY+GeJkeH
	9qsZ7Frg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0q-00000000ndG-0zvd;
	Mon, 06 Jan 2025 10:07:08 +0000
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0o-00000000na9-2Rl6;
	Mon, 06 Jan 2025 10:07:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 07/10] usb-storage: use queue_limits_commit_update_frozen in max_sectors_store
Date: Mon,  6 Jan 2025 11:06:20 +0100
Message-ID: <20250106100645.850445-8-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106100645.850445-1-hch@lst.de>
References: <20250106100645.850445-1-hch@lst.de>
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

Use queue_limits_commit_update_frozen so that limits lock is taken
with the queue frozen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/storage/scsiglue.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 8c8b5e6041cc..dc98ceecb724 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -592,12 +592,9 @@ static ssize_t max_sectors_store(struct device *dev, struct device_attribute *at
 	if (sscanf(buf, "%hu", &ms) <= 0)
 		return -EINVAL;
 
-	blk_mq_freeze_queue(sdev->request_queue);
 	lim = queue_limits_start_update(sdev->request_queue);
 	lim.max_hw_sectors = ms;
-	ret = queue_limits_commit_update(sdev->request_queue, &lim);
-	blk_mq_unfreeze_queue(sdev->request_queue);
-
+	ret = queue_limits_commit_update_frozen(sdev->request_queue, &lim);
 	if (ret)
 		return ret;
 	return count;
-- 
2.45.2


