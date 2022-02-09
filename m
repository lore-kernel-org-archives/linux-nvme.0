Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D575AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0uEBABQlCXiFnCVuvIL5FAq+qUQwvgtAWmNHUi7VEI8=; b=X4AwbkMRH73D1bUfQ5WFn2gSnF
	wfobnqcHFKUc2w8j8LDuoYEifc/YVdgR26BBeldJVSvqGf7vxIrVfx/g+sKLO75Yx/+KvIYi+WUlg
	uLHRvrdym0VR1AZlN9B07Q7KCoLeUsEUQxdaf4vNCZGg5yidGRArTEoSVZI6asDr8gMdc1vID3RjY
	Un9g8ItfG+Yj4lwrhy5vHUy1rdNK9PXkBw168N1CiLacH1BQSNMAvHkA+k+cTw6uzyzzO0pmgpwJi
	eeh9yjuHY3PuEv8x7J3dMR+IDglGC3XXirNGfHlyzM9mwsKErX9t21SJ/1k8vfxrD0mS5BKJXSltp
	L87WMlJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHs3L-001Dkl-GH; Wed, 09 Feb 2022 18:50:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrwW-001BFm-UK
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:43:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 61D8661296;
 Wed,  9 Feb 2022 18:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EC8C36AE7;
 Wed,  9 Feb 2022 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644432232;
 bh=xbseft0bFThlkg8lFzuN/SR2wFUAQLzKHqgJRlH3A6E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NSDlhu1t++mtj/XceTUQNH+QiB/y3Gzi+GEn5EUN4Dw5fBgsK/Kg/sZibp2Nwx65p
 pgqxLLQ7eMK1WxZ+8OCifKMeG0C58z91YimUDJDLB3macLtJ60Xn4lVJE/qyQbDORB
 SHYqc+GsQGpcfs5v2s2AK64WNMNZCe2OZyhLocNq5V+op/Bah9/zoUe+qlDifOtdiG
 xFjdILo2XOC+MG1bzxnxU7NQtLqeeFSb1BkwCv6pHEe2w7lBZf4wlGXS+rRyWm1afi
 eCAenIXV3go9VKY+4ivSB5q4UzzROpM3NZXmoDPjASz58n7Iyx4r3wN7PKuFC+mFuX
 TLX+zDu5uwgyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 13/15] nvme-rdma: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:42:59 -0500
Message-Id: <20220209184305.47983-13-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184305.47983-1-sashal@kernel.org>
References: <20220209184305.47983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_104353_061023_3D925552 
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
index 08a23bb4b8b57..4213c71b02a4b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1110,6 +1110,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-- 
2.34.1


