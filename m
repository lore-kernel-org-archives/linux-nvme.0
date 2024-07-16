Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1320C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aEsX1Uly8pT4EcPWYrspXJiik+CSkIuPjJxqtIlWZGg=; b=RwRJlLRlhGO9ye3q0l0jWdWX5c
	cORWFO3xsT5kDpwlEBsTYu4jhyb+Gy/1A+e+h45+uNtuCZdKzijFo8UMgyuwJnY/qLlvvo2tskrIU
	6TjMqLOiMSBOK3Ea+PCmho503TUdgkD1FCZcVbH77ul+vkxb9QRbXs7q65ZCXltj9id7yCjI8tA7Y
	5n/0T+hbUPv0I64qAYXu9JXC/0lTmtuUC8EdNno+Kz2NRm/wjyCc08OxUtN525Ddv2ZrUQX+MtFLm
	AhgxUM4WRQibk5drpho5bbshfBLCY8htjSRFqlUf/9AQJKLAfMzIAG0CHKOrSOaum/2Vnkk5KGfv8
	Kilos0Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjr-00000009buL-1Ua5;
	Tue, 16 Jul 2024 07:36:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjl-00000009bqN-2GPG
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D74A6CE0F22;
	Tue, 16 Jul 2024 07:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800BCC4AF0B;
	Tue, 16 Jul 2024 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115395;
	bh=dwOyGisHfs3/7Ql0cH7a8D0a+vnmYzjhPfrAsSNRx3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkApqxEqA0Ao7SrVJOP5OvJz73JEynR1gsTOrdUT03yportjzAIlXbg1zwqSiSL54
	 cveNDPxiDNPmeX+GTKCFU9F9sen99J/QBdxlQFXkZruMMyF4OEyB99chEQvNWz12s5
	 nQ+6pD0w/ebJOFatZbu+w1/in/C+GRiRAm2pML5otqVw5ZG8cUUgmBe7SBlW4UlVPz
	 BzGYqDntmqKoXbXxx8SDWThTsEo9w5y8UpFsAgp/6XO3zCASJLWf1zMoz7n8h0n3o8
	 bQjt4bxFC3JKDjnWBXrIGLk4DYeiBxK/zO4MV1QGEfthor4rgqhvPjSc8pi8FIj45l
	 0plY4AK3Dt2Nw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/8] nvme-tcp: io_work stall debugging
Date: Tue, 16 Jul 2024 09:36:10 +0200
Message-Id: <20240716073616.84417-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003637_835563_EA3AAE3C 
X-CRM114-Status: GOOD (  13.04  )
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

Add a debug message when the io workqueue exceeds the latency target
given by 'deadline'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3cf9a9abb0e0..7876bf7d2fac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1282,13 +1282,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
 		container_of(w, struct nvme_tcp_queue, io_work);
-	u64 start = ktime_to_us(ktime_get());
+	u64 start = ktime_to_us(ktime_get()), overrun;
 	u64 tx_deadline = start + deadline;
+	bool pending = false;
 
 	do {
-		bool pending = false;
 		int result;
 
+		pending = false;
 		if (mutex_trylock(&queue->send_mutex)) {
 			result = nvme_tcp_try_send(queue);
 			mutex_unlock(&queue->send_mutex);
@@ -1304,12 +1305,23 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
-		if (!pending || !queue->rd_enabled)
+		if (!queue->rd_enabled)
 			return;
+		if (!pending)
+			goto check;
 
 	} while (ktime_to_us(ktime_get()) < tx_deadline); /* quota is exhausted */
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+check:
+	overrun = ktime_to_us(ktime_get()) - start;
+	if (overrun > 10 * deadline) {
+		dev_dbg(queue->ctrl->ctrl.device,
+			"queue %d: stall (%llu msecs)%s%s\n",
+			nvme_tcp_queue_id(queue), div_u64(overrun, 1000),
+			list_empty(&queue->send_list) ? " empty" : "", queue->request ? " pending" : "");
+	}
+	if (pending)
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
 static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)
-- 
2.35.3


