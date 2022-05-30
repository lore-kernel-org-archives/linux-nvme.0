Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EDBC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 May 2022 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4IY/b+5J/H2mMk+TCdW1C073dwWPWbshvqZ5cnctPaI=; b=2atEkvkLD+6Vscgmsffr/id9p1
	qPfnpbxACbE/zNZvACbTA9jcUu6fa/ZlMsk/xhxBAXoSMe/e0MV9b02nG+L/lmIeokLedNARy8wmQ
	Wf7ilJWr+xra/78dMHF4Fabkki9y6o6br7aFiFK/1IJtxLehoF8V38j9kuTSY7Vk7KRxkMb1yq90C
	mQPKL6T3ltLmu18+lkSBKi78KdHpA8le/Z6OKI9oyCawG2zOSy2gWKBag+SQRCmtC8DtkfKSwLRIS
	4P5E/EN0XusMGPr8fdXbGV1YjuC+pvCoI/S7rCNyKhOWvmLW3bo01tVygHyysha/kg8c9fjRslhFT
	qDbwjA7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvgJA-007BCv-AR; Mon, 30 May 2022 14:23:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvfoL-006vHi-4L
	for linux-nvme@lists.infradead.org; Mon, 30 May 2022 13:51:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9D59460FEE;
	Mon, 30 May 2022 13:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453B6C3411F;
	Mon, 30 May 2022 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653918716;
	bh=xxgAl27rmpcyIt+ia+jYT3R5XT8FLi98W9DLwPfVKfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HypTCAJid3p1epQs2sNh9DLSGYsIU4v46/HcgxYp2viDccedqGmq3dqjjsiaBM3J4
	 aCr0MMsrMXo5im1Ha1K3bAmgmetXqUW0k+a6IECakZiqUCJX6sHRGkcHAHTFP1gjxq
	 GAd3gp0Pyj0F8tpe8ssK32h9EXEZu1X+fUvuKCMtQZJhi9VRRiw0ifbhYuhJBVQ0Sx
	 kQfXy/pX2gnzNcO1WpokWoXJlohndnxfsxCddsScvu++4ZKuFPELrpTcutyqzuMVL1
	 SfVzgYvW4ct91vF04Y2FZzKxKpHb6+Qz8HeqLlFc4Z0FkyERi9BJ5REFQJuWFQePj3
	 3v/NY8MQBqjew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 23/29] nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags
Date: Mon, 30 May 2022 09:50:50 -0400
Message-Id: <20220530135057.1937286-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530135057.1937286-1-sashal@kernel.org>
References: <20220530135057.1937286-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220530_065157_277770_D330CBFE 
X-CRM114-Status: GOOD (  14.72  )
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

From: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>

[ Upstream commit da42761181627e9bdc37d18368b827948a583929 ]

In nvme_alloc_admin_tags, the admin_q can be set to an error (typically
-ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which
is checked immediately after the call. However, when we return the error
message up the stack, to nvme_reset_work the error takes us to
nvme_remove_dead_ctrl()
  nvme_dev_disable()
   nvme_suspend_queue(&dev->queues[0]).

Here, we only check that the admin_q is non-NULL, rather than not
an error or NULL, and begin quiescing a queue that never existed, leading
to bad / NULL pointer dereference.

Signed-off-by: Kyle Smith <kyles@hpe.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 92f269a0846c..de23f2814877 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1424,6 +1424,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
 		if (IS_ERR(dev->ctrl.admin_q)) {
 			blk_mq_free_tag_set(&dev->admin_tagset);
+			dev->ctrl.admin_q = NULL;
 			return -ENOMEM;
 		}
 		if (!blk_get_queue(dev->ctrl.admin_q)) {
-- 
2.35.1


