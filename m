Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1052C0218F
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0EV3OdBcPD1ajnFR/jNPfD31GiMfS8OVMSrdDRjbvgg=; b=HJc5qygQ56QyyptskeS2PTDxrk
	plZeBhIzbWZ7yuxYctC+4bewgy4zA3UK0cuBP6RE8Lr0+oMOWXHzbv3Zc4a+v3/m0DV7xjn1Lzid7
	4jOy6+jD3pD9+xaIlJdoECVPO9zdeLU+25oUklIu6gbxT6pHwnhahMCQ8xCjKt65dqA+YTWpNOdL6
	G6M7CMVeqv3UmSNd9/AvgFnyotRr/NROzCYy9sfXqe/uT1wNAisEjl9ZHmNzDg/tng2ielRMebbH2
	8xjsi8z11jmUaTjl5ZGxrJmVoBhQ6ciupwtXqPkN2InyORzkkaJ6/ghBz1QnFyLRicgQs75uv4ip+
	f876HmBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdY6Z-00000009FSc-3Kv0;
	Thu, 30 Jan 2025 17:13:27 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdY6W-00000009FSH-0uAy
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 17:13:25 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso1417449a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 09:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738257203; x=1738862003; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EV3OdBcPD1ajnFR/jNPfD31GiMfS8OVMSrdDRjbvgg=;
        b=gUEcp54ovIMoEmKv6pU9L/IfGAi48crCXRXAjEmJyz7X+oeIOQbZI04h5FrtxjrUCm
         OrA9HwOLVUpIpFPNbXt5T9wDToPgEANykemYrlJNeJI7PmTHZfcdTjnxhd1pBF+FpUYm
         8hiXwqbRl5NmKHlfawCk9F7Haguw3BGA/G8D4+c/ccoLoGmSdjpdAvV/AYg3gzQQnje/
         hRu3K1PSEdlOR3XtV7PVV79PngVRz429kHmhi8HYbrX1+9lHJ4k9sTX3DuWaxlat+U9Q
         NYmg5bxuKaq7LGp9OFQ5wckDUeOCE8QpK88tlkIkBp/MpZUlZJVOwKILvB9idZnDb1bj
         3TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738257203; x=1738862003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0EV3OdBcPD1ajnFR/jNPfD31GiMfS8OVMSrdDRjbvgg=;
        b=jR8I3N+S5J3h2dxjcl39adbAn9Rxyst2V0fV4hs3NmwR6tqQ3s9R4ZBig9655Z3mhf
         0PVNhTsF1XYCfXEGnrOPQt+2fwkkgMGPt2GpMMo4je/h5EVcBkym3iiMLpScgVcaBA+P
         5XHSuaCC4qFqfm8NzN2EUjNGfY+r/YjCUcBd56iCh+o+YU9kL6KSoKluyuDNvh4t8zoT
         0sr79RSCnbKKeXhGt5cd2j0fNOmO1EkLHSb4RvpQQMrt0leWqZeR6qpVbWczevvesUub
         mugJCxVn2YB+cz53LRROs2KiBhXXnmBvWPm7NQY2oQBVs3lbkQ5XHlWddpbSOXccBX8A
         c5jg==
X-Forwarded-Encrypted: i=1; AJvYcCU2DV81WEoShGtfdVP1FYqayo4gdPsIT7baAFNQVY2ldfL7o/HHMJpA29jkLj8Q9tFtj2hRgUsreG24@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5EPg/6A3naSpxph/zGeXPJEJBhQlzBu2fUdVTr2KfWoXec2Fb
	QUqUVS/O6UFD2aggCkzsxgyEHn0nygErl0QD+2Bfr9tBC1ywBHGQ
X-Gm-Gg: ASbGncvB5uy38ZKm3O/j6+S5XS48mDNTKyQrXxthMuUp3B9YwlrWIj1Dw9d1zcAaN/O
	TM2Z05rlFWn/LibrVYfZWmpI4l+hNWm903W6EYMF1Cn7kZzrwMAYmnK08LeIOdpOIxo3QZ9kB1O
	ysezrLI6AIojq2V2lNzfgIddMNJxcfqEy7a5PixtuY40OM5CpHtSAUsTJLhH07vSpJzQ0H0ni9T
	8/dRV05+pFEX0C1/PZNSMO9duNiqwOJmq5k5DwSBsYjuqnURuekjLe+diAtzAOIBwEefBT4r05E
	u/d8
