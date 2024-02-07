Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4714DC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyEUnmLj0vZRVoGwF1S1ttLeomdPyAfwudPCitGFRhg=; b=bVDC5o4bwHsE9I/UOEZjcmskrw
	+edO6W2MFuG8u1+egxcgApi9IuPuUk03mhaz30D10rfaXsnYkEMjXR2cXc/fi0w1YwFXeaIZeecdO
	PopTNWvwsg55NVSly4eN2yW/tPXoVIE8x2EwGa6jE+37pxyPPziVxr0BKWpjWxE/AaqXGFngjR/f5
	+XuhtTx0sH8YEBezc7G9ZPEKNMoPrPZydtsJz/aZubL5x2+ygA0Zz8uKQR1ZmN7krE5fhhhU/cHlv
	/5+6EbuQAAQfxyubgsWxcwY68/fQNeFwBZ5UoTEnW+TLFHiS9SPaPrWq/BmNOVeW9KzgHcrkAx8XT
	r9Fd2pIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf7-0000000Bx88-3e9Q;
	Wed, 07 Feb 2024 21:40:57 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf3-0000000Bx4p-0Kzb
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:40:54 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d953fa3286so9858335ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707342051; x=1707946851; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyEUnmLj0vZRVoGwF1S1ttLeomdPyAfwudPCitGFRhg=;
        b=p6VahXsAG+fq3YHvvEEgr5wmBGcIcuh2dzrX03HkJHahh7ABymxuDEqG92uwZGswnq
         k/8HlklCqERSIkotzr9ZlJkDPQydOktBiQPw6sgC4E+BgkoXD5x43B2QtUO93nMukA+p
         cimiXi4HgmTV2UtuokhgPuv6Mo5e416gedeFvYl7PoaimZj8DX0J5dSIdKdZvCP5Tx6t
         tTshV0vp0n3oH56eFlkKDP+WlVDlWjP97AB0iP3iqOHEv9ixJww6O/Kgvns3lVEF/HOY
         19r5kzmMtXFNuxPu/Zk1VJx09C9/UutYhxgSpqq6PXGPHFNqwhqXU0EF2hHsYDBtqz52
         58yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342051; x=1707946851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyEUnmLj0vZRVoGwF1S1ttLeomdPyAfwudPCitGFRhg=;
        b=UCHjIE/OnsOP8FvFLBMXbLmlSunoyWg39mWqMqK43jqUzijpGLfybQvmJ17uwfrv8t
         /Y/K8mAZsMc4HgF8JZ/MrOMRTQkgknol626zkCOD1sX/NlMu3MIe798Bf/isU3MFlVQE
         SDDPYxYqUIY7dhFOst0/vwoOj9xhArS0wKhrAvmuHp8nF3jaJ8s+oP2NusmmQMsCTwF1
         QpryTlKqHrEBf4TCbr2v631eHJA7NjZ/wkmCWCfdSev418BLONBTFxUG8L/DGQSsz4Dp
         F7zNTE9osgJ+VP3FPx33cyQytsyh+wmJ5HU/NMsLefxW17MXaziZ6HyALEZNc0PnemVQ
         r20w==
X-Gm-Message-State: AOJu0Yw+SQigT62d+o80/kLLVMmMbvay5cb0Y/0tdIzUU7nYi+/I3n2e
	yg00HqSNIqEZdKT8GBOWJvltgCyjhtBbNV92XRlMbrUvNK9o/aJXd9l4XvtKF666MY9tZZcgbxL
	Z
X-Google-Smtp-Source: AGHT+IF0qY3kmtoTM6XSAsKEJMrKkDoShDNMOJ5iIHwYMX9ZFQ0OSB5efuqrwesNXNvD3XgA72VDOA==
X-Received: by 2002:a17:902:cec7:b0:1d8:ae30:eddd with SMTP id d7-20020a170902cec700b001d8ae30edddmr7989119plg.23.1707342051347;
        Wed, 07 Feb 2024 13:40:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwnXLV/Bi1exnTaHuTgvtIzSi756Ntp9paYpTas47eSy7e0huYlfVJ1OkjND6u2Xzp6mK61foqa826MdKcx3PQcwPRKPymNVkePyBWVsiU8JiesXtOz++V25EAKiWOIV6f5VwCIBxo1SidrJpgU2i5HEkK0lH4aKDzVFKEot9EAT03L3vHLwbjTTFsJolpQkMAAeSuP9xmp+wWdU99zMH2im+VkELIcuTf8HOlKjEExzd6RwHRJlaG3mILeJBihDig+ZrYtEwwnjf2
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id ml7-20020a17090334c700b001d7274cbd33sm1939005plb.121.2024.02.07.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:51 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me,
	djeffery@redhat.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/5] PCI: Support two-pass shutdown
Date: Wed,  7 Feb 2024 13:40:41 -0800
Message-Id: <20240207214044.2374295-3-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207214044.2374295-1-jallison@ciq.com>
References: <20240207214044.2374295-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_134053_148882_DD818CBD 
X-CRM114-Status: GOOD (  19.26  )
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

Enhance the base PCI driver to add support for two-pass shutdown. Add
shutdown_wait() method.

Assume a device takes n secs to shutdown. If a machine has been populated
with M such devices, the total time spent in shutting down all the devices
will be M * n secs if the shutdown is done synchronously. For example, if
NVMe PCI Controllers take 5 secs to shutdown and if there are 16 such NVMe
controllers in a system, system will spend a total of 80 secs to shutdown
all NVMe devices in that system.

In order to speed up the shutdown time, a two-pass interface to shutdown
has been implemented. The caller calls the shutdown method for each device
in turn to allow a shutdown request to be sent, then the caller walks the
list of devices and calls shutdown_wait() to synchronously wait for the
shutdown to complete.

In the NVMe case above, all 16 devices will process the shutdown in
parallel taking the total time to shutdown down to the time for one NVMe
PCI Controller to shut down.

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


