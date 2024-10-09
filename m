Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83D6CEE33E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CbKbrq2eBZoafCjGOvWmirCqOvc1rlNEfL7PzJ9PmSg=; b=JKnhzT2ei0IjfGhy99dSDl5xe/
	o7FzxsjbtL8+5Wik3ek4P203PxDdXydCl0Lctw7oVZ4idphFDzrB67PEI5c0zBo0go+g62bUmncF2
	uxwKuDt9O5XBN4ZjPa8V03Pa+jo6uegKFOwOmWs5Iwn0frqxdVahr4RxZgsTOjAe2ZbCWnSgByCtI
	O1srnZ6D1NDgcpE0+SLVwCtwZrR9bh3c6D2D3EOeVsQvyJsdvWiw5NC0QmgG/HevwaJxI9iVQ1HEC
	EAqO5+W6X0W980b5E39WSAeoMcSFkj7qKf9ZnRBmUpLXz+etNFJkqbzPXM+yjoON2AwmUzF3R7DqQ
	s33VG1ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syaxc-0000000AITM-4BnU;
	Wed, 09 Oct 2024 17:58:57 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syawh-0000000AICr-3pYN
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:58:01 +0000
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7165df3a85fso45291a34.3
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496678; x=1729101478; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbKbrq2eBZoafCjGOvWmirCqOvc1rlNEfL7PzJ9PmSg=;
        b=ItEwLtnDDCTCykAnqLJepufILWEESIrzc1eaox25jCK524jk/cuJCf3WCDj5ir6DeT
         vWO+nDVHfOfhbxtVQhagfRsO34zj3xcUaNbeSSyoivJ0uisjnDeQUm/7Vh54kyroV9VW
         PQ0DrtbA6SCaDQVDdLyGdva3U58V2/1kHc5g++sqQWzNTyImRTec0I/rQLFBvWNbHr56
         BHOdQwrmmY968uRGwRMO9pEzpSRZmpUKVnemjZO9jzFK4TkboWAFe0X+2N4oG7fdl8A5
         R1MIXHgz7z65cWkyd0wD0mRUcvPnABtoNNc9bJuQuZdafcHqLFYl3jo3PuSnCk72++7n
         F7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496678; x=1729101478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbKbrq2eBZoafCjGOvWmirCqOvc1rlNEfL7PzJ9PmSg=;
        b=cdgexDyK65lU1vq7BFoMkpEsTyTf/roio+P2MPgcyobTvQOQRD8eIfK1JihJ5jAd/3
         axt2JF9ucxmKVcbqGOlz0MdOrSttyfLR80z2CiWrVc4gckK7Cs06m4dnNUPTM1wEOJKO
         ry8NPuDnLYUGF5zIfVvjKTBR5w4Peb/L1sH7IHOO3lsT+Qg/wieCY3OloOmXYnRWAYHS
         VuvZMliDEvQlB/VGpcNaziWeBrivRJsDJQJKaKGoAYxaKO/LGMGstJZ/AVQW3xLHRp+w
         EjPT7j3ebyuyGz676lV0DfQdkJjb1mp3YZYJ7GfMguFtQBfZQuE9kbbfCyqDlhdGyCTn
         tpkw==
X-Forwarded-Encrypted: i=1; AJvYcCX9mS/qLODGN9/+dj3D4ln9IHmSFqQoIteAsGYs396XsSh/tqG1FoPbYm73jKx4zMxHU2tzeQ5b0bLV@lists.infradead.org
X-Gm-Message-State: AOJu0YzJKbTJpAVM78zfT3MtbmU+gVS+fwTzSsM59QeiHKpkfQCsnk30
	eVlkIln6r++BDJmGLCenHub/+KjE4vMjxaiSBuPnujJMMHYYyDC2
X-Google-Smtp-Source: AGHT+IHsDJkfTNGPYZjTJw4QewG2zd6CFF2l5EXBDuN2TTJHxDt9CybyyYW3NqGWR12c/J4eH2GThw==
X-Received: by 2002:a05:6830:380c:b0:715:4e38:a1ad with SMTP id 46e09a7af769-716a9ffae17mr1682332a34.21.1728496678513;
        Wed, 09 Oct 2024 10:57:58 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:58 -0700 (PDT)
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
Subject: [PATCH v9 3/4] driver core: shut down devices asynchronously
Date: Wed,  9 Oct 2024 12:57:45 -0500
Message-Id: <20241009175746.46758-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_105759_978999_00947359 
X-CRM114-Status: GOOD (  29.83  )
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
device is shut down before its parents & suppliers. Any devices that are
ordered in the devices_kset list such that a parent or supplier would
shut down before its child or consumer are shut down synchronously (as
they are without this patch).

Only devices with drivers that have async_shutdown_enable enabled will be
shut down asynchronously.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/base.h           |  4 ++
 drivers/base/core.c           | 81 ++++++++++++++++++++++++++++++++++-
 include/linux/device/driver.h |  2 +
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8cf04a557bdb..ea18aa70f151 100644
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
index 4482382fb947..bde3fdeafbdb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/cleanup.h>
 #include <linux/cpufreq.h>
@@ -3524,6 +3525,7 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
+	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4779,6 +4781,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static ASYNC_DOMAIN(sd_domain);
+
 static void shutdown_one_device(struct device *dev)
 {
 	/* hold lock to avoid race with probe/release */
@@ -4814,12 +4818,61 @@ static void shutdown_one_device(struct device *dev)
 		put_device(dev->parent);
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
+ * shutdown_one_device_async
+ * @data: the pointer to the struct device to be shutdown
+ * @cookie: not used
+ *
+ * Shuts down one device, after waiting for previous device to shut down (for
+ * synchronous shutdown) or waiting for device's last child or consumer to
+ * be shutdown (for async shutdown).
+ *
+ * shutdown_after is set to the shutdown cookie of the last child or consumer
+ * of this device (if any).
+ */
+static void shutdown_one_device_async(void *data, async_cookie_t cookie)
+{
+	struct device *dev = data;
+	async_cookie_t wait = cookie;
+
+	if (device_wants_async_shutdown(dev)) {
+		wait = dev->p->shutdown_after + 1;
+		/*
+		 * To prevent system hang, revert to sync shutdown in the event
+		 * that shutdown_after would make this shutdown wait for a
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
+	shutdown_one_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	async_cookie_t cookie;
+	struct device_link *link;
+	int idx;
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4850,11 +4903,37 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		shutdown_one_device(dev);
+		get_device(dev);
+		get_device(parent);
+
+		cookie = async_schedule_domain(shutdown_one_device_async,
+					       dev, &sd_domain);
+		/*
+		 * Ensure any parent & suppliers will wait for this device to
+		 * shut down
+		 */
+		if (parent) {
+			parent->p->shutdown_after = cookie;
+			put_device(parent);
+		}
+
+		idx = device_links_read_lock();
+		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
+			/*
+			 * sync_state_only devlink consumers aren't dependent on
+			 * suppliers
+			 */
+			if (!device_link_flag_is_sync_state_only(link->flags))
+				link->supplier->p->shutdown_after = cookie;
+		}
+		device_links_read_unlock(idx);
+		put_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	async_synchronize_full_domain(&sd_domain);
 }
 
 /*
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 5c04b8e3833b..14c9211b82d6 100644
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


