Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B55C7EE31
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjfYUz5Sj9VCDUhJbZKoCap8L6aycyxFsKLXfxsEkRo=; b=su4IkwgWSTGdBZRP0TpxIxikLz
	vsY9k3G+tYnZ7hkm5iGwJjsXeFagXoOcsJHkjnDS6z8huXZmetM9CZsCNzbjeWQcVHLvljxppxtyv
	12q+iWH/84+LptSqBDiQrkoL6sa4wdfLZYkivsJiutsKim7KWaDHFezBEHy56Wv3pjYT9yVV0ojDE
	AMXvfO6FKiVfObGgXgYywRS/pcJA7FUT1lplrlLXW1Uaj3ZdP6jrWI8xD/U+SrApa80Ey8++5UgQi
	JLSFU/sXnWZSgEBLVGPyP+5sjZsTxzccnVgNdwo1+yHofL7T/ecXaEZvAy2q/idIJmW6Wa0hALvR9
	YvV7Y5dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWru-00000009tHw-24z4;
	Wed, 25 Jun 2025 20:37:18 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWaQ-00000009p97-1mT9
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:19:22 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-40b1c099511so212512b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882754; x=1751487554; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjfYUz5Sj9VCDUhJbZKoCap8L6aycyxFsKLXfxsEkRo=;
        b=kTaE6/xYt8z4o/93N3WYXPG/pFipbJdia6K7FTt6Moh3SzuVs29KHmDhfWFDSJj0ij
         lsrtOHOdXWYwS078mJxgc0P07XrxH2yjjPzZZPJ22pzvCMMKRU1t/rvG7lvYlwvB1iJ8
         fUaY2o1Qgx+h+c3xB6IwTBA8Wou6Yd/TDHYMTm1bhqCe0yT5CTnOgxKvOfCrnIpuuTW0
         j+5Ck/2+aw3wVxH+COMmJ1ixcWRT0SDA6ZGYP5ufZvFIh0cHrb2KUJG/iCmbEH0sT+NJ
         rqGc8XRPJOB4j59ldP7ytIRpEC8PPH3tUjNrdBKV4kJqNlV+Lq/NWQfkRmQ1tdAfy8hT
         8q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882754; x=1751487554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjfYUz5Sj9VCDUhJbZKoCap8L6aycyxFsKLXfxsEkRo=;
        b=AOVKI94y6x2AmujHnX9HuK5PMPOvUjISAYxidf1WP9XUMLXI1iUkcxoCsD9QFa7FaL
         2gNt+B30B+9EyclZedcoli85CN1gnTIVjFPPUApsvJDGyiDCB6KvPP0AjeNbWJRy9b1G
         ktlm4iC4U6G5v/uhlDRAbEePcnj3hhQAWkuIzVu6l5grJ/4pQgFRBvyeaLHuXl82cq86
         RBHM3JKOFR4YDY5n4mVbJ5YG0QFgTO6Yv/Q5TkHYkm7MG0MhGx/f9YothoIGKiuN7mor
         32PntzgiEkSzpMMmThkKazG33UwmYmQjpaCQD7s8zRcFTXYh917S/Knfiae1pHOAsP1/
         dRpA==
X-Forwarded-Encrypted: i=1; AJvYcCX9kpJ2KQbV9zh/G4M0wr/xQTQJUyIo9zuQTd24V1b6S4/dviLGSehLX+Sv4lO5ReFIC7Eb2sk1a6LJ@lists.infradead.org
X-Gm-Message-State: AOJu0YwzOaZ9/rZeoBBlXH7+Kj7uIs6AO317dfVU4Na8KebEHmFrdxod
	m9O1Umf+TlEzk0V5aEsD2H2EM+X6RDBIAqQO5BRIvbi+/1IJ6etkKVMp
