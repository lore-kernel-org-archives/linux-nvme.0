Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE2DC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7bPFlbXcyBAJAY0GCX/cI2jUl+3ZWxWtsuJ61mLDzc=; b=GayDj8fItcT3r+oA5eUgNbnsAk
	j/o48d+ByD2nUWaGMPogdTwlp43E7CpGF48c9Dhke/HUeAmUb05lAyvzt0pKXW7dqr1TU420/82dK
	XGEOfLd5n9eDJksRF8Ye/36nNos5wxy0Bz+Uijc695qBeyW3TjKGkCd5mdVKUeO5ZLWVOWDf9+diF
	efo3XuhBlnJGnopyVjmAW00fYck04PbmTgIPu945/W/ipSm1GAq9C75dE/xPKFrogJAJHaKBugaHV
	QwpGODu9K4r04R4trMdybU71+DVNycGaaicc0r7/SeX+oFNPCe0IGlpEjcoLdrV5GZMqVLRzOf4wd
	/1TJwcTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7Ca-00CShV-1U;
	Tue, 12 Dec 2023 18:09:52 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7CX-00CSgG-1N
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 18:09:50 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6d099d316a8so1882088b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Dec 2023 10:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702404588; x=1703009388; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7bPFlbXcyBAJAY0GCX/cI2jUl+3ZWxWtsuJ61mLDzc=;
        b=aKla298Vg5WeJk+GyiW6sSrBUmdhO173DM+I6jlxmnEm818I9uaj0t9e5q6BAjlMDf
         BRennvePLOIBmHXk9t6TJZoehcl66CxwSFU8Ru+fEjofxQt3EgtdPuXsmhjIk8WQOGb+
         vKHaqz3DGA8+Z5G7Y3SoifYibmhHGURsLz3aKvwApLsJ+0yS0apDa6pZR/iNZ0U6PIyk
         EtrYuDAn8pnQKVQTz9qhuTvVhzsDhTPLp67qrnz/nWv8ccayYY2vXFM26WeRb1WOpzw/
         8HyIxV9iTKepS2buJZS8SaHFukTjRLDTWLxMjRvkqKizVs18CDBXYIAM5FDrgwZmPaft
         4hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404588; x=1703009388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7bPFlbXcyBAJAY0GCX/cI2jUl+3ZWxWtsuJ61mLDzc=;
        b=SaT91uKRSI800g3lgUlzRu6w/OcdpBrskUmULG+Ph2ulorjManvtknDeEpSZhabUK1
         U78houMDM90A98rgga45sjso0W9JbFs65TyTeXJ1fng4iuaOdh8CtE9ndGRw6ONXjshu
         cpOxBfnM0MoKdgyem5ImzRhWcNT+pu3SEHpz190sDqF15+JmEIboG4Fhq1LOR39RC9N5
         1qwIwprn9vJRkICXt5oY/bx5DVUAaN3UzpyUNOdG6XXtJs9DkUV+7dSX93KJkoickRzX
         Jq/bMC5yyH2Udczodtydyh8a3Aly0gEVUB9X+rjiWz+hoWnvmKGx5CxOBTeRh2HqS4NE
         djWg==
X-Gm-Message-State: AOJu0YxssCLgapdOHKVu6sACU7stsFmnTaVJ+jRLM/ek+el25KF8AbGu
	0Vb4xQxk6oYJjNq6LJ1zHaM9nA==
X-Google-Smtp-Source: AGHT+IG6ouYOToFq6UywL74KLA73roKV9Pw0Kf+oj7poSOJlYyWsNW0k1ffsZLLbuh7OEePrPYv8mg==
X-Received: by 2002:a05:6a20:7fa0:b0:18f:ef63:7839 with SMTP id d32-20020a056a207fa000b0018fef637839mr8682712pzj.100.1702404588010;
        Tue, 12 Dec 2023 10:09:48 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id x3-20020a636303000000b005a9b20408a7sm8419861pgb.23.2023.12.12.10.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:09:47 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] PCI: Support asynchronous shutdown
Date: Tue, 12 Dec 2023 10:09:37 -0800
Message-Id: <20231212180938.397403-3-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212180938.397403-1-jallison@ciq.com>
References: <20231212180938.397403-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_100949_463590_575970A3 
X-CRM114-Status: GOOD (  16.99  )
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

From: Tanjore Suresh <tansuresh@google.com>

Enhances the base PCI driver to add support for asynchronous
shutdown.

Assume a device takes n secs to shutdown. If a machine has been
populated with M such devices, the total time spent in shutting down
all the devices will be M * n secs, if the shutdown is done
synchronously. For example, if NVMe PCI Controllers take 5 secs
to shutdown and if there are 16 such NVMe controllers in a system,
system will spend a total of 80 secs to shutdown all
NVMe devices in that system.

In order to speed up the shutdown time, asynchronous interface to
shutdown has been implemented. This will significantly reduce
the machine reboot time.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/pci/pci-driver.c | 17 ++++++++++++++---
 include/linux/pci.h      |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..a98037a9f886 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -502,14 +502,16 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_shutdown_pre(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->shutdown_pre)
+		drv->shutdown_pre(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
 	/*
@@ -547,6 +549,14 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static void pci_device_shutdown_post(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->shutdown_post)
+		drv->shutdown_post(pci_dev);
+}
 #ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume */
@@ -1681,7 +1691,8 @@ struct bus_type pci_bus_type = {
 	.uevent		= pci_uevent,
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
-	.shutdown	= pci_device_shutdown,
+	.shutdown_pre	= pci_device_shutdown_pre,
+	.shutdown_post	= pci_device_shutdown_post,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..730069af649d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -948,6 +948,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*shutdown_pre)(struct pci_dev *dev);
+	void (*shutdown_post)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.39.3


