Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B9C52D6F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=; b=Aaxat2Q+y7DX3AzBnDd/kaLqZC
	FJNhC+3CROrc/ZRIM70gdtrpfbQA7gOk7VlV0uYWXM0ayhc5OXTnKEjxkE9kYenJ2nglMXWnONnPW
	XCd+9esgHXS8uGpkZn3RHJtCmfQtuaC70Kso6DVyZVuw6v8FZAodcUT8VVagHFMNQuoCN0R83A0Oc
	e22av+EeCmS6GssUlX5Ao4VV1Con34Ho6SDLfe2RKQqOLW00u5X723p4/riML9Rru9oYclzKC/5nG
	+IXCg4aXT8HWYLtfnrNJb4ZJg4hV2ev17be+/4WCkass7heFaddtQQM3jKTbzx0qgoi3LrL4oRbiM
	OACoJVCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZP-00000001NCQ-2AXV;
	Tue, 06 Aug 2024 11:41:39 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZI-00000001N6G-0NrU;
	Tue, 06 Aug 2024 11:41:33 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so3231425e9.0;
        Tue, 06 Aug 2024 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944490; x=1723549290; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=J8en9XFrmTlOEDb59OGPUWxGALmDK4VdFS/AmOO97xdELTkDTkArk+0W+3pPGNAzW+
         vZ68aDnLgaQ7ol5mh8dulSTRLnylsopakjafWACJSNjmZvet40ci8WeD/Wf/FktPeslo
         NAn05nC3KeoTS9Q3g2ypiHhcY7ee9vYZ9/2pa7rUUVDlmDF3SilINHGc5QAIsCET/byA
         iQc9IbRAefYANv92ALF3/dvvoTR3HNSBF11uKXh/QCw++Kgt1HWN/TuXe735oNr5sgax
         Tn7bHen0U2ZZFeZEBcIAf8Y8jJl7u8X+iQ4xfEL4wgyLNPR7XO7xdbDHlulT3duzdTng
         JqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944490; x=1723549290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJElgdSeo7tFBhUWI5Y2VGkmcaarTUGB2bJhxj7nOts=;
        b=Azky0UwU/ay7gfUXJ1R8zj4N4VUIeE/DbLvh+EzKJ16ZdfE7aDgMxdeBvzZ/FeOT9k
         JZij9OCkY6d+/diEIvzl0SBuSYSkWpO0qpRY3EjfPqvkOD7Q1NbxDCZC1TJxzIzFAWR9
         2AOcZVqKb+BxqsHFrEdSUJO3+wzJHIQQPOWYcXr+0ln4NmyozzIQDUJB7zqNe8rnWxyQ
         iU1udor4oq+nBaorPuPepwa/MHY8fgzR3S5TSHp+fKggekQnKJs2i1dSPfJO8CtcO4k6
         GaEXxUkmbkrw1Tb2o+R45ddE5nKyLyVIhyu7NOZGayLsUHW7d3AyNiUpY9OdK9OM1kGP
         9KmA==
X-Forwarded-Encrypted: i=1; AJvYcCU60UzX66S6QBUH7kzL0qg0Rz2rD6sk6TLNhysvS+Yd/el8CX5k9Cd3bV2uAbATU+39bAtKSJ3yhxSKH68BBvTsTu2CHeMpW59YY2pJLUczyI6vkOWV6+dRsPAIdlRPjhDGdmIKNkqYjIVE2c7k
X-Gm-Message-State: AOJu0YxK8enW5cZjcD0wfC1CwfCCRUk4j+NIlgUQy6WJ0epaAbpTezkA
	DR64xwrOAn1sNCBC6ylO7lyBLhFGlAZFjoDWUSUdWPDPHd+BO+Me
X-Google-Smtp-Source: AGHT+IHsLBFQO+J/lS62zM2qc6hKgOhyDSFxfwIUq3wJKk0pA9FyD5Jiwj6/3xBLV/JtPtreeeXWCw==
X-Received: by 2002:a05:600c:4e87:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-428e6b7cab3mr105454325e9.28.1722944490056;
        Tue, 06 Aug 2024 04:41:30 -0700 (PDT)
Received: from localhost.localdomain (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cce6sm176105845e9.31.2024.08.06.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:41:29 -0700 (PDT)
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
Subject: [PATCH v3 2/6] nvme: assign of_node to nvme device
Date: Tue,  6 Aug 2024 13:41:12 +0200
Message-ID: <20240806114118.17198-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806114118.17198-1-ansuelsmth@gmail.com>
References: <20240806114118.17198-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_044132_206150_6DB67FAE 
X-CRM114-Status: GOOD (  15.08  )
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


