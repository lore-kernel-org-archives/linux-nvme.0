Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E91BC5321E
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BN9Dqeft6D+8f3HlmvNpHrHmxwq4si7sL5spWhZXP/0=; b=cDXeIl6DkKs2SuwBWqSoM1yWm+
	BSJBRVX1Oi3AJ0UGongR32g+Lrqfy8T3fd4Xim4PV1HLhuVTGtf3o4ZqPGw8EXPL9RTFP63aeh3Fq
	DLTT6RkPFJ/0JsuJ9MTUHpTmTZox+85az3SfZ7uBm4w7kW+1jLPu7A3acvUl5uGaCQHaWnq4WC5VM
	zVKFDAPCXbBzuK/R7OHTtkiJbMXZI3GN8QhC5gSaITHgudFFnPqZFabPdhNPOR8BxI/sRxYvPaPBX
	g5p6qASKZJl3bScfv0hbnA/TVrPa8Y8L0UCAdqtAG1Wy0is43gFWa+jwoGz1uCpWddoEUSuzsAqoJ
	hweZYOvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPu-0000000EDeM-100N;
	Thu, 22 Aug 2024 20:28:22 +0000
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPq-0000000EDby-3JeL
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:28:20 +0000
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5d5bf833de7so895749eaf.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358497; x=1724963297; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN9Dqeft6D+8f3HlmvNpHrHmxwq4si7sL5spWhZXP/0=;
        b=DwxHgIlC2QIDYd0oQucVS/26TosdWW/S3lnLFpS2JwZvTaesdkkq13+49hyFK8klr3
         7xp0MlchH0k0vZR1ce2XbG+qoKIeJo2j9bQXAQXHX5+6LoA8mqKfc7lGmYykajIshF3E
         OmoNUGw3Y5leTePwWmv8DI7v/kM7C9lB0GM5Cyrxq3ygHR86tQWILR4XvSRvyVnk3y4r
         InfHhOH4t/Red6JEM93fLvq7cqlCvEqgFpagPChtdyyQj3usMxqiRuCF+8H5LWmNEF7v
         hgSnd9Q0u/urr9CQrvE0sUuTY5q18IQH0IjfWryN+qKRyP6pcWv5ma2LkPYciFhfSS/4
         73GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358497; x=1724963297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN9Dqeft6D+8f3HlmvNpHrHmxwq4si7sL5spWhZXP/0=;
        b=akkG27e0OTLGePqu2ILikrIQPvc7fxFShez7P5LuQWYqdCnSUY2btlUMo1swfHsbKf
         w8cVkIWe8YG7z8HwJwNaloZJsxfWLV0iorKo66oymiYqvooWCZNnOG5LA840tAo/AU1x
         yLCdTJDdcb5Hh8y2qF+PJ59dEZn1UYVOSBlI+aYMSs5DPtARd46SjZAirNVXwSHU0GF9
         XsteUxTRKSf722+D3fJQBs7/fod/R9N8eqH5AENWRhr6xeOzoQYGpCSFFsns5vjY3ssD
         yEPu0cxYODma5kByx/OGEFL9ChigcsGmLIZpLFeeQM4tHOU3sZwg2DpDXn4UX8y+Tvio
         8JVg==
X-Forwarded-Encrypted: i=1; AJvYcCXIN53lpCLwhvO0bqp/Q6tuOOBN7KK+wrQXFVp8js3zj9i+rleYDz3luTNsD35sBMLMTMXLmd//Phlp@lists.infradead.org
X-Gm-Message-State: AOJu0YznFotq2ZkHTHv5e8khc6QKPb7/e8p8LNJ09F0tX8P4KweMpaj0
	eNt5FqN5SerNkHZbTMfNWCxgEozdc+2McSy6nFEKyir8e/7owqkN
X-Google-Smtp-Source: AGHT+IGVMGaJf5A17/+BmjJ2vW4XtZLorWv8OhPuJs/pRN8TEJbUI0Rv/UopCyIInmLEHWlKrzkavA==
X-Received: by 2002:a54:4393:0:b0:3d9:245c:422e with SMTP id 5614622812f47-3de2a869a43mr21710b6e.21.1724358497424;
        Thu, 22 Aug 2024 13:28:17 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:17 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 3/4] driver core: shut down devices asynchronously
Date: Thu, 22 Aug 2024 15:28:04 -0500
Message-Id: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_132818_856294_7D9DE952 
X-CRM114-Status: GOOD (  27.20  )
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

Add code to allow asynchronous shutdown of devices, ensuring that each
device is shut down before its parents & suppliers.

Only devices with drivers that have async_shutdown_enable enabled will be
shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |  4 +++
 drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |  2 ++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0b53593372d7..aa5a2bd3f2b8 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/async.h>
 #include <linux/notifier.h>
 
 /**
@@ -97,6 +98,8 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @shutdown_after - used during device shutdown to ensure correct shutdown
+ *	ordering.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +117,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	async_cookie_t shutdown_after;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7e50daa65ca0..dd3652ea56fe 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4781,6 +4783,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4816,12 +4820,34 @@ static void shutdown_one_device(struct device *dev)
 		put_device(dev->parent);
 }
 
+/**
+ * shutdown_one_device_async
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * Shuts down one device, after waiting for shutdown_after to complete.
+ * shutdown_after should be set to the cookie of the last child or consumer
+ * of this device to be shutdown (if any), or to the cookie of the previous
+ * device to be shut down for devices that don't enable asynchronous shutdown.
+ */
+static void shutdown_one_device_async(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+
+	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
+
+	shutdown_one_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	async_cookie_t cookie = 0;
+	struct device_link *link;
+	int idx;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4852,11 +4878,37 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+
+		/*
+		 * Set cookie for devices that will be shut down synchronously
+		 */
+		if (!dev->driver || !dev->driver->async_shutdown_enable)
+			dev->p->shutdown_after = cookie;
+
+		get_device(dev);
+		get_device(parent);
+
+		cookie = async_schedule_domain(shutdown_one_device_async,
+					       dev, &sd_domain);
+		/*
+		 * Ensure parent & suppliers wait for this device to shut down
+		 */
+		if (parent) {
+			parent->p->shutdown_after = cookie;
+			put_device(parent);
+		}
+
+		idx = device_links_read_lock();
+		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held())
+			link->supplier->p->shutdown_after = cookie;
+		device_links_read_unlock(idx);
+		put_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1fc8b68786de..2b6127faaa25 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -56,6 +56,7 @@ enum probe_type {
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
+ * @async_shutdown_enable: Enables devices to be shutdown asynchronously.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
  * @probe:	Called to query the existence of a specific device,
@@ -102,6 +103,7 @@ struct device_driver {
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
+	bool async_shutdown_enable;
 
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
-- 
2.39.3


