Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA9CC3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sysZQtvV889s8KC2dKsPTtc7qILC91Qq0UM8kRqFr2A=; b=RWMInzLvc8un9CrWpjUisR24Or
	Cll2QuQ1xEDgM+khHgWUYY+4A3CVCC77KFw7XYIj0mBTMn7gJ/81b4EoT+hJp3YaAigbRWxiZhq0O
	Gh5MpyJjjbopgg7SHMCddTWUpQZU2RlHoDYqtp2qh46/fbaTlTd5t83GgJmzr/g5eZmwMzk9DCrBc
	lPPrixO2TST3mZQeRmNbswAtB5NhB/32nMUeawz6rHDj/+EX/7ByfOFAIiAycmHzaMrydq+YSAowO
	i4gyi4wrsyqwWgRNsQs8ntwtWdrPzaquR+TEc63oEGEz+j1TgGcDLczvQ6i/6HlA91oPiB4dmlT0/
	CCjdDlkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTck0-00000009c3b-37Mx;
	Tue, 16 Jul 2024 07:36:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjr-00000009bu3-1uNj
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BC8BF60EA5;
	Tue, 16 Jul 2024 07:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030BBC4AF09;
	Tue, 16 Jul 2024 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115402;
	bh=M/L3OyXwSfLt1Ebkv7E88lPC38ofCDFgFSI67kZLFsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9cxoJhLq2WXJ0EpZJxhgHXmFgM4sBMPQNj/dRtVCIVpwxQ6ywyQ5XWUmICgY4SvL
	 QDigQkHrthyV/uSIUBep0Pm31R7n5u/eAlC7fqAODTzg/92xq7eJ8jA2/G4fhGOAbH
	 hwRwX6FqdqkXzRthrSOVo628+CQLYiD1uk28DdgZ7f6roFLmyMe9dYVhb5PgKuzUAA
	 7e/s1EydYEhOFqqjjZVXmHbUPCrQp/g0Bdg1Mxl6wp7YOhKPWnN8AbvlsjrzyriA15
	 v0QssCbaS93Dd0nyVk18/OBGNLOOV2OyXR5A2pIBn+7bNePirw2ZWWTQDm2Joob1oZ
	 7xcwCF/qy2PgQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/8] nvme-tcp: reduce callback lock contention
Date: Tue, 16 Jul 2024 09:36:14 +0200
Message-Id: <20240716073616.84417-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003643_631465_BA564C78 
X-CRM114-Status: GOOD (  11.41  )
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

From: Hannes Reinecke <hare@suse.de>

We have heavily queued tx and rx flows, so callbacks might happen
at the same time. As the callbacks influence the state machine we
really should remove contention here to not impact I/O performance.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a758fbb3f9bb..9634c16d7bc0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1153,28 +1153,28 @@ static void nvme_tcp_data_ready(struct sock *sk)
 
 	trace_sk_data_ready(sk);
 
-	read_lock_bh(&sk->sk_callback_lock);
-	queue = sk->sk_user_data;
+	rcu_read_lock();
+	queue = rcu_dereference_sk_user_data(sk);
 	if (likely(queue && queue->rd_enabled) &&
 	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 		queue->data_ready_cnt++;
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
+	rcu_read_unlock();
 }
 
 static void nvme_tcp_write_space(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	queue = sk->sk_user_data;
+	rcu_read_lock();
+	queue = rcu_dereference_sk_user_data(sk);
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 		queue->write_space_cnt++;
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
+	rcu_read_unlock();
 }
 
 static void nvme_tcp_state_change(struct sock *sk)
@@ -2076,6 +2076,7 @@ static void nvme_tcp_restore_sock_ops(struct nvme_tcp_queue *queue)
 	sock->sk->sk_state_change = queue->state_change;
 	sock->sk->sk_write_space  = queue->write_space;
 	write_unlock_bh(&sock->sk->sk_callback_lock);
+	synchronize_rcu();
 }
 
 static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
@@ -2115,6 +2116,7 @@ static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 	queue->sock->sk->sk_ll_usec = 1;
 #endif
 	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+	synchronize_rcu();
 }
 
 static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
-- 
2.35.3


