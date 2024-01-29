Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431A1C48285
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hweC0yGkUBskdfzYZ5VPbAI3FjUrfkbQmkkuVMgbP0Q=; b=I+QggcYq9fZu8yYkf/GggjTDf9
	LBsyGI1/1WbpfnOvjWN0AlS6x94OMyKBdhMRLXVFpYkA9L+ovMX2+UggV6dzAOBfk7i1r/6CMpNoV
	Cvxosjq5OxLcX91O2wPR68v3HdJzpkq4ng2EYaLGqe4bLYf+w5gWWsPOfEp6zwzDIOGc/6mAEXSrQ
	Nm7j1Wk6FePfiZNaI78VnitIKEOMpY9qynL8Mk4smXROQ5fraX7DePkBiqxKXL+1/f1w5amVfWLhi
	5KKpYTnj57ASBY22MVn9EzzFE3Tv5rYHJgtyUZjdxJ9sKTzira2dMPRlfigoc1LVe3R7PAsflqWq1
	H4os4jLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEn-0000000DuS4-2qqk;
	Mon, 29 Jan 2024 18:20:05 +0000
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUWEk-0000000DuPz-2JgB
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 18:20:03 +0000
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3bd72353d9fso2486530b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 10:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1706552400; x=1707157200; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hweC0yGkUBskdfzYZ5VPbAI3FjUrfkbQmkkuVMgbP0Q=;
        b=paWOmpwhsK3LlyRyuSKjbvJOfEN/a+xMe8NfeErofTxPInIBo5hY8qGyRkT8sLK07/
         tg9Z8/aNpeujgtp06BsnZpFoHWpx3hd2ngfZbeiTBXJn3rXI7NMPaWFJNOt46as+XK59
         QT9OmfckAdALRzj57dCeS18yjYgjN+mCNgRTQgmFfowFgw/VVaBEplAtnHlZviNiW35N
         zjOPXNx7FIjhLveZzkrRl81kj68LwyPwbR2xCYLRwRyIrP21Ml4Qy3gQdL7fK5KEElsK
         ojnMqIqH7pry0/tU9Efn9H6/wA0vqFQA3uApVungiqVce7DqGe2glqFz+VU/C54l5aqN
         Su5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552400; x=1707157200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hweC0yGkUBskdfzYZ5VPbAI3FjUrfkbQmkkuVMgbP0Q=;
        b=vSC2w6baH7sFKWePGp//8JFbk7kY6x2sZ5RSc3nkIkDmLakc0v2yqvZ54TL5+WANnh
         a5yaMqM6HGAuo38CRMci3cvUXo6K/6f64Sd6y8XUCHz7lKWNsYRXRVxzlUIAehCm7/5G
         yKjZ4uv+1Ujsde03tXFXRJSe0WIXfULOKSiHYcD8nMUmTCxcNZ+0XKvjScLXos6tAjb1
         35rzEIGU9e23ZDh+HRG7FMolxpAGDd2IW8xJ1Xe21ft160gN6ar1NiHQ+ZYLk/79bA3R
         EsExwsfX2lpgBC7WldguIRkUlcej7wx8Ggyn6wffxfsLePQiqB+xhmoXIYtrcVsKGElq
         tUHQ==
X-Gm-Message-State: AOJu0YyU5StSDv2VUs17RzyBwyx8+RMpCuEJgvaZB5x0HG5UWvvlHq2u
	ZBTQk7nICK0/eJLPOmomAZ7yVoIWuGZCwaxgEegSafV9C5/XDVX2SXnwzUaEZfc=
X-Google-Smtp-Source: AGHT+IGKl3Tazk5JwHGp8LRgEt8wdgvZh0sPOF3WytS9KJ+wuSPP0vuRpSLufZH5T/cw1OIRdNTofQ==
X-Received: by 2002:a05:6358:927:b0:178:72b5:cf3b with SMTP id r39-20020a056358092700b0017872b5cf3bmr3433403rwi.29.1706552400360;
        Mon, 29 Jan 2024 10:20:00 -0800 (PST)
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm6617750pgb.50.2024.01.29.10.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:20:00 -0800 (PST)
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
Subject: [PATCH 1/5] driver core: Support two-pass driver shutdown.
Date: Mon, 29 Jan 2024 10:19:49 -0800
Message-Id: <20240129181953.1183084-2-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240129181953.1183084-1-jallison@ciq.com>
References: <20240129181953.1183084-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_102002_620317_1C866E5F 
X-CRM114-Status: GOOD (  20.03  )
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

This changes the bus driver interface with an additional entry point
to enable devices to implement two-pass shutdown. The existing
synchronous interface to shutdown is called, and if a shutdown_wait
method is defined the device is moved to an alternate list.

Once the shutdown method is called for all devices, the
shutdown_wait method is then called synchronously for
all devices on the alternate list.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h |  6 +++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..c8b0d4c9abed 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(shutdown_wait_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4769,10 +4770,17 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
+
 		if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
+			/*
+			 * Only put the device on the shutdown_wait_list
+			 * if a shutdown_wait() method is also defined.
+			 */
+			if (dev->bus->shutdown_wait)
+				list_add(&dev->kobj.entry, &shutdown_wait_list);
 		} else if (dev->driver && dev->driver->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
@@ -4789,6 +4797,33 @@ void device_shutdown(void)
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	/*
+	 * Second pass only for devices that have configured
+	 * a shutdown_wait() method.
+	 */
+	while (!list_empty(&shutdown_wait_list)) {
+		dev = list_entry(shutdown_wait_list.next, struct device,
+				kobj.entry);
+		parent = get_device(dev->parent);
+		get_device(dev);
+		/*
+		 * Make sure the device is off the  list
+		 */
+		list_del_init(&dev->kobj.entry);
+		if (parent)
+			device_lock(parent);
+		device_lock(dev);
+		if (initcall_debug)
+			dev_info(dev,
+			"shutdown_wait called\n");
+		dev->bus->shutdown_wait(dev);
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+		put_device(dev);
+		put_device(parent);
+	}
 }
 
 /*
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 5ef4ec1c36c3..a4132c44dac3 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,7 +48,10 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
- *
+ * @shutdown_wait:	If this method exists, devices are stored on a separate
+ *			list after shutdown() has been called and
+ *			shutdown_wait() is called synchronously on each device
+ *			in this list in turn.
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
  *
@@ -87,6 +90,7 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_wait)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.39.3


