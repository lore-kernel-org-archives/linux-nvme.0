Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8677EC54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Dm85BXuVczHuF7thZskvHACa56yT/MJpoY/H4BB3y8Y=; b=lXhdag4LyqNsUBUeRzn5ypeTFZ
	8ZFsPDowUJPba2M4h9l3WU1qCDz38mzPev/RsIR/5WnuEdimQsCknz3PCM429QSj0eN/dptgZA2i2
	T7apHx60SE4lVrhnxkjratnaLKbcIlMn3P15bxmvn2UsOklfCfsrdZxaYiht50adrjLpnfBpJp76o
	xml8xjolrsnfEmjGDm7vuHv37iiLWlNqc2tPEkgsHpv5VXio4JY1rT6pw4DS6jpupZZtu4Wwsl9oq
	KuhvLd09mhv6UApsmyfQeNFEKdEoAIwX1tqMJTQnGG65XwqTEU2oB5/Z9uck+R9C8X1e7FT/ekn2V
	oG1FYpNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkKPF-00000009OSD-1Zvr;
	Wed, 13 Mar 2024 08:56:13 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkKPA-00000009OR8-0CJv
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 08:56:11 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so5233235ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710320165; x=1710924965; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm85BXuVczHuF7thZskvHACa56yT/MJpoY/H4BB3y8Y=;
        b=yEVA3uqIQc62eDbWhivNQTJx2+BhUCH+MoIwLTIwUeQxzFxWfusLKlCll9hGxH0GcU
         KHI3X/Nb6LkZOhdx446UEiYbRTQM0dK2CbpTUxZOrT/B7IOYAv/J7PRd2KT+Ywp0MZY6
         Kr3d6knkDTOEr6s0dqT2jz4lvh8dPEWW0rqMWa5EjC3fTJyCBAPgBle+J/RvG91BP9Kx
         aRDy6MDrKnyrdfT77zlqz0CAuxKlHL9D2pdzJR8F1Al/st67Ia7zCDW8wSvQ0TvP9E3G
         J7jkJiqTGArGpZwpQw9djUgZ4a8NFWS/ERR00q1u8dWolv6uz/S0eHoRL16/OrZoXKyB
         FL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320165; x=1710924965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm85BXuVczHuF7thZskvHACa56yT/MJpoY/H4BB3y8Y=;
        b=axAbZjIsDe461Ig8sA/c02jKV82DIye/pM3u6h+mP/21aahRf8gnc0CIS9aXEgBJ5l
         rEOGkEFVoDVJOukquoW1H3qk6dLNkuXf4WMcedV5LtPi2cuuMfRzoNUnx3v3JfuXybWv
         1OzpCro0ojCBUtD772PX8SawnJF2lP4vGjsup/H1XC4cLwUt22QHOMlStZXoG94vz59C
         YOLIzsO//wSYzP4fIhv+GMWbBUDkA3pvlwGMhAZoscj1cvsLYx/StY9thD29vmK8eDaO
         JPm8VgtTD6bMY0J7EmM6jMImSD4jSaSjpeqnb/chlwSei9m5p36ld1TfSWfDne7kfkez
         oovA==
X-Forwarded-Encrypted: i=1; AJvYcCWSQTtxIG0LPJDnWq6VjbMCZzAyKAJ5zTKr2gs2e42s+COKkrOm9mV3pzgABwtZo5J11eQbobenm2XVOzKmJw6hD5UCxlQRDK4LcRlVQvE=
X-Gm-Message-State: AOJu0YxS9sbB4TnTUP3Tpw4+ALG3JhwTgHF+HFIO+mg6A6kKlpjYqWOY
	wyKTz46fH2TaaPVlM9bzkiokd0YdXA9drS9lHDw2mw4l4M+22KsVnbbaynHUSI4=
X-Google-Smtp-Source: AGHT+IHj9sWvnrNbgEbJTmkO0mdVRd3JkV/BMSjseGuZwRkFHTRCBZuuBBAWm3G3tmwBHnuUO6m/Dw==
X-Received: by 2002:a17:903:947:b0:1dd:a616:8205 with SMTP id ma7-20020a170903094700b001dda6168205mr2047210plb.34.1710320164517;
        Wed, 13 Mar 2024 01:56:04 -0700 (PDT)
Received: from localhost.localdomain.cc ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001dc6b99af70sm8022794plg.108.2024.03.13.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:56:03 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anton.Gavriliuk@hpe.ua,
	Li Feng <fengli@smartx.com>
Subject: [PATCH] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Date: Wed, 13 Mar 2024 16:55:17 +0800
Message-ID: <20240313085531.617633-1-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_015608_314842_D4E21193 
X-CRM114-Status: GOOD (  14.65  )
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
index a6d596e05602..5eaa275f436f 100644
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
+MODULE_PARM_DESC(wq_unbound, "set unbound flag for nvme tcp work queue");
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
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -2799,8 +2812,10 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (wq_unbound)
+		wq_flags |= WQ_UNBOUND | WQ_SYSFS;
+
+	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
-- 
2.44.0


