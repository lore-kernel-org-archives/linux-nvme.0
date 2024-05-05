Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BABC4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cU64d2YTTfR8VSHg6/hjkfU/9EImQ25rzfMrJdS5uIQ=; b=Q/k9ja6prj5EYoYRAuR8S2RweA
	ScaAhTAy/YhvoyVWwcP3rylpo1809NFnhFEDKytz6ZY3h18N3I2l5QN441Hb2RT6pRCm4UneMNL6I
	6jLPEU0uOrd+upEE4SoalhUTMOxvlzzFYFVa4gLFlUV0aNMy0Lqmzm2ZLt58Pf9wNiCaaXDQI+Ak3
	ITFQiJc1IqKBXgzWh7R8xgv46cnZv48vT1ZACNQ48JgpS7kjWjwzl5MyP5s3KDRXhWbilMaeD0Rll
	L8i3eEcMdD7PMW7mWxJHbbsoXmwQBvKok3HEphSncVxbie+IShU9Nv1Rc+R9nEif4D/P9ETXy21Lr
	1F9m2yUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3dk2-00000004bqk-1GDT;
	Sun, 05 May 2024 15:25:30 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3djz-00000004bor-3kxU
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 15:25:29 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6f4603237e0so471998b3a.0
        for <linux-nvme@lists.infradead.org>; Sun, 05 May 2024 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714922727; x=1715527527; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cU64d2YTTfR8VSHg6/hjkfU/9EImQ25rzfMrJdS5uIQ=;
        b=ReBOAK39jwF3o4nV4JRYN3zu0LoVJP2Qc9GhJT1s61d0Xu3rqFnI7dL8V2+Jd540Gj
         //nfsWdR2e+hqm9xD5ieKrP1QHXfPIhz3l7fPCfpcf7f414u5E1jBdhWfF9j1v7YKYid
         YEVg9BC0uYmXTfEWjSFDyHRi2iw0LRck1Dk3CBfvUjqBfjdRiQIxTobB+Bm7yVfGIvo2
         GxDDgPzTt/2ezqoloLXqfpLOVUo3UjYYJRGKGkqczylsgVM04kZpGjTokXvCi7IGX5B1
         IX5xk7xz8qegQkf16BgHfsehUdnqI3Su8jjNWyWpYM2lUVg8ADBIAm16Rd7hCWvlPDu5
         8ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714922727; x=1715527527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cU64d2YTTfR8VSHg6/hjkfU/9EImQ25rzfMrJdS5uIQ=;
        b=T0aOiVxXqEdecCROPPjVc7OSIzmPix8UXl+v74Endf9oCVtezufJEuVFHdtn17WVU3
         qg3D2mPKBnbaG5PloMMkHsAPL+kCdzmpHhdc/fvynQ0I8tFqXjh8yJ5YPPzvDkmtrJM4
         z+CYcTyu8JR4xAvgU2LYyYldgp/4hq9FmxtwKbfQPaMdrjAAhRVYfrNU8g41FRkh2XJK
         4p7uooY60E6Uk5HoXdtNxXegfRiWPdzavu7L/d/TPTXyC9AhbkWsybJYpK3gVckWPeWu
         YNtdinqNU5A3pOoViLj6CseeZmaxdz8772a6jFfHaLYG6Sdx5WX4Zs33SBuNLlce/XtI
         Ongg==
X-Gm-Message-State: AOJu0YxkhbQTdgmUhub2wN3pXunSI4FmwRXDYeqEH6oJq20o4nCfXTmJ
	nFloLkdUkfcWK7quY6VW1kAHO34j/dYTKrm7cEMjwlvnyhDT4nde
X-Google-Smtp-Source: AGHT+IHTNDz1g1Sp8B03FcooDFAeTK0ORVmq26XtLuPv6ivM7o/dd9IXy+EN9ruybu8y3QChKYPBoA==
X-Received: by 2002:a05:6a21:8187:b0:1af:aeb7:7a14 with SMTP id pd7-20020a056a21818700b001afaeb77a14mr1319906pzb.2.1714922726585;
        Sun, 05 May 2024 08:25:26 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:dae:6af2:7bcc:d74])
        by smtp.gmail.com with ESMTPSA id b3-20020a636703000000b0061b0c6a56e0sm5754798pgc.56.2024.05.05.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 08:25:26 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme-rdma, nvme-tcp: include max reconnects for reconnect logging
Date: Mon,  6 May 2024 00:24:59 +0900
Message-ID: <20240505152517.8508-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_082527_977371_BF63047F 
X-CRM114-Status: GOOD (  12.04  )
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

Makes clear max reconnects translated by ctrl loss tmo and reconnect delay.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v1:
- Change the kernel message as "Failed reconnect attempt %d/%d\n".
- Change the same for the successful reconnect.

 drivers/nvme/host/rdma.c | 4 ++--
 drivers/nvme/host/tcp.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 366f0bb4ebfc..ea2fb7b47ad5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1118,8 +1118,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	return;
 
 requeue:
-	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.nr_reconnects);
+	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d/%d\n",
+		 ctrl->ctrl.nr_reconnects, ctrl->ctrl.opts->max_reconnects);
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28bc2f373cfa..24be1b5fbb02 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2264,16 +2264,16 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	if (nvme_tcp_setup_ctrl(ctrl, false))
 		goto requeue;
 
-	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
-			ctrl->nr_reconnects);
+	dev_info(ctrl->device, "Successfully reconnected (attempt %d/%d)\n",
+		 ctrl->nr_reconnects, ctrl->opts->max_reconnects);
 
 	ctrl->nr_reconnects = 0;
 
 	return;
 
 requeue:
-	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
-			ctrl->nr_reconnects);
+	dev_info(ctrl->device, "Failed reconnect attempt %d/%d\n",
+		 ctrl->nr_reconnects, ctrl->opts->max_reconnects);
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
-- 
2.43.0


