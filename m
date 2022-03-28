Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D98C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjCJgoS657I/tk8eQdlHI01Sy2nbJ1vs0eOca3BDeMA=; b=vQNiaHGWFOv8Z/FsjuDmP1mQrw
	Lcjt7w8BxBQrKlUb1Nl9I9xYwzMTMWqKmkRyBCzVge/P9AEww1HyPOpVz+TqCe0C13rh/C0o8TzB2
	N0RYjlGC1x4mb8D5b7fFQQgEkB4+rdk/1N/AMYa29sh4CRSoDI7GodbUOTsBC6NF9szSTg+Hv6L5D
	/5rqFLREAtLoIUTJ+5RzTopejubKUUe4jCh1dhGG0/3FDwxn0hp+C5JX9pSV6nUPiN5ApB3k+aEP/
	orBom+W1+uR8sCUy2bvArlykKK27VilRKHtEig31oCVfXUax4RfJj5bzY84zFHY8R33GlVcZMnaiA
	Sjg978CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYyLe-00AO8s-6X; Mon, 28 Mar 2022 23:00:30 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYyLY-00AO6H-Hl
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 23:00:25 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id
 y193-20020a25dcca000000b00636d788e549so10951788ybe.5
 for <linux-nvme@lists.infradead.org>; Mon, 28 Mar 2022 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=PjCJgoS657I/tk8eQdlHI01Sy2nbJ1vs0eOca3BDeMA=;
 b=YrW1oHI6OeNS97qb0yJLiWsmS/O0yisj3J+4OLHulXFrVW++E6+RYQOIE9kRM8gvPl
 nYVOVSMnQ38vUWHmvPhbD7Di+LW8cxAlhFJk6rylh8ho4c7W6RbVgiqFR3kqbUGal79N
 AnGraxxjbZ/qEIuvv/3hskPbqVzITszKNTauorm3U5A10LAz33yyLW+qRHr39PSjgZEc
 gFxP0vIK4JjSTg72HAxnLs1TerTNewB0WjKzK2tZmdEGrsphjP+GpJ/8nRfVGtQ6/6oh
 8DnJjPZ35lUPzzKkyIyhHXn9zk+j+m6UjTXpgJYAHJ8LEDsxYZSRsjbEB7hd4MEVv7fE
 U7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=PjCJgoS657I/tk8eQdlHI01Sy2nbJ1vs0eOca3BDeMA=;
 b=58cJ/9JLRt3YTt0pexpK5ROrv81GQTPjgcwFbKDdZfL/HtqvSz54obAFQJrXREb6tH
 3qtrzWyIH1H7WuoDIcLgspLDFG/OCbUNncYyk7DtWArLM1Aup7eLO+uS0oXajUqGxP/D
 ZpXIGNwBtXgkee1H4LHLHq0ZsksiWb50mtPFumd0V3h7+xvxY43hvJeBVbPjIx4j9FoX
 NaQPlTDRV39zvUWb92s1eex1X17DvoqWSexXC3i+W5ixWqg6vNSTFBrbd2bvsN5JJ7Tm
 63oQ54PsGKnwbJFNk1/7TwvjiV+TNNSZFg5X8L6m6j0nFX7MIiwisXg7/5zsPbm5kfwn
 9wpg==
X-Gm-Message-State: AOAM532Og+8E97lMs/Sh4YBlTPfZ67g91S4jn+YRwmXRVuNUQ5XyaPjZ
 8jVjCMc7es3cPT/27DCJlq4NxBHCukwdQeY=
X-Google-Smtp-Source: ABdhPJzCP0I8+FlderVfuOTtetUSRQ7p5Ej5WF/C0Zw2u46sRNYBzp8kbYF//zgxfxG0NFdnd84urn2FfzqAcr0=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:3dbb:6bbc:98be:a31e])
 (user=tansuresh job=sendgmr) by 2002:a81:c02:0:b0:2e5:b6af:2c8 with SMTP id
 2-20020a810c02000000b002e5b6af02c8mr29031195ywm.190.1648508422372; Mon, 28
 Mar 2022 16:00:22 -0700 (PDT)
Date: Mon, 28 Mar 2022 16:00:07 -0700
In-Reply-To: <20220328230008.3587975-2-tansuresh@google.com>
Message-Id: <20220328230008.3587975-3-tansuresh@google.com>
Mime-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com>
 <20220328230008.3587975-2-tansuresh@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v1 2/3] PCI: Support asynchronous shutdown
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_160024_617430_0F2344F5 
X-CRM114-Status: GOOD (  17.28  )
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
 drivers/pci/pci-driver.c | 17 ++++++++++++++---
 include/linux/pci.h      |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4ceeb75fc899..0d0b46d71e88 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -501,14 +501,16 @@ static void pci_device_remove(struct device *dev)
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
@@ -522,6 +524,14 @@ static void pci_device_shutdown(struct device *dev)
 		pci_clear_master(pci_dev);
 }
 
+static void pci_device_shutdown_post(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->shutdown_post)
+		drv->shutdown_post(pci_dev);
+}
 #ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume. */
@@ -1625,7 +1635,8 @@ struct bus_type pci_bus_type = {
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
index b957eeb89c7a..19047fcb3c8a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -905,6 +905,8 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*shutdown_pre)(struct pci_dev *dev);
+	void (*shutdown_post)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.35.1.1021.g381101b075-goog


