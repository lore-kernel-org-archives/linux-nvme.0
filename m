Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D96C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2YTePvZLP1lrvJdr3+9Hdo2uzIkh90SO2ddsHw1+kYA=; b=ujTqtKa/E00P62IYq2DCQb8iy2
	sN7M1WbPmU9vuy5BXmn+SKOlJjPrgJQ1hLnQVeMQmvFEAOqqbnfZ+SqtNlYAD8q/2vhZrySmYASni
	DsEwOx6RnyoAbN2TfG2P80PgRFKclpsTAa8IlPdwhWJDR76VAFVw/J1vqAz5AL2tLXwUri4Aa1+ik
	tgbgGIZLEk9gH3jTvZX0zdE/uHF0UszQwiXxw9hxF6WKT/fN4JwJm7HWxb7/e7UuUh+/fquaLiONf
	kOLZb5CPthdgynMRhyVucWfYOS5pMFNEE8k6/qnbYqqTTjJOTl6x/7OC0kOWecOgvDqwAkZQAyL7H
	18zPvWZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXV-00000006hbw-2sHT;
	Wed, 26 Jun 2024 12:14:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXL-00000006hW0-2tBQ
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E96B3619E8;
	Wed, 26 Jun 2024 12:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507B5C4AF07;
	Wed, 26 Jun 2024 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404046;
	bh=QF/zsM5ReuSlJKT01SP5R5KV8BuYD81ErH/xyB9MqV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhBLxn9YUebFPKCs1H0bPHGmJpQJ5UzbsYc9/WK755mm+ODA6oZOrNXDpFgYSoWac
	 LArZse1DPZYtX1mTPY2aEvDNeliy2KrGvRrBie/aHwFOkuE9rK+xwaZrzRFwFEQIpY
	 xqDhm5sucE3PmM+kDb/9DvVyXWMxz52V2nJPloSGF4cI3tn+HkUyb2rm9hMyyacN9L
	 fhdqby6q4jyhBuKlyNx2G5z2XarMVD+qt/MvPNZ5f0BdsM+NxfXOjhUzlfmD6slpON
	 04OtJ+uond0472jSfN1Kvn9LcBRUkVMghB9hahHLyvZBg0nJmUWEFs8jy/jt5YXJdo
	 z5JIwcp7LUKuQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/7] nvme-tcp: make softirq_rx the default
Date: Wed, 26 Jun 2024 14:13:47 +0200
Message-Id: <20240626121347.1116-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051408_015792_4F7C10DF 
X-CRM114-Status: GOOD (  10.99  )
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

Remove the 'softirq_rx' parameter and make it the default.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d78cca2f05d4..79fda5ab49ce 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -46,13 +46,6 @@ static bool wq_unbound;
 module_param(wq_unbound, bool, 0644);
 MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
 
-/*
- * RX context runs in softirq
- */
-static bool softirq_rx;
-module_param(softirq_rx, bool, 0644);
-MODULE_PARM_DESC(softirq_rx, "nvme-tcp RX context in softirq");
-
 /*
  * TLS handshake timeout
  */
@@ -998,12 +991,8 @@ static void nvme_tcp_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled) &&
-	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
-		if (softirq_rx)
-			nvme_tcp_try_recv_locked(queue);
-		else
-			queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
-	}
+	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
+		nvme_tcp_try_recv_locked(queue);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
@@ -1319,13 +1308,6 @@ static void nvme_tcp_io_work(struct work_struct *w)
 			else if (unlikely(result < 0))
 				break;
 		}
-		if (!softirq_rx) {
-			result = nvme_tcp_try_recv(queue);
-			if (result > 0)
-				pending = true;
-			else if (unlikely(result < 0))
-				return;
-		}
 		if (!pending || !queue->rd_enabled)
 			return;
 
-- 
2.35.3


