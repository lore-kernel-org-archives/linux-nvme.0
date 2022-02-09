Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55F9C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GBoT/YbczQdxiYD/lRDeXHRNibhJs8ekSb2c3N5NxA=; b=jwQK0HTok+IeKT7tmdgDVjVDQc
	69il9QDy+PVQSlsN0jNZZO/hvEwXTdpLvJUeqUH5h/QkHm7CHZAIAOHZz1bMmkJS0hXtTu28vIURV
	Bb6rxRKRmOrg3f1Rbx7W4A1W5i0CkNKQJXBlyug+F6qDaNKcY4eRWSdJIs89d+k3NF9QFLpIJMxSX
	ivsxmqWw2cOD++TGoq0wtqbBdy2XqpZygb2PVhEgCrTY5yHXmdWZg/RvWPRbRfklxYxJwd0DxS5IZ
	ssoeX+HDVM/bA0C9MAmoaB30yVVpyYxWmihDt7R3FxKwyHXZ5FWXcuWfXIkLly68Z860CED0u40wv
	p4vEFs9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHrxK-001Bbe-GS; Wed, 09 Feb 2022 18:44:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrvI-001Afh-Vj
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:42:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 460816129D;
 Wed,  9 Feb 2022 18:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB9C340F5;
 Wed,  9 Feb 2022 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644432156;
 bh=LVhx2ZtmY6kksmFne2psdMuePMhtztetOJrJizL7un4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tI3x42hjED9V4sLMRUZD/LcMIn9onFHPrtvgQdGPQ4iLz2TV1Q5URqy2wqujGFfCz
 9posFcxYkw9IJKZG9M93RldljYUmQ2GBKH6tnUCgtPOQi5Idxy/rPRt0GgfQfZohjD
 D9OsH0iFJ0D3i7QUD4X6JTLvdBAIVZOWZ9VsxmlcfpVmfPHcS6AxPPe/qP1J3Gnm30
 Ehfy2stRqfbIeaL1sVzyqSYbgzsS8W2kfM/xB1E0cCmesc+urgyfC5HpLXA3xE6zSJ
 J2rQ5c08yLRvRcTf3Y92uR6vIdW7FayVK1m3IwPN0LD/0Ge7TFH04LRTiPGEmaiXlL
 1Kykuetw3KZnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Chris Leech <cleech@redhat.com>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 21/27] nvme-tcp: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:40:57 -0500
Message-Id: <20220209184103.47635-21-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184103.47635-1-sashal@kernel.org>
References: <20220209184103.47635-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_104237_142248_B432F75F 
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
index e99d439894187..45b3a919ac281 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2069,6 +2069,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_start_queues(ctrl);
-- 
2.34.1


