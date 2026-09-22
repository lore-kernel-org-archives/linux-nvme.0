Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A81DC98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DHOT2PMGUFhuByMTJSr3B57dIXKaBHqTAzfX9zwMX8=; b=jJGQf7/joxjYTw4J+sHc2Eslcc
	6FJPdR3zYpFJPoHnOkPUdxEpZTTM/hGRIqeEHOxCniykRdMdXlnlAjcT8VYXt9RDGM1qylWSzMfMN
	63tjpEynNtQTPFSrUVFjD2F95e265TI/3tvHYyXx0MgQzniWcmOO+M+yZj/pkOTHU2gH7j5GCPcAn
	yDWS7jmXDR9HC6jhlvZeNW7iogQUttc8Rh1VJwK7p8/mE7zPTEQDd54k+RU4CEp9bY8GkzNn3yoY3
	WHwgAcuAacx2USYecO5tMLhXqqKVqL1PkpfxVZVf6Kx1lLxoFK1pbXUL9nid2qDVvHCSRDIL/G5j7
	vlsd0thw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mH-00000006Vbz-2uM1;
	Tue, 22 Sep 2026 20:07:45 +0000
Received: from mail-pj1-x1062.google.com ([2607:f8b0:4864:20::1062])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x96mE-00000006VZs-3LLp
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 20:07:44 +0000
Received: by mail-pj1-x1062.google.com with SMTP id 98e67ed59e1d1-3a02551822eso193257a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790107662; x=1790712462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DHOT2PMGUFhuByMTJSr3B57dIXKaBHqTAzfX9zwMX8=;
        b=JyumqZmnOkPRqX/lR4lzjcFG4fKuWIQs0bu6qx/6q7jcvuAv++N3yq2DEDbhd/XWZ3
         wL2tWWk1jwpf0X0bd67h0c2EcHvTrv+gPfzbocfx5fCUU7DGRLKHV4g0BKQ89IR1E99K
         7cRFYIxExuvXD/0x0eT1Hfk6+3a6QcUuIALn0QE9YrWWeS3+y5aOqbDbjvIErTr9Gw3S
         S7hj5pTNzTF/0E0RB15oF++uJFXlYcs+rukM6mOKLH943xJbMoxN31KRkEcQIO7CflpZ
         /lcVd0Kujz7jHih7GHaqp8gEl/AfftajdzeA2drgfmd++I8f2naZY3gkrYejpdc/eSlC
         nRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107662; x=1790712462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DHOT2PMGUFhuByMTJSr3B57dIXKaBHqTAzfX9zwMX8=;
        b=s/8aiStdei3cmDJWifWEpyNHx9kQzbHk2BQwo8RXirh6Cxn+NqDB7AzczWitYOOKvi
         Jryq/CBzytnMNia5a7gJMVpmJIcquQl545zeI/WZmdxclNxAIJotZeUIFLdlEkEkqDfP
         hF6c1q5nfrbSBWGYR2wNdpx0JhE1VdY6KhDotKs5jxAVPaYygkrwDhG40sW1FU4QPpd3
         MjFTc3lBYKoWrfnbp6Zs6kPC9KShRtittUOzgf3B3MzWb7T1ydsr5SzC/ZK2sxczO1T5
         ag3wO14TsQzymcJrri+LhiKJOriyq2RB4s6pVMV3TeoQtiv9zMVz+V7TVeGAmRBroJ+5
         c8Qg==
X-Gm-Message-State: AFuF++kF1EBmNaY75flvsdjh046sShLcMYtJ5q1rKeBH9Sq+i0Q4DNlw
	uLKaSgidONpnH42w02K2OxYif9d/EN4crHh972Pa0fmdE2NCwGpsHnG/DlmfQID+A8/wihS52G+
	RRo2zsx7jNChwZ16UqfHdtBCpGnpO/qGiA1b7z+1jO/NcFiq4aLHw
X-Gm-Gg: AYBFou2SmgzAl0a/UC40n6hPZ2rpxzEa2WqbIVHatNUPNds+NIuTHAO0QeEVpQgvLLu
	9bla+5nkcrrfyrZhxZJzKV4gapVpJ0qVtXAdkdlfDboWAzvzDjkaSXA8akNdurl5zdRDUK62kab
	cmQjg0Zio856IPG8Af7vb5mLxcmbH+8YmX7v41OHKm8Yrw7emetDf0sBaO2wbaSzHnHp7RoOw0X
	D0zhqYT/+j4flQydGCcDin16p3WJXAxMd0CR9G6bWr9oNsZePl8Ze4U7+N9zzy7ZWSA8MeJajAg
	o4pE/ffRFv9tiGklFqFLNbiL4GzPlZQgaxIsx5ddNJ+tBl3F+aV122UJFKanbQcFjqqWCdhO6Vg
	HQiZvcIghDf/8N10=
X-Received: by 2002:a17:90b:5648:b0:3a0:78b6:588e with SMTP id 98e67ed59e1d1-3a07e5957dbmr300750a91.23.1790107661882;
        Tue, 22 Sep 2026 13:07:41 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a07dcc1b89sm311270a91.3.2026.09.22.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:07:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 45CC94014B;
	Tue, 22 Sep 2026 14:07:41 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 4334D3F9F5; Tue, 22 Sep 2026 14:07:41 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v4 2/3] nvme-tcp: refactor I/O queue setup path
Date: Tue, 22 Sep 2026 14:07:17 -0600
Message-ID: <20260922200718.3941465-3-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922200718.3941465-1-sgogte@purestorage.com>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_130742_863382_F0403A76 
X-CRM114-Status: GOOD (  16.86  )
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f916bcca304f..9308feba8a74 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2184,10 +2184,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
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
@@ -2209,6 +2207,13 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
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
@@ -2225,7 +2230,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_set_io_queue_count(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
 	int ret;
@@ -2247,14 +2252,22 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
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