X-Google-Smtp-Source: AGHT+IHof2FRD+TZUtI6PHx4SWglMOy1L9RvjX69AaZHJVXxy/Uh4SGHaz6+JPYp5KH7tOSC1Rwqtg==
X-Received: by 2002:a17:90b:2749:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f83abab6b5mr12609111a91.7.1738257203182;
        Thu, 30 Jan 2025 09:13:23 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f84897a52esm2082877a91.8.2025.01.30.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:13:22 -0800 (PST)
From: Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
To: mhklinux@outlook.com
Cc: Martin.Belanger@dell.com,
	axboe@fb.com,
	djeffery@redhat.com,
	dwagner@suse.de,
	gregkh@linuxfoundation.org,
	hch@lst.de,
	jallison@ciq.com,
	jan.kiszka@seimens.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	lukas@wunner.de,
	nathan@kernel.org,
	oohall@gmail.com,
	rafael@kernel.org,
	sagi@grimberg.me,
	spasswolf@web.de,
	stuart.w.hayes@gmail.com
Subject: [PATCH v2] driver core: optimize async device shutdown
Date: Thu, 30 Jan 2025 09:12:48 -0800
Message-ID: <20250130171248.3405-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130030625.4461-1-sultan@kerneltoast.com>
References: <20250130030625.4461-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_091324_261289_BED56656 
X-CRM114-Status: GOOD (  30.14  )
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

From: Sultan Alsawaf <sultan@kerneltoast.com>

The async device shutdown scaffolding assumes any device may be async and
thus schedules an async worker for all devices. This can result in massive
workqueue overhead at shutdown time, even when no async devices are
present.

Optimize async device shutdown by only scheduling async workers for devices
advertising async shutdown support.

This also fixes the (data) race on shutdown_after so that shutdown_after
isn't modified for a device which has already been scheduled for async
shutdown.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
Changes in v2:
 * Fixed the unbalanced device refcounts, since queue_device_async_shutdown()
   itself needs an extra set of refcounts on top of the refcounts required for
   taking a device off of the devices_kset list

