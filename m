Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964C5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CN1TgepjUBrmnL+a1R/NPPyRwbSC7ptmROEXP+5E2Gk=; b=IcccEDDmCCswTTA6N4v26tfMMR
	T2F8YmQVGx6srv9dhaFc9+IxaHAMCkXLdeFGyZQAunT70y0MiRuXUSMauk/XUwzYnrhw1x5eq1DIX
	L8F9RUBn7xz4t/ulYpjqybnpDZD5a7wHn2Yt6lK6n2D3o0AiY2GOElyLK4voWe2ZY+yk5EMbebUJ9
	3TIC1N2ortz5EGX5OqZ5bwN51zGJZZPqZ69OL7J++7qD4zezLHFUw4DIyA58kfOQ4cFFTkFlxLN9J
	brSv/qBbKecMJqqT9PEaf+nrCiCajz2H0qD9HJoL0LJRlPZPMoAa2VN+3HNyGIjqDg1keJkI0wzEq
	io9jxe/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHrq0-0018Ga-Dh; Wed, 09 Feb 2022 18:37:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrpW-00183t-HV
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:36:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 214F261C4F;
 Wed,  9 Feb 2022 18:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D572CC340E7;
 Wed,  9 Feb 2022 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644431797;
 bh=uOGHB0PhJWRjRJyytDv6xrbR6xnITxBkeN0s7zIIQGY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=agDiyi8/ppbrezpJ0YvzzzJoZi57pObPBBbx47LuSJ9zkiYSooCa4EaMDWOhpfuAq
 NbOtVlgWZHkthtzPyhMnIPGP+S1hUhuH5xYz3m5xAir0+5B4Vw47LnPJia/Olr+yJ8
 k+JGn2wH3w0YVzX7IRI0XocQSw4hMODu8gkhARL8akCI5JsWJd6JL7JaU500ZdNSlM
 85p3NouMAZY8KZnq+9w4iPHCNgpW0X/+rZMqh14pN1OtjMfq233jTzE+Dzch4AWQNl
 j6r3j8gO1oQgeHqZ6iTpE46HCmjkOW6Pd+fcaK39ItdJRvufRM1FLqa7l+6vXlQmSQ
 27nPSOFiLRUYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.16 34/42] nvme-rdma: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:33:06 -0500
Message-Id: <20220209183335.46545-34-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183335.46545-1-sashal@kernel.org>
References: <20220209183335.46545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_103638_646651_6B1A8A1E 
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
index 850f84d204d05..9c55e4be8a398 100644
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


