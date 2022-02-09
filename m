Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D40C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XdidOS6iNWsRHwdbD59NPeoGdPCvxo+O0GxrRcW2kag=; b=v2gTBEvyLi8y2340puHZcGwCre
	UiowzO/dZx3rU86dSdBM8ySmvv7wUvoBJCM7kliFszZNFvdwgWj46+mzfWPXlRgbIyUR8dbe5s95w
	hqjRI3n2+Vm19F0SgELQtpyFrkBi4sPWw9A2eduAlzvAwAK1TwuJvAeZq20udCe7cifDgTGaDOJXT
	MR6Gl1NK8b/HPdcGnt/G54uqaq9DryMa4u6h9kcrFXpcvI0Yjd2LJ9VW7VKTpAWUqtTNI7xrNvPTj
	o+1Ikck4dmY0gUsgSH6s1575w+fmrVB0/YgFudbJ05G2eCBKgWRO3NVuXyuVi3kn74y2F3nFeK+ZA
	sD0QIVAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHryM-001C1N-Lm; Wed, 09 Feb 2022 18:45:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrvM-001Ah2-9X
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:42:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EF127B82215;
 Wed,  9 Feb 2022 18:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF6BC340E9;
 Wed,  9 Feb 2022 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644432157;
 bh=s1iia/oG4l++iAJX1joJXCl2kNDCLXGpUQxLtL6WHdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BZI8/87VrU80OulcmB9htoTgFPwq2CyE3G6MJj93llKFIs//0z5o/Zd8Fdp/2pUGv
 xrx65oHghuPKZwTS3WFagXH3StFGvX4uYLz+xD+2JBWX0WbeqM3Zu+bKMMwFnbkPsX
 xznPRan0nmCHnkrmX2eduH+q+7TNPxbv43FikeFrFSxKdYH2S2L9iuwSlqVbY26SS/
 QWJQ5lT2Lfmu8PgtlOhBBK0wwdJCvgBq0Sv+vaeefSgbWtcid22owJK6YaRGNreL19
 LVVNXoEZ6rf0PVa86OEMCZ2Bl9cybWCjKfYTP/c56Oh2JwNpzVOpCTlOMyMan1NYrr
 C9t/+HTAuwPow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 22/27] nvme-rdma: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:40:58 -0500
Message-Id: <20220209184103.47635-22-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184103.47635-1-sashal@kernel.org>
References: <20220209184103.47635-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_104240_524903_F2C8022C 
X-CRM114-Status: GOOD (  11.17  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit b6bb1722f34bbdbabed27acdceaf585d300c5fd2 ]

While nvme_rdma_submit_async_event_work is checking the ctrl and queue
state before preparing the AER command and scheduling io_work, in order
to fully prevent a race where this check is not reliable the error
recovery work must flush async_event_work before continuing to destroy
the admin queue after setting the ctrl state to RESETTING such that
there is no race .submit_async_event and the error recovery handler
itself changing the ctrl state.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1b90563818434..8eacc9bd58f5a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1200,6 +1200,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-- 
2.34.1


