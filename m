Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6580C00144
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7bOYWg0LVjt7qK3Pu4GLMmifcU5gQXI5+vWeKrstb8=; b=B5Adhz58y0SQQd6WM7nXNiNKqx
	7ZMzLLOM1Xv47W5mCIPB6FkxcrufYfEU7eSHfweZ4IjSJgLpo7OqpFtvA1TCZ/0EndAqLKb7dhXeY
	VBz4/oPe8wRQBKV8TbAWPkkgPYHjs0YP4cO2wghY4JVQHtGZhK2YiMET0tA1YEUReNapENBb/Ow3t
	ccv5JdzvGG+A452ZVCvHC70OGQHqdu+Wpvf0jxNf7IJ+J43ZL7K3K/79fnj8HGPxEcUZoXp+2km9A
	ltsWtzfkJ0brj3VFQh7SN4LZvAr7uhRbuyn1F6rlJOcsEjGPeHueIrqnb7Z/aQ7tnV2lbzlwp0wVJ
	Nr/5LKRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEld-002ErR-18;
	Sun, 29 Oct 2023 23:00:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxElZ-002Epr-22
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 23:00:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 23BD760F18;
	Sun, 29 Oct 2023 23:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D5AC433D9;
	Sun, 29 Oct 2023 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620420;
	bh=2pbXGDmprCdEE1yeypDxw2BmMHElQ4jyPazLH+X3M0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gNfJ7FDkYUFr89r0PooF4dvM/TeXxlnKEnq1zvjeKyKH+5ww8rEBmmO8mVdfei6C5
	 m3wtL55MfC64z0ziifUe9akWWB+0T5/OTfmTE3o8cEx+bpuu9IRHedGTq40BTgvf/z
	 lRrwE9tVeaxMouTd1sp6XSvFXS4RQzjKuABlx71xj72BaFucmKOuhTv/6uwjadd0+Q
	 ew7q4FQ+QD2u4zTYc7I8PZInJPCt+VuguZtiM6K4eOwd7ozPruy3uiAq0+4ULEADin
	 nOipMBc1857i7vwMn145hp5YOLlVMloIKjWI4p041VKPp+QOMcUKsd88gL6FCoDa4u
	 ofA8P4aPWlyrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 03/16] nvme-rdma: do not try to stop unallocated queues
Date: Sun, 29 Oct 2023 18:59:49 -0400
Message-ID: <20231029230014.792490-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_160021_823387_A9DC32E8 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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

[ Upstream commit 3820c4fdc247b6f0a4162733bdb8ddf8f2e8a1e4 ]

Trying to stop a queue which hasn't been allocated will result
in a warning due to calling mutex_lock() against an uninitialized mutex.

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 4 PID: 104150 at kernel/locking/mutex.c:579

 Call trace:
  RIP: 0010:__mutex_lock+0x1173/0x14a0
  nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
  nvme_rdma_teardown_io_queues.part.0+0xb0/0x1d0 [nvme_rdma]
  nvme_rdma_delete_ctrl+0x50/0x100 [nvme_rdma]
  nvme_do_delete_ctrl+0x149/0x158 [nvme_core]

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 825c961c6fd50..ecc3f822df244 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -644,6 +644,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (!test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+		return;
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);
-- 
2.42.0


