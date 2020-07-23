Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AB6C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 23:42:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0387E207C4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 23:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IgQXO7Sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0387E207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EtWaObufew+R8RIMLL7vIF+oHA8V89PyIS8ZC5yB93s=; b=IgQXO7SzkLC8fHfTwfcSOyXyJu
	QPc6lIuOmkvekM927/jIom1O29UU1+3/4MxrXT7Y9wZ9Xj+qcBjSQ2Hdwsx581HwX915CvrOmjcYf
	4Ejur8sjdi4EHhbXndZ2p0VxiQkNG7V3NCyXSGRGNuMCVbf0QWxCfq0it5i5npU7Y4o+AkugGpzHI
	eiO69+b0MSgrv8V8Mc3EIYIsy9+HF4qvijetc28sBB3otfKP30i0RV6ccBzYZPAM/xJx7H8Fln7ke
	DL7uviiGoigBon/Rrpj5YXNlwOLYLA8LCwnQJFUv0jvJI8nySo6jQD8ksVjiq1GLGpERNPPcRW7NX
	Fh9jJigg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jykrJ-0001XW-Mq; Thu, 23 Jul 2020 23:42:41 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jykrH-0001X6-UH
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 23:42:40 +0000
Received: by mail-wm1-f67.google.com with SMTP id f18so6693243wml.3
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 16:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B3BaGkMlAt5sg/UGKf3NzEl4euZxwZOBuTYvTTppCUE=;
 b=QFCLZdpNIY585fh0h3bVLvqJdM/TAjOGDIaSkqwnM5FHp1t9vibFK4cJONFNLjFsuW
 AiaAbLsONH/pgHzcyRJQK2VgmqCnvEB2sR4N6RHrd15hFjyG4BBJXfz0TRDEZUay7z2L
 AppYl0H4zMuz0IJkKMrsPgZEbDxJe8QKbNrdxQIDTNqB+QL83gNnHK1RrnJd6gnEtHhA
 mnRMcw4NiZUfN7E64/qkWwXQwOiIA2F6o2VUra4JkaXsiI+LcW6ie9V1BVz4i61nuk7D
 71ZUTCLvbCvM2ZmLYabZ6stKl+3zqdam6lIkha0M/aIOW+KK6nd3zYn4J3+I7uMyrPPE
 AAGg==
X-Gm-Message-State: AOAM532Qxmh5zTM5F3nPAOs+di7lqNQwReBFfbjYDzSLvzmsBeN8wvKs
 UT+MV9JelntXTahRzFccH2YfpLWK
X-Google-Smtp-Source: ABdhPJw9Hpl7FJnqKtyf88C7oSSgIEo0WMQnmKSw+ohiW7cNWXeriT3IlyaLK9Ta3YbFB6VifWuvkQ==
X-Received: by 2002:a05:600c:258e:: with SMTP id
 14mr6558176wmh.159.1595547758229; 
 Thu, 23 Jul 2020 16:42:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id x11sm4784943wmc.26.2020.07.23.16.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 16:42:37 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: fix possible hang waiting for icresp response
Date: Thu, 23 Jul 2020 16:42:26 -0700
Message-Id: <20200723234226.456265-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_194240_129910_691DB79A 
X-CRM114-Status: GOOD (  11.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the controller died exactly when we are receiving icresp
we hang because icresp may never return. Make sure to set a
high finite limit.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8c8fb65ca928..7953362e7bb5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1412,6 +1412,9 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
 
+	/* Set 10 seconds timeout for icresp recvmsg */
+	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
+
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	nvme_tcp_set_queue_io_cpu(queue);
 	queue->request = NULL;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