X-Gm-Gg: ASbGncu7uiTHBTnb8hNtpooXrvrGTmsEeX1UOy7TxQ4uWYhv2FW+BHhX6b4skvVnvpC
	5gq2VWvbtOwucgyvQB5y03Xh12nVJV4xeitIH4uHSx1hRZd9Ixr81Z6+f0M5/ltA01u3rzyy/qu
	CxEqQQj9vtYjgjeJE2ro/DTfOpSz2o8CxCu2qjRt16itfwwDiRzv94G4mDcz1SXYRaUhbc+u2a8
	ZR3KHFf29dHyJJo/drpeQFmKKYx1K4tTvbzpWZMm316aSdR1aW5vO0CqRVHV0jlorlhWW+lcvik
	OAEy+cAt+YFxQZcTENFs4DxUqFI/htbAimOp2azfU2dlPRsLoCZxoifgNO2QQT5TJLYHOIuiqQh
	K50I898U=
X-Google-Smtp-Source: AGHT+IEPPX6GdITt8r22TB09bMzNMI1EoDKyu9xgoJ9OiZYs/o7KlircW0SgMKIhPLWaoccM3UA6HA==
X-Received: by 2002:a05:6808:3021:b0:3f3:d6f9:69a5 with SMTP id 5614622812f47-40b1c8ca908mr942132b6e.8.1750882753614;
        Wed, 25 Jun 2025 13:19:13 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2319188b6e.42.2025.06.25.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:13 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v10 4/5] driver core: shut down devices asynchronously
Date: Wed, 25 Jun 2025 15:18:52 -0500
Message-Id: <20250625201853.84062-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_131914_494770_0A5D8CF1 
X-CRM114-Status: GOOD (  33.62  )
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

Add code to allow asynchronous shutdown of devices.

Devices allowed to do asynchronous shutdown can start to shut down in their
own thread as soon as all of the devices dependent on them have finished
shutting down. All other devices will wait until the previous device in
the devices_kset list have finished shutting down.

Only devices with drivers that have async_shutdown_enable set will be shut
down asynchronously.

