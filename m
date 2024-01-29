Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40233C47DDB
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rraRGlpHPgCU7YZH5s53wZIDBHgJRksals5IRVQ++OU=; b=GO1/tVzgSOcuLNd+ssZ7o/3ClU
	WZQy5/qc+tLIHag1ekWQNCc19alzmh7TqUNV7RRlXwN1kEjYEpeKqZK/pGvVqlmUgNxNyewQYzs3j
	3fob3hwvMCIKYwOX72uns5Jt0umuFD5cQz/fe6mzB4+Z8T/g5ExUj7WpOI5GdfF9bpvVp3vjpn4LO
	bPsM1qyH2PY+lUYBwibnlYjoXV/BFqG2h0+XVUxExb5C99LNZJgTPyf9vhWjZOUSj6xq4YZQy5iwY
	ndehxE4cBPp5hyq1/QtY1XvHyD5AeKq3lPo2/zBrRvZa+qm+NfSmGSLnjbHplvs3VAH4W5agMh60t
	35gBRozg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEm-0000000DuRc-3SNe;
	Mon, 29 Jan 2024 18:20:04 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEk-0000000DuQH-0JVU
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 18:20:03 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so1436651b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1706552401; x=1707157201; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rraRGlpHPgCU7YZH5s53wZIDBHgJRksals5IRVQ++OU=;
        b=H8e7bCe/lOeknz1O9PGcaFnG03duIRUHpU0pgw4S8P42LQ1milFYYKcSe7m7O3rWwm
         OT4jzFKuUWULjWMyNwjN62s8YRB0nuEnQMUtaUbOqJxQudSKErJAmx9ar4xJ6NyS6wiK
         WIZ47WGNWxBeK4HbvrfbTqalkd8neb/zpNptseTm5HWZkcfcmuYqVwgm6mkjhaUeBnKR
         O2D2v8LE3b/H2okW6zAMusGPowg0KsrBJEyT37N9LQLC1uzQ0wEhYz33fCIbkJiBgRDF
         VOs9LwNE690BOEGILnSfSMcQXBr4pdx2/esaCauiZHiP4UgZEGzxwdgVX6ytqe1eSewF
         /NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552401; x=1707157201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rraRGlpHPgCU7YZH5s53wZIDBHgJRksals5IRVQ++OU=;
        b=LwwMrdGMORHMT/v7HfEjXKJIb5eKfnmS/MVt145piloiqYTkBmqnQ+UGIotmS+tkTE
         75T3egi0nn3d0wJ9Axv3Snr7TNYkSRSsvUdI/ndBDC7fvcCOmfJ0P8Fx+bHPVZ73swdc
         7rB7PFa8DNyM70GWPvkSGNzQZFi65NV6FY8/5yjhVTYRzpgVMNP2wqYvsliGiI7jxRka
         Nc359PCFEEt54XJMXNvprC95gHvx7n1/u6PVZZmg//hFKSRrlTjUPqfiisuvJqVaBCsT
         S+BxRReTVRZgoeWFC40lkb2hBqLuFrgQWr8E4+6R3Pn3mbOiV0Vit+phojp6rle1UVek
         X0Lw==
X-Gm-Message-State: AOJu0Yym150q74Bd2GL5g0DG1MK147lBRoS8WfWcLTluc+fBdyncZveM
	bpjuuFYJGKeLRlBPr7WNPn7x5N6/aNptJmpiCvvTBlF3Vvsu8YmQblMtWUAv0+s=
X-Google-Smtp-Source: AGHT+IFoAHkNfcMwJQOskCosMcHpgZRf8YKv6QCF1G7eFrWf7hEaoNHz1O1RPwfAgDn1j0uEOUMZMw==
X-Received: by 2002:a05:6a00:4b4f:b0:6da:bed1:c8b with SMTP id kr15-20020a056a004b4f00b006dabed10c8bmr7727644pfb.20.1706552401303;
        Mon, 29 Jan 2024 10:20:01 -0800 (PST)
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm6617750pgb.50.2024.01.29.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:20:01 -0800 (PST)
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
Date: Mon, 29 Jan 2024 10:19:50 -0800
Message-Id: <20240129181953.1183084-3-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129181953.1183084-1-jallison@ciq.com>
References: <20240129181953.1183084-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_102002_145752_33C0148B 
X-CRM114-Status: GOOD (  19.10  )
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

Enhance the base PCI driver to add support for two-pass
shutdown. Add shutdown_wait() method.

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
index add9368e6314..5ef014ac84f2 100644
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
@@ -947,6 +948,7 @@ struct pci_driver {
 	int  (*suspend)(struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
+	void (*shutdown_wait)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
-- 
2.39.3


