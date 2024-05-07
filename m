Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BDDC10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mLIU51c+pYnojVDAV+qOaN4vueomXM+v5jMZDy/31ro=; b=RuJ0RLs+nXlckJ8fLa9970Ioot
	Q5JHVYmMjCbO9NBTkYnmanrJvwGv0U1sYbCbw9hCXpdo9TS9dosnAc4cgJ/tof5rc5hbrZnB+ors/
	d7lAQEHOM0HDzFv1y8THTjSlbCMYRJMavMUzXqWpUBg2KswjXw6rAr8aeXA2M8y2YB/DOzk4pNyf/
	Ba8A6VZqeL6+Dvk6ISdro1Q0meyMVInlGdQYKACCKXSS4YJ7Vzn/bXZgNMub9uV/stU3iJf0tXp5Q
	o4YW2H9tmmyBeXr8xWekH+efxdP/TyJwqxK7xuG5xybDVxPpFRKR61kEpXZogOGCZKwpxJ90EgIg8
	ncrgYqug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyx-0000000DBdm-3XrH;
	Tue, 07 May 2024 23:12:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Tyj-0000000DBTd-2Hzk
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:12:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0E77A61985;
	Tue,  7 May 2024 23:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A7DC4AF17;
	Tue,  7 May 2024 23:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123528;
	bh=+b3UhOorUYRN3icKNmfSHrThvhesb+DJyS5oQUGZx7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAACnHwykqX7TWvNA3geIRqF6tNCo/NboGtiI27Voiz6xkQeHb19xkaRHw5qNApCg
	 s47rCceLEsdYHeOcHqV+G7OT2vXngmOxaHUdyD/3PhSPg46ef1kpwWRl4CAqB79bfM
	 iriA5GttDAoOMIZIaMGVKSZGEd+EQcZDaO4ohAM5CXAS+kuQHVwBr+Ql9pNrrGT7zo
	 wv667yKQ6Upade7YheBWevMQrWYx3k3hnYA4El1ZbeZmHSdtIV/W8H5gT08zjr266p
	 S5qiuT4nbLlA5e1W44sTm420/F4VpoxcpzqCHGSGpmViST4PQBKeLT+oxvVKvmZeV2
	 dRCQZlViEfXsw==
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
Subject: [PATCH AUTOSEL 6.6 41/43] nvmet-tcp: fix possible memory leak when tearing down a controller
Date: Tue,  7 May 2024 19:10:02 -0400
Message-ID: <20240507231033.393285-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_161210_031086_4CAC7E30 
X-CRM114-Status: GOOD (  14.50  )
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
index 8e5d547aa16cb..3d302815c6f36 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -324,6 +324,7 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+/* If cmd buffers are NULL, no operation is performed */
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
 	kfree(cmd->iov);
@@ -1476,13 +1477,9 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
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


