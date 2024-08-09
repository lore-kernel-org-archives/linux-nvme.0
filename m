Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59D9C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Aug 2024 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=; b=zhGnI8xsetRfqfYeLiBWMMBIaz
	T74dO0BTqHEGseCMG9jldbm3IBEYTewvnXEnpt4N8s5iObqATCXBnbUuncP6BrKQUZNwuRHAhiJWT
	Cr4Yq7kvHC4ZJSLUXiRsPNzYt8I6o68q4bgamS63oKmWzy9pD9gLJhvT6zKOFobare6IprKezsgWJ
	usYj+UYW/2ZYhG4POR57lbJp3DjLOzjqF/VvjcYed8L9wbqSpHe/5Ky8sUdpjPwUeF0HVwBCGb6AC
	K86bMpaf06w9z793dKofshJTtH4tK/mkK9ceXxvHdRmZL8ENntU/LYus+MZIILJi22CbaVdljrJa7
	Zt/otmog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYd4-0000000Ci3W-0MWq;
	Fri, 09 Aug 2024 23:02:38 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scYcy-0000000Ci0a-08lZ;
	Fri, 09 Aug 2024 23:02:34 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2f149845d81so28731931fa.0;
        Fri, 09 Aug 2024 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723244550; x=1723849350; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=YFzcSZkGr63Y0QFMIQWgaXYIaOhn7UXOidq8GL85DB8QrLJWWbIIGvELmlUsdYyYeV
         u1kjmfJZs6QqiKoobfAOb/DGYdKMRHL+4it0PZpDhlB+PiHsQbz206hlnyey9hDVCyYF
         ozzGmuCoLHQpLEyV49ADeWKlgC3r0769PxoAMjEtacx/qqUWr05ReOUHMUxnHNOUV/v4
         nCBSnbL3VQO3NU+Yh//y3kJnSyCrP5hrCHkdkV36Vw9mlphtFq8g4DDnP4LIeZdv4Ggs
         Ff5aexN0ZMbU2GzbxaPSD3WPNa/mv1eE1T2AWKUIjdrxf/4TaD4jeNuxtR0ceovDlAAX
         r+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723244550; x=1723849350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=s05hpWeP34piUFvOndZwRV/z4ndEdL2AgWWPmyhJC4iwbCEN1gXRCvYaehfsGZiQD2
         1RlZSerJmnVlifNrRyu4romAZVQaEDJjM9hHP03BuJnLVZndVQ+9IZgrrHZC/6um4ZPr
         P/omXkMkmLUTYT2v8DFL8wnyphBGUHVNKk6spSpsqT518kIctZQzFICE5Tp3jMj7gpxx
         9FC3jfPqfNCcdQ9pCV3UnQC0QQi0DUohqC0l61TGQHxSiEOvvdde8ITpfokHubHYQC7C
         Rx4oru1PWPtJU7rRNvSBY1FUk6cpPHwjZwMEwQ0ISjXDhPaA36lmx4MwnvH7PKOqYAIt
         IFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUavAcgccpHwIEAHx5/GXGlBCDlhAdLZrPbVJ0pwFfCYFTNYQr56gRh+CX8Y1vKUyyIIt68LwsjgnujGhxgN1oOZ/tSL28zgGMRRLa82z+cGxK1wSwWS102eBViSjy4NM4h3MbFvVod2bJuYfcF
X-Gm-Message-State: AOJu0YxTas7U4mOEfmm3l3y12q9HCoWF4329FSUQcPApyzJkn6VifjUW
	OjCtllE8ONBbz5HwTgmhgF2avlVutFyBRUERZbp+IlegOcpIStKX
X-Google-Smtp-Source: AGHT+IEgI2zjmdRYRlZuFS3JMcj18YcXEyrI/y4EefxeFqU02qwA4OQ98srTe294d8hiQpQ1tz2BoQ==
X-Received: by 2002:a2e:98cd:0:b0:2ef:216c:c97 with SMTP id 38308e7fff4ca-2f1a6c65834mr20972061fa.19.1723244549573;
        Fri, 09 Aug 2024 16:02:29 -0700 (PDT)
Received: from localhost.localdomain (host-87-10-253-138.retail.telecomitalia.it. [87.10.253.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429c75044a8sm7987485e9.9.2024.08.09.16.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:02:29 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v4 2/7] nvme: assign of_node to nvme device
Date: Fri,  9 Aug 2024 19:21:00 +0200
Message-ID: <20240809172106.25892-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240809_160232_078784_859376B2 
X-CRM114-Status: GOOD (  15.13  )
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

Introduce support for a dedicated node for a nvme card. This will be a
subnode of the nvme controller node that will have the "nvme-card"
compatible.

This follow a similar implementation done for mmc where the specific mmc
card have a dedicated of_node.

This can be used for scenario where block2mtd module is used to declare
partition in DT and block2mtd is called on the root block of the nvme
card, permitting the usage of fixed-partition parser or alternative
ones.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 053d5b4909cd..344523274d1b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pr.h>
@@ -4651,6 +4652,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
+	of_node_put(ctrl->device->of_node);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 	nvme_put_ctrl(ctrl);
 }
@@ -4771,6 +4773,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	else
 		ctrl->device->groups = nvme_dev_attr_groups;
 	ctrl->device->release = nvme_free_ctrl;
+	ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
+							"nvme-card");
 	dev_set_drvdata(ctrl->device, ctrl);
 
 	return ret;
-- 
2.45.2


