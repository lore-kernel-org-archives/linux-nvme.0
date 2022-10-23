Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AF5ECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Oct 2022 08:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BbdLFtoJiGN2V3tf7GHlpHREfdQSg6ezzLTn7J3VBl4=; b=k308wya1Kbu7v1Y/GaxuaSruCZ
	geJ0f3j7vTw/Ou6LU6FWG2RO2J1YlwoyHpiZocZzPpl9ue1k51A9ZajKXptt/0q0qTm43txk3DXfz
	KpSffDL6pemSpEgybCKMTlpRal7A+CLwo3NE97hTnF0i7Mc+MCjcsJgy2qbLNn+eZrINJhScH+t+X
	gmToBxqMyygqWnN4tfj6LjRpSxVaLO62/u2CknEgjFoxNsQ7sqZdYqJkEH6azYPFTbr0BTk5JMhCN
	z6EQSpKBcQN7QPjijd/txwdmoA/4p3MNDsQC99cx9k0rZysJn1EgBnVYgg2xOLZFwjUDdORcAtRQo
	y98equSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omVyV-00EgOv-PF; Sun, 23 Oct 2022 08:04:51 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omVyT-00EgO4-5Z
	for linux-nvme@lists.infradead.org; Sun, 23 Oct 2022 08:04:50 +0000
Received: by mail-wm1-f43.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so4701979wmq.4
        for <linux-nvme@lists.infradead.org>; Sun, 23 Oct 2022 01:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbdLFtoJiGN2V3tf7GHlpHREfdQSg6ezzLTn7J3VBl4=;
        b=L6gdXjbVsQ3eMh2cfG/rg1yma1kDGuI4zr943A6D7irWgdL8VMTEhiYBmwiarGrP3G
         w/ld6kuWN7NcL6aYO51WppCSy6NGEXvF+ufCXGV2w+9e/VDMSZlEfskO5MgLI45nsLiF
         3jatzM+6Asv7Xtw3dWhqdnPVmnhck0MAQbKQflj3RJwhVtH44yBtcT1b04cH9F1CW00i
         F6/dSG9PsoAmBKEppHOv9Q0nkcVxqhKHAe9T9L2G9LW85IgOWPe8rE03hVFYIkj567sL
         PTlqr65AeOPHsqxQZogDvXRv4Y9YPK3QX2oDJACvFUXSgmLaUZ2v32l8HYHXnZVoU/Da
         RIIg==
X-Gm-Message-State: ACrzQf2gXXJFnAG+VyXPnpff23Z/IWS+FVX2qXkMOiXR2GepnT4SPZED
	Op/OPbD7yUKeJ0I0i4Z6LEYHCFolZNU=
X-Google-Smtp-Source: AMsMyM6YTNV1JDwyXgR0RDnGNODNgg9sZolR6sywM2wBChzrAfaN964jX8X4yfuFhDWnlMyOkNUWcQ==
X-Received: by 2002:a05:600c:88a:b0:3c6:cc34:abf with SMTP id l10-20020a05600c088a00b003c6cc340abfmr37703480wmp.147.1666512285894;
        Sun, 23 Oct 2022 01:04:45 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t189-20020a1c46c6000000b003c701c12a17sm4637354wma.12.2022.10.23.01.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 01:04:45 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: Fix possible circular locking when deleting a controller under memory pressure
Date: Sun, 23 Oct 2022 11:04:43 +0300
Message-Id: <20221023080443.592097-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221023_010449_229446_45D48410 
X-CRM114-Status: GOOD (  17.98  )
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

When destroying a queue, when calling sock_release, the network stack
might need to allocate an skb to send a FIN/RST. When that happens
during memory pressure, there is a need to reclaim memory, which
in turn may ask the nvme-tcp device to write out dirty pages, however
this is not possible due to a ctrl teardown that is going on.

Set PF_MEMALLOC to the task that releases the socket to grant access
to PF_MEMALLOC reserves. In addition, do the same for the nvme-tcp
thread as this may also originate from the swap itself and should
be more resilient to memory pressure situations.

