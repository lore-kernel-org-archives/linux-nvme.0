Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C80E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 06:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAyM51ZMh2WQCIzVgXjOQiiOuyowXnbXZDM9r17qCgg=; b=4sigydCmLdC83OkEn04Sys9gP9
	tyofu8BZfMLHCSAAeqnjMORK1BiA7QeWVn65lXrcKRNwhaRKINN0cQaUW7MfEyqxFs48KZo6oZVTK
	2Z0DdpfLuoZTWj43KJPfPaz6uzqJWk4eHf5AckxE8of9jVGaLUyU5WueH6/MlAxitu20+SUj6KpAg
	3eX++QSQ05iXKFZ2Gi3T5W8+ObmKTmKUoLc5bgovPlToq7IY10sk0vXQ89Kttpj5NlpGswBvo98Hp
	vkd+UrBL/2EJKBSW5rqplBE/9nkewV6ByfgA9cXzfB76FKoQ+UezlxPLKp2ik0mqgYGm12VgrVe0c
	oWDwobpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV380-00000003e96-3E0v;
	Tue, 07 Jan 2025 06:31:48 +0000
Received: from 2a02-8389-2341-5b80-d467-d75d-35bf-0eb6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d467:d75d:35bf:eb6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tV37y-00000003e4Z-3ejf;
	Tue, 07 Jan 2025 06:31:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 8/8] usb-storage:fix queue freeze vs limits lock order
Date: Tue,  7 Jan 2025 07:30:40 +0100
Message-ID: <20250107063120.1011593-9-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250107063120.1011593-1-hch@lst.de>
References: <20250107063120.1011593-1-hch@lst.de>
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

Match the locking order used by the core block code by only freezing
the queue after taking the limits lock using the
queue_limits_commit_update_frozen helper.

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


