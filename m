Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09324C35280
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C922C20857
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f0oDVivC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C922C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GFsaMTA7V9KDlesvW5EPciwmJh6GFmNc0a76Lh4aJs8=; b=f0oDVivCN3gqiN
	qcc07rerdCV3rojkpLQYv8FwDAoQpaowKW21mwaE2qmxDa99jAT0+kqihHNifN76fokj30i56Q8XM
	soxHv4FVD/emV20+w8HtH0jyzj03N9hUZjLi2jBJ2J0y9ZsRC7cu97Jf4OsZWXxIf7+rx+l5C0KV+
	SFGEI8ffsxpN83xgbEHSrHZOjVf+3tSi/GcMSTk7MDNr4w/Gm1QcGjUec7XFFanbqYl9L82p0pU06
	LEVq0EzY9zPOcmmXP8xS1U5Ze7fEqIlLajWuzcrwO685QBM5waYOgVc8oD7GvY7nfvUzzGxEGbhhh
	wOfd/NOvfVtsI5RH2g0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUdAW-00032t-DP; Fri, 01 May 2020 21:26:00 +0000
Received: from [2601:647:4802:9070:4c3:8135:9a7c:5f17]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUdAJ-0002oR-Ug; Fri, 01 May 2020 21:25:47 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-tcp: avoid scheduling io_work if we are already
 polling
Date: Fri,  1 May 2020 14:25:44 -0700
Message-Id: <20200501212545.21856-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501212545.21856-1-sagi@grimberg.me>
References: <20200501212545.21856-1-sagi@grimberg.me>
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Anil Vasudevan <anil.vasudevan@intel.com>,
 Mark Wunderlich <mark.wunderlich@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When the user runs polled I/O, we shouldn't have to trigger
the workqueue to generate the receive work upon the .data_ready
upcall. This prevents a redundant context switch when the
application is already polling for completions.

Proposed-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4862fa962011..b28f91d0f083 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -60,6 +60,7 @@ struct nvme_tcp_request {
 enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
+	NVME_TCP_Q_POLLING	= 2,
 };
 
 enum nvme_tcp_recv_state {
@@ -796,7 +797,8 @@ static void nvme_tcp_data_ready(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
-	if (likely(queue && queue->rd_enabled))
+	if (likely(queue && queue->rd_enabled) &&
+	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -2302,9 +2304,11 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
 
+	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
 	nvme_tcp_try_recv(queue);
+	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	return queue->nr_cqe;
 }
 
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
