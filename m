Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A558C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7qiPn6EYgGAYp+BHdZ3F1iq8Z8dNtWremCt+lbJkYH8=; b=YCetmE7XFxmLHROGxP/ikEwD0M
	rzw2MjXnsNYKfGOyGV60YiIi9gXPJRXiuypYX3AVnOQ/S4KBhS3u1BPTYXI7wlapgBCd8ypSTfyYL
	JUS99IOmLvQw+jyfJwOBwuMeZceOYJIZxGnQOccHppLX6pIujt21c1BBU5cNyTuWHriMVnm9Lgcjb
	zX9B25wmiYIw11FINeMbdDgsJS0WEIPR2wRhCVMlcNHiXGO0zYo33t7zOuWRnoUeS6pa/KvLkTW1V
	H/rF1kMBdhozSGYWdy50KKP00Bg+qzVdt3h9A/ZwQ7LLzgGEIOaW2VaGGA48NR6jx5cWh4v8At9VC
	FEhIvx5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FoQ-00HQHr-0e;
	Thu, 25 May 2023 18:35:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FoL-00HQEg-2l
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:35:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 604E0648F2;
	Thu, 25 May 2023 18:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4850EC433A0;
	Thu, 25 May 2023 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039741;
	bh=ioLBaUkSFaDEfzK+WS5lXFN2Mc3psAgVLYHDH6tAdZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk/eiGUL1WZEbnLIIa7slTOceR82VFBDe3Pi6FtBuloodJKH/3XiIWhLLxJzT2VVW
	 QH5aWcuXKzuNt0rZiVA0IXrVne3eL/DdX1Fi/52e3we02mQqtLW+6dBv954dhql3FM
	 RsG0zmHkLinFjTnEDpRimuSkMtNhNHuui+uaBN9PDUt/AAl49owejNon+RW/YShznK
	 JTkf8I18WuOu6kwfahsRs5YLDFRmi5JtsGmu20ByNrARb2k1caPC3IBH/+YGE17+7r
	 N7gil6pzm1UVn19ZSzRdpenULkQoLoO+aoIaoLhQKDd2yQ0b6URyJTKGduh7ZlZ9GJ
	 pmAtphZFBfoaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 58/67] nvme: do not let the user delete a ctrl before a complete initialization
Date: Thu, 25 May 2023 14:31:35 -0400
Message-Id: <20230525183144.1717540-58-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113542_011972_8CE298BD 
X-CRM114-Status: GOOD (  17.61  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 2eb94dd56a4a4e3fe286def3e2ba207804a37345 ]

If a userspace application performes a "delete_controller" command
early during the ctrl initialization, the delete operation
may race against the init code and the kernel will crash.

nvme nvme5: Connect command failed: host path error
nvme nvme5: failed to connect queue: 0 ret=880
PF: supervisor write access in kernel mode
PF: error_code(0x0002) - not-present page
 blk_mq_quiesce_queue+0x18/0x90
 nvme_tcp_delete_ctrl+0x24/0x40 [nvme_tcp]
 nvme_do_delete_ctrl+0x7f/0x8b [nvme_core]
 nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
 kernfs_fop_write_iter+0x124/0x1b0
 new_sync_write+0xff/0x190
 vfs_write+0x1ef/0x280

Fix the crash by checking the NVME_CTRL_STARTED_ONCE bit;
if it's not set it means that the nvme controller is still
in the process of getting initialized and the kernel
will return an -EBUSY error to userspace.
Set the NVME_CTRL_STARTED_ONCE later in the nvme_start_ctrl()
function, after the controller start operation is completed.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdf1601219fc4..c015393beeee8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3585,6 +3585,9 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
+
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
@@ -5045,7 +5048,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * that were missed. We identify persistent discovery controllers by
 	 * checking that they started once before, hence are reconnecting back.
 	 */
-	if (test_and_set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
@@ -5056,6 +5059,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
+	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.39.2


