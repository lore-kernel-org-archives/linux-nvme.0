Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA05C3DA7F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOfQ6PranLoD+iROjXBHWVrWUAE8K7cRNQ5h3Vwmujo=; b=SF5mbTfFNASauX3pSoV83xkTY0
	+A5GrrIGBbLA8hRFA9FC0zFyG1kQtfzJule749FNIxGUf0JhMe/LFZ5+Ot0puJbhYOlfXYGZErt2j
	lvSv/NE6EdGqCLy/mDLXYwISZKhu9iej2LYhmHMg6c+wQlrA2mPIVK3nVRqtAmkR443hq2BuRs696
	ZbZRxV8HInW9yNhY7RKDxpBN6EGXU6UFpTC4kFBfAZzH31CXCjwCFZmMhocR2SSEBCtvB0ho/VeNI
	fuHG1ib5ttszl6OJzlwypmrXMJZr8K10PrpZnVAkUeRSbjIfuppRQHZJgpL1dAw2LZiD/BmZpGqIP
	kkvgT6fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZch-0000000DAae-3SSc;
	Sun, 04 Aug 2024 11:42:03 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saZce-0000000DAXn-1W4S;
	Sun, 04 Aug 2024 11:42:01 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3687fd09251so5116458f8f.0;
        Sun, 04 Aug 2024 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722771718; x=1723376518; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOfQ6PranLoD+iROjXBHWVrWUAE8K7cRNQ5h3Vwmujo=;
        b=ZR5s0Hk6A1VPMCD/YkA4LSncRz8ay4FVD/UyvYPUuLysN91MmA4qdcVr3baYIRKjp6
         KxvpUP/6C1dxRklsVw083PxqdFGnRq0lvnTTVEL+ove+UL493J52GcasmMdwVfMoaHKC
         d3vRuodr+0inaM3z795FTdi6Cbfkcja03wfNYZ7ky6udRMeUNAYZamEWvbOEoXBmOJpK
         5thfPwwo/Ym9iQFNr+XZi3/SwcLKQuPIzGlA+eJonye2taJDjx8zmrOHniYM5eE51YcY
         txkM1dqlAsiw2Bcrm7DcIZB/cQr0873o/M4iCGUMZuHYaxJBVlremmpbdJM/5q4hV0FF
         vbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722771718; x=1723376518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOfQ6PranLoD+iROjXBHWVrWUAE8K7cRNQ5h3Vwmujo=;
        b=nnxMiWgDtX4wXcILTpCtZgrox76qeRvN+qqjwO2TuJOM76v/AtJDHf/thFhE6xbj9R
         4nG+exYWAnzlKI8FhyuUoadm68Zp+VGXBo5NGC8box1v1e91ap8X+iSzE4wXs+hFZyI+
         eRUn3gb8VNEidFbqmv6txjTuPj/p7VXTgugFidhEemf9A7qnrcyMtGkI9bnlTksz3seO
         VdFyGUrnr+G1PSpHt1bIOiVXXUursGFlPuWxcFEus3bFLdNHCxq9FyqUrfV+cQV8WRyA
         4B7/F4UA5GmGwlCv2BPUsUFqr0cidBwPndKBRrgY+J7xD25Ws9FYdg04xSSKowQcv/vH
         KMdg==
X-Forwarded-Encrypted: i=1; AJvYcCX5nLdfcUXCzHopB76HkYGHC/Fn0MI/7PZdq5tJrgvoqqOVji5Zcite9p1o/s62Br8xTB5JoqV2mbSgbAL7To65IUxzgWd7rxDCf0aLCPn5JLzeBp+6zIzAzeZ2UG/OK2/MZ+dH+NQqqzNIpU13
X-Gm-Message-State: AOJu0YzjeCgNiG79/eBnrFevB6Q05FZ952UamqprKfw5GhQdyfxwzbcV
	fS8TmTfEp430KNN6M5LU7kOJpkSYm+d6vYZ0dbvUzQU9omXR4j7r
X-Google-Smtp-Source: AGHT+IGmBqLkmUPrb6PVyJ646RbotoYKt7rhCLpvhXazgn9MYHBkQIQkseu8qxI4YXnyXjeT1VIzkA==
X-Received: by 2002:a05:6000:a8b:b0:368:327c:372b with SMTP id ffacd0b85a97d-36bbc0dcf5fmr6441035f8f.19.1722771718267;
        Sun, 04 Aug 2024 04:41:58 -0700 (PDT)
Received: from localhost.localdomain ([109.52.148.115])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36bbd01eff1sm6635130f8f.44.2024.08.04.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 04:41:58 -0700 (PDT)
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
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/6] nvme: assign of_node to nvme device
Date: Sun,  4 Aug 2024 13:41:02 +0200
Message-ID: <20240804114108.1893-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804114108.1893-1-ansuelsmth@gmail.com>
References: <20240804114108.1893-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_044200_421444_E30DAE58 
X-CRM114-Status: GOOD (  13.84  )
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
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 053d5b4909cd..b9553bb8fade 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4651,6 +4651,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
+	of_node_put(ctrl->device->of_node);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 	nvme_put_ctrl(ctrl);
 }
@@ -4771,6 +4772,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	else
 		ctrl->device->groups = nvme_dev_attr_groups;
 	ctrl->device->release = nvme_free_ctrl;
+	ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
+							"nvme-card");
 	dev_set_drvdata(ctrl->device, ctrl);
 
 	return ret;
-- 
2.45.2


