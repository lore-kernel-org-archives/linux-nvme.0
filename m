Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6141CC52D71
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=; b=k0t1NtR6xUX3JcbyqkY4Cm7mVF
	zgQNuWGt71WvZ84f8s8F6quw7WQqHhhEaXN/NJsXuSCnP+eSSAY0PNwN0XenRrwjtAeTIRkywM6iD
	WB+CwVTytSzRXxms85gdwEIakVsTlNhoIXWchpKXAXI+2DO8cmPygD83wTnzsIfBbP2ZlM6tdjRes
	0FaHtrqTQbuy9GkurCSKSExkgfpLACvU6hmYXzc8bP2E59V5kojFctuNp8SW/39o+dGtKNZSYOEb3
	8Aqvh1ReG1Ay5zqqLo8wGAuN+N4Ec91qOnZpI84Y+LxvMyrsDiOt6c4djrfQQEdJ18KvReOo/4Tmi
	TfYuD0ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHZ-0000000Dgwg-2lco;
	Sun, 04 Aug 2024 17:44:37 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1safHW-0000000DguQ-03ou;
	Sun, 04 Aug 2024 17:44:35 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso67939045e9.0;
        Sun, 04 Aug 2024 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722793472; x=1723398272; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=K8z8gMZ7BL9qsooCkXLPlo2AxcpT4TSjOtMoKYYisu5BcLqYyDtWZWji2910FMWhek
         zlBbC9wd24WzR+0GWT8sMZxjiJOhR4FWZiSH5gFb/ykzd1OQBEuJqKdcMMObyqoRgrPv
         OPS31wqBNUyZgDy2Yjj/FlF3FAEkNHDYyWkqgfjJxxkek1BQHoxdc5/tUcKa700AKWmo
         oET2AcljtmiRvxA32eGMQlKlRftxhft7RO3QJ4M4mNWGmLQxcFzg6V2v2xjrMllrsttW
         Clad14n0MIpoJ/P1yppAIYpzVtO+PBZjyVYGqLR0MC5Pm45wJ0wI2DgpEKPccI8nXBNd
         XX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793472; x=1723398272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=m6hgfN85Vr6LpCvVN1S2vQynRMTl2QflZrTmLiZwf9ijQehrWTHRDEuIMO4VYLXlQZ
         2DeaSKfVRPB8fauleNMxNhzwnT4fGWdrdTtXqgF00l24670EgtIQk9yAJTbiwwWiLXy0
         1WckT1sJgeBmsbUSZvHa1j0hG/YYcIrbGZav2gfUimNZoHpak/J393LH+90ks43LgiDe
         5hbW6xhX9B2o0QFFzDXO1bTXfpc+uATYA1lHvH8P64wCjYzJ1UTd/fxIoyiYtL9Gctaw
         etGSaEfboy2VTsyOV9SpX/jVWn6oOCPLZL5WwaizxFcwLU/pcCDL9QAha40gV4Wox3/2
         Qysg==
X-Forwarded-Encrypted: i=1; AJvYcCVxb9N5AyD0sdWi3Yzh/Tkawrqdk/RGDXycoFvIgfWJtGpKhhI+3Hf9NWRnDOt/4XuVwv5AnmW2h8rAxpFCn7k7OXKicDCrD3SQyAZtAEbftqVDHLxKkjLwPQhpZuji5kTLLqbRPt0o134SEhYo
X-Gm-Message-State: AOJu0YwFsdXkQpaf5wtNLt4nJjcch7tRXqYXvaosurfuuKWLnOVKeDUF
	iaecb8BKW+xI0kjyOkOHS3ARUmxeExpTZxXC8UdwDCJaJD4bQJ7+
X-Google-Smtp-Source: AGHT+IF6h/dGDHwUKaeJf81/S6Xw4YXN06iaLrsJ+xyLkFLlhqRSyGV1A+2MwoRSks+8BuECDOiQtg==
X-Received: by 2002:a05:600c:470e:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-428e6b9369bmr73165125e9.32.1722793472007;
        Sun, 04 Aug 2024 10:44:32 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm109530485e9.12.2024.08.04.10.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 10:44:31 -0700 (PDT)
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/6] nvme: assign of_node to nvme device
Date: Sun,  4 Aug 2024 19:44:06 +0200
Message-ID: <20240804174414.18171-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804174414.18171-1-ansuelsmth@gmail.com>
References: <20240804174414.18171-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_104434_092680_BBB655B3 
X-CRM114-Status: GOOD (  14.94  )
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


