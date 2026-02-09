Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A51E78D41
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 08:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjVUUP480jmoliPvaldoIqqA839mptPGZs7rGQIgaPo=; b=Ys8smgr43omjhP236kcdv3cvng
	6K1WoSxS3l8rkkuHN92x5co2MUgyu4h+KsqOV3qE5XIwtVgeVX0ZWdT52nQnggu9ErcnpIYDT3Zp4
	ji/LMOazLZI9kYtEO6wkh9hX+jlZMB9RtTznllATm4nlwUPvFd8QZPaRq/k72Ij0CiweXxIUa6TnI
	t2LhwpZ3wEJqsPfFQ8/a908AnbxbsLDgl+q104jZOL2tFhrIk/Z45G5vzrnZRxwEPiYZ52ar41R7l
	GK//0x+xYa9swFKcAVuDNqGkbx/wgA0y+25aZ9RThMEHyt/UdjKCu5moqesejC5bCbSKzd/O8qLan
	QqzIMHIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMes-0000000F1o4-2ZJk;
	Mon, 09 Feb 2026 08:30:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMep-0000000F1lY-1M8y;
	Mon, 09 Feb 2026 08:30:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E55184443C;
	Mon,  9 Feb 2026 08:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C11DC116C6;
	Mon,  9 Feb 2026 08:30:07 +0000 (UTC)
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
Subject: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after nvme_unfreeze
Date: Mon,  9 Feb 2026 16:29:52 +0800
Message-ID: <20260209082953.3053721-4-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209082953.3053721-1-yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_003011_387748_A5BF9EA3 
X-CRM114-Status: GOOD (  10.37  )
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
When the queue is already frozen before this call (from nvme_start_freeze
in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
only decrements it to 1, leaving the queue still frozen when
debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
so the queue is unfrozen before the call, allowing the internal
freeze/unfreeze to work correctly.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/nvme/host/apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 15b3d07f8ccd..1835753ad91a 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	nvme_unquiesce_io_queues(&anv->ctrl);
 	nvme_wait_freeze(&anv->ctrl);
-	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 	nvme_unfreeze(&anv->ctrl);
+	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 
 	if (!nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_LIVE)) {
 		dev_warn(anv->ctrl.device,
-- 
2.51.0


