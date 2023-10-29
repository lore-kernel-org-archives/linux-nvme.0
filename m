Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A5FC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 22:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjxyJNEUH0hl3UQHFEe6hI38LBGFtEVI7+Rd0pi2pFc=; b=0m6bSS0b3TKg7dbagcyj00UZ6d
	v93dut8OZXuNZiDZEPZ9DzmnVoTnY1PNKUPu+0ReHibi1UHrUY0VjY6UuTA15SEWZ0gkcju3CWudh
	y44655P0KkwIyt5+6k2yMPFAWqKKXiY0ESmRFGjIH34HpoJq2ceyiGljCHxYj3iJe18Uqhi4V2wdg
	esTaW0DdtT8bkL88Y3X4QgPhMpnRM51XLrAQEROvJ8QL3Hck2Lk8LZbwn/7c6ccTU+cVMtR+TUj9l
	A6XNv8nFhwrdporOQ04ice4hri5ufshwHhewjdR6R83FpR9HVYoV0wJYSSBBOZDSQzkg3vKQhO3DD
	5/hwO9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEjJ-002E7y-29;
	Sun, 29 Oct 2023 22:58:01 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEjG-002E6w-2r
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 22:58:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7F314B8074D;
	Sun, 29 Oct 2023 22:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016E0C433CA;
	Sun, 29 Oct 2023 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620276;
	bh=XK8VooXnurc1BFxsLPqCnhiM8Mdfh0R1ydlPC0bcP2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNHYZadAHiCl5I0S7AOC6z3lz4nwG5a00/9KGM2Xo5v4ke60TKNECwjF1lVjixNNO
	 8Wum4uVsLXk4mFTeCKNy8r8p0vvSMSQhu19HNE3nNb+HMbglESoQz+Mc548MTtvch0
	 5iHVWUZYPI5rOxxiUTskhmfZD3+/gYSjs+eu7d++/VOQ58BQJM+rIEZS/EGPVy1ZIA
	 t5+ePe6oNxzLG0yNYhloiMrL0T1UNt0IYd85D71Vz0h6MOh5lqTh7DUEhTSAn0sjUf
	 +eA90Hc95pISVy1IlnwxmZdsOIn9oYmrsNfGx/LTlAq6Naxnio1ALayreudfn3zzul
	 0nIes5EEtrQjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/39] nvme-rdma: do not try to stop unallocated queues
Date: Sun, 29 Oct 2023 18:56:44 -0400
Message-ID: <20231029225740.790936-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_155759_068699_06D140EB 
X-CRM114-Status: UNSURE (   9.13  )
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
index c478480f54aa2..aa1734e2fd44e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -643,6 +643,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
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


