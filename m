Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7205AC87FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgt0RW1ytIxlMXzvFaCd3u+wuWOkXNFg3PALHarFCkw=; b=26mhtXfRRUOLPsx1EkqwbNZ5Vu
	HqFPe+4hGLI7xtlrwX8ugfT/qYBkbg/MWzv3ObHRdMC629seVHUKD8eqrFaDgcQusBCK2qku/1wTB
	cflpcopOkdDAs76mhNjq6EabESvpGeuPnLzihy9j7UvmrgS8MwG1gJx0aCMFHRl2DvNZJp4ADdywt
	v2lYDHfiEPs4ZeLUCEbvrhTWzIkBEty1iM8cxgw9fCLo5n8leBwPHEV7in0zQOq4x2/SK5RFF0LL0
	B27Qm/GlCESLrEXDw3fuPPzhAN/6BWVeFF3sUEFud24b7PPwcxN1egeJ2fMzrohyFpGDfzL7y2zLK
	aSh+IClg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugezO-0000000G9U0-3hYH;
	Tue, 29 Jul 2025 07:43:10 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugaJt-0000000Fn6m-1JAO
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 02:44:02 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so4467802a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Jul 2025 19:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753757040; x=1754361840; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgt0RW1ytIxlMXzvFaCd3u+wuWOkXNFg3PALHarFCkw=;
        b=OjR6sGMVMEhkwcla3eDkpxcAdVhNL5sgD8E5RmomElTQpVACYUDbPenXgYXV4huDIu
         PhM5Epg5lgAoL1HCRW+QgPBaQsE3Ti7IRqQasCMwli6vDPM26USGS7MAWa8Uh5HoXSpT
         hNvXvX1d3WZjhaXLVTcbpJNiGz8LJtMP3mwELkhmKf4Csf1b/qJUX2KhBFenqtpEdDvr
         Dd04k4e2k7MHhX+yxLzoT8emaQ0KaxACPBNwK3Np0x8DMEH3D4/SBExkLaw5qRBKQZzZ
         +D/XIbdC1v05uqluwYSHfUGQ89dgRfbshk3NrOp8W3XYxzcVOmsxJ86DSu7lVmI1KVQy
         BPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757040; x=1754361840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgt0RW1ytIxlMXzvFaCd3u+wuWOkXNFg3PALHarFCkw=;
        b=XUdmnVsFiuiP9Tq2mxLy4HAHysNuBMqrEXAO/kj1c9vOD/2Z3X2ioUhgPYup4tNFzR
         4Jlb/w0HsVH4a0gPzvIqRO8PQ412MIkDOtLeZ9FDkmDWlwbjfRJNgsIkLWscplMzcPLZ
         RpjUi3xYWLD+gXpjZPR/oEHI+4UHuNgGSB7zDmMTk641aD+mgA6jRzYlsoZHt/bDBPJD
         oI9S7wRkohCV2Ncs0WfaOGh0OATnOt9hIQd0L2vfvHgZf+Y7Z1PYbSQw1PebkSqL2xHs
         qH/XAqs6n6rRUhfJkVLnHF89R/jMeqOavNOXyZbs8Ws8FGLrhkhRWtmH/Pb2XqEb//Wt
         ggyw==
X-Forwarded-Encrypted: i=1; AJvYcCWhW6xHdbeEuylJGLbCp8nIEPDgNM04+YKzXH1gLkVdiN2XoK21ynPO79lDp85tt6D8STE3TqlGVVlc@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2KF4CB0+Qx7JKidJA7AAhEg3F6C9up8AdoX/5C4Aq8G9bk71n
	IychvT4Xcx7+AaClv1SJOuoVHFiJ+t07LS4hXxLupxdYSd85rRjlREFx
X-Gm-Gg: ASbGnct+nQjIQmLE0AaO6NLbJNzf3nhfuv0CY1zgiI45Me3U/7r+0tWdHHNIj8h63Y0
	AuQYbu+BbOR63L34t80BpTzuP8KY3gnVth1FXWOY5aIbASZ9zHzKcq722vPrGYdBCZQqb9SYbgS
	DB6f/pkjzJkYcFkzq59cKyTgDqle7JYCH7r8RJbhtWwviP4L79NYjzjEkv3zFyE+KShKojPZH/e
	Rf0aN68mLp3QZJ2GKWVTstlx7KiUNVRCYg9nEQMyzrla68YqrjHeOOYAt8LccNdtocWe9hD+D2N
	FU7vcuo2pg7t5WYgsGkUX3a/+jbFM7iJwmIF7rPVRk65hLt7XRINPjLnhXO5qMhw3qq84eAw71K
	h8b/7FIJOcPn7wTO2WgsXL+Shqg==
X-Google-Smtp-Source: AGHT+IHoH2RqRBEpNTQOrmGzch5WJntLLn2XCTRa7EVmeo/2jrFb47DkbxUEJrAbw3CNGKSshrbO6A==
X-Received: by 2002:a17:903:98d:b0:240:44aa:7f3a with SMTP id d9443c01a7336-24044aa8419mr55052065ad.31.1753757040472;
        Mon, 28 Jul 2025 19:44:00 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fecd9ed12sm51327855ad.8.2025.07.28.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 19:43:59 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair.francis@wdc.com,
	dlemoal@kernel.org,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [RFC 4/4] nvme/target/tcp: set max record size in the tls context
Date: Tue, 29 Jul 2025 12:41:52 +1000
Message-ID: <20250729024150.222513-7-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729024150.222513-2-wilfred.opensource@gmail.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_194401_352763_4A17BC12 
X-CRM114-Status: GOOD (  14.40  )
X-Mailman-Approved-At: Tue, 29 Jul 2025 00:43:06 -0700
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

During a tls handshake, a host may specify the tls record size limit
using the tls "record_size_limit" extension. Currently, the NVMe target
driver does not specify this value to the tls layer.

This patch adds support for setting the tls record size limit into the
tls context, such that outgoing records may not exceed this limit
specified by the endpoint.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/tcp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 60e308401a54..f2ab473ea5de 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1784,6 +1784,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 					size_t tls_record_size_limit)
 {
 	struct nvmet_tcp_queue *queue = data;
+	struct tls_context *tls_ctx = tls_get_ctx(queue->sock->sk);
 
 	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
 		 queue->idx, peerid, status);
@@ -1795,6 +1796,17 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	if (!status) {
 		queue->tls_pskid = peerid;
 		queue->state = NVMET_TCP_Q_CONNECTING;
+
+		/* Endpoint has specified a maximum tls record size limit */
+		if (tls_record_size_limit > TLS_MAX_PAYLOAD_SIZE) {
+			pr_err("queue %d: invalid tls max record size limit: %zu\n",
+			       queue->idx, tls_record_size_limit);
+			queue->state = NVMET_TCP_Q_FAILED;
+		} else if (tls_record_size_limit > 0) {
+			tls_ctx->tls_record_size_limit = (u32)tls_record_size_limit;
+			pr_debug("queue %d: host specified tls max record size %u\n",
+				 queue->idx, tls_ctx->tls_record_size_limit);
+		}
 	} else
 		queue->state = NVMET_TCP_Q_FAILED;
 	spin_unlock_bh(&queue->state_lock);
@@ -1808,6 +1820,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 		nvmet_tcp_schedule_release_queue(queue);
 	else
 		nvmet_tcp_set_queue_sock(queue);
+
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-- 
2.50.1


