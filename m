Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418F6C0218D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=op1d1tXUm2tCCekAlnALKVuCzfVX7pfXlggV9vI9r+8=; b=uY8SB4JvcAabVWtnF9wbqTf3wV
	ghTc5MQP6pulDCAVwgZCM01/2mYeXABs3H88QgERZaXyhvcOmx/HkVSBzzJ2yPWejbbALLSfrQ5a4
	V8oTqWIZFLRKKj1y/Vd9S3pag2gXV7ffyEK2+auNe9vbqeo8COT3bvFT0qddSzjILfFBb6FneJpk7
	lbWxLoDiV06hqaKjkZuk8Rrvwnr6z54yh0Ib5ZLMwKB1cETU42w+bkiZegkEN527i0z4l+JMjcKcY
	zRZEjAkFh4LR2K/Wuc1l538KrXKBwDR9zx4alnbcBH4STdcGua56k111S5FY93A7Hu4VeE+VDdVeV
	TDojdfsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdKtE-000000086Ht-0IAs;
	Thu, 30 Jan 2025 03:06:48 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdKtA-000000086HS-3Htn
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 03:06:46 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-216426b0865so4833965ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jan 2025 19:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738206403; x=1738811203; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op1d1tXUm2tCCekAlnALKVuCzfVX7pfXlggV9vI9r+8=;
        b=BKZrF4fuhkIq/XoUu5QdiY3YSgV4hrM/0s8l+ljjl//NZ8jGQ+WhtSmyaTg3ngFejX
         5Hz1lBlX0D0gkGjk0RQCBJAoN5PIc2cxt2uImLRlXuiT531LgFqJjuyeHjfwFwQQ2dNO
         wkzlq6FVh/awee3xFQEkzgd5XqhnfKRzdjIaufDIese09jjIc8WMHvsoXHXLo1onw97z
         REy+9sjRDPR3iVUCFMWAVy0Ua+4kvGpcqex4meNH7zkrfuXsy78eLRUIICZdFcd9f0BV
         uIanI6z6gps2t6aO6GtGyR/O3tQxzdk+rfug6sncjEbPNDQ3j2K3fjTgy7hULx8GPwZf
         nh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738206403; x=1738811203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=op1d1tXUm2tCCekAlnALKVuCzfVX7pfXlggV9vI9r+8=;
        b=wVOvlqQ1JxkaXQnM0indq/pAfYUNWGdv6fys7ClVL/QHFOlyGugsBKJ3UICxVN4h3x
         tT3TtNEHP/3Ep6cMURRPI+qHZ1+aTDUaoss0EZyokca3DU3fLhEOJCkOf1zJ5KT1HjgQ
         f78E42Xm1BEuuE1jSMt8mlRE0MF7L/j1PjrAHM1nLU9FQifcadTZzAhUnZ3E+P18FrpB
         ezUgMjGOIcQaWMxnho02J7jgvQe61bYYM+lRAaRd76n7giTZRGS7xO/uV54DwIVDGxcX
         pb/bpXzrUsmFRWY3ZWy/fvKRTcMogHpZiIapVJPJjpmyJ4czOxZorSZogTVWA3+m1ovf
         SKvw==
X-Forwarded-Encrypted: i=1; AJvYcCURUFQkoGHP5xfQgauxSa6WfQjBYv3dgqH+oBUga8WsMlLhug+WWAXV48f3SRDqRh5jyz+qcK5Lp62q@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6bzH1DdIcPLVGi4sEG37oN1nz3/niXGIS6Q+QftFjb/lzskW8
	yXhp30tkKX0VjQnIl76VnbL4U7av4GItvF+z9bGEjYgf1/qJdLHe
X-Gm-Gg: ASbGncsxrNKgpJQvuLdVkqY/BLybkk2rs3AxHd+63yffyPiwq5rVBnRA+0x6Xl43dXB
	929qp0xlZ4B4DszI5PkYn1iJVsapKPO8auIf6jydH9vSWqfcsKRCOd8Fd2itUKxNQcFWcr6A00d
	90umujsZP3SBiXJAZWsVKly4knYB+fd3ulZilg+DVj2/ANI+jYPkUKhCqyL2N01+PvLf6jb6d5i
	6a3eMHRU0e/F0maZnmJEn8ww+vEZI8o0qcDeGtvfepdOEt7dlqYNnskjavUZ7SjT7n6AQXkRpcP
	ELXS
X-Google-Smtp-Source: AGHT+IHI9hubfXKcJhgGPeXIbm6pWvHvCDpKuB+0Sr/ceItq/TzOuv8SgDTjhcsyAOu2v86IyVbgkA==
X-Received: by 2002:a05:6a21:8dc8:b0:1e1:bd5b:b82a with SMTP id adf61e73a8af0-1ed7a61ced9mr10026282637.40.1738206403244;
        Wed, 29 Jan 2025 19:06:43 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe856890sm270387a12.42.2025.01.29.19.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 19:06:42 -0800 (PST)
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
Subject: [PATCH] driver core: optimize async device shutdown
Date: Wed, 29 Jan 2025 19:06:25 -0800
Message-ID: <20250130030625.4461-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_190644_825988_EAAB635A 
X-CRM114-Status: GOOD (  31.03  )
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
Hi all,

I've created this follow-on patch to address the overhead problem. With this
patch applied on top of the v9 series, workers are only ever spawned for devices
which request async shutdown. This should also improve performance in the async
shutdown case.

Cheers,
Sultan
---
 drivers/base/base.h |   4 +-
 drivers/base/core.c | 136 ++++++++++++++++++++++++++++----------------
 2 files changed, 89 insertions(+), 51 deletions(-)

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
index df0df531b561..993285bc0d1a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3515,7 +3515,6 @@ static int device_private_init(struct device *dev)
 	klist_init(&dev->p->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->p->deferred_probe);
-	dev->p->shutdown_after = 0;
 	return 0;
 }
 
@@ -4856,37 +4855,66 @@ static bool device_wants_async_shutdown(struct device *dev)
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
+/* Assumes an extra reference to @dev and @dev->parent are acquired first */
+static void queue_device_async_shutdown(struct device *dev)
+{
+	struct device *parent = dev->parent;
+	struct device_link *link;
+	async_cookie_t cookie;
+	int idx;
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
@@ -4894,16 +4922,37 @@ static void shutdown_one_device_async(void *data, async_cookie_t cookie)
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
@@ -4928,37 +4977,24 @@ void device_shutdown(void)
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
+		if (dev->p->shutdown_after) {
+			get_device(parent);
+			get_device(dev);
+			queue_device_async_shutdown(dev);
+		} else {
+			shutdown_one_device(dev);
 		}
-		device_links_read_unlock(idx);
-		put_device(dev);
 
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


