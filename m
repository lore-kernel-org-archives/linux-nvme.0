Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EF4C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G2riPEJLYe5F7Q6T9PPxOzCuDi4PfLqS+kMqp8LcPIk=; b=SlZDXEqcIC+sPwFicgJsCgyjZo
	A16OIgCDYjsFPJwsewfyNIWeuaNX75AuiN6Xybymc/3KCRFdHWpprn7YJSYxzsJmq18p/q3KWzqi9
	//ka6gtmOetrK0wbrRSHIIfLGxIyQzGgt5dBHox31NZ8J8MqCic6bt3KZNrZfZslx57ktRbog3zFq
	H9R9d03xGqCD5k4en6IXHelBxJRvxvdTtxqRV1K5BItrNjIBW5KeYLn1kaWY9dWIbqs/S+XFrcT3/
	9pBRwAGpBLaIBkrrQ6PtR7cRqMiZlzABj887f4CpcDE9+7oBikaXNxJCnaZXP2sTyFXJDyKYufxUq
	6Fx0J9nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjLf-00FmNG-0x;
	Thu, 16 Mar 2023 08:52:35 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcjLc-00FmLz-2y
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 08:52:34 +0000
Received: by mail-wr1-f46.google.com with SMTP id j2so767382wrh.9
        for <linux-nvme@lists.infradead.org>; Thu, 16 Mar 2023 01:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2riPEJLYe5F7Q6T9PPxOzCuDi4PfLqS+kMqp8LcPIk=;
        b=EBBKy0m5g/k5j5RC+eBHRP5sUJBnzA/qWS8R+eMdtad99+TMFCgZqKQlaSAQXJERSw
         xKDt7qjlIKrSTPaQ1gi3wI9IKTFTRa7xnNt/eirq6p8nb+bzutXjJTlxXZTlL/O669I/
         TRIcrTERf7J7HeNU/0IKjahpt+frR7aThfESIBn2MPKTiXnOLxCrdWMJ0ebx0lQU3nqh
         BEM1p/J7FikVTDegkGZbMn1OjOQ4hDEg/7S8W+WLMXtcF3LQ2ktyu6rTu4CfawBpX8pQ
         jiOQRbgi8avniamUAlMVTjyZg3xP1En3wuUY61i7u3SPsauDhxwbA3mrkuS6vl5nq/NU
         PTJg==
X-Gm-Message-State: AO0yUKU5tv5alE71P8kWkP9Ji1b+VKh9mxbBlUyzpqlVkyFNQ9ru9Lkv
	/FKJTk2NBxfRXfhAzB+czI4RG4VPZ9o=
X-Google-Smtp-Source: AK7set9TVxdhpWTRvL84i17OO6nxQuCVH1pXmtHymjPLZabFxIB2lL9IZAF9eYKxHCIhCymCX4T+LQ==
X-Received: by 2002:a5d:4d92:0:b0:2c7:b49:97f6 with SMTP id b18-20020a5d4d92000000b002c70b4997f6mr1493960wru.2.1678956750774;
        Thu, 16 Mar 2023 01:52:30 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w17-20020adfd4d1000000b002c70ce264bfsm6642474wrk.76.2023.03.16.01.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:52:30 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: [PATCH] nvme-tcp: fix a possible UAF when failing to allocate an io queue
Date: Thu, 16 Mar 2023 10:52:29 +0200
Message-Id: <20230316085229.158775-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_015232_962359_D4B8CDB4 
X-CRM114-Status: GOOD (  14.64  )
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

When we allocate a nvme-tcp queue, we set the data_ready callback before
we actually need to use it. This creates the potential that if a stray
controller sends us data on the socket before we connect, we can trigger
the io_work and start consuming the socket.

In this case reported: we failed to allocate one of the io queues, and
as we start releasing the queues that we already allocated, we get
a UAF [1] from the io_work which is running before it should really.

Fix this by setting the socket ops callbacks only before we start the
queue, so that we can't accidently schedule the io_work in the initialization
phase before the queue started.

[1]:
[16802.107284] nvme nvme4: starting error recovery
[16802.109166] nvme nvme4: Reconnecting in 10 seconds...
[16812.173535] nvme nvme4: failed to connect socket: -111
[16812.173745] nvme nvme4: Failed reconnect attempt 1
[16812.173747] nvme nvme4: Reconnecting in 10 seconds...
[16822.413555] nvme nvme4: failed to connect socket: -111
[16822.413762] nvme nvme4: Failed reconnect attempt 2
[16822.413765] nvme nvme4: Reconnecting in 10 seconds...
[16832.661274] nvme nvme4: creating 32 I/O queues.
[16833.919887] BUG: kernel NULL pointer dereference, address: 0000000000000088
[16833.920068] nvme nvme4: Failed reconnect attempt 3
[16833.920094] #PF: supervisor write access in kernel mode
[16833.920261] nvme nvme4: Reconnecting in 10 seconds...
[16833.920368] #PF: error_code(0x0002) - not-present page
[16833.921086] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[16833.921191] RIP: 0010:_raw_spin_lock_bh+0x17/0x30
...
[16833.923138] Call Trace:
[16833.923271]  <TASK>
[16833.923402]  lock_sock_nested+0x1e/0x50
[16833.923545]  nvme_tcp_try_recv+0x40/0xa0 [nvme_tcp]
[16833.923685]  nvme_tcp_io_work+0x68/0xa0 [nvme_tcp]
[16833.923824]  process_one_work+0x1e8/0x390
[16833.923969]  worker_thread+0x53/0x3d0
[16833.924104]  ? process_one_work+0x390/0x390
[16833.924240]  kthread+0x124/0x150
[16833.924376]  ? set_kthread_struct+0x50/0x50
[16833.924518]  ret_from_fork+0x1f/0x30
[16833.924655]  </TASK>

Reported-by: Yanjun Zhang <zhangyanjun@cestc.cn>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Yanjun, I'll be waiting for your Tested-by tag. Need to
in order to apply this fix.

 drivers/nvme/host/tcp.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..a8f3d8052b8d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1620,22 +1620,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	if (ret)
 		goto err_init_connect;
 
-	queue->rd_enabled = true;
 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
-	nvme_tcp_init_recv_ctx(queue);
-
-	write_lock_bh(&queue->sock->sk->sk_callback_lock);
-	queue->sock->sk->sk_user_data = queue;
-	queue->state_change = queue->sock->sk->sk_state_change;
-	queue->data_ready = queue->sock->sk->sk_data_ready;
-	queue->write_space = queue->sock->sk->sk_write_space;
-	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
-	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
-	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	queue->sock->sk->sk_ll_usec = 1;
-#endif
-	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
 
 	return 0;
 
@@ -1693,6 +1678,21 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	int ret;
 
+	queue->rd_enabled = true;
+	nvme_tcp_init_recv_ctx(queue);
+	write_lock_bh(&queue->sock->sk->sk_callback_lock);
+	queue->sock->sk->sk_user_data = queue;
+	queue->state_change = queue->sock->sk->sk_state_change;
+	queue->data_ready = queue->sock->sk->sk_data_ready;
+	queue->write_space = queue->sock->sk->sk_write_space;
+	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
+	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
+	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	queue->sock->sk->sk_ll_usec = 1;
+#endif
+	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+
 	if (idx)
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
-- 
2.34.1


