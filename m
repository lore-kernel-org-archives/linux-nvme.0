Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFC9C10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dogUzI0AEkc0u0eBb5eEuI4QvQE6tEIra8ouxmwgLGo=; b=ECSSS8iBT29go6HvcWp97LSjvZ
	zUn3SJ+cjBemS/5n18HMXwwsdqZdfA3E+Meqb4npNRJGqCE7Rb+pm/qr4IvI54iAviap4x4YL4u0x
	gcbNPMsyWiUcRkaMIdaZz58ckulL1R6QTWenhVJi8rfJdF05PgODBVy/3eWEtwUIW2jt7n4Z5BKp6
	QP67FNNnQ+gW0PYKk5ja7dsmogw5+matB8SSBoJlSBT00KDQxRDhmELVQQzmuK//hNN9ZsEqHkwF2
	QU1coLJnhVg5/+cf8fjWMZT0YzAgGcjc944GwrYKaZItRbb+ne+ubmD0Yxy/xzrXQ6csB38SuGOyY
	ZdpuU30A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4EiZ-00000009tn3-3Vzc;
	Tue, 07 May 2024 06:54:27 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4EiW-00000009tjn-3fWk
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 06:54:26 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51ef2eafe86so533963e87.3
        for <linux-nvme@lists.infradead.org>; Mon, 06 May 2024 23:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715064852; x=1715669652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dogUzI0AEkc0u0eBb5eEuI4QvQE6tEIra8ouxmwgLGo=;
        b=irHHA8ZDXcsVQoQA+wa3xWle6CBoP4eMXfWMv6wft3je8EEDi/GfAtdpL4vxGXOiqQ
         wVs995N850gxJzGceiXImAi68LjW8yqSEGpLm+86NnEJg/dambbsW9haXIkHmVsrlK+c
         q/gv16vmY9AROO4R7pR6uvb6hFx3bZZbe8xEfm5K7HOEXVybUH22kgHauL9vBPM+QMq1
         XiuYuTEBMA7liINnXBKA8Bven19eEw31b5TcPwFBJhCGnVybp4qcJRFoiwsAtjylHEIA
         bKjrYK+08SU4P9Q/P5niBUTp+e+dt84wOKoYAsY5RUS9hP0+jSgU8iFyZJ5fZbhc5wTp
         Nt+A==
X-Gm-Message-State: AOJu0YwAHXb8DSLwZBNE199r48pmmWH7kSV4VJfB2V6BRGoGP4VqpN1M
	DR+81MYAqJ5lB1y8zLOvg89v7TFHQkhQc0rL5bqRBZFw0LAyh0VsIRN8Ww==
X-Google-Smtp-Source: AGHT+IGEYvoxsMvHu8mDkcGo73OVS0XJqIxbNw2jViBRzxN4K9zBCIQxlQGOJkcIbdu77+njSUvjXA==
X-Received: by 2002:a2e:9147:0:b0:2da:320a:6739 with SMTP id q7-20020a2e9147000000b002da320a6739mr7643235ljg.1.1715064852197;
        Mon, 06 May 2024 23:54:12 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d4d8c000000b0034e65b8b43fsm10218880wru.8.2024.05.06.23.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:54:11 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvmet: make nvmet_wq unbound
Date: Tue,  7 May 2024 09:54:10 +0300
Message-Id: <20240507065410.1107169-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_235424_941780_4EDAF047 
X-CRM114-Status: GOOD (  12.54  )
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

From: Sagi Grimberg <sagi.grimberg@vastdata.com>

When deleting many controllers one-by-one, it takes a very
long time as these work elements may serialize as they are
scheduled on the executing cpu instead of spreading. In general
nvmet_wq can definitely be used for long standing work elements
so its better to make it unbound regardless.

Signed-off-by: Sagi Grimberg <sagi.grimberg@vastdata.com>
---
Changes from v1:
- remove unneeded WQ_SYSFS

 drivers/nvme/target/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e06013c5dace..2fde22323622 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1686,7 +1686,8 @@ static int __init nvmet_init(void)
 	if (!buffered_io_wq)
 		goto out_free_zbd_work_queue;
 
-	nvmet_wq = alloc_workqueue("nvmet-wq", WQ_MEM_RECLAIM, 0);
+	nvmet_wq = alloc_workqueue("nvmet-wq",
+			WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
-- 
2.40.1


