Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CCCC02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1XpCNPxx2sS27CmMIsN7upmtK0PeD89d72RGUihyz90=; b=a65Re79FPYS245aJ1r9ScXQqaH
	8olIBsRbaZDyChgi6r3Cq+z+mnGuh+oBwB9y3aN1aY+vVQBNl4waTkKRKzOVDtjVBjTIuJJoVEApk
	ZoWjobQ8hQRLRVCOsGd/kK+ivgpzlfbi061uM/6yCQi/JcOdaluvvTj/15dw4L26/D9xyc3x6JHBZ
	0AtTip0CZyfveQ157X860GmrF1Dpw+uc3VmVat+mSUnYxvK0DkYESrsIP+XQQgGZpRmKislNjxG7b
	+aCL9ZrRdcs6nWDLYNNhgeJX+fHkA8UGPF3x4cjk0muuQaVXctNPiW9agWmLR58wwRLGH2tdVr7oW
	3nH1AZug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbO27-0000000FG5P-00uk;
	Fri, 24 Jan 2025 18:03:55 +0000
Received: from mail-io1-xd62.google.com ([2607:f8b0:4864:20::d62])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbO24-0000000FG54-1ZGi
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 18:03:53 +0000
Received: by mail-io1-xd62.google.com with SMTP id ca18e2360f4ac-844ed31df76so11178439f.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737741831; x=1738346631; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XpCNPxx2sS27CmMIsN7upmtK0PeD89d72RGUihyz90=;
        b=VbSslsgtC2GgBfD9dGK0miUl0C5GI+anmja0fKQJBBQRTTkx8jG/9bSy3g//qdijYl
         9aqm9EDs5Qe01q+/i3FGhx4nUqXv0swp9N6AzvkTNkJx+Fq7AFEZEI8cGo4fjuupwjBn
         C/aJK3NzIkKvkVUtcl/5TkK0UXdV3ZSSjYtxt7PBsr2T9GJFqt8lNehRQO0K42KiFYLv
         O1pe1FpPcEINcrOU96CaaPNBlVXmISPIHXecXHqU4BmEEZb0fR17ucordqo7b1a8EoZC
         Wfm/1nIMVIgPBew1H+7/r7RCOn/d3dOHPvyoznESVM4xfBrl4IzZ+ngPQGL3gugJIv7N
         QpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737741831; x=1738346631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XpCNPxx2sS27CmMIsN7upmtK0PeD89d72RGUihyz90=;
        b=hledoL+clZxvYVoTZo32HRAuwkqMXhwwxFha550OgYFBs4ElpRJygS+QbIiBGn+mzU
         XWVNRW2224vU2qKASLcDegoaoy+uPMWsECP+aiQQFDBrrEzeG9B1ffyF8vYx02rXxEFy
         dCOpGIfX6ca0x85zxEK/7EG2c3r0Y+J+y7SisjQUoHF6tT5m0uXTNVnJLZ4VDSC3yjkz
         5IojMLeTlIlJ5Rwh/hCtUjlNFE6rEUg+hvb3C1W9OlSjyb52XMxsyaRaHlLgEzAoIfQS
         L3hhB+Q7H3EV+gjPoCcfj46Hgb0a63IScNZ0ZqjG3gDr63t10+dFoKIV0xGPnXw/Izib
         MQYw==
X-Forwarded-Encrypted: i=1; AJvYcCXM1CeomC7GEK8WEHn90Pl+azYxEh3m9AnqXJL2JAbwN2qwYw0Yv/rGk7rIpEbW1BTvJXw4bRTKI4FW@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+qsZiwjQUAye5AnBLZgP6fiGJE4pfcyTBfcyVm/kXePpHyRiY
	NPUzLm+LgrsTDzMfBMAZVZiI+eTTxPeSn5w5aPORHXa/4atzxcSC2JmAeh+NjcE79OOixkkZhND
	F3IPY4FBXXLekBvGC2/yRJirUTHe6o2F++7WHXPTdsqfHVOIH
X-Gm-Gg: ASbGncswjgpvfvdy+ivxOc/ZPOcyTkdHojHtXiYFnq4b/BYAVWzRruz4TMqqJh/dW5W
	BwVt0oWsHpIY/IUBtZsakHJIMYukPpry7JYTfa5WVExhxf5UiLJdO+chOnmeqGQa2G9wEt/R48l
	kJe6f+kF7pEag9Y5Gr3VKxQaTwztkEv6OTb5RqoTsp6u/fK5WFybq+2gdUtajXVwRel2HCQELDd
	rozaLEbtg0ljPvvWyEhXkw3cQqFsdVDmuGvLALoG4GQ+ZDlYpBz5UNWyXlKEj+yZnczGOy46LWd
	za8a0K9LjLiP
X-Google-Smtp-Source: AGHT+IHSFUS/grHJrmDBI0zDHi/JOfF6zLSw3MBeGwRKgw8SBBoWa3SsCeYyO+GBghV7AcvPHhgyrIsvAozB
X-Received: by 2002:a05:6e02:160a:b0:3ce:7ac0:64c2 with SMTP id e9e14a558f8ab-3cfb15f3254mr26261215ab.1.1737741830346;
        Fri, 24 Jan 2025 10:03:50 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3cfc7529e56sm1290165ab.63.2025.01.24.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 10:03:50 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A5F393401C3;
	Fri, 24 Jan 2025 11:03:49 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9C02EE40B44; Fri, 24 Jan 2025 11:03:49 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme-tcp: fix connect failure on receiving partial ICResp PDU
Date: Fri, 24 Jan 2025 11:03:41 -0700
Message-ID: <20250124180342.1628060-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_100352_563088_E193D76C 
X-CRM114-Status: GOOD (  15.37  )
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

nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
checks that the return value from recvmsg() is non-negative. If the
sender closes the TCP connection or sends fewer than 128 bytes, this
check will pass even though the full PDU wasn't received.

Ensure the full ICResp PDU is received by checking that recvmsg()
returns the expected 128 bytes.

Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
split the ICResp over multiple TCP frames. Without MSG_WAITALL,
recvmsg() could return prematurely with only part of the PDU.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
---
v3: fix return value to indicate error
v2: add Fixes tag

 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dc5bbca58c6d..8cd1735772c6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1447,15 +1447,17 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	if (nvme_tcp_queue_tls(queue)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
+	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < 0) {
+	if (ret < sizeof(*icresp)) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
+		ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
 	if (nvme_tcp_queue_tls(queue)) {
 		ctype = tls_get_record_type(queue->sock->sk,
-- 
2.45.2