This fixes the following lockdep complaint:
--
======================================================
 WARNING: possible circular locking dependency detected
 6.0.0-rc2+ #25 Tainted: G        W
 ------------------------------------------------------
 kswapd0/92 is trying to acquire lock:
 ffff888114003240 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_sendpage+0x23/0xa0

 but task is already holding lock:
 ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (fs_reclaim){+.+.}-{0:0}:
        fs_reclaim_acquire+0x11e/0x160
        kmem_cache_alloc_node+0x44/0x530
        __alloc_skb+0x158/0x230
        tcp_send_active_reset+0x7e/0x730
        tcp_disconnect+0x1272/0x1ae0
        __tcp_close+0x707/0xd90
        tcp_close+0x26/0x80
        inet_release+0xfa/0x220
        sock_release+0x85/0x1a0
        nvme_tcp_free_queue+0x1fd/0x470 [nvme_tcp]
        nvme_do_delete_ctrl+0x130/0x13d [nvme_core]
        nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
        kernfs_fop_write_iter+0x356/0x530
        vfs_write+0x4e8/0xce0
        ksys_write+0xfd/0x1d0
        do_syscall_64+0x58/0x80
        entry_SYSCALL_64_after_hwframe+0x63/0xcd

 -> #0 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
        __lock_acquire+0x2a0c/0x5690
        lock_acquire+0x18e/0x4f0
        lock_sock_nested+0x37/0xc0
        tcp_sendpage+0x23/0xa0
        inet_sendpage+0xad/0x120
        kernel_sendpage+0x156/0x440
        nvme_tcp_try_send+0x48a/0x2630 [nvme_tcp]
        nvme_tcp_queue_rq+0xefb/0x17e0 [nvme_tcp]
        __blk_mq_try_issue_directly+0x452/0x660
        blk_mq_plug_issue_direct.constprop.0+0x207/0x700
        blk_mq_flush_plug_list+0x6f5/0xc70
        __blk_flush_plug+0x264/0x410
        blk_finish_plug+0x4b/0xa0
        shrink_lruvec+0x1263/0x1ea0
        shrink_node+0x736/0x1a80
        balance_pgdat+0x740/0x10d0
        kswapd+0x5f2/0xaf0
        kthread+0x256/0x2f0
        ret_from_fork+0x1f/0x30

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(sk_lock-AF_INET-NVME);
                               lock(fs_reclaim);
  lock(sk_lock-AF_INET-NVME);

 *** DEADLOCK ***

3 locks held by kswapd0/92:
 #0: ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0
 #1: ffff88811f21b0b0 (q->srcu){....}-{0:0}, at: blk_mq_flush_plug_list+0x6b3/0xc70
 #2: ffff888170b11470 (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0xeb9/0x17e0 [nvme_tcp]

Reported-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4f5dcfe5357f..5bae8914c861 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1141,6 +1141,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
+	unsigned int noreclaim_flag;
 	int ret = 1;
 
 	if (!queue->request) {
@@ -1150,12 +1151,13 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	}
 	req = queue->request;
 
+	noreclaim_flag = memalloc_noreclaim_save();
 	if (req->state == NVME_TCP_SEND_CMD_PDU) {
 		ret = nvme_tcp_try_send_cmd_pdu(req);
 		if (ret <= 0)
 			goto done;
 		if (!nvme_tcp_has_inline_data(req))
-			return ret;
+			goto out;
 	}
 
 	if (req->state == NVME_TCP_SEND_H2C_PDU) {
@@ -1181,6 +1183,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
 	}
+out:
+	memalloc_noreclaim_restore(noreclaim_flag);
 	return ret;
 }
 
@@ -1296,6 +1300,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	unsigned int noreclaim_flag;
 
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
@@ -1308,7 +1313,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
 		queue->pf_cache.va = NULL;
 	}
+
+	noreclaim_flag = memalloc_noreclaim_save();
 	sock_release(queue->sock);
+	memalloc_noreclaim_restore(noreclaim_flag);
+
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
-- 
2.34.1


