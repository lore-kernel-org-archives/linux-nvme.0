Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62FBC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=npS5cE3jFgxapcsRYd7PH7wB3aZi9VEvH+Ti6KKLmKM=; b=O8mhsG7DdKywzoJcivc4zmEuqm
	ShPuR46WpK53b8Vjc0ySjYyuOxP7F20vKEFWughIRXNwuQQIqJx9MqX+2p2XzywHn4mtBCE+IfVkw
	9CJUHZ7ZI9vhYZ5lM+HshNnFtiR0B1EpwnZkRiRz8TWe6hLNcaXZ9OtIabSJqNUMsZei5GEcIA0r7
	3hqsBMM5kfmGvtB11oRn557wTuBJD8+oICsi2vO/dEdVLFBeFNM2NxBKJA5LzMPNt73WupAVo6kEm
	Rr16pkDB3s7t72JzRhWxPCsMO4I4vfhEEtStN8qAI78ULeljcSABHquGv0VIhMIYzdfwBJgxZARgC
	vtlY6thA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovCpL-000dIK-3I; Wed, 16 Nov 2022 07:27:19 +0000
Received: from [2001:4bb8:191:2606:ece6:cc06:ceaf:11e5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovCpG-000d9P-59; Wed, 16 Nov 2022 07:27:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: lengchao@huawei.com,
	linux-nvme@lists.infradead.org,
	Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when ctrl->tagset is NULL
Date: Wed, 16 Nov 2022 08:27:11 +0100
Message-Id: <20221116072711.1903536-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

The NVMe drivers support a mode where no tagset is allocated for the I/O
queues and only the admin queue is usable.  In that case ctrl->tagset is
NULL and we must not call the block per-tagset quiesce helpers that
dereference it.

Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

It turns out we have a bunch of other quiesce calls that can happen when
only the admin queue is live.  So bring back the original quick fix to
check for the tagset pointer in the quiesce helpers.

 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3195ae17df309..fd2e26cb7a688 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5215,6 +5215,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
 {
+	if (!ctrl->tagset)
+		return;
 	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_tagset(ctrl->tagset);
 	else
@@ -5224,6 +5226,8 @@ EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
 
 void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl)
 {
+	if (!ctrl->tagset)
+		return;
 	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
-- 
2.30.2


