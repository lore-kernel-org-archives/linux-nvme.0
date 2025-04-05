Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E7EC36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 05:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z9okLDTgArbJRsWAIomNX+0oF72yzuEPIm4Cyepbc2s=; b=LLMdx71pZENiZPM+mBIvhAQQlP
	dYE6QUZQO23fZ202m23oVVmMYG8UFyPFAAYQHYZIZrOZ7jszYyyYtLaMo1mgoz5OVXFoj1HpdW2/p
	9mPyteww9eF7TDkv8PHqDFD4KdRPK+coV/Mzrx1kjfF0Oq35sMD0qMxdS7Vtaxk5Com4jf5GVYHsl
	pXor3VuQCW24tROTRBU63N03S0kQq1tBrfZ7PePQI+hF7iy039OeeppclfzpNG/9Bt/ljQBi8kAR8
	3LYLxqMpBjsaae9M0ScVzAQg4OD7nv1lxBxIMT0miwezAxSPov3KIw5kQqznNofdPQJdd+1Og0Hbe
	S46+q4Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0wOw-0000000DWV7-2hpq;
	Sat, 05 Apr 2025 05:49:06 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0wOu-0000000DWUk-0xrp
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 05:49:05 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2228107a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 04 Apr 2025 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743832143; x=1744436943; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9okLDTgArbJRsWAIomNX+0oF72yzuEPIm4Cyepbc2s=;
        b=fcVwQJAOtOS+D+RF8xXi6CuBpoj61iKWJMrDejyxJxQ7u0R7KEkgexdBwESU+S+WNA
         xfyyrFhT9LntSMMJoN+8AQnq3ulJE5ZjbE529dhY4jDXo88Dx19u9Izfflx7PNOfhu5C
         IqigiI3zj4gVplRh4/V/sCbgilq/ECstJGplMVoR2rQBGElrIrtwGUGmtYuAksBUtBb1
         QDbwYba8TAICURjU/eRg/QW/hSRmQV/cVts+CzeXJuMekf2B4Cndw6jogISbHFMzjBir
         R7OOloOHfKkExK2gMgg92cAuLtRgjJM/zx/Z7aWEPIvlDLnShjoT/O/ar/pNfDwo4ivR
         agzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743832143; x=1744436943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9okLDTgArbJRsWAIomNX+0oF72yzuEPIm4Cyepbc2s=;
        b=VPsT2TxpC/tVFJjwbOPlFeG8G9aP5JtPBzNJtWCzhqn9RowTj7oB0+eC7yh5maWvQL
         bZokOSrFgqgmggsU9DlV3lMOkkRWsfeps1VFYpLW5RLKCDkf85NIZmaZs1FT8lD0/xkX
         H019XpLZurfY5czLDjQ40Wm+4ecU9mJiMJxrEXJwKdlMWQNHBcgBy/AvTG1qIiuOn1y2
         A3Ywte40TFz+dUqiAF/Z9fU8VvIXnx1DL37kASCE1BWuL99CmEMmAE7IlVkPp57Q9FwE
         GoCilG8Yw9CJG99CAPtQnrR0We4wJCVcH2sdbThh5N7t3/Ce1Sr88aoE5Lzghct4YJ4B
         6vdA==
X-Forwarded-Encrypted: i=1; AJvYcCUMO8cfWnRU+hfan1PQwTb6N9BWixZ3/WBKC+bPtKKk/u19OrEAVWgpZhFRvt0q6QezwtIEzL1n7Z/q@lists.infradead.org
X-Gm-Message-State: AOJu0YzhX7dMBc4fzCrzGSq6PjauyOED3MC2DoIY2R66m284ym1BmMSf
	NYiaAp7dvqzoTkSgeFo11sXwJsIn1S40NDzS56WfL2tvA4kE0nMtzEZiY4b8jx0=
X-Gm-Gg: ASbGncsw5JjRSZsjxyTsR6qrOdeVllWB8Di9rhYw0I9vZxKtTjnoyiWHxHtqcNYhtfr
	zVY2KoAVI75Lkgo0ybmIm4M9u6ZkU45i7nKDllWkhnFe9kv7wda/lSveUP0jso3yoDHXvGa7+96
	Phdj44VQOSCBcbt1WcvJWJg/aiLyrfqb3/nlLCJS9Gl1px3cJL6nCO3NuOiHXnNaUMOtVf82F+t
	gm51ddQ5bdG2pa/olb0OXkV7y1K/TrN6R0H59jthe8EQaN9jbe8nmpP7iDWWqTV57PXdsxzFUT9
	Fi3MWQ9m9TOiYZjhY8hJKVdemm6VuVXm3l/EkLrh/v1oCQfg1MszsITaLWmtEbzGsKN4zpUIl6b
	OhEOuXa4=
X-Google-Smtp-Source: AGHT+IHFlL8yAtLJIGh/nZnzxRPL2dsvOXC7sATN3B9Az7sYa4+SKAV2ggejLCCXPe1erV8dkaxOew==
X-Received: by 2002:a17:90b:2804:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-306a61659c2mr6677747a91.20.1743832142622;
        Fri, 04 Apr 2025 22:49:02 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3058494ab14sm4591129a91.17.2025.04.04.22.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 22:49:02 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
Date: Fri,  4 Apr 2025 23:48:48 -0600
Message-Id: <20250405054848.3773471-1-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_224904_470911_90BC24F3 
X-CRM114-Status: GOOD (  17.45  )
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

This patch addresses a data corruption issue observed in nvme-tcp during
testing.

Issue description:
In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
I/Os are canceled almost immediately after the kernel socket is shut down.
These canceled I/Os are reported as host path errors, triggering a failover
that succeeds on a different path.

However, at this point, the original I/O may still be outstanding in the
host's network transmission path (e.g., the NIC’s TX queue). From the
user-space app's perspective, the buffer associated with the I/O is considered
completed since they're acked on the different path and may be reused for new
I/O requests.

Because nvme-tcp enables zero-copy by default in the transmission path,
this can lead to corrupted data being sent to the original target, ultimately
causing data corruption.

We can reproduce this data corruption by injecting delay on one path and
triggering i/o timeout.

To prevent this issue, this change ensures that all inflight transmissions are
fully completed from host's perspective before returning from queue stop.
This aligns with the behavior of queue stopping in other NVMe fabric transports.

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..837684918aa1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1944,10 +1944,26 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
+static void nvme_tcp_stop_queue_wait(struct nvme_tcp_queue *queue)
+{
+	int timeout = 100;
+
+	while (timeout > 0) {
+		if (!sk_wmem_alloc_get(queue->sock->sk))
+			return;
+		msleep(2);
+		timeout -= 2;
+	}
+	dev_warn(queue->ctrl->ctrl.device,
+		 "qid %d: wait draining sock wmem allocation timeout\n",
+		 nvme_tcp_queue_id(queue));
+}
+
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	bool was_alive = false;
 
 	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
@@ -1956,11 +1972,14 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
 
 	mutex_lock(&queue->queue_lock);
-	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
+	was_alive = test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	if (was_alive)
 		__nvme_tcp_stop_queue(queue);
 	/* Stopping the queue will disable TLS */
 	queue->tls_enabled = false;
 	mutex_unlock(&queue->queue_lock);
+	if (was_alive)
+		nvme_tcp_stop_queue_wait(queue);
 }
 
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
-- 
2.34.1


