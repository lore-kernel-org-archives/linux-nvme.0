Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD98C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 21:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMBmRDOTC7EfkvYiwpvQuhn9OJIipU39+Dy3Tg5EG9Q=; b=nOxxj802R8abvfBYh2KPLdgEIl
	0LVfSHiZmiZVSIdbJhSJDHXjqvZ60P4T3zmiZodrCAaR71D6cKBLGEEXxU4sfgvX0Y8Hj6RiA9Jty
	wR0wQOhheweY0lGYkv+HnGXGnUwMzCwqsBYxyac2b/WNY9ecJMra2WmzxQ9x26bqsFLinf/P9XJO0
	Udr5U8X7LT6KPzbqikyxjYIHIIC+SFZ1M7MymIcotoXgsdx6sUExN7CDd3ORVKM/lBHxDrXecbQ/v
	En4YY3MqJae2I4K8zkYEhNDL5V9omR9jNTk+6WBPQdJbiA7auMOwTRwNuEl8Th+dPW+IN/l2Qjtx4
	v1chYWlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PU-00C6oM-2C;
	Wed, 03 Jan 2024 21:04:20 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PQ-00C6mh-2P
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 21:04:18 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6d77c6437f0so3666379b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 13:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1704315855; x=1704920655; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMBmRDOTC7EfkvYiwpvQuhn9OJIipU39+Dy3Tg5EG9Q=;
        b=Fr1i1b8ORrhpgELoS6VJ3G8ENDPnRKUUWfPa/cHuzI5/2IZfsSF58KJrVu1c4VYbUz
         vefJGgqeEGXLfz/9V6DMl+yzVDCAmrTErykaJVUrP7+SpXTlzvBRBB7oGTh6umIUYmq+
         ZnF8eiblzthPbZWSPFurv0hBkvhAYqtVe2o/aG+nmi1biGEj9gkxQjwmR6eOLUtBCjuE
         g6C63KRvSLgwcuU7Bchtv2iM0cHjskG7py4h7f/jFr9ariZAVeuRo1Mi9zuSQadnijCV
         lqBWcY3ftahLYImjr8aZJryustPfOoXgHWV8mbR2QPLIYMzpfPRWKkhIlc0dpyb07fXl
         tg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315855; x=1704920655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMBmRDOTC7EfkvYiwpvQuhn9OJIipU39+Dy3Tg5EG9Q=;
        b=UD+4r5vI2U75UHgRajFcbPTpvRZDSpK07wakGsSsnJe5sJ/DOZTffdc1r13tF455mk
         WNQlBBPE9kf61wvZ5CBVorFQtiF5FVGSCUh0L006gpg6juYMyNAku5i0W6e007sAKzH7
         luwqPrFZHUEiTDMVfDHV9I8pp2JILE3FDf2iEmRwFehL5ZuK0UD6w4y7yTFURsp+o/iE
         LqJbV7qvqFKesWpKlCboP+ZtsCyvaakiheYS2O97EAkh/MLak7CsXyprzXoE15SMb5dk
         xjd1IGqxRBrG91KsCt0HU5Xz9U+I512m/JvJRFu0vuzyMQKdmOajtIO4oaTWsIcApyuE
         zJ0A==
X-Gm-Message-State: AOJu0Yx0B//ezSf+dPaHC/kOwcOBgRf5qGbZSHfaZx1T+GyvuuMXg5Qm
	UxxSOrLrUI2PT9Gy+f9s6qpvnetRo4xa/w==
X-Google-Smtp-Source: AGHT+IGmjS9PVpw6kx8Zas5H+RXdQnoduHQ3156Qk6PQ2Sj21utdkPGHfDCStDIl5EkaJ33cYujsiw==
X-Received: by 2002:a17:902:ced2:b0:1d0:98d8:955c with SMTP id d18-20020a170902ced200b001d098d8955cmr9318993plg.124.1704315855605;
        Wed, 03 Jan 2024 13:04:15 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d414a00fd9sm22505837plb.29.2024.01.03.13.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 13:04:15 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/5] PCI: Support two-pass shutdown
Date: Wed,  3 Jan 2024 13:04:02 -0800
Message-Id: <20240103210405.3593499-3-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103210405.3593499-1-jallison@ciq.com>
References: <20240103210405.3593499-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_130416_785143_4E640244 
X-CRM114-Status: GOOD (  18.91  )
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

Enhances the base PCI driver to add support for two-pass
shutdown. Adds shutdown_wait() method.

Assume a device takes n secs to shutdown. If a machine has been
populated with M such devices, the total time spent in shutting down
all the devices will be M * n secs if the shutdown is done
synchronously. For example, if NVMe PCI Controllers take 5 secs
to shutdown and if there are 16 such NVMe controllers in a system,
system will spend a total of 80 secs to shutdown all
NVMe devices in that system.

In order to speed up the shutdown time, a two-pass interface to
shutdown has been implemented. The caller calls the shutdown method
for each device in turn to allow a shutdown request to be sent,
then the caller walks the list of devices and calls shutdown_wait()
to synchronously wait for the shutdown to complete.

In the NVMe case above, all 16 devices will process the shutdown
in parallel taking the total time to shutdown down to the time
for one NVMe PCI Controller to shut down.

This will significantly reduce the machine reboot time.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/pci/pci-driver.c | 9 +++++++++
 include/linux/pci.h      | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..257bbb04c806 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -547,6 +547,14 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static void pci_device_shutdown_wait(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->shutdown_wait)
+		drv->shutdown_wait(pci_dev);
+}
 #ifdef CONFIG_PM
 
 /* Auxiliary functions used for system resume and run-time resume */
@@ -1682,6 +1690,7 @@ struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.shutdown	= pci_device_shutdown,
+	.shutdown_wait	= pci_device_shutdown_wait,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..e3ba7043c7de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -917,6 +917,7 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @shutdown_wait: Optional driver callback to allow two-pass shutdown.
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
@@ -948,6 +949,7 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*shutdown_wait)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.39.3


