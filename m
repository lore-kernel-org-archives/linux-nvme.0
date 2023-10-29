Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78BC00142
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 22:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLsV4s274KLdH1M9nhG6hDhOHr+XN/mXoJCGK2wtno8=; b=syI4GAH1frV8mr8qMCX0A+EGTX
	K76s2/RHLE65NK1uNh7nPHg6mNomV3O7YfCwQBjw5ppshfJ4Z83p3aLtloTPy3Yb+e/vfRljqxDsx
	8mZV6HyeuSbQvpvZ1+r/86Ly3Zko9gxsPLiIkn65gIAGVh3qOfZll7XYixApu+QHPOtkHNdvvXpbG
	zJEvmCpr/OfK4o5v4cUK0rv5njwR2VUEBdxV8luPzT5Sru1lq90QQ24ldbYIfi9vcrKbjkSicVvp0
	juGg4yKD5hx+vUwiiSZOIQWH1rfklYxDB6DkYEH5r8hTwRotEvz4F9CjB+ovj27LWw5iKYyS9WjdP
	c2QZgtDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEkr-002EX2-1o;
	Sun, 29 Oct 2023 22:59:37 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEkp-002EVu-0Z
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 22:59:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id CE34AB80707;
	Sun, 29 Oct 2023 22:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56098C433B7;
	Sun, 29 Oct 2023 22:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620373;
	bh=mfutkbzhl3xkRVSBDt388tSkZwdwIZdy7DDdvPlTclo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQBeqinCDWEj6/ZL48CHD6M8dsUwEEfISA1t7nfXCnzooTk/WWC6P6tgdrzX35ESn
	 W6/6f5eybyHWiEddlkH6GEV9bbb6f/dBRyj1kzUxXlFXaGKrQUw+fU/qO92cy8n5JA
	 SuRHQFtW+auS7Jiqa9dyZVAiXWQ/Zv3HlK+jg9OHDH8bv+Fzu2pDGt6vetDYiZWTes
	 +3CPfMaf7RH4ELzgTeOT72V4Tfc5s9i5DsgjdznXTh30Sjt2sDt6XwiGF/JoIlYRTA
	 FSQ0bdCZ5HQSY9nbiOjHIKJd4p3S1VF9l+8ecLh9VOl2eMcxk0UB99ghEfJRT1c6jM
	 dDbmf2JB6vLLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 12/28] nvme-rdma: do not try to stop unallocated queues
Date: Sun, 29 Oct 2023 18:58:47 -0400
Message-ID: <20231029225916.791798-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_155935_358443_DA91DEEB 
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
index b76e1d4adcc77..6e92bdf459fe4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -645,6 +645,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
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


