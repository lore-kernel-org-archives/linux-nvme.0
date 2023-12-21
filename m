Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF52C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMBmRDOTC7EfkvYiwpvQuhn9OJIipU39+Dy3Tg5EG9Q=; b=hF7vIfpZZt78fA+1b3FtWIIlcG
	OqGohpUfy9Guq3VF4oliQG+Urn8v1TXq8j7CXsJ5s/rGsEWbauy8uDBcZrVzxL6DYqn7zIEFYuLkM
	xYhppLUbbcBqO1v+Ly96cmQxVKrbjwDDiqF9Mt+BMGBzo3/7yrmrje4wPbA+c8EK30n5F+ya42sGd
	RrkzhmC4W91qaTE3+zXcEJTsCD5mU6eiuBOSfpVSQavNsdJtqjEp9y1nQ+1KNODv7YXxU2IYZoG5c
	9/pfPQwGcm+TxAe3r0siEAxV6t+yyA5sZYUUDpsolHoH64oteVUzUQlv72lIJnjNvodRqeTz5wr06
	/Pb8N2yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlR-003dkt-0U;
	Thu, 21 Dec 2023 17:23:17 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlM-003dh7-25
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:23:14 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6d93278bfbeso654496b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1703179390; x=1703784190; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMBmRDOTC7EfkvYiwpvQuhn9OJIipU39+Dy3Tg5EG9Q=;
        b=PAOkfIcDbhcUnTuPR6LXtLI+aKnjbRIOo5CYOWWIXqJKgu5HqAS3pchi9EOa6hBbVm
         THPfFT8rVIBA2qCSn2zJRFC6LWelsOaew/BQlOZESARgwrrXa4VWyQsDVEI40Cm3ylgW
         W9tUeie+H9+aC8l069ef+Tpfpij9hMAoafObhrTOqeJkeJv7mOPS4Rwbk3V37UpsDY/u
         i9SbDZFNjLu/a7SPSZk4gq3Y6eaz8brlS3bN9b6f0Q3d57Zk5V7dV7meW3mM8KZAi0i6
         YUHU1ckA0ymWDhvKi2xSEV22PlMELJBpMP28oaz1b0kLxnC4bpzvbZvbmIkSAjlN1mcw
         /ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179390; x=1703784190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMBmRDOTC7EfkvYiwpvQuhn9OJIipU39+Dy3Tg5EG9Q=;
        b=rmL9kjCGO5JONIbDCFKyPo78N6XpPWq5CSHIU1piFdP5cgnZKL+qfZ+nqDJRRpVQ8N
         LvEUd9+w36uN60vE4CzRLwPQ41MlVKTEI6DvSDJSy62nEwOzeBO75b/F3DIaq/KwKLVu
         hwKF/XfJL0qRt/BzApJG/gkkQlTuWKaW9DZ4rz9yB1jMy3BZVvQY7keBHeW5GoecJ07n
         wuJdhOMA1qYcWfgvu+zXeU9J2X8VevW3T5m/YYLw3WDF0bO6G1iW/KYYXPLTiUv9TWaI
         4DauTGbAh/dtEX/031ZoOxfkOYeZ9djLSzC47xK38Z2fDV9/gqq7ooCRQl1jo3UnUQlv
         baOA==
X-Gm-Message-State: AOJu0YyrV9FkJG8EEV53bwq6hqmCENeGFmOVdz5ysSN6Wn4BHRf/LnKb
	4r04yUoVxuU8ho/sX7LFcKRpy6fR+JnBPg==
X-Google-Smtp-Source: AGHT+IGd8WVw55r7GkMgS2jEGJ3WyLiavxkzxjp9D9ogNxESlp3eKVcEpmKC6Xb5c2xUb7QrbjlWkg==
X-Received: by 2002:aa7:8515:0:b0:6d9:5b79:c72f with SMTP id v21-20020aa78515000000b006d95b79c72fmr3059pfn.29.1703179390567;
        Thu, 21 Dec 2023 09:23:10 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id t67-20020a625f46000000b006d6b91c6eb6sm1990744pfb.13.2023.12.21.09.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:23:10 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] PCI: Support two-pass shutdown
Date: Thu, 21 Dec 2023 09:22:55 -0800
Message-Id: <20231221172257.2234320-3-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231221172257.2234320-1-jallison@ciq.com>
References: <20231221172257.2234320-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092312_682154_683B7C89 
X-CRM114-Status: GOOD (  18.62  )
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


