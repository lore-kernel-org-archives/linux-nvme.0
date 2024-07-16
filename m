Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DBDC3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Na+vzr3yUxQMzJmbU12l0T+aqWdQZBZk+iLPnWSdlU=; b=PRrvMEujv8/272NmODkFzEJiPT
	kaCnX4m+hEWsTprUoapd05xrUdZ93AperoBfhKuyfJ+1alHFGVrpspPrGFTBNwVMevblROIIeqjnc
	Z+eeSK2WMYtoosxCbwrecFkj9lMMfCen6JPu80SEHVZM7tiNjBQlzyV8t7wM8th/1yBMtkh42VIQh
	7pba48EPPQ1XnuRZHSz81cUSk4js7UOEqTV72t/tzSkGHgkSp4dzJNXDAGC8WHbwIdG0CyGoH7PUW
	Awo1o3jGLJIA3e15UM1kneMSL3uhELdipESZYvDcjbjODDbQsA+JMWVi3T+rCZhqUJegB4V+EuplI
	PBqpeR/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjl-00000009bqU-0WSt;
	Tue, 16 Jul 2024 07:36:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcji-00000009bos-1toL
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A78660ADE;
	Tue, 16 Jul 2024 07:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1775C4AF09;
	Tue, 16 Jul 2024 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115393;
	bh=gHdLmlZkLCybLwujngoGRSoyK5Odgkpk8TmI/5A450g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxjoAUp5pDcaqyv7gLJmeDPx/7Gm1OsEY8Xng0ZVKI21owbhm1I8c1zRM1QGKLSJM
	 GQPzldKXo063/+235Xfqc2P5OaUhroQd9UzRO77iegiZ226au5008qMMfEXH9S6maA
	 a/JZSq75sCGOo4r6n+gbM+N/n8vTGdEKtvUzPoWbSFbu6b6BQfpfp4yjT+gAwl0Bu3
	 YsOJ4A6V8dGmOLVAF5QePFm0wnY9hIrtHBPQ7fnxTWrEsim4HCmuZu6fHKr1eJO6fp
	 gN6aAYEgObgEdVMXTh0uL2+eflcQPqmF9001P2bPLBsuxI0nL62yfsUnQ2/zZ/Agil
	 WUzyWYAkqhLcA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/8] nvme-tcp: switch TX deadline to microseconds and make it configurable
Date: Tue, 16 Jul 2024 09:36:09 +0200
Message-Id: <20240716073616.84417-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003634_577973_083ECCB0 
X-CRM114-Status: GOOD (  11.32  )
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

The current TX deadline for the workqueue is pretty much arbitrary,
and jiffies is not the best choice for sub-microseconds granularity.
So make the deadline configurable via a config option and switch to
ktime instead of jiffies.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0873b3949355..3cf9a9abb0e0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,6 +44,10 @@ static bool wq_unbound;
 module_param(wq_unbound, bool, 0644);
 MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
 
+static int deadline = 1000;
+module_param(deadline, int, 0644);
+MODULE_PARM_DESC(deadline, "RX/TX deadline in microseconds (default: 1000)");
+
 /*
  * TLS handshake timeout
  */
@@ -1278,7 +1282,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
 		container_of(w, struct nvme_tcp_queue, io_work);
-	unsigned long deadline = jiffies + msecs_to_jiffies(1);
+	u64 start = ktime_to_us(ktime_get());
+	u64 tx_deadline = start + deadline;
 
 	do {
 		bool pending = false;
@@ -1302,7 +1307,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		if (!pending || !queue->rd_enabled)
 			return;
 
-	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
+	} while (ktime_to_us(ktime_get()) < tx_deadline); /* quota is exhausted */
 
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
-- 
2.35.3


