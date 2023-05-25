Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D2FC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LsgGtxwaee94hBhng30bxERAD7N9GElUnXg1C2dpf7E=; b=XP2qVEhN/d8zvQvwN4CjC++7GS
	0hiDNWqwJrIDEP1UK3BlkX7WBHfT1lkJqdSgsXA3CQNWajW+/4ECCBl4wW/k68oKy6iDAvO6VfxqB
	mOIwdwbF9+5ENa+IKZX5MWhU/tq8xi5LSqNkro4jgcEbOPH1jHYxDANZKU8+Oa5LNVCQPnBS1i3oO
	odQrPqNiaj6fgUJwSvFIFg1yVyuVus1/BBHmHwnXZbzY4MPPFgOxrIUOYGxZd6pgjMXbK6v3q3Vyr
	6RhzBOWdhsFTNPyQ1rS2pUYoIRnsJw6ZAupsGrTEKjdodn4tx06aCI/nSMt96qHwcvgBRsGTDOD2J
	Ct46oGYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2GtL-0000LZ-33;
	Thu, 25 May 2023 19:44:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2GtK-0000Kl-1s
	for linux-nvme@bombadil.infradead.org;
	Thu, 25 May 2023 19:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LsgGtxwaee94hBhng30bxERAD7N9GElUnXg1C2dpf7E=; b=ijizoFFsp5GcbfKiVGcMd/FKD+
	+VU+WJnEwWA/+0SMbWOfUykjjmBfvJAMwGKWkrdzSmo9Rj1eaSLTkm4476V4zyc/mJWefSPFsNaWT
	75C1wFhNvI+RSKydNJBbcDHZhqnhFXdIF/9Hx29in4Y72uvHCrafBr4NX1hs4ZM6S3mRHN/gwp3Bv
	Elbsko9HcvDOneoX9Vk/cxJk+4r/CMchuYOafHaRmiNnNP0nogxcXp5aTrYoeS8OxPOZrhdFdf6yz
	hokSMAp4zg5aKNlm0O/otEvKtA1bFkcnng1m30fEXnhU5Lzh1KSPCfUUazvoozx7WB7rdPY1KobXy
	qKgpxYQA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fr8-006dgS-0U
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:38:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0058964919;
	Thu, 25 May 2023 18:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978A7C433AE;
	Thu, 25 May 2023 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039912;
	bh=wNda3bZlc2vfyvi7DQgqvTCZhG0Vfg3T2a4I9OeFoXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sf4dKkUNDuZ2c4SULq3DRYC4R55lI90a6Vub1xT+tvk9k5n5y85MKWkzgGG6tOOTX
	 EV3lEdwi1zjmJniP/MEOlvCn/qXvBLfAYipa7+j8MgJ5Q8bWksDLwOK/YKlqE9HZ1x
	 KL7czPUg7gLE5+LjxQ9rwiKHiHoPs3FSdmKY9gbH92wSibjj1ka6jlzg0/wk7EcZ/M
	 /HwzXhkQRrlzhPAE0RWFoAJv/X52stGWAH9AQincbRgjV0D0cZLa6XeSBDM8RGHNVi
	 QlGS/J5qZTR1h9ZIOeULRCqp0FQVzFLwgnz7JYGRZTqllrfv7AAT/MLvY6QOo5m7ku
	 pciv8Rgsvw91g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 48/57] nvme: do not let the user delete a ctrl before a complete initialization
Date: Thu, 25 May 2023 14:35:58 -0400
Message-Id: <20230525183607.1793983-48-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_193834_456310_B3665D35 
X-CRM114-Status: GOOD (  17.56  )
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
index f502e032e7e46..2e22c78991ccf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3540,6 +3540,9 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
+	if (!test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags))
+		return -EBUSY;
+
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
@@ -4980,7 +4983,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * that were missed. We identify persistent discovery controllers by
 	 * checking that they started once before, hence are reconnecting back.
 	 */
-	if (test_and_set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
 	    nvme_discovery_ctrl(ctrl))
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
@@ -4991,6 +4994,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
+	set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
-- 
2.39.2


