Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AB2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJhZLakRHh+AMN1HqOU8fpjYfPL8m+b0n8rRaSVPMuM=; b=KRq9MpZ4GOVCMmhCae0QEQQ2Uz
	hVn1bWOLedQOTGehVe9F0NeySXpup34FwUSi6LtrrL/Y57OF8JCS3ccV0q4DBWplZqvc6bLUJO/nj
	y5gBYOXpud2R1QdoV2bTorSXk6G2nngGPHfjX38PoaOxlaOIIT0SmYCmrh0kvsbZBxSsB2o0MY48D
	PEG88aen/5gQIbcBKa+JoUYptDaZcHEfpJa9zonqCydsjbNIwI+1Tvs8h3YMve6mjBSqWAOQ6kqiR
	CaS+IvT+KwxwYnOsbYPKLqeA9xBQNvOY9PURXU5Sq9dQ6js7pjipYZAelqXs8uovpIpfQM+lgaP5g
	cQLAzIhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHrt1-0019kv-7K; Wed, 09 Feb 2022 18:40:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrsg-0019af-1v
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:39:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 85B426006F;
 Wed,  9 Feb 2022 18:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3249AC340E7;
 Wed,  9 Feb 2022 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644431993;
 bh=zIx1hJ3twxcRwji/KiyxGcWVwTCRfzELab1GBSE3O4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lsNrizGBE/qhBVqtHmMBfwNK++tB/pcIealzuvfsMwXVK3kSKksZqWb9t4p8QOXXG
 6gkZgOHBLPdtg6/7SXO2bWwiWsinu6oRHE+PHc5rIE8v+/a3s6W4LC2vi2MoAP+IdM
 sRBcBwK1EscfUzCogw3W0szNuff+BA7whEvJz+ygIXROV4FJty/Ww9pEPJ1jX3udFP
 6q8OcIXZgl9cU8FSkZ1PaWbWNh3TzaM1bMsN191w6kt6UkwBiG3xLukFTHBViMxWRL
 2Wt8wZQlBgtNFc40/a+JotSTJTQ0M2LK4yDkbcIG1bMzGJ62vR1ZTROZu84VWARvtk
 DmVx3O7ywEghg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chris Leech <cleech@redhat.com>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 27/36] nvme-tcp: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:37:50 -0500
Message-Id: <20220209183759.47134-27-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183759.47134-1-sashal@kernel.org>
References: <20220209183759.47134-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_103954_255066_AE1726C7 
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
index 4ae562d30d2b9..e5f7c7fa76478 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2097,6 +2097,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_start_queues(ctrl);
-- 
2.34.1


