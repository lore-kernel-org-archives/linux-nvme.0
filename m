Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1789AC88E41
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=exD+q8RvsL8LlA1NdvdgIxXpMfooqJfEtsvkYfwTOw8=; b=A3yP2oAS5RqLWOw/xWFr1b9+43
	1qZmDEihSoubVP/vkwvSXkJZG1GJvx64sIsUkVAVJ3rh2RGpFmEexyXuGxmnF62Ct959t1Crm8rmr
	kJAwgKfm0G/QhnsDEjaJUrUurxBMvY3aByt+0FvBqwvxTEQ12mpkRuNNk48UZLCnx1rUBlx06JEm8
	TToh9Q2lMn7f58YWvdRK69r6eSaTNhY695yiojtIdTHGHotxhW2pPypKaVytEd+5XAN2WeCC/YRu7
	yg2lOnx8iF0csersCJ0Rsehx8iGjmaXcDO307Sk2ZRv/R+ANdYTosA/YLIlVosTM2Dkx2s/zdujWU
	gOrMipkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lOM-0000000FKmG-2ajx;
	Thu, 10 Sep 2026 20:29:06 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lOK-0000000FKlH-3Kyz
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:29:05 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-851cbd64814so121777b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789072144; x=1789676944; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=exD+q8RvsL8LlA1NdvdgIxXpMfooqJfEtsvkYfwTOw8=;
        b=Q3E+xdzlqnEtS+6+i3+XIsjCqKvMaQXzHSGyutLI8rFRkafPOesRDTz1I+GbUmdazR
         3WMAlX3lGpH4SwE0A/hiysp9ubmGjacSBjpZ6Yo6FUDuPalbQFWxONpi05dt8KVvfDru
         FuWVm/xBYE1QA9YJLhCkAfY1Wz6DDLT48+SXlWDfG9fE5KtdjJ5JsQTP+QXWOzC6Dnx+
         tc9nKJgSXHlWkwSEOPiJ05WwLJR5vBXClbGURS9c/6ZXQiVzUrnB+Xy3Re2ipOCW3RnV
         jMQGv05q7iB4pP1hmtpsGl7YeGcpHHQRpGt0F4UQSwWe8Reb0Zx7xOCPHCoDKAsJU/81
         INhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789072144; x=1789676944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=exD+q8RvsL8LlA1NdvdgIxXpMfooqJfEtsvkYfwTOw8=;
        b=mCTbq1okNCe2OqdUYKmW0GhM/qZnotdNaIrabIDrw1uyTj96j004cKGxEr8EBsKj1M
         CqPQPaLRbPOmzJJfKugSNMLhaq2OWgXNFgto1dhQDufAp5HSbHK1Pw8EuPAIqLrH+Z8O
         u/tfGUDNQDWvNjZ1tAHz9iZ/K4suUu+oZ8k2DQv+0SlyaApJeVbkryTdft6YiAek7fJv
         v4NNZhhNRM4qUdW0g0KguQqfNKUdoHwoMYqPCHUkonSPLOm+in8bdCT9pywl2/9O4bAg
         2kwEobXxj92RkYPaaLgt3sNykbjgLdq8Nw3JC9in3tBw/Yd4aOWFojM4oiAPz19vz2s3
         FVjg==
X-Forwarded-Encrypted: i=1; AKwUvBxHXhhxv4X7HMbvGFVtzTDsD98U0odWCIUqpCfYzCwlNuZ4UgPIvsBBNmRR//og/NNFsdhjU8X063vG@lists.infradead.org
X-Gm-Message-State: AFuF++lao4D9UQ+vij2yeWfhXlLWnoKTdMrZhMGj9MTo0SOXWBqP1r4j
	At1vqmB2NtmLYe3t8khI7HZQ50VwTEjbWcqVYeFEtWgL66AYr/I0BiPdz7dM+MFTdnExp1LH5hC
	Pc2EMXrcv+af+a1ot28Fv6oizGc3rSZHnpaQm
X-Gm-Gg: AYBFou2gTuQgky4gbXy4xKcDkxeD5D4mWjLJgTQ9ynMsh2L5dMoJm7/cWiXTlht77Bs
	5sB4l2lLclDrAhiBgSwKlW/E7YIgb5NMT+4yiqoFJ3Gfg9Taaq0JgIBPAHXOOWSUOG2koLEZJ6V
	I6iAeG7u96yBMcxGx9H7ezc7T1XmchXvrXdH7ATQ33Bjn2Fap1DMlARz4FXCk8yZDSKwbVDz7rg
	jvl4QuKGPwTCTUu410ZuHk2pDCdQ9QZJ3Qr9p+xYn846zV24iukueAO3cbbs2gGhP4VnjjoTgI+
	ZLCkvu2J6IrrME3gJ74hoyLfdxZ5S7DRvYLeg1IeOvj4w/P7+sUiWb3WSBnXojj6w2XCYXcrg3k
	B7SNBd37rLvYW/0Hn57tSWvyEfNSAdQM=
X-Received: by 2002:a05:6a00:39a8:b0:857:73e2:9107 with SMTP id d2e1a72fcca58-86b344f0d09mr814115b3a.23.1789072143746;
        Thu, 10 Sep 2026 13:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-86b27dc0f73sm108946b3a.5.2026.09.10.13.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 1044940320;
	Thu, 10 Sep 2026 14:29:03 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 0D37851EC2; Thu, 10 Sep 2026 14:29:03 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v3 2/3] nvme-tcp: refactor I/O queue setup path
Date: Thu, 10 Sep 2026 14:28:11 -0600
Message-ID: <20260910202812.1642832-3-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910202812.1642832-1-sgogte@purestorage.com>
References: <20260910202812.1642832-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_132904_834689_07222B38 
X-CRM114-Status: GOOD (  16.60  )
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

Split the I/O queue setup helpers apart so that the individual steps can
be called directly from nvme_tcp_configure_io_queues():

- Queue count negotiation moves out of nvme_tcp_alloc_io_queues() into a
  new nvme_tcp_set_io_queue_count(), leaving the allocator with just the
  per-queue allocation loop.
- TLS PSK validation moves out of __nvme_tcp_alloc_io_queues() into a
  new nvme_tcp_tls_check_psk().
- nvme_tcp_configure_io_queues() now calls the three steps directly in
  the same order as before.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8e5e22febe2a..fe0e581608b4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2172,10 +2172,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
 {
-	int i, ret;
-
 	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->concat) {
 			/*
@@ -2197,6 +2195,13 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 		}
 	}
 
+	return 0;
+}
+
+static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i, ret;
+
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i,
 				ctrl->tls_pskid);
@@ -2213,7 +2218,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_set_io_queue_count(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
 	int ret;
@@ -2235,14 +2240,22 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 	nvmf_set_io_queues(ctrl->opts, nr_io_queues,
 			   to_tcp_ctrl(ctrl)->io_queues);
-	return __nvme_tcp_alloc_io_queues(ctrl);
+	return 0;
 }
 
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
 
-	ret = nvme_tcp_alloc_io_queues(ctrl);
+	ret = nvme_tcp_set_io_queue_count(ctrl);
+	if (ret)
+		return ret;
+
+	ret = nvme_tcp_tls_check_psk(ctrl);
+	if (ret)
+		return ret;
+
+	ret = __nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
 		return ret;
 
-- 
2.55.0


