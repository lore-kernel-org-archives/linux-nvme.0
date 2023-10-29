Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C2FC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VnfjelIRcRQGFkmbP6BHKNsUVYDFFuyyun2R9/zsNco=; b=DTOhIXpfSyyZ242bbkzlUbkcDZ
	v8o0FHY/mP+meU+dLXnZ9HWUptfI/D358FhqHdfu8dBfBvWajYfj/eKagGpZJDWvz+MQg2tUz29lI
	fPLOdifHHcGpuQgrIKh5M5ZPXg03iCv8csJGsirWb1EMsFsWZ2jl68VLf9J9EOJu90/nn2VnN8UUa
	IwFCIKr3moUoNTBydfis+eRp3oETBPSJ1o+VIutJQ3ijtOMCs+IRMMAiA1sWLLcqw26KY5PTWET4N
	8N4JDVMJwY9/2kCV0gLifo3AC3kotZjOuodtsGrDX1ssME+1Bs+/SlEk8YiKwMHl+862kdJAzDDhG
	do+L0GZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEgc-002DYo-1X;
	Sun, 29 Oct 2023 22:55:14 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEgX-002DXG-2v
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 22:55:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 38531CE08CE;
	Sun, 29 Oct 2023 22:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774F3C433C7;
	Sun, 29 Oct 2023 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620107;
	bh=d6+abDYEVtUova+KDIxPln5hjytDhkyGRBLx/ZCBVSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLI2pk3rXZYqXzS8vVVvtravK8O9ghccPpV4wMtH6tXrQIDbqb4KoPf69Vtr/huM2
	 XHka7c4OsQgvJyv7T4wwZfOp2ODibDUjJuFyLQFYwcmi6uZB/zIvUqX/TK/b+JgrAP
	 jLL0lUtIK4Ov/Kz2ZzXKNu2RfCVJPakBd6xnFkStQazO22uxkS3fd7CLUqh4Dhst9U
	 apjLvQS1t05nf9Uay/G/RMu+J810xOHfi+1hNwn/dK7yowioSAU6HQxbAlvK3NsDdD
	 vNS2MxlKSBCxTzA6npDC/vuSmUT70up8d/yN9yGhUq1IXZxq2UtRGo0tM+UD5ctmO0
	 X0UD1NnXUMNzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 17/52] nvme-rdma: do not try to stop unallocated queues
Date: Sun, 29 Oct 2023 18:53:04 -0400
Message-ID: <20231029225441.789781-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_155510_158347_EA220E3C 
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
index 337a624a537ce..a7fea4cbacd75 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -638,6 +638,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
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


