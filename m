Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB1C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZu9R5AP7G7mXZxp2v5lobHZ9+CJp984UQPj7WFuo5c=; b=gsWQhZdy6qiBkpQe7IZx1uRIAa
	CQbqAt8bazExC8Ewk5tqI/Iyurlyfz4HIpiGceOPdmMnCKbAKmm6ajRq5vSwiqItz5JFZJiUOvffA
	ZpZ7HHVv/8edxWwAIaWaMEVa3u4Gttx42Z+qIKhTxnaxC/87xpKkPW9qiGLAWDZgYFWghTK0RZdQW
	qGWTCafK91fNM1Qp+V9SEjzQvwTNZ4Y0f8j5WDCqiRbRODoYwLoZSSR+FVvIfeAYzOLqUkiersL/E
	A6cwL7rHRhlAaRr3ZELxItyhCD1wgFuYMNZTymmmTbpPgAKpwGUjDYSoXRz/eHFJVvosqq8fw2lod
	vP5laqwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvgc-001bCd-0R;
	Fri, 15 Dec 2023 00:04:14 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvgZ-001bAl-2G
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 00:04:13 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so963601b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 Dec 2023 16:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702598649; x=1703203449; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZu9R5AP7G7mXZxp2v5lobHZ9+CJp984UQPj7WFuo5c=;
        b=mY1D9VT19v654gvrIA5at/I/Z7IE/hJ6L2e7LO3ufU73HFouecg0pD5d8934LqGiTh
         rX0xS7EZOayCy8HqZ+xu4S6j4AoAVZSvmYKWkmKIHOdQ5RPf+nNU73Xk8HrSLPMqXGyZ
         64I8M/qII6rl5CW9WtbVE0qJYQr0TpgxYuiUZmSG9gqBsbiYGBEF7RIs3V2BGFd/lSBN
         jf7yduSSMJz3EfcqMo9acbfMj0Jw6tNCcENDLS2LlhBoNUCgG+1MC1tjNv/UTOzA6cUn
         B1BXXD1SMVZgSLIt1uj2b9+3VlUwcS9DnoGZL61lu9TC4KKCDdcYeObhCqO/Ge0dWjnE
         qYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598649; x=1703203449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZu9R5AP7G7mXZxp2v5lobHZ9+CJp984UQPj7WFuo5c=;
        b=dIy/o2WH/4YWFrXF0gwpZ2qoWdp0n+31rcy9tB8aZXCEmDNGreifCoWDKefJPpdujW
         9mPT1XyPCE15dGb6U26fP3e8rzgu6kzf3BSgwpKOLGJMrrZdfSibEN0kejJJzHZhdLzb
         Yrwlro2Kgrpr7HwuM+qkJum6X6EgzzR6zomZjpSUj/AO7/bI0PWZMA0y1Z8/BCm1/gks
         O50D+i5fXvXb3Vbwy5WO8LDhu9X9NDIX0zwCW0YeEZNH8mDbJIGYcZLSB/jBar89JmHJ
         dKwcSgkZo0Tf8L6TnEdls5ro681zUg0LYt/Bx5FweT9hBHFfUxqYeZ/VoG22BaOREKpn
         fzNw==
X-Gm-Message-State: AOJu0YxO3fRyFMSIA3mUM+GmG2itP0oXJI7egDEV9T/basORqGXUs4E5
	E75/X3NEmyRpF3kjk2qxtaZKzQ==
X-Google-Smtp-Source: AGHT+IGm4MLQU8SqYcS9bqQ2zTfbqpw03xXVmbxBCY/ppn0rND1u1nd1GjFA6LhqNtJsQtq3+BT29g==
X-Received: by 2002:a05:6a20:7d89:b0:190:4b78:99b1 with SMTP id v9-20020a056a207d8900b001904b7899b1mr15392015pzj.42.1702598648703;
        Thu, 14 Dec 2023 16:04:08 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b006ce7e497302sm12208524pfi.21.2023.12.14.16.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:04:08 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Subject: [PATCH 2/3] PCI: Support asynchronous shutdown
Date: Thu, 14 Dec 2023 16:03:57 -0800
Message-Id: <20231215000358.1203338-3-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231215000358.1203338-1-jallison@ciq.com>
References: <20231215000358.1203338-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_160411_740994_DA7B27EA 
X-CRM114-Status: GOOD (  18.09  )
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
shutdown. Adds shutdown_pre/shutdown_post callbacks only
called in preference to shutdown if both are defined.

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
Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/pci/pci-driver.c | 18 +++++++++++++++---
 include/linux/pci.h      |  6 ++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51ec9e7e784f..865316e5236b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -502,14 +502,17 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
-static void pci_device_shutdown(struct device *dev)
+static void pci_device_shutdown_pre(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	/* Only call shutdown_pre if shutdown_post is also defined. */
+	if (drv && drv->shutdown_pre && drv->shutdown_post)
+		drv->shutdown_pre(pci_dev);
+	else if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
 	/*
@@ -547,6 +550,14 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
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
@@ -1681,7 +1692,8 @@ struct bus_type pci_bus_type = {
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
index 60ca768bc867..a25d1a3a3764 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -917,6 +917,10 @@ struct module;
  *		Useful for enabling wake-on-lan (NIC) or changing
  *		the power state of a device before reboot.
  *		e.g. drivers/net/e100.c.
+ * @shutdown_pre: Optional driver callback to allow asynchronous
+ *              shutdown request. Called instead of shutdown only
+ *              if shutdown_post is also defined.
+ * @shutdown_post: Matching driver callback to shutdown_pre.
  * @sriov_configure: Optional driver callback to allow configuration of
  *		number of VFs to enable via sysfs "sriov_numvfs" file.
  * @sriov_set_msix_vec_count: PF Driver callback to change number of MSI-X
@@ -948,6 +952,8 @@ struct pci_driver {
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


