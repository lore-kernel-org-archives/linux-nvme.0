Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A98C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZkssoxvWt9ihDKeFmzMPiwWbvYvrj6xN0citAIj7g38=; b=vh8KRsh/0WmCdXWt9M5iJ3WXD3
	cf4+5GyQVuWv30tiUbqH+uDiY8oTix9NWi1nOcs+qCNkkMvsNKZHpi2TnJH99q7ryxeZzjVw81Mq2
	gS40rHYFFxryLunFNWu3pYhjX4YmXj5ha9uKf+DeclPfYe4ZBN0MDFVtnE3/YofnTyIm6cN/VcBs/
	oZyGxg/qOqiVCnP3h1MMBu7XrBAhgnxN/ndJvaV+jiOh8KGYE+P4npqApUvShgZe/z4OoR74Bz7ZO
	SinGh//eqBu5j1id6FrATfEuO+haI0812Nxxpwr+x5aZ/SJdXKDmIQh/aNQanQJJa2x1D0rdZKcw8
	ZBOEEXHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHrtI-0019rG-U8; Wed, 09 Feb 2022 18:40:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHrsj-0019bU-30
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 18:39:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 920A1B82385;
 Wed,  9 Feb 2022 18:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA334C340E9;
 Wed,  9 Feb 2022 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644431994;
 bh=27GxyIgL3H4PudnK/GThhSqcMFh/8JEiCRGKwE1+/sI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ChGLUbcWhPomy0dNw0d1lpJpzNe2bBsoEZyz8MVs6HbEzFCS9TvoLLbMnMhHbDuU7
 SkMZfjXsE8YvkZiYb+ALWkp+4dY4YVH3+vniaPGQLxtMdUuLh2Labdit3IjNAUbbP/
 rZY5C75HBbzXMh4aZzN978sVsFTMkUQ73EOjKFTk3peMhPMDUr7Yu1tIiYzld5jBmm
 0CsFCrx7XYuEoBEslXc9R05DjFvBLDATB/p6nOtmd92IfRGKjZNpw49FgQjy0EQSe7
 h1s3O4EXkGV/urbNX/ejmVRLB7cH4oM4MPwdhW50Gn/YryhTTd5PW4im7of4jz8uxV
 ugTt9X9B+eqVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>,
 kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 28/36] nvme-rdma: fix possible use-after-free in
 transport error_recovery work
Date: Wed,  9 Feb 2022 13:37:51 -0500
Message-Id: <20220209183759.47134-28-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209183759.47134-1-sashal@kernel.org>
References: <20220209183759.47134-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_103957_306093_66C621D8 
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
index 0498801542eb6..d51f52e296f50 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1192,6 +1192,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-- 
2.34.1


