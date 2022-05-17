Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7B1C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zm0DqW+BoHKP/acD7zIvmyyRPadAhJ70kej4mteuoVA=; b=lgTb7TyqiMdop2bEgCJbd3Asso
	6GkVMbhTT78633gXm/fVUa8YXb+xKwaQT9duB+Bk7faKl2s8QS+cpLaVcRVdsR5vekexfxgcgytry
	ZEAdfrr8iFQRMTYntL4Ct6DmvXgY/FxJ482WdUEPYR3CPrP9FjmGrKME1a6XBpoG7KxW0byt/kbLq
	H/IdmuGDFqaqPiA6j7t+8mVOlfegNU4LDDM0lpzotlw8HspC2YCOBb92zahFjquND6CyjcWBp551q
	XBr+0ymHYBnuVLJKHc2X7FwnKAXxsBct9Q7NWtbue5qE+XnbmpENU6+vDPM4/ZJqbv4HQLQBQ4mkT
	oc25lO3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr5Mq-00G2Vm-CT; Tue, 17 May 2022 22:08:36 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr5Mm-00G2TV-Fx
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:08:33 +0000
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2ff40ee8109so2369907b3.14
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zm0DqW+BoHKP/acD7zIvmyyRPadAhJ70kej4mteuoVA=;
 b=AsNbs7wnDoomcBDBtfoCOElE6jNniS5QhqV6pIza4jl4lpHIHoIYTtS9hAoHBuc1P5
 Lai81UoqAapTGV+EhVeBkb9ifvYs4rS3/UM04qTmqwbuktXpET6Zr8lur6zjXKSJaDYw
 JrAu/bjtVVQCKzKgvkPerJoZcyc/wAI3pKA7B3S2FvC6tHkHMFB33Y8FGIKJVRhU9Fvq
 VXoLxEyN6Zuu+gbZk8aUKRbh2CbfJd5zJjM4WNL+YDervkJkXdgRDNW82FG9uJVWj1US
 bI3ndM7Dlh7Tc/WbUDlpdK80LuSSQuPZmwdVDBcPS5Xq1OQBpuUWpp81khbnmmAAbegu
 xmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zm0DqW+BoHKP/acD7zIvmyyRPadAhJ70kej4mteuoVA=;
 b=6NkGbk+QcnRcC3ZGi3DCS25VE2AniYRy9t6jWDnZiG7upTc/CRTATIMfnn5AzCU6BT
 J8B/ieD7LsbA/R5lanuuIvCzdVA3VD17jcGX5B2rh2C4jRvpOiBJfDRTj2leU/x+kzov
 Q8VDfOvm7rKY1I95GdJ5AoZUsHbA/P0nNqCADAICpwBP1bB4riIDOnZ2IfKNy9UidMtc
 ILQ+TlUBEeCUfxkw1BKsddX8FCSMIiyWgpWUvJWMdYW9hi7QchqZLNeWh4FVb8FczLOR
 RWUaz06ZNOHxsX8H5xF5v1Isl0iAjwZxzzmQ0C71n8uemuKB6yc/giL8m7EE/zedPAFw
 tngQ==
X-Gm-Message-State: AOAM532juUA4C3/U24UbO0XlO2ufLTRL7oASzlpK6lBTKIBHnogUsK5D
 Io7ihYqhssmMz/BzLQ2pj1VOAMtcdhHShqI=
X-Google-Smtp-Source: ABdhPJzdJAzeV7gm8AS0Ny+YavQ8JOhwxUevF3poLXIh2oE3WhHG+lRupAn6BASD11L0wQDazBgiZye60KwAhw4=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a5b:481:0:b0:649:d872:d521 with SMTP id
 n1-20020a5b0481000000b00649d872d521mr24676650ybp.73.1652825311407; Tue, 17
 May 2022 15:08:31 -0700 (PDT)
Date: Tue, 17 May 2022 15:08:15 -0700
In-Reply-To: <20220517220816.1635044-2-tansuresh@google.com>
Message-Id: <20220517220816.1635044-3-tansuresh@google.com>
Mime-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com>
 <20220517220816.1635044-2-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/3] PCI: Support asynchronous shutdown
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_150832_568972_C439445C 
X-CRM114-Status: GOOD (  20.63  )
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
index 60adf42460ab..ef5500c18fed 100644
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
2.36.0.550.gb090851708-goog


