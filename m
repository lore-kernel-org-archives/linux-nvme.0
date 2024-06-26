Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB20C30659
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQd9NfcbQ+syhLBe6/18fBdcS6aDxucFi2Cj+NDPEcs=; b=GmjrhumZMWFGb15z4PyYJRxd8C
	P0PqY6EJs7aaii08vXagBMa3uNoK9gwks8T3V9M8uXKKq0MRQi9ALG65IBB7T0ySyAyM9OlrXKhbb
	HK6zJ6T+cbakf5QR/AVD3u7oFDJ0ubHd7LL0myMJ1kOy3O2zX8EtFVelv53CVkqym9fs/hkfKTKNq
	yF/t7QGaqkYSWCIB60sl01jbyLDV7Lob06evzc95wrSkSyjIb3FpqXVKyjPdCGTrUSZXWmrTzamXb
	46z2cEFvX/9NipdQpDmZYHyy5jsuZFkXn2eingdW2I2/JoGYl6svEVzAO5n98otihP+bziAtIXJhq
	O28Fwcvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXR-00000006hZX-3lDr;
	Wed, 26 Jun 2024 12:14:13 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXI-00000006hUC-0q9O
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2DA8BCE21BF;
	Wed, 26 Jun 2024 12:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33252C4AF0A;
	Wed, 26 Jun 2024 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404041;
	bh=sSYHJODHI0nHFRkXIU+Meui33bYnKZU4T1+J+YDnjAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaXJbbgNuyMCyhlBOj6NHUbJInd5JibLjQqDL37cDkq2VfnN+yl25b7T5VMXyO+vQ
	 3vhQXOh/UsoZR2OGbsSYOo7dvQzA7FdbBmIZCwquM3FAlmiLYQu9R6I6Y4CeQJxZYE
	 grRbLZjlYv1QfzIyZbDJT3halYB+EQvRJUybBioCjXiM3nFUmf20ZTHmQnox30ylMp
	 WrkYQ0P2cEYS6B1pbZz2/+HJcrejecukzZo3rJ9aZQOPyUDQM8c7Fjcm/TGFdxsaCr
	 tlQuIKeDdQ+SSS6HpxHA1Be6dwTCArFWrCKOgU+o3ibsG2GPcEUGc47hdSHYtFeoCX
	 kzpuuI6+HfyIw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/7] nvme-tcp: receive data in softirq
Date: Wed, 26 Jun 2024 14:13:44 +0200
Message-Id: <20240626121347.1116-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051404_642882_0F2685E7 
X-CRM114-Status: GOOD (  15.94  )
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

From: Sagi Grimberg <sagi@grimberg.me>

Network interrupts are already delivered in softirq, so there is
no need to punt things over to a workqueue. This patch adds a
module parameter 'softirq_rx' to process rx packets directly
from the softirq context.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 52 ++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index faab55ff86fe..599d4ebf888f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -46,6 +46,13 @@ static bool wq_unbound;
 module_param(wq_unbound, bool, 0644);
 MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
 
+/*
+ * RX context runs in softirq
+ */
+static bool softirq_rx;
+module_param(softirq_rx, bool, 0644);
+MODULE_PARM_DESC(softirq_rx, "nvme-tcp RX context in softirq");
+
 /*
  * TLS handshake timeout
  */
@@ -957,6 +964,20 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	return consumed;
 }
 
+static int nvme_tcp_try_recv_locked(struct nvme_tcp_queue *queue)
+{
+	struct socket *sock = queue->sock;
+	struct sock *sk = sock->sk;
+	read_descriptor_t rd_desc;
+	int consumed;
+
+	rd_desc.arg.data = queue;
+	rd_desc.count = 1;
+	queue->nr_cqe = 0;
+	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	return consumed;
+}
+
 static void nvme_tcp_data_ready(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
@@ -966,8 +987,12 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
-	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
+		if (softirq_rx)
+			nvme_tcp_try_recv_locked(queue);
+		else
+			queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	}
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1253,16 +1278,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 
 static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 {
-	struct socket *sock = queue->sock;
-	struct sock *sk = sock->sk;
-	read_descriptor_t rd_desc;
+	struct sock *sk = queue->sock->sk;
 	int consumed;
 
-	rd_desc.arg.data = queue;
-	rd_desc.count = 1;
 	lock_sock(sk);
-	queue->nr_cqe = 0;
-	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	consumed = nvme_tcp_try_recv_locked(queue);
 	release_sock(sk);
 	return consumed;
 }
@@ -1285,13 +1305,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
 			else if (unlikely(result < 0))
 				break;
 		}
-
-		result = nvme_tcp_try_recv(queue);
-		if (result > 0)
-			pending = true;
-		else if (unlikely(result < 0))
-			return;
-
+		if (!softirq_rx) {
+			result = nvme_tcp_try_recv(queue);
+			if (result > 0)
+				pending = true;
+			else if (unlikely(result < 0))
+				return;
+		}
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.35.3


