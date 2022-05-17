Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD47C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tf+qNQoI5qGFZ9RW7jx4HEPwOLh/TGpPIUH/6a1l9U4=; b=SLimVmPkZx9hNV/tEUuUMKXpAT
	2/dodNNCGPYkwabF4rzGQIugnyTEzC+muFqbINkaJvz+5vvYqV7Oc3t84hH3X23uXvmLp9KICiyu4
	S/tBbZu0zGEp67JV5P/CRXQKC88TO8NGPBszyTgfIOiQVXU+rfJWZhcI/xsPrnWMa5/IsIIPmMcHi
	fTA/Aq6FMZV9g6/g73RcP1N0Jusyag2QN/wxOsm18pGMZ994ZW5uYHwE+dezwUAeD7Kt9qiKzBLMN
	NzZT1cmJQKOZ3x+2txxNHR5rQ//CULpLqisqQnEJVbk3YnsaPsb/Wh58eWgh8G92HTFIDYGDDnpFv
	h4zjOBPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr5Mm-00G2TY-0P; Tue, 17 May 2022 22:08:32 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr5Mi-00G2OZ-T8
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:08:30 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 o7-20020a256b47000000b0064ddc3bea70so330545ybm.4
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=tf+qNQoI5qGFZ9RW7jx4HEPwOLh/TGpPIUH/6a1l9U4=;
 b=Vsd0rtAyuCX1ep9X8JPz0kVgE4qriTwFWX2119dzWimM6EjZ30AHxEw53p3qxrWdi5
 POmyjeHImwG4MqnpLGozKFxoNPL5EGmsOIPrfxbeifQQoCw61r9cF6yLgj9qaJudrBCn
 TjT2tZwfvaODmd0MssVVbrKjGeMSc6AW81dJLt5WkCPgCAdTmPdy1mskr6PlDa56AKta
 25rvMKsojCYOuGZa4hqfLIuJZnoUa0GnEMoN2rRTBJeMWGKQFe9SJr22yWJXSPsaCeoQ
 awSYMJYsMF7kP+naNxCLPkKZAodpvp94xIYrYzmJDzVjbz7xUvrsI31pwdAGhXQwJLv7
 LH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=tf+qNQoI5qGFZ9RW7jx4HEPwOLh/TGpPIUH/6a1l9U4=;
 b=7UQCFDKKWsJFR88FKRDocfc51/rQzk0VdoLA03wcwAEL7S9eBf9vjuHhdSL/mMp+fq
 zl/iM9dxybRSYu0oKQ1JgB9g2uOoof+UUcB5PKC3xvAEIjZH5izn7Eik43d0FVoDRuRE
 aH8nFkZ1HRShQDSYmycPsVPg3J6P6bXE69nSW1u24zo8vFAiodGHncpli9El7rUjgxTG
 hdt3MAJ89iVDMnRLSot2aePWw/NIoY1mzgPzsyB1hbVtbExVJl7Lvig5b0cKTxsVLphB
 J78TAIB1AZft8bzaUEI0v+hLKhf9Z98FiodySyD+aVxf2wywpD+faO5Xi1sW42VWH8El
 N6CA==
X-Gm-Message-State: AOAM533qB1Z48l7nZPGzA9EXkOBfhSRrZbnTDJWI1VLc2VUafoD3escG
 8V4/L1B1Kw17SKNuDPZoLPddnenF32fID1s=
X-Google-Smtp-Source: ABdhPJwcmd7U+J0BbWux8Dql+fC0+EhIAotkoA14iXEPCqqLPyINCsjksq6MYJzDnCiD6Pwc0H4rOmOTjArLiFM=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:3c9b:5345:708:1378])
 (user=tansuresh job=sendgmr) by 2002:a25:9c08:0:b0:64b:c9f8:de84 with SMTP id
 c8-20020a259c08000000b0064bc9f8de84mr20468621ybo.391.1652825307082; Tue, 17
 May 2022 15:08:27 -0700 (PDT)
Date: Tue, 17 May 2022 15:08:14 -0700
In-Reply-To: <20220517220816.1635044-1-tansuresh@google.com>
Message-Id: <20220517220816.1635044-2-tansuresh@google.com>
Mime-Version: 1.0
References: <20220517220816.1635044-1-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 1/3] driver core: Support asynchronous driver shutdown
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_150828_982653_E30F70B3 
X-CRM114-Status: GOOD (  20.14  )
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
 drivers/base/core.c        | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 12 ++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3d6430eb0c6a..ba267ae70a22 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4479,6 +4479,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4523,7 +4524,13 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+		if (dev->bus && dev->bus->async_shutdown_start) {
+			if (initcall_debug)
+				dev_info(dev, "async_shutdown_start\n");
+			dev->bus->async_shutdown_start(dev);
+			list_add_tail(&dev->kobj.entry,
+				&async_shutdown_list);
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
@@ -4543,6 +4550,35 @@ void device_shutdown(void)
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
+		if (dev->bus && dev->bus->async_shutdown_end) {
+			if (initcall_debug)
+				dev_info(dev,
+				"async_shutdown_end called\n");
+			dev->bus->async_shutdown_end(dev);
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
index a039ab809753..f582c9d21515 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -49,6 +49,16 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @async_shutdown_start:	Called at the shutdown-time to start
+ *				the shutdown process on the device.
+ *				This entry point will be called only
+ *				when the bus driver has indicated it would
+ *				like to participate in asynchronous shutdown
+ *				completion.
+ * @async_shutdown_end:	Called at shutdown-time  to complete the shutdown
+ *			process of the device. This entry point will be called
+ *			only when the bus drive has indicated it would like to
+ *			participate in the asynchronous shutdown completion.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -93,6 +103,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*async_shutdown_start)(struct device *dev);
+	void (*async_shutdown_end)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.36.0.550.gb090851708-goog


