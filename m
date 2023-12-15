Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BFEC4167D
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 00:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zu6Kv+piX5rsWT/XYfwYEdYL+zGX7UJzAJo4X8Rim6I=; b=OLJHgzN0QUc86DOcXqCrqgpvpb
	IAf8urJVMb34X/ul37hZqIydHxbDqj1iIgOSP65eWo94fODmcMJ10oXgEVWHKdMhTHKS4oo/19q/O
	Q3RCZD6q6N8H3JqFnVHdzlS4xpQXVP+Iw7NUIQBNgrAzU6CdPX4GIvLYZEYwruPBTxTnXW63IWHyJ
	rBJHQ8kZNPa+JutsTG8Dqkj9Bun2/lEj1pxcrFAJki53W5uUr8NYuR0+lC5CyomfhUee60edBE4w6
	oF9TScpZ8pu3Zdl0DNGm6j1ukx3EzbMjVjr4vLMU3nqtxObm3TNeTCYdZ6SIr3u+NZyzrTC5YHOg6
	UEAwmk/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvga-001bBi-19;
	Fri, 15 Dec 2023 00:04:12 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvgX-001bAZ-1C
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 00:04:10 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6ce6dd83945so72777b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Dec 2023 16:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702598646; x=1703203446; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu6Kv+piX5rsWT/XYfwYEdYL+zGX7UJzAJo4X8Rim6I=;
        b=ovp+U9mPTqMduyJ7r8T9f3y2jsEzg9Tm+gl6Aeen2Lu//KfDPtLHOl9wrKL3YxcLlP
         SsrHNRqkpBpDgcF6nx25v5f7lXZncfMN7/i1Tox/hmPkaF4DTGQVr6iR7QeT9uCBidIc
         slGosvFGMbpgkGsVuENZRVCPLeQL5gvVQ56O6vDwj5+pr5IZnBkuPxxwpPJrIra616BU
         ZrQ0i2301f1p7PNAXEzCaCxpJYljVjm736L0RRLxFpYJ967TBbDfPeBFRgZ4l29+keLx
         I/NsJAAk8K3HMmWDvdflYzkV+qhlcsdZGgynEoBfRqDGdYnXulbtVTXFbUNiEBSTqdQf
         TD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598646; x=1703203446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu6Kv+piX5rsWT/XYfwYEdYL+zGX7UJzAJo4X8Rim6I=;
        b=qJcdH4ZlTr0mSxP/+xarFMsQeufOL6Dz9/PbSsStl/7s4ulAukGNdqzeEpa0hrFIEA
         Gk/Ll0ywuisJiLjExsQyA8dhseX5Qov6hvPQqXM2Fu6R+sh8X2r1cSu/nB6yCM3EFCpc
         4iKxPfGoQIvXw0Rp6qUVrvMQRQH2GjtLl9Ub0IRkkGYNVHDzduB62QyDZNZSkXPSPM09
         CYDpdJeD7ghnMrMw33UfBX1m0PScvsNGVn8PhECF+Pbdmj8ONXRrmRgazlXSqxsruPOK
         U6AcaG4EdWOrGV7vgt0y6BZnwa57Bwk6OH5FG53b4ZzO0hUT/5laiqlg4sYKf3lCKCXi
         mjcg==
X-Gm-Message-State: AOJu0Yx+u77qgVhI5LC/hZL83H4sjKxLXRlzTExF1pnGVNXedaX6hihI
	h53UVgMonYOSnu1slK9NkIdmFg==
X-Google-Smtp-Source: AGHT+IH2W0xLul79H5a3wWsCPkFU2gPJC47oFQ0qrQwb16Mbjbq3DPQMBVxdazEDPAwAgLEUB0zINg==
X-Received: by 2002:a05:6a00:6509:b0:6d0:dff8:39b3 with SMTP id hc9-20020a056a00650900b006d0dff839b3mr1998792pfb.58.1702598646274;
        Thu, 14 Dec 2023 16:04:06 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id c12-20020a62e80c000000b006ce7e497302sm12208524pfi.21.2023.12.14.16.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:04:05 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Subject: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Date: Thu, 14 Dec 2023 16:03:56 -0800
Message-Id: <20231215000358.1203338-2-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231215000358.1203338-1-jallison@ciq.com>
References: <20231215000358.1203338-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_160409_421570_859BACDC 
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

From: Tanjore Suresh <tansuresh@google.com>

This changes the bus driver interface with additional entry points
to enable devices to implement asynchronous shutdown. The existing
synchronous interface to shutdown is unmodified and retained for
backward compatibility. shutdown_pre is only called if a matching
shutdown_post function is also registered, otherwise the synchronous
synchronous interface is used.

This changes the common device shutdown code to enable devices to
participate in asynchronous shutdown implementation.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/base/core.c        | 41 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 11 ++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..a842d402a088 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4769,7 +4770,16 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
-		if (dev->bus && dev->bus->shutdown) {
+
+		/* Only call shutdown_pre if a shutdown_post is also defined. */
+		if (dev->bus && dev->bus->shutdown_pre &&
+				dev->bus->shutdown_post) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown_pre\n");
+			dev->bus->shutdown_pre(dev);
+			list_add(&dev->kobj.entry,
+				&async_shutdown_list);
+		} else if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
@@ -4789,6 +4799,35 @@ void device_shutdown(void)
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
index ae10c4322754..d49dae1a280c 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,6 +48,15 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @shutdown_pre:	Called at the shutdown-time to start the shutdown
+ *			process on the device. This entry point will be called
+ *			only when the bus driver has indicated it would like
+ *			to participate in asynchronous shutdown completion
+ *			and has also defined a shutdown_post function.
+ * @shutdown_post:	Called at shutdown-time  to complete the shutdown
+ *			process of the device. This entry point will be called
+ *			only when the bus drive has indicated it would like to
+ *			participate in the asynchronous shutdown completion.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -90,6 +99,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_pre)(struct device *dev);
+	void (*shutdown_post)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.39.3


