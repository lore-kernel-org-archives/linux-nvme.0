Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37551C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 22:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hi3AFMxd4lntnLY/VQnmQFojrvZ1/71m51waZccMBqI=; b=IH/6+ksUyAOr5Is09I+WkExAwU
	sR+eIJyTGmerFybyQsYxnC3n7HnRCCOXXLDJ/SSpsCGm58zGT3SURyMQ3fQMzS9vrkXA6XCO23q2z
	YHa0dR72lF5frwh8N0yLd3y6/JNVB/AtYPnj9VRl5PfrhxzDezllBh7QD8BnjOPYj7TdF28HHJQ/g
	T/Me2zKZvvt+3pXCZJdCeXe9GF/ecKfMjJWOGoB4XdOY5MpSTtmGFHl6PFQloWwXk5QQfIdryv+sJ
	oJwq3QxT8CidHgq99djqR5zgnPblpBTC3ycTmlCh1WGgoh+k48k9jv2yei8J5sU97Kt2k5Y1SJ1w6
	qWuXFelA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nePF7-00FzGo-Fx; Tue, 12 Apr 2022 22:44:13 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nePF4-00FzF0-Ht
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 22:44:12 +0000
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2ec12272fb2so2873397b3.6
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=hi3AFMxd4lntnLY/VQnmQFojrvZ1/71m51waZccMBqI=;
 b=VSfz0n9nJ2lR6P4G1ocNVOqrsqdiqSq5veHYoIkdL2cPgyxU3+U9LcU9Zkt/L/espf
 NmwSsO4+O135IPaW1U4SpRbUoVTI6czXTZTUQVOfP4GB6t9DP51zByHNa3ErVrq6PdQX
 vhvq0g4vS1ppV6+ekIZN/hh4KMwYNcbvxHa4fY5rwjDS25nFDqBqYQNIxVq2N+qkdI5P
 tOm7zxWSH0otzyH/4jZINtMt3bMcfFxWkRewzcq0hIZY65SE1OIMXyyLfG6ujnRWmYHB
 uo8WBsGjShsN2CT5NZo9aXr/G162d6Vf+fOdGvQ5whNcumFtjtuA8KUq/+ekNeiJMXPM
 AbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=hi3AFMxd4lntnLY/VQnmQFojrvZ1/71m51waZccMBqI=;
 b=ZOmPt6Q5H0xRKoc+j9hXcB8vZdtC0ZwsJCCeZvzHJ+tWvgEwr6izn88XTh7r6usGCb
 0l0QNQo0FGOMvDGGp4dG8Nvjrt7GHGRdVIrvyRBXq/hVcZhgd86uGh0cAglo9Yu9O1M+
 9g2O4P+8TnHsULtYjl2rffzXCNeiPrvdsZBpZ+bMJeiN9kX2VFopIwzYy8ijQj5efxHk
 egkf+Ckj4iUyVDCia7nYboavSKIBujdUd7Eg7avIXM66CEKGMl9S+1fTKg7FQbuBvrqP
 iJkzz9Fk7E7uD/oKKf1qc/8meQ5/c6TwP93ykOIAqH0SEkxZ5aH3tNOZDfyU8B77/Qhc
 Z/uQ==
X-Gm-Message-State: AOAM531lFaZD+CQMxREkt7eeJQzbPSqZK6ZZBhPN03hyGmhG7qlNFvlE
 6xf7QSei2aipdTPemsE8MUNJwZx5XVWr9sU=
X-Google-Smtp-Source: ABdhPJxBsxbpOMmVxsT/oTTD7ilgxR9LQI/XCGpqtElVe+HELVc1DLqgy7IThzRYQurYCsg7OyK4RdKoUJkOazA=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:8573:aa64:c3e8:ebc])
 (user=tansuresh job=sendgmr) by 2002:a5b:a0c:0:b0:633:6489:7e3a with SMTP id
 k12-20020a5b0a0c000000b0063364897e3amr28515611ybq.71.1649803446833; Tue, 12
 Apr 2022 15:44:06 -0700 (PDT)
Date: Tue, 12 Apr 2022 15:43:47 -0700
In-Reply-To: <20220412224348.1038613-2-tansuresh@google.com>
Message-Id: <20220412224348.1038613-3-tansuresh@google.com>
Mime-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 2/3] PCI: Support asynchronous shutdown
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_154410_642016_68CE529E 
X-CRM114-Status: GOOD (  21.09  )
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
 drivers/pci/pci-driver.c | 20 ++++++++++++++++----
 include/linux/pci.h      |  4 ++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4ceeb75fc899..63f49a8dff8e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -501,16 +501,28 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_async_shutdown_start(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->async_shutdown_start)
+		drv->async_shutdown_start(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+}
+
+static void pci_device_async_shutdown_end(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->async_shutdown_end)
+		drv->async_shutdown_end(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
@@ -521,7 +533,6 @@ static void pci_device_shutdown(struct device *dev)
 	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
 }
-
 #ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume. */
@@ -1625,7 +1636,8 @@ struct bus_type pci_bus_type = {
 	.uevent		= pci_uevent,
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
-	.shutdown	= pci_device_shutdown,
+	.async_shutdown_start	= pci_device_async_shutdown_start,
+	.async_shutdown_end	= pci_device_async_shutdown_end,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b957eeb89c7a..bbdf7d52e87b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -881,6 +881,8 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @async_shutdown_start:	This starts the asynchronous shutdown
+ * @async_shutdown_end:	This completes the started asynchronous shutdown
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
@@ -905,6 +907,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*async_shutdown_start)(struct pci_dev *dev);
+	void (*async_shutdown_end)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.36.0.rc0.470.gd361397f0d-goog


