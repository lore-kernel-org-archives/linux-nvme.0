Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8E1C10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzZx5vGA64jEjKBjseUs+M74lcCVh24eDRvumzjGYEU=; b=VogNv1G6Ztw+t6igi12R/meryz
	MkvvFnYqVhymj1SjO4MQxh+KQvjqHEr0sX4iit51LHpYjUFmMHIUEQTo2iYY9Kx292h2790lmbRvt
	usBcixgzQeXVsbTGwj0CbSweaFduCRXPWfAa9IkvTz0P5wDcsvSqPqFhRL8Vz61baduElrR13k5O5
	QeAJsPF8q0MwhflLKVJw/CJG0kJZn0xWShA6yvSMa8sn0rU/bpArMFP4VWAQR/u4nMElcd5bsZwoX
	tdPNcS8aZAY9An3TEeUUTBOWbVDbLxMDDS3yEeDxCknGrbwgv5QYFez5MksnrHYd0DwaLk1VfXvSp
	MqdXl13Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4U0G-0000000DCXD-2mVR;
	Tue, 07 May 2024 23:13:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tzu-0000000DCIa-0NbQ
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:13:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8E0D661A1E;
	Tue,  7 May 2024 23:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CFC3277B;
	Tue,  7 May 2024 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123601;
	bh=HOFK1k5/G3H5LG+wE2AHumQWNVSavEuXqzk8rzQ3Irc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2DyyH8wtRKhSNcbpKzmnKN3v6WTYhJsBAhETEWZzDHYwv+qArb0owarFqfAD+JEm
	 sYXCGlmdvJQZndemdPvebK4nV1ApDXLr7Aq4JnxrSkBn5G+LeV7ckBwGnt9e2t1SXP
	 Lr2AX+R+6QVn5PWHbwMgrZLnpYicBZQZlEg1zGXQBplAT03QjjJraQwJ5ymsjEQw3n
	 zYUrLUBeQRysQ+GJd6Kt6hhHZhu4L51J086tLCqPRuFzXhgW/0trGxIhr1ZKh4UnlC
	 x+v/NU5IX1qq5YGOXiBTaqmIH5qye0laPTZopMdB3dEEMpTtnJT91gBn8YGBkNLFSt
	 gFp3uFzcovbyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 23/25] nvmet-tcp: fix possible memory leak when tearing down a controller
Date: Tue,  7 May 2024 19:12:10 -0400
Message-ID: <20240507231231.394219-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161322_378725_0E9358B5 
X-CRM114-Status: GOOD (  14.51  )
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

[ Upstream commit 6825bdde44340c5a9121f6d6fa25cc885bd9e821 ]

When we teardown the controller, we wait for pending I/Os to complete
(sq->ref on all queues to drop to zero) and then we go over the commands,
and free their command buffers in case they are still fetching data from
the host (e.g. processing nvme writes) and have yet to take a reference
on the sq.

However, we may miss the case where commands have failed before executing
and are queued for sending a response, but will never occur because the
queue socket is already down. In this case we may miss deallocating command
buffers.

Solve this by freeing all commands buffers as nvmet_tcp_free_cmd_buffers is
idempotent anyways.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3480768274699..5556f55880411 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -297,6 +297,7 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+/* If cmd buffers are NULL, no operation is performed */
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
 	kfree(cmd->iov);
@@ -1437,13 +1438,9 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
 
-	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_free_cmd_buffers(cmd);
-	}
-
-	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-		nvmet_tcp_free_cmd_buffers(&queue->connect);
+	for (i = 0; i < queue->nr_cmds; i++, cmd++)
+		nvmet_tcp_free_cmd_buffers(cmd);
+	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
-- 
2.43.0


