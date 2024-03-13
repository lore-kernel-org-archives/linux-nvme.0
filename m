Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F32C54791
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p793P1BTk7k277weTIdJuZGu4hnig42k4ieb9wGqdXY=; b=AKrqLsvP483wuHeXVB0Dm7EbRB
	Lnk95ic78Fr4FX9aM2CvC22r3PAMoPHN7nS/+g/yhXMfP49PHWsltHPCMXULXYU3ZKdxqdVsI9afA
	wVDafePS7ImhQ5Wx+vQWDAxMchWzKcGtReM4vpKohx4nKOlPswYQLEqRZRpH1zAhMXGgOCp0m/S3x
	D4rEG3Rpkf3dW86xkdJsw3GJ382OAQriKh58RGRLyjGsT9s49evDY9jB7fke+SgceF9IpcFfNIFdg
	mw4kOwIZ0pN/Dkb/oV6NlJjTou50Q5rc13ZeTlm1N/o+ZTJxVp1GGAeeJ+VIQihk351CA3r46JyOO
	Vniz3OwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNt1-0000000A5xM-0A2q;
	Wed, 13 Mar 2024 12:39:11 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkNsx-0000000A5wQ-45NL
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 12:39:09 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ddcfe064faso3887855ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710333546; x=1710938346; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p793P1BTk7k277weTIdJuZGu4hnig42k4ieb9wGqdXY=;
        b=2tjvI9LYucKhuvD8Szn3ZogYzJZhFNrs0QKMTGxB82/cRDLH5qtl8wiSnrIG2F5BQ1
         PrssovUVgsHLhY6FUJ1cliVghKg8va01Pnb87+4BTyIdHqA2tCP30Oyw8CPnvWjUY1UC
         8ZMRVV41RywdfGS7RkowcJPXPrDNaBNBBESCQ3TfuoltCeSTOCiEweMf3ylfE2U6B5SE
         hAv1CxBngAkr2F022SJeeCPSigveSWmi/9DW+QH05yxC6Y91/X9Jb0HGemZgzoiMWb5t
         9GolxEwZhWp2sHG5X1wTgzwQcvSuhY+i9QaoJZ0I+Y6TC6ZFPBrTKtpTFIhaT3uV6dup
         fs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333546; x=1710938346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p793P1BTk7k277weTIdJuZGu4hnig42k4ieb9wGqdXY=;
        b=poKOklLSYY4xMta/85pnUO9OSq7faqS+vClZu99DPgrCZOS4L7SX+qzqq27J0CQTCt
         a83lwNfKrTwS3zgME5UtMr4WxM/GFkSmqxctViHml4i4yyOILAC0SAmNsE8hkHvyYnxz
         5pklhRspA1CArB2yeX+K48fixKID9ZLq+f2IOnGRsxhWSis0BrwxRtgH6MMgg1aK63k3
         CHdESF/ckvOEvfFQvZ8/Bd/TPVtbEqrNuE4cFllUH7ZFa71wRCM/mgFmcSY9pWslYmLR
         oPpto/NaE65fUaJd8qG6FQR8aPFD4gW19oK0G1G8pbOtlUnyLDOLi5X7aGrWVP4g/TSZ
         OLkg==
X-Forwarded-Encrypted: i=1; AJvYcCXFVXhX98BDRp7Ga6jUFYpIU0ZmjAR3NZNpUH6k/yLGeF3NhYN1p9/ykI2/xOwdIw8oK3WJVeZHtj3pEH0m6TNIfgDbVfpYTvQQ85WwFPw=
X-Gm-Message-State: AOJu0Yy7fT1moQcHvGkHyNMkZ5vWCsSBIsVn1Looc/S55x2sBIyfJvpp
	Fywd/tYRhQrBbkwvLuKP42+Ny0nBVM14b/m0oVefZwjTRirMNvvtMZwKYdymW0Q=
X-Google-Smtp-Source: AGHT+IHSR4NZqEKpPRGEz1h9gCqyf3I7QrJuUdWoD2pI+Gb4mE8YekSGojr4q+MbQUi3dR12PXz0YQ==
X-Received: by 2002:a17:903:22c8:b0:1dd:72cd:9442 with SMTP id y8-20020a17090322c800b001dd72cd9442mr3612081plg.30.1710333546263;
        Wed, 13 Mar 2024 05:39:06 -0700 (PDT)
Received: from localhost.localdomain.cc ([2407:cdc0:ab48:2284:ee43:5c89:b26a:f291])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001dd95b5dd0fsm6440696plg.69.2024.03.13.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:39:05 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anton.Gavriliuk@hpe.ua,
	Li Feng <fengli@smartx.com>
Subject: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Date: Wed, 13 Mar 2024 20:38:10 +0800
Message-ID: <20240313123816.625115-2-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313123816.625115-1-fengli@smartx.com>
References: <20240313123816.625115-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_053908_032484_83A58FFA 
X-CRM114-Status: GOOD (  15.07  )
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

The default nvme_tcp_wq will use all CPUs to process tasks. Sometimes it is
necessary to set CPU affinity to improve performance.

A new module parameter wq_unbound is added here. If set to true, users can
configure cpu affinity through
/sys/devices/virtual/workqueue/nvme_tcp_wq/cpumask.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2ec1186db0a3..34a882b2ec53 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -36,6 +36,14 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+/*
+ * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu affinity
+ * from sysfs.
+ */
+static bool wq_unbound;
+module_param(wq_unbound, bool, 0644);
+MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
+
 /*
  * TLS handshake timeout
  */
@@ -1551,7 +1559,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	else if (nvme_tcp_poll_queue(queue))
 		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
 				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+	if (wq_unbound)
+		queue->io_cpu = WORK_CPU_UNBOUND;
+	else
+		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -2790,6 +2801,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -2799,8 +2812,10 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, 0);
+	if (wq_unbound)
+		wq_flags |= WQ_UNBOUND;
+
+	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
-- 
2.44.0


