Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D1C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:44:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA1B206F9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 23:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jpa+a+1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA1B206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tJc92x/QqWeu8V6F6SBcOsPXfUqqP9rPimS3+Z0DQtM=; b=jpa+a+1h3yhIPR
	OF8YBDgaZxQG7UIS90faxnBmVeHgpdVMFXseqHzuzLl6fNXPFZMAeH3GGVdZzkW4QO/3IUD6YYJxK
	TbJp0R3O/g6hFXvja/3BcgH+kNrPVfon9+wkcZcsntVW4eewTDq3PP8RBcqC9co+tiOJOpyaemfeB
	/iiTTit+HPLzgHd765aikAHtTLteikdr0sGLDN7kpW57oPveoFcuu6qn5LM/ts1PzGxUhv8AM5j10
	0M130xsBUQP7RU2DPOyFtsF7QlPX3QCkcKgWedXEBqGwv6//odonqe/AhfgYoEKl6SjjPLl0ZgcEh
	M+HHzwfQXgoPwVN/J7yQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGWje-0001tG-Hy; Mon, 23 Mar 2020 23:43:58 +0000
Received: from [2601:647:4802:9070:45a4:15de:f2dc:1149]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGWjc-0001rq-Nx; Mon, 23 Mar 2020 23:43:56 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvme-tcp: don't poll a non-live queue
Date: Mon, 23 Mar 2020 16:43:52 -0700
Message-Id: <20200323234352.23753-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
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
Cc: Mark Wunderlich <mark.wunderlich@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In error recovery we might be removing the queue so check we
can actually poll before we do.

Reported-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- applies cleanly on nvme-5.6-rc6

 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 80b3da7b7e02..8f944e2b0231 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2295,6 +2295,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
 
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return 0;
+
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
 	nvme_tcp_try_recv(queue);
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