Sultan
---
 drivers/base/base.h |   4 +-
 drivers/base/core.c | 137 +++++++++++++++++++++++++++-----------------
 2 files changed, 89 insertions(+), 52 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index ea18aa70f151..28eb9ffe3ff6 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -105,6 +105,7 @@ struct driver_private {
  * @dead - This device is currently either in the process of or has been
  *	removed from the system. Any asynchronous events scheduled for this
  *	device should exit without taking any action.
+ * @async_shutdown_queued - indicates async shutdown is enqueued for this device
  *
  * Nothing outside of the driver core should ever touch these fields.
  */
@@ -119,7 +120,8 @@ struct device_private {
 	char *deferred_probe_reason;
 	async_cookie_t shutdown_after;
 	struct device *device;
-	u8 dead:1;
+	u8 dead:1,
+	   async_shutdown_queued:1;
 };
 #define to_device_private_parent(obj)	\
 	container_of(obj, struct device_private, knode_parent)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index df0df531b561..a697c13a6787 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3515,7 +3515,6 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
-	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4856,37 +4855,68 @@ static bool device_wants_async_shutdown(struct device *dev)
  * @data: the pointer to the struct device to be shutdown
  * @cookie: not used
  *
- * Shuts down one device, after waiting for previous device to shut down (for
- * synchronous shutdown) or waiting for device's last child or consumer to
- * be shutdown (for async shutdown).
+ * Shuts down one device, after waiting for device's last child or consumer to
+ * be shutdown.
  *
  * shutdown_after is set to the shutdown cookie of the last child or consumer
  * of this device (if any).
  */
 static void shutdown_one_device_async(void *data, async_cookie_t cookie)
 {
-	struct device *dev = data;
-	async_cookie_t wait = cookie;
+	struct device_private *p = data;
 
-	if (device_wants_async_shutdown(dev)) {
-		wait = dev->p->shutdown_after + 1;
+	if (p->shutdown_after)
+		async_synchronize_cookie_domain(p->shutdown_after, &sd_domain);
+
+	shutdown_one_device(p->device);
+}
+
+static void queue_device_async_shutdown(struct device *dev)
+{
+	struct device_link *link;
+	struct device *parent;
+	async_cookie_t cookie;
+	int idx;
+
+	parent = get_device(dev->parent);
+	get_device(dev);
+
+	/*
+	 * Add one to this device's cookie so that when shutdown_after is passed
+	 * to async_synchronize_cookie_domain(), it will wait until *after*
+	 * shutdown_one_device_async() is finished running for this device.
+	 */
+	cookie = async_schedule_domain(shutdown_one_device_async, dev->p,
+				       &sd_domain) + 1;
+
+	/*
+	 * Set async_shutdown_queued to avoid overwriting a parent's
+	 * shutdown_after while the parent is shutting down. This can happen if
+	 * a parent or supplier is not ordered in the devices_kset list before a
+	 * child or consumer, which is not expected.
+	 */
+	dev->p->async_shutdown_queued = 1;
+
+	/* Ensure any parent & suppliers wait for this device to shut down */
+	if (parent) {
+		if (!parent->p->async_shutdown_queued)
+			parent->p->shutdown_after = cookie;
+		put_device(parent);
+	}
+
+	idx = device_links_read_lock();
+	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
+				device_links_read_lock_held()) {
 		/*
-		 * To prevent system hang, revert to sync shutdown in the event
-		 * that shutdown_after would make this shutdown wait for a
-		 * shutdown that hasn't been scheduled yet.
-		 *
-		 * This can happen if a parent or supplier is not ordered in the
-		 * devices_kset list before a child or consumer, which is not
-		 * expected.
+		 * sync_state_only devlink consumers aren't dependent on
+		 * suppliers
 		 */
-		if (wait > cookie) {
-			wait = cookie;
-			dev_warn(dev, "Unsafe shutdown ordering, forcing sync order\n");
-		}
+		if (!device_link_flag_is_sync_state_only(link->flags) &&
+		    !link->supplier->p->async_shutdown_queued)
+			link->supplier->p->shutdown_after = cookie;
 	}
-
-	async_synchronize_cookie_domain(wait, &sd_domain);
-	shutdown_one_device(dev);
+	device_links_read_unlock(idx);
+	put_device(dev);
 }
 
 /**
@@ -4894,16 +4924,37 @@ static void shutdown_one_device_async(void *data, async_cookie_t cookie)
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
-	async_cookie_t cookie;
-	struct device_link *link;
-	int idx;
+	struct device *dev, *parent, *tmp;
+	LIST_HEAD(async_list);
+	bool wait_for_async;
 
 	wait_for_device_probe();
 	device_block_probing();
 
 	cpufreq_suspend();
 
+	/*
+	 * Find devices which can shut down asynchronously, and move them from
+	 * the devices list onto the async list in reverse order.
+	 */
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_entry_safe(dev, tmp, &devices_kset->list, kobj.entry) {
+		if (device_wants_async_shutdown(dev)) {
+			get_device(dev->parent);
+			get_device(dev);
+			list_move(&dev->kobj.entry, &async_list);
+		}
+	}
+	spin_unlock(&devices_kset->list_lock);
+
+	/*
+	 * Dispatch asynchronous shutdowns first so they don't have to wait
+	 * behind any synchronous shutdowns.
+	 */
+	wait_for_async = !list_empty(&async_list);
+	list_for_each_entry_safe(dev, tmp, &async_list, kobj.entry)
+		queue_device_async_shutdown(dev);
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
@@ -4928,37 +4979,21 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		get_device(dev);
-		get_device(parent);
-
-		cookie = async_schedule_domain(shutdown_one_device_async,
-					       dev, &sd_domain);
 		/*
-		 * Ensure any parent & suppliers will wait for this device to
-		 * shut down
+		 * Dispatch an async shutdown if this device has a child or
+		 * consumer that is async. Otherwise, shut down synchronously.
 		 */
-		if (parent) {
-			parent->p->shutdown_after = cookie;
-			put_device(parent);
-		}
-
-		idx = device_links_read_lock();
-		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held()) {
-			/*
-			 * sync_state_only devlink consumers aren't dependent on
-			 * suppliers
-			 */
-			if (!device_link_flag_is_sync_state_only(link->flags))
-				link->supplier->p->shutdown_after = cookie;
-		}
-		device_links_read_unlock(idx);
-		put_device(dev);
+		if (dev->p->shutdown_after)
+			queue_device_async_shutdown(dev);
+		else
+			shutdown_one_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
-	async_synchronize_full_domain(&sd_domain);
+
+	if (wait_for_async)
+		async_synchronize_full_domain(&sd_domain);
 }
 
 /*
-- 
2.48.1