Devices shutting down asynchronously will be shut down in their own thread,
but synchronous devices in the devices_kset list between asynch devices
will be put in a list, and that list will be shut down in a single thread.
This avoids burdening the system with hundreds of threads on shutdown.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11
minutes without this patch to 55 seconds when this patch.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/base/base.h           |   8 ++
 drivers/base/core.c           | 157 +++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |   2 +
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 123031a757d9..214207ca5392 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,6 +10,7 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+#include <linux/async.h>
 #include <linux/notifier.h>
 
 /**
@@ -85,6 +86,11 @@ struct driver_private {
 };
 #define to_driver(obj) container_of(obj, struct driver_private, kobj)
 
+union shutdown_private {
+	struct device *next;
+	async_cookie_t after;
+};
+
 /**
  * struct device_private - structure to hold the private to the driver core portions of the device structure.
  *
@@ -98,6 +104,7 @@ struct driver_private {
  *	the device; typically because it depends on another driver getting
  *	probed first.
  * @async_driver - pointer to device driver awaiting probe via async_probe
+ * @shutdown - used during device shutdown to ensure correct shutdown ordering.
  * @device - pointer back to the struct device that this structure is
  * associated with.
  * @dead - This device is currently either in the process of or has been
@@ -115,6 +122,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	union shutdown_private shutdown;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 39502621e88e..f0484ceefc52 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/cleanup.h>
 #include <linux/cpufreq.h>
@@ -4786,6 +4787,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4821,12 +4824,116 @@ static void shutdown_one_device(struct device *dev)
 	put_device(dev);
 }
 
+static bool device_wants_async_shutdown(struct device *dev)
+{
+	if (dev->driver && dev->driver->async_shutdown_enable)
+		return true;
+
+	return false;
+}
+
+/**
+ * set_wait_cookies
+ * @dev: device to find parents and suppliers for
+ * @cookie: shutdown cookie for dev
+ *
+ * Look for parent and suppliers of dev that want async shutdown, and
+ * set shutdown.after to cookie on those devices to ensure they
+ * don't shut down before dev.
+ *
+ * Passing a cookie of zero will return whether any such devices are found
+ * without setting shutdown.after.
+ *
+ * Return true if any async supplier/parent devices are found.
+ */
+static bool device_set_async_cookie(struct device *dev, async_cookie_t cookie)
+{
+	int idx;
+	struct device_link *link;
+	bool ret = false;
+	struct device *parent = dev->parent;
+
+	if (parent && device_wants_async_shutdown(parent)) {
+		ret = true;
+		if (cookie)
+			parent->p->shutdown.after = cookie;
+		else
+			goto done;
+	}
+
+	idx = device_links_read_lock();
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
+		if (!device_link_flag_is_sync_state_only(link->flags)
+		    && device_wants_async_shutdown(link->supplier)) {
+			ret = true;
+			if (cookie)
+				link->supplier->p->shutdown.after = cookie;
+			else
+				break;
+		}
+	}
+	device_links_read_unlock(idx);
+done:
+	return ret;
+}
+
+#define is_async_shutdown_dependency(dev) device_set_async_cookie(dev, 0)
+
+/**
+ * shutdown_devices_async
+ * @data: list of devices to be shutdown
+ * @cookie: not used
+ *
+ * Shuts down devices after waiting for previous devices to shut down (for
+ * synchronous shutdown) or waiting for device's last child or consumer to
+ * be shutdown (for async shutdown).
+ *
+ * shutdown.after is set to the shutdown cookie of the last child or consumer
+ * of this device (if any).
+ */
+static void shutdown_devices_async(void *data, async_cookie_t cookie)
+{
+	struct device *next, *dev = data;
+	async_cookie_t wait = cookie;
+	bool async = device_wants_async_shutdown(dev);
+
+	if (async) {
+		wait = dev->p->shutdown.after + 1;
+		/*
+		 * To prevent system hang, revert to sync shutdown in the event
+		 * that shutdown.after would make this shutdown wait for a
+		 * shutdown that hasn't been scheduled yet.
+		 *
+		 * This can happen if a parent or supplier is not ordered in the
+		 * devices_kset list before a child or consumer, which is not
+		 * expected.
+		 */
+		if (wait > cookie) {
+			wait = cookie;
+			dev_warn(dev, "Unsafe shutdown ordering, forcing sync order\n");
+		}
+	}
+
+	async_synchronize_cookie_domain(wait, &sd_domain);
+
+	/*
+	 * Shut down the async device or list of sync devices
+	 */
+	do {
+		next = dev->p->shutdown.next;
+		shutdown_one_device(dev);
+		dev = next;
+	} while (!async && dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev, *parent, *synclist = NULL, *syncend = NULL;
+	async_cookie_t cookie = 0;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4857,11 +4964,57 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+		get_device(dev);
+		get_device(parent);
+
+		if (device_wants_async_shutdown(dev)) {
+			/*
+			 * async devices run alone in their own async task,
+			 * push out any waiting sync devices to maintain
+			 * ordering.
+			 */
+			if (synclist) {
+				async_schedule_domain(shutdown_devices_async,
+						      synclist, &sd_domain);
+				synclist = syncend = NULL;
+			}
+
+			cookie = async_schedule_domain(shutdown_devices_async,
+					       dev, &sd_domain);
+			device_set_async_cookie(dev, cookie);
+		} else {
+			if (!synclist) {
+				synclist = syncend = dev;
+			} else {
+				syncend->p->shutdown.next = dev;
+				syncend = dev;
+			}
+			if (is_async_shutdown_dependency(dev)) {
+				/*
+				 * dev is a dependency for an async device,
+				 * kick off a new thread so it can complete
+				 * and allow the async device to run its
+				 * shutdown.
+				 */
+				cookie = async_schedule_domain(
+							shutdown_devices_async,
+							synclist, &sd_domain);
+				device_set_async_cookie(dev, cookie);
+				synclist = syncend = NULL;
+			}
+		}
+
+		put_device(parent);
+		put_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	if (synclist)
+		async_schedule_domain(shutdown_devices_async, synclist,
+				      &sd_domain);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index cd8e0f0a634b..c63bc0050c84 100644
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


