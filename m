Return-Path: <SRS0=EJ6s=FZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC9C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Dec 2020 08:03:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDFA22AEC
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Dec 2020 08:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDFA22AEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MN7/K6XkCHt3Qg5fzXPYM8nl0KhM+MqgCNPBS+lLUeg=; b=MVyP8YoJXR/mSFsao88euNYY45
	N87Q84CfnIJlmK64wHGXNs0v+qjvIM0dFuf+UvAV/ve77+9z9k8TAqTZncplrvL2Xq1ZZ8WEdi+UK
	Y6kFSprWFUFTcMIp0ZdlTRZPsnXsQUeRtyFwyV/YsymVgLFL3Wi3jP61WehpfwV+vCDzJr50eJJ2j
	6qTXU/33+ZFiCUk2rZFoWFBR9rCovxpx2xSwEefnONDSPaB1nV88wuWANX0H1p+dWOyzsYIDvESDA
	9nlPGpg/uTeqvBKVsuBQa1ylyk8lyn3bSZYqX9JcdeFC8AgFSs6eKg24F0rp/E9Ob2+nD2M4FNhJm
	Err4V3wg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1krGAW-0006Br-AP; Mon, 21 Dec 2020 08:03:48 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1krGAU-0006BP-Ql
 for linux-nvme@lists.infradead.org; Mon, 21 Dec 2020 08:03:47 +0000
Received: by mail-pl1-f169.google.com with SMTP id t6so5221506plq.1
 for <linux-nvme@lists.infradead.org>; Mon, 21 Dec 2020 00:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+E+QAQKKCLrcNbWON9E/ne/qPvEYOqjBp3B5r2DgFpA=;
 b=LVQCVi/Jnq8QOUWAR95lr7Y31BtzOJ1FYT2bluxcbssLP/dvIacq8hLlj9iQPNpIKo
 HkgAqTLpIRCTv68U0aHY5JuUpivr+wvGuJ6Pf2YEI7ZpfKXsG+/SVj6cDDp7fosuttSf
 2wd5mAyaxLpjz5Tl9meeaPgizaEcTRFibiZP/JyoSr6WejIHO3kkFabcGt5i5ILjx2Rz
 RxnsRphuHFjZbE9fLLTN9AseIOmx62nBkjP2yEEQyoyzrhO+kI03H+ngg0KV6x63c+Yr
 9jhD8RKzLY2PQkaJAywXOgD4VWcAEWS20BNMVkNy67FazPe0EoAoT6ijkSW+dTPJS/xz
 B/Dw==
X-Gm-Message-State: AOAM5309EbU3imFoCN8lhjR+WZ5vZkOmkEVTWyjbhK1mWaMQekVpDteU
 1+Fidryes+vdrDSaPzxSPyAl9Y/5+bs=
X-Google-Smtp-Source: ABdhPJy6KkGKJY8RvgxMM+bMsfbJvaJdkXgRopIP5qhx9H7jGg5T5NvRtM7GUWZSlCCyglxMb0elPg==
X-Received: by 2002:a17:90a:ca93:: with SMTP id
 y19mr16385079pjt.71.1608537823148; 
 Mon, 21 Dec 2020 00:03:43 -0800 (PST)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:de56:3dd5:c538:3f2b])
 by smtp.gmail.com with ESMTPSA id w131sm15673074pfc.46.2020.12.21.00.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 00:03:42 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
Date: Mon, 21 Dec 2020 00:03:39 -0800
Message-Id: <20201221080339.945164-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201221_030346_896341_407E1E2F 
X-CRM114-Status: GOOD (  17.11  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We may send a request (with or without its data) from two
paths:

1. From our I/O context nvme_tcp_io_work which
is triggered from:
- queue_rq
- r2t reception
- socket data_ready and write_space callbacks

2. Directly from queue_rq if the send_list is empty (because
we want to save the context switch associated with scheduling
our io_work).

However, given that now we have the send_mutex, we may run into
a race condition where none of these contexts will send the pending
payload to the controller. Both io_work send path and queue_rq send
path opportunistically attempt to acquire the send_mutex however
queue_rq only attempts to send a single request, and if io_work
context fails to acquire the send_mutex it will complete without
rescheduling itself.

The race can trigger with the following sequence:
1. queue_rq sends request (no incapsule data) and blocks
2. RX path receives r2t - prepares data PDU to send, adds h2cdata PDU to the
   send_list and schedules io_work
3. io_work triggers and cannot acquire the send_mutex - because of (1), ends
   without self rescheduling
4. queue_rq completes the send, and completes
==> no context will send the h2cdata - timeout.

Fix this by having queue_rq sending as much as it can from the send_list
such that if it still has any left, its because the socket buffer is
full and the socket write_space callback will trigger, thus guaranteeing
that a context will be scheduled to send the h2cdata PDU.

Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
Reported-by: Potnuri Bharat Teja <bharat@chelsio.com>
Reported-by: Samuel Jones <sjones@kalrayinc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..979ee31b8dd1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -262,6 +262,16 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	}
 }
 
+static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
+{
+	int ret;
+
+	/* drain the send queue as much as we can... */
+	do {
+		ret = nvme_tcp_try_send(queue);
+	} while (ret > 0);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -279,7 +289,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	if (queue->io_cpu == smp_processor_id() &&
 	    sync && empty && mutex_trylock(&queue->send_mutex)) {
 		queue->more_requests = !last;
-		nvme_tcp_try_send(queue);
+		nvme_tcp_send_all(queue);
 		queue->more_requests = false;
 		mutex_unlock(&queue->send_mutex);
 	} else if (last) {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
