Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57342E78D41
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKuCSY7eigf8asVI3D43/1VRf6FYhcE1gfUr+Cr8+Ek=; b=XZTKqBX7qJgrJHhMGTwEa2Ba3i
	SEmOdGIpfq20sxmlk7iOXJbZmsbfMhLVk7FaEtdCM2GE7ZI/ptvlNG/sG7r7uwN3gDzDCn4/BrWiw
	CZnrdbQE/WCY3WGjaUN2umaDEijrTxQX3yhAtQjK2M0r6xvwpcbrWx/1BXSeD6yGfIAhI30f8mZNH
	FK7Rm/mGY7jKITl3IKbeBvOb7U5KpqBRB6z06JctwmMRSbAgdkF3gCn5Uug/2YEJZPRcULI+lBDc/
	QJD6ZO6upkP/gusSbNi0sc9io4IfXvQTBwi/7Yw8XV9ra/ZT3up0r9PUpcZAqrvpaJ+ZvXukE1P6E
	p3vOqVsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMen-0000000F1ke-3P4U;
	Mon, 09 Feb 2026 08:30:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMel-0000000F1if-1WOW;
	Mon, 09 Feb 2026 08:30:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0572343E6C;
	Mon,  9 Feb 2026 08:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B28C19422;
	Mon,  9 Feb 2026 08:30:03 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 2/4] nvme-tcp: move blk_mq_update_nr_hw_queues after nvme_unfreeze
Date: Mon,  9 Feb 2026 16:29:51 +0800
Message-ID: <20260209082953.3053721-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209082953.3053721-1-yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_003007_424835_6BCF3DA1 
X-CRM114-Status: GOOD (  10.51  )
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

blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
When the queue is already frozen before this call, the freeze depth
becomes 2. The internal unfreeze only decrements it to 1, leaving the
queue still frozen when debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
so the queue is unfrozen before the call, allowing the internal
freeze/unfreeze to work correctly.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..daa02afbc9f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2203,9 +2203,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
+		nvme_unfreeze(ctrl);
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
 			ctrl->queue_count - 1);
-		nvme_unfreeze(ctrl);
 	}
 
 	/*
-- 
2.51.0


