Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE278C433E6
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 19:47:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4851464E75
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 19:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4851464E75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TqQx5EsWVouBba5E2qFetmkfPWa8PgoPtDUvLq1fptk=; b=GJkSPpzuiN1mzFj6CMYxOwP+ID
	Ys+0zHzyAxX9FwKoow8bVuYIwP/JlvZxTLtlyIbcTBX8ww72s25k8SDnupJwIGHV42t3Yd+3TQfLF
	QWWehsZCXFYw293BHEKZ1dl/dHwe7mI5skSzT2EMhBnuvSnntqp4KhMvPKHdbU1hKSLaGLICZ4ul0
	mD8PRlPxh6NT9zdHImL2JTEAsmXlhCgCSNH/d1QRWUwqn8ZpkDqg1jxJBIez4n5cZt2Nz3mANlDwV
	zY8cVR1UQoWOb6CT3LlxCYHvTqY514oYB5UzZ6WgOXQrw02/NKMLyxT/o2YJewKs+sKYcyS/XQrzs
	IIu9QV3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l874n-0003u6-5l; Fri, 05 Feb 2021 19:47:33 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l874k-0003tQ-B2
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 19:47:31 +0000
Received: by mail-pg1-f170.google.com with SMTP id t11so1584146pgu.8
 for <linux-nvme@lists.infradead.org>; Fri, 05 Feb 2021 11:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8AkPk3WnP/Pkawm4H5/SchXIuKyv9J+z/plfxbZlgqI=;
 b=BBZX8vZuxe572xiYim40fnYlNBq4+LMSu1X65Xo7XRrUttTUmBpwyV8yTg0yhCBBda
 EFfe3P3Em34VNaZ36vyIcWHQB0ttHjxDLsO0F4pxbETu9y2z4kSTnN1/8Dq0CG+SIV45
 N+gcCBm7ybrSc2YDO8QD5SYm6MiYnis4xdslgejjzibiKRq0DULHN2Fl0c+R5Q3wttfi
 /oKKfdJwlqLWBVQ3ZTQCj83K4r4cwuk0+AN7B+rRVQ0QyPEpO/W65VenkNDG3Af/HpHT
 thRNCPwLFyINj09WqZ4NIJP+7hBsrcnIakqrc0kHz/dINvi+ws2CtJ5DCqr1616UFBKq
 QpwA==
X-Gm-Message-State: AOAM531u/zC7XFVcD5fYkEBujuDT/bLKbElZlKBC8sY0dg/wyTKd85Xh
 PE7TmQV+a5QBruGfeTlwyMZ6NcIVHHM=
X-Google-Smtp-Source: ABdhPJzy8RKbsRE+lGek+3svCnHKlbQKi4nVYjURbO5Iqh8GO0YKyp0OeFo9/4XsH0ZqKvlKPqzXSg==
X-Received: by 2002:a62:5f84:0:b029:1d3:1af6:54f4 with SMTP id
 t126-20020a625f840000b02901d31af654f4mr5739187pfb.72.1612554448258; 
 Fri, 05 Feb 2021 11:47:28 -0800 (PST)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:e569:9026:928e:73dc])
 by smtp.gmail.com with ESMTPSA id 123sm10530945pfd.91.2021.02.05.11.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 11:47:27 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-tcp: fix potential race of tcp socket closing
 accept_work
Date: Fri,  5 Feb 2021 11:47:25 -0800
Message-Id: <20210205194725.625035-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_144730_398346_79F9F4BD 
X-CRM114-Status: GOOD (  17.59  )
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
Cc: Elad Grupi <elad.grupi@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When we accept a TCP connection and allocate an nvmet-tcp queue we should
make sure not to fully establish it or reference it as the connection may
be already closing, which triggers queue release work, which does not
fence against queue establishment.

In order to address such a race, we make sure to check the sk_state and
contain the queue reference to be done underneath the sk_callback_lock
such that the queue release work correctly fences against it.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Elad Grupi <elad.grupi@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 577ce7d403ae..8b0485ada315 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1485,17 +1485,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (inet->rcv_tos > 0)
 		ip_sock_set_tos(sock->sk, inet->rcv_tos);
 
+	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-	sock->sk->sk_user_data = queue;
-	queue->data_ready = sock->sk->sk_data_ready;
-	sock->sk->sk_data_ready = nvmet_tcp_data_ready;
-	queue->state_change = sock->sk->sk_state_change;
-	sock->sk->sk_state_change = nvmet_tcp_state_change;
-	queue->write_space = sock->sk->sk_write_space;
-	sock->sk->sk_write_space = nvmet_tcp_write_space;
+	if (sock->sk->sk_state != TCP_ESTABLISHED) {
+		/*
+		 * If the socket is already closing, don't even start
+		 * consuming it
+		 */
+		ret = -ENOTCONN;
+	} else {
+		sock->sk->sk_user_data = queue;
+		queue->data_ready = sock->sk->sk_data_ready;
+		sock->sk->sk_data_ready = nvmet_tcp_data_ready;
+		queue->state_change = sock->sk->sk_state_change;
+		sock->sk->sk_state_change = nvmet_tcp_state_change;
+		queue->write_space = sock->sk->sk_write_space;
+		sock->sk->sk_write_space = nvmet_tcp_write_space;
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
+	}
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 
-	return 0;
+	return ret;
 }
 
 static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
@@ -1543,8 +1553,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
-
 	return 0;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
