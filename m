Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1EAC30659
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ng2WmGXQZql1jDXPW/vYyFeh8nYeJu3JtauFqQLagBk=; b=WGek/4gKcmd8EjelkGt1ROoJio
	vOsqfo/GDjCzd5O7rAa4PqO7SikTOk6BJZHeebxTZrKNHhfDZap1uyiGOic3MtYQ596nm2XeJPtg1
	uMmeTbXQmsJnerxnx9iNLQPgjsZWPwmFBDc2SAVwE5hhTIXOFhl9/GsQeu62LoIB4apxFk0Fkvebh
	nuRH33ZSnTiBOVU7mghrAdSPgrq/8pvC9uT5nsx28mi9Tl9bmXomKd6nBNt4yE5ivUZwpOP8fVAwh
	NmQ9y8UmFtITWMsagbGiz9Y1KXzMnQo3+H/Dqaxnb8nKgO2FmMMtGvMh9Di2NE8+HMPDfDxtigfwV
	KY8ldj9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbv-000000086MA-3awM;
	Wed, 26 Jun 2024 19:47:19 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbr-000000086J9-1t37
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:47:17 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-63bd10df78dso66920857b3.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431234; x=1720036034; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng2WmGXQZql1jDXPW/vYyFeh8nYeJu3JtauFqQLagBk=;
        b=Wjaq9FMVKKofR0ExCiinpaNfC9QB+Axrv3tNxUcUS9eaLWy5tJFf5ADpFbYSJcqxr2
         VEMl0KlIiKUf9X7Y3zUegnLaU+mLZt1xadzWXc6YVEaAPDkFBc/aoHdyvbw3e1LXckCF
         K7RJmCjPsbInAdgEr7PHHlgpYYoPcsfUeIaDbYwGA2dPA1KqiYpvN0ukEL09sHZwHb0w
         G6NAXOVDzVTfJdydwWmKYtS9H6RYujYZr0VLMGmo6s74n9F/Rfo1xnpgxeveeeSC3pAv
         LymmUOeelXMWN2r3+ZgzB3HFQR+Nk8Sw8vQQATiaryJBTB+IvHFpv/ngznMDOB1Bp0IW
         YPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431234; x=1720036034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ng2WmGXQZql1jDXPW/vYyFeh8nYeJu3JtauFqQLagBk=;
        b=YYRAVMqkuuPgZhFlc/YCW+odXG4xUeHqqXf6zOGW+hOfp2Xtc9RGeNc7po8/zKRgFV
         p6NRzsn/v/IorGp2yIPT/C1Tl81teUqoe7o28CgHYNatGvJcEA+MylmLL4nABb1sUEiL
         eE3a/pkinaQnM0UBJpJiLu03udsetTaXYhfq5snLy2MAW8hqfgnq9fBQg20vwkMarc9F
         f+3FQsSVoxfK7xRoFs2pu8WviD342MIpoaYhoC6h8V3+GPzGpsdUOHCQeQlCHDbIViDh
         i9dIeuTThd75SBYIXIKSlDbrJAy68VVnAjP0p2upwA75QNZonXHVUwvCopdwSQh2w9II
         BsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFu0VnvaNDyLQfJOpqYDYre1O0jUfoG207CUPAdddnTBiM+/6WcucEiZWoCCOHmxY5d7QmKlK1GE58RpDOv7pBq0us2YhBL31AcEuQ29A=
X-Gm-Message-State: AOJu0YxqEP8nZSZOFSJuPymSGWkIZ7yCjoQrmM14MhMc168WdgPQ3SiY
	TEEXAfRBlyytvhNCJIHcs+FzUb0FPX/v09PElRZEH5+EiWG9lF+O
X-Google-Smtp-Source: AGHT+IHl9hABe7xX2H7iF4FE+OsGRaWYvA0ZYF+mCybXMF3BftUU+kXejmxt9lePOISoscwqnHSTSw==
X-Received: by 2002:a81:8904:0:b0:63b:ee94:1eb7 with SMTP id 00721157ae682-6433e906b0bmr109055207b3.25.1719431234276;
        Wed, 26 Jun 2024 12:47:14 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:13 -0700 (PDT)
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
Subject: [PATCH v7 3/4] driver core: shut down devices asynchronously
Date: Wed, 26 Jun 2024 14:46:49 -0500
Message-Id: <20240626194650.3837-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_124715_517526_F677BDA3 
X-CRM114-Status: GOOD (  29.69  )
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

Add async_shutdown_enable to struct device_driver, and expose it via sysfs.
This can be used to view or change driver opt-in to asynchronous shutdown.
Only devices with drivers that have async_shutdown_enable enabled will be
shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |  3 ++
 drivers/base/bus.c            | 26 +++++++++++++++++
 drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |  2 ++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index db4f910e8e36..6f65f159d039 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/async.h>
 #include <linux/notifier.h>
 
 /**
@@ -97,6 +98,7 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @shutdown_after - used during device shutdown to ensure correct shutdown ordering.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -114,6 +116,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	async_cookie_t shutdown_after;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..97fd02cff888 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/async.h>
+#include <linux/capability.h>
 #include <linux/device/bus.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -635,6 +636,25 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+static ssize_t async_shutdown_enable_show(struct device_driver *drv, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", drv->async_shutdown_enable);
+}
+
+static ssize_t async_shutdown_enable_store(struct device_driver *drv, const char *buf,
+			      size_t count)
+{
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (kstrtobool(buf, &drv->async_shutdown_enable) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+static DRIVER_ATTR_RW(async_shutdown_enable);
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -702,6 +722,12 @@ int bus_add_driver(struct device_driver *drv)
 		}
 	}
 
+	error = driver_create_file(drv, &driver_attr_async_shutdown_enable);
+	if (error) {
+		pr_err("%s: async_shutdown attr (%s) failed\n",
+			__func__, drv->name);
+	}
+
 	return 0;
 
 out_detach:
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4be6071c2175..1eb5a7286c79 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -3528,6 +3529,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4778,6 +4780,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4813,12 +4817,34 @@ static void shutdown_one_device(struct device *dev)
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
@@ -4849,11 +4875,37 @@ void device_shutdown(void)
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
index 7738f458995f..1e78f2ab1366 100644
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


