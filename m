Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC648C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xkEJ9O+1yuYXnQQ+jtC6bTiiBkThEg2ri8bWUV87jqI=; b=l0MJftbiB8IeJgQVPMEa7rNmRL
	iUfPhSgqZfXE7WxRivTO9AvyRMqy7oNJIzJsmLHW1VrdyVHgZfHG34L5ifQPFJJAQGn8e8v5Hfpa1
	4Lj2ElUxnOxidlidwSWf0+tUIa+eaqARObbMzxcSicJx8vufk2Brf1mPRXDhg11jJ0bIF/p6tv7uy
	sL1xsjE5wRNG4g83zziN8HQU438Mh+ffmNiT7qy41LRXhRaPVX5EOIbjrW63VEWZn5fjhxo61sBYa
	xKWSCaw6mpudISVXqiThrrLu8HlhYtKR/JtfCKkNU9xKkv40vRZWUWSvMCVfFupV+3QaFUr3bj0ap
	SjoaSOhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHrpn-0018B2-3y; Wed, 09 Feb 2022 18:36:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrpU-00182p-ED
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:36:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EDBA261A7C;
 Wed,  9 Feb 2022 18:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A47C340ED;
 Wed,  9 Feb 2022 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644431795;
 bh=yOgw4Yd4WYCoi0YooHiYuwWDyvVW9wrXs/NRDkELzzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gq8qHvIAkJT+gd9EPrZXlPFwuBi/AsJndKYQq72hkxwoViymL+SKK4vQMIoa37Gd/
 pRb5QkB2MxgFAU8FBolKCz5a+6dBq1WQ+hwf5Xv/OmW8UBoiVNFmAXQ9fAbj50AalJ
 VifH764mmoXCxt679g2yw9r4Qgtg1cJqStBuCed2Uffyl3L4wS/vhIyesh8peo/PH3
 b/tb+rWyeSmugFKiPnW4jBuW98bkA67hSFSv4hRUJrDDCYlDWKvXnR81Vsz0PjWrjt
 c+ldZ2d3QtHnbVOp3PfiybYZxQc+aLPcLstNHzJlNi5eFoE9Rf8YZibA7YKGi+OTwB
 axrSGXqyRlWTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chris Leech <cleech@redhat.com>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 33/42] nvme-tcp: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:33:05 -0500
Message-Id: <20220209183335.46545-33-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183335.46545-1-sashal@kernel.org>
References: <20220209183335.46545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_103636_568096_D8784DE8 
X-CRM114-Status: GOOD (  11.23  )
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

[ Upstream commit ff9fc7ebf5c06de1ef72a69f9b1ab40af8b07f9e ]

While nvme_tcp_submit_async_event_work is checking the ctrl and queue
state before preparing the AER command and scheduling io_work, in order
to fully prevent a race where this check is not reliable the error
recovery work must flush async_event_work before continuing to destroy
the admin queue after setting the ctrl state to RESETTING such that
there is no race .submit_async_event and the error recovery handler
itself changing the ctrl state.

Tested-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4ceb28675fdf6..01e24b5703dbc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2096,6 +2096,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_start_queues(ctrl);
-- 
2.34.1


