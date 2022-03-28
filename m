Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C285BC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HE+KJmElkBiRdLqH+GjHP+Rl3V6ftUnhFGl2WadF25Q=; b=Vu75+h2LtfDkRq/3XSWz2uq1FZ
	yUkyVMVORLo+eyeghCjOwFtt6ZT9J7Y8SemHjEGhpgDYTy78x4WKrpww2wrHb7IVptd0BHM4oKP9c
	AWzlS4kh7UvCf+/CVCyqsnJcz4m4y2uSyd/yYrp4nBqKPohe33dZZdaKAtHzWdSMXwIPchwstpugs
	WtJC75KZ2695Kys87L9voFjoJJEeXZbzWo9HWERNjz/2VxKcV4k4fWql/jpHqxaMSejFntbc5p7VI
	KAyWysuLlE9tuVFewYZ7Qm8xbVQ6dSKUnEQm5VVCj01juUtmq3Zx+itpVLd30k91jYHIJzVrA7V5c
	sDyRVlew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYyLZ-00AO7E-2T; Mon, 28 Mar 2022 23:00:25 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYyLU-00AO47-20
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 23:00:22 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 i5-20020a258b05000000b006347131d40bso11873536ybl.17
 for <linux-nvme@lists.infradead.org>; Mon, 28 Mar 2022 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=HE+KJmElkBiRdLqH+GjHP+Rl3V6ftUnhFGl2WadF25Q=;
 b=MWRcatLqV8jhdG9ohWm7mM4E3R/YbC1/FIFzwNDD6TlY6EYMe/xuHPFJHuooAj3aXf
 4fJnfu9sk+tQmJn/OsEvJ644ufB1KJUyOS57p1Kr1FoZ2LkMV+NcO2Tn61yRVx0vSZ02
 As2kMTmHM3+2vcZPWir+uiPFUfpWiidfUOVa+5s0fN+X+T9z4gpHxuLcE4GCGTO2yUBG
 E/YhxqmsZ3PfScXtfw7d4xHeWcdVdSlZuDFK0jHSsZq/Rn8vo+L4KVzXyuxl9W3E33RA
 Tfd62IaObJUTQy+NaMZBs9PavgPC+FdcHfKDuvN8hcAamVIJRXhLmFfvIuDTIza+ZbO7
 XpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=HE+KJmElkBiRdLqH+GjHP+Rl3V6ftUnhFGl2WadF25Q=;
 b=FoXK1g3SBnaU4BW13aGMBvLZbB5v3BYpXZv59gQ9CV4JzgfeK29u7/hAE2hmVxuLs4
 wJoV86F3KCqdj7eDsPSNu2MiMSWMo+PhdSMzxmQyHT6b2jxZ5n36dSB4VyqqMeIVJcA+
 pccUxXl6mWwAivUJJ+Xd+qEg9fRIWzGeXat6++kSy6obD64B2yP+voDfADa1YDfz/E/v
 zHF0SJ/T6W2LQhq1fs5Ty8MXjX9ogfCimi/LV86QuSWLxedFepAA8zm63FnhTLLyQpIA
 yX+fp8nY907ppwMvkLClgWDiwW0VqGp07kGaYt7UkvCXXA0AAkNFOl6X8Z0Kz6mSfmPY
 kJug==
X-Gm-Message-State: AOAM532uF+g42Bp2EV4M5NYuoSTskJ2R9MmnOy+tlZ4jBs0EKo1Ew5n4
 OLlcOk71C9B6xlyI8yp50J70v/DqwX5oJ0g=
X-Google-Smtp-Source: ABdhPJyJLGwD6p/MqUDfw8nEh0DJ9s5L0oPyAGDvmxNwqd6Cp0ER8bUrxaaN8M+8r2L4xk3m5KFU7Ql3rq3c7tw=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:3dbb:6bbc:98be:a31e])
 (user=tansuresh job=sendgmr) by 2002:a81:4ed6:0:b0:2e6:aee7:6b7a with SMTP id
 c205-20020a814ed6000000b002e6aee76b7amr28282562ywb.399.1648508418228; Mon, 28
 Mar 2022 16:00:18 -0700 (PDT)
Date: Mon, 28 Mar 2022 16:00:06 -0700
In-Reply-To: <20220328230008.3587975-1-tansuresh@google.com>
Message-Id: <20220328230008.3587975-2-tansuresh@google.com>
Mime-Version: 1.0
References: <20220328230008.3587975-1-tansuresh@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v1 1/3] driver core: Support asynchronous driver shutdown
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_160020_126989_5BFF3AA8 
X-CRM114-Status: GOOD (  19.96  )
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

This changes the bus driver interface with additional entry points
to enable devices to implement asynchronous shutdown. The existing
synchronous interface to shutdown is unmodified and retained for
backward compatibility.

This changes the common device shutdown code to enable devices to
participate in asynchronous shutdown implementation.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 10 ++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..359e7067e8b8 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4523,7 +4524,14 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+
+		if (dev->bus && dev->bus->shutdown_pre) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown_pre\n");
+			dev->bus->shutdown_pre(dev);
+			list_add(&dev->kobj.entry,
+				&async_shutdown_list);
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
@@ -4543,6 +4551,35 @@ void device_shutdown(void)
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+
+	/*
+	 * Second pass spin for only devices, that have configured
+	 * Asynchronous shutdown.
+	 */
+	while (!list_empty(&async_shutdown_list)) {
+		dev = list_entry(async_shutdown_list.next, struct device,
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
+		if (dev->bus && dev->bus->shutdown_post) {
+			if (initcall_debug)
+				dev_info(dev,
+				"shutdown_post called\n");
+			dev->bus->shutdown_post(dev);
+		}
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+		put_device(dev);
+		put_device(parent);
+	}
 }
 
 /*
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index a039ab809753..e261819601e9 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -49,6 +49,14 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @shutdown_pre:	Called at the shutdown-time to start the shutdown
+ *			process on the device. This entry point will be called
+ *			only when the bus driver has indicated it would like
+ *			to participate in asynchronous shutdown completion.
+ * @shutdown_post:	Called at shutdown-time  to complete the shutdown
+ *			process of the device. This entry point will be called
+ *			only when the bus drive has indicated it would like to
+ *			participate in the asynchronous shutdown completion.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -93,6 +101,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_pre)(struct device *dev);
+	void (*shutdown_post)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.35.1.1021.g381101b075-goog


