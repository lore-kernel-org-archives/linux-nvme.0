Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B21C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JwqnoRMEPnDTY/wm0LWTRqRDQbHwvegYwS2lK3Rpn1Q=; b=zVlkn2qljK5nUj++PyO4OfinR4
	nIqww4uTknlqWCp9IxjYEdkUFe3770mJYj9+J4XccGlM0tPlzN/Ch73p/DfQJIDJg13iZw3Do8rV8
	7QWozGsnKOuaRqrDO9KodAWAB815BMuJqHCo1ocAhQhkGTcN4b7miD+wVRSWeADDNdlUaqqv7f/4M
	fGRolLcv7M9fmjpK/+3kOvvNZLlrMctSkLZ4hSrcEJRjdPF/YpXVKzGZsG83zwhJ3CQCaNsb9nPd4
	uZjyW2+63ezMTIhG7dqLl1oEOP1U/mdhXI9j1IVLy22tmU6etSGV2DauitSaoTGKjWHcmQlor846Y
	y7Xjd7DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peXU9-00Bhqs-1L;
	Tue, 21 Mar 2023 08:36:49 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peXU2-00Bho3-22
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 08:36:47 +0000
Received: by mail-ed1-f46.google.com with SMTP id cy23so56441737edb.12
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 01:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679387798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwqnoRMEPnDTY/wm0LWTRqRDQbHwvegYwS2lK3Rpn1Q=;
        b=mmgym1MaagHU6VZqg8YFCXm1cd37Bd0FXjRy2H74Ig/OhMK1asjB75IKMEmZYTOH7T
         /8Ryaio641PB0OAsxzOMkPTzYa/dewi8gvXLzpEDee/+3Uzs0l8yg6XjoEXJpv8wajP3
         tagmQyZ8hQFxqo8aKuY40HDzz20cVv4Y1galSmHUawTMQexBOKCMxWaNyrrVjCoo/Ju2
         tsJj9aF4tjTPoO1g8BGav8Gx2/zZC+Uue0iU0FcHoqdhQQ32v7gWhBV6feYjKU+WPMOP
         T/ZnSh5gZhLi0ngBVb7UpM39oP68kyuBWVtI61ldqjNj8xs6DMMbWAqpH/IeJsRO9zNf
         wlzA==
X-Gm-Message-State: AO0yUKWwi8+e7at/Buqc0lptRfq1JU/nkiH3NHoHRxaOz3DsJMdH5s4k
	Z40P8sxMPNcAk282g0b4LWWQPOxgXFQ=
X-Google-Smtp-Source: AK7set8uDlSQ6H5uCsEu78j4jiBUOHkk3xsErtgUhjooi9wCHR/f/PECjfhL9AwWuTwwRq47tHlaig==
X-Received: by 2002:a17:906:5349:b0:8eb:fb1a:6970 with SMTP id j9-20020a170906534900b008ebfb1a6970mr1344957ejo.1.1679387798562;
        Tue, 21 Mar 2023 01:36:38 -0700 (PDT)
Received: from localhost.localdomain (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709062bcc00b0093034e71b94sm5434158ejg.65.2023.03.21.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 01:36:38 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: [PATCH v4] nvme-tcp: fix a possible UAF when failing to allocate an io queue
Date: Tue, 21 Mar 2023 10:36:36 +0200
Message-Id: <20230321083636.95424-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_013642_674197_4192D934 
X-CRM114-Status: GOOD (  17.53  )
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
queue, so that we can't accidentally schedule the io_work in the
initialization phase before the queue started. While we are at it,
rename nvme_tcp_restore_sock_calls to pair with nvme_tcp_setup_sock_ops.

One more trivial change is the CONFIG_NET_RX_BUSY_POLL check.

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
Changes from v3:
- change CONFIG_NET_RX_BUSY_POLL check (Chaitanya)

Changes from v2:
- Move sock ops assignment to its own function (Hannes)

Changes from v1:
- Fix silly compliation error

Yanjun, I'll be waiting for your Tested-by tag. We need it
in order to apply this fix.

 drivers/nvme/host/tcp.c | 45 +++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..bf29ba89553c 100644
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
 
@@ -1655,7 +1640,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	return ret;
 }
 
-static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
+static void nvme_tcp_restore_sock_ops(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 
@@ -1670,7 +1655,7 @@ static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
 static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 {
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-	nvme_tcp_restore_sock_calls(queue);
+	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
 }
 
@@ -1688,21 +1673,41 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
+{
+	write_lock_bh(&queue->sock->sk->sk_callback_lock);
+	queue->sock->sk->sk_user_data = queue;
+	queue->state_change = queue->sock->sk->sk_state_change;
+	queue->data_ready = queue->sock->sk->sk_data_ready;
+	queue->write_space = queue->sock->sk->sk_write_space;
+	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
+	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
+	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
+	if (IS_ENABLED(CONFIG_NET_RX_BUSY_POLL))
+		queue->sock->sk->sk_ll_usec = 1;
+	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
+}
+
 static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[idx];
 	int ret;
 
+	queue->rd_enabled = true;
+	nvme_tcp_init_recv_ctx(queue);
+	nvme_tcp_setup_sock_ops(queue);
+
 	if (idx)
 		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
 		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
+		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &ctrl->queues[idx].flags))
-			__nvme_tcp_stop_queue(&ctrl->queues[idx]);
+		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+			__nvme_tcp_stop_queue(queue);
 		dev_err(nctrl->device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
-- 
2.34.1


