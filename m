Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D97C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PGUgs/fouCz7pBqMgWpqIckyfatQT0O3qzf8A2LBkm4=; b=bMJbSwwOeI8BHL
	kYkDdnLpRJHVR5APcPtPq0ZFTcpPAozD4DGqkontYD03DmKzR8ULEtXRhZU3iGc5x+AG9UPwRoFfK
	UZks2WA6DfOIPK1S+ln3qQXEQNt3P9lG2pPrhGleAWQ7qUl5bwcWp4u15d2KYrXbyUlwY80AccJfl
	OZ3W+oBQlQlBoub7/uAKC0l+3xJvjuJVeGP6KthdVMP/LGL17eIZKUr1HyT4JQaadN5gUXgBvTGpd
	QxvKPezZLhqvWZD8qiExpVHVGD07OT/X5LqPU+d3GzFvxL0PH4Qe04N6N42SBvs36LR8ZSVwZ3S1X
	MurVMoeuADrEoJfvkdPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nK9yX-005J72-DJ; Wed, 16 Feb 2022 02:23:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nK9yT-005J6i-IS
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 02:23:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644978199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PGUgs/fouCz7pBqMgWpqIckyfatQT0O3qzf8A2LBkm4=;
 b=HTuISZjpoFQjyerfVPPz4wzH8qaGYRlEQsKxmMlgE8LVJaqvc75s8D6g4C1J/n9SPnLCa5
 vAJ+F2Zb/4rbzTPgNV58lGkfSfX26VDVemfnQmfgXJnXgS0ZyEbZBeXc3h1xIBQCiNAZsy
 1qvUbne/veNZCZR1EdjJfodC7nd/P2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-9tvnZbpHM5aOwZEXLOhvWQ-1; Tue, 15 Feb 2022 21:23:18 -0500
X-MC-Unique: 9tvnZbpHM5aOwZEXLOhvWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57C9C1091DA3
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 02:23:17 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.16.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED1DA5DB86
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 02:23:16 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/1] nvme-tcp: lockdep: annotate in-kernel sockets
Date: Tue, 15 Feb 2022 18:22:49 -0800
Message-Id: <20220216022249.2856536-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_182321_709556_41EB821D 
X-CRM114-Status: GOOD (  14.92  )
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
---
 drivers/nvme/host/tcp.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 891a36d02e7c..f1b27e8b9b70 100644
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
@@ -1435,6 +1473,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_destroy_mutex;
 	}
 
+	nvme_tcp_reclassify_socket(queue->sock);
+
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
-- 
2.34.1


