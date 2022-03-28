Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E29C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Nn3mjXv9L6zToUuNERHVRfIaXp74XF9cWxdkA6zJJ0=; b=gmruFZBMZRl6Buel168s0S1lwB
	rDieUGbfSlOqwgnjpCFnE0e/a5POb0K30JKeHVRrP7oV2bl23onFZ3crESRKcsY7VpRMd33syAGxy
	lCNLT/WBr2fkUxOKdpTTk3Mj+CpYKUf/GDqzZ2JDTtIkfOrLbd4tx53Exbie0Ae5SfPprmAReVSTH
	vER3N4eVs/9UpkJyi0ifUGxv6QWSTRajLzI/n9R1gk56Fd+yDfrk/SRcDRl3qeamwAjHnd8zbWNz9
	6avETs/ePIvpD9fKWh2KYHp/OLdB6cQLx6UpyOwtpCUsAH7U+k3kX/x8ekBwwSPPShXA+erWTrasC
	So8tqCdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYnTO-008MiM-HK; Mon, 28 Mar 2022 11:23:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYnTL-008Mgw-Ue
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 11:23:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 77306611F0;
 Mon, 28 Mar 2022 11:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FBDC340F3;
 Mon, 28 Mar 2022 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648466623;
 bh=o8wKoUb2M1W9qRi7fF9bUG326XYmoANmb7pml3OIOJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KqD6TG5mFILsV+gHm6E8NqwZ+JgopOgkCxlpvD+kg9wqAsOO9ZdnSuEpEVIOS36Gl
 YUQ0LWUulJptUw5mSPDEHiQW/Xc4Wr+uF7rBe1AqH3m2/nBkKDtA1IRzqobYpcIoWu
 DOTJ4CTmO4aEwQiWfYpi5ndmh0rQLt2Vu7kiyoq1gU6a3c4nxWAazU+Y1rY4LMivEJ
 HiW7zhWfBU5BUMNFAJ7oYUS9YIAtSsgHgtMIPkEZokr1GYnGzFfwUvf6y+8Cmnzpco
 89jxxLpMezEW/0V2rD84sXMW144v2KxcqSM2yGMzH/iM6+2HDjTGZdW/SBisVc9AzY
 RMq0oePxpWXQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Leech <cleech@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, kbusch@kernel.org, axboe@fb.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 20/21] nvme-tcp: lockdep: annotate in-kernel
 sockets
Date: Mon, 28 Mar 2022 07:22:53 -0400
Message-Id: <20220328112254.1556286-20-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328112254.1556286-1-sashal@kernel.org>
References: <20220328112254.1556286-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_042344_158030_C4FFD73A 
X-CRM114-Status: GOOD (  15.01  )
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

From: Chris Leech <cleech@redhat.com>

[ Upstream commit 841aee4d75f18fdfb53935080b03de0c65e9b92c ]

Put NVMe/TCP sockets in their own class to avoid some lockdep warnings.
Sockets created by nvme-tcp are not exposed to user-space, and will not
trigger certain code paths that the general socket API exposes.

Lockdep complains about a circular dependency between the socket and
filesystem locks, because setsockopt can trigger a page fault with a
socket lock held, but nvme-tcp sends requests on the socket while file
system locks are held.

  ======================================================
  WARNING: possible circular locking dependency detected
  5.15.0-rc3 #1 Not tainted
  ------------------------------------------------------
  fio/1496 is trying to acquire lock:
  (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendpage+0x23/0x80

  but task is already holding lock:
  (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]

  which lock already depends on the new lock.

  other info that might help us debug this:

  chain exists of:
   sk_lock-AF_INET --> sb_internal --> &xfs_dir_ilock_class/5

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&xfs_dir_ilock_class/5);
                                lock(sb_internal);
                                lock(&xfs_dir_ilock_class/5);
   lock(sk_lock-AF_INET);

  *** DEADLOCK ***

  6 locks held by fio/1496:
   #0: (sb_writers#13){.+.+}-{0:0}, at: path_openat+0x9fc/0xa20
   #1: (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: path_openat+0x296/0xa20
   #2: (sb_internal){.+.+}-{0:0}, at: xfs_trans_alloc_icreate+0x41/0xd0 [xfs]
   #3: (&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xcf/0x290 [xfs]
   #4: (hctx->srcu){....}-{0:0}, at: hctx_lock+0x51/0xd0
   #5: (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0x33e/0x380 [nvme_tcp]

This annotation lets lockdep analyze nvme-tcp controlled sockets
independently of what the user-space sockets API does.

Link: https://lore.kernel.org/linux-nvme/CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com/

Signed-off-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6105894a218a..7e3932033707 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -30,6 +30,44 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/* lockdep can detect a circular dependency of the form
+ *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
+ * because dependencies are tracked for both nvme-tcp and user contexts. Using
+ * a separate class prevents lockdep from conflating nvme-tcp socket use with
+ * user-space socket API use.
+ */
+static struct lock_class_key nvme_tcp_sk_key[2];
+static struct lock_class_key nvme_tcp_slock_key[2];
+
+static void nvme_tcp_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-NVME",
+					      &nvme_tcp_slock_key[0],
+					      "sk_lock-AF_INET-NVME",
+					      &nvme_tcp_sk_key[0]);
+		break;
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-NVME",
+					      &nvme_tcp_slock_key[1],
+					      "sk_lock-AF_INET6-NVME",
+					      &nvme_tcp_sk_key[1]);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+#else
+static void nvme_tcp_reclassify_socket(struct socket *sock) { }
+#endif
+
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -1422,6 +1460,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_destroy_mutex;
 	}
 
+	nvme_tcp_reclassify_socket(queue->sock);
+
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
-- 
2.34.1


