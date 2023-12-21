Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2CAC46CD8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbaMMVd6M1iDuxSIoW00jFQ0sJ8tIutmqRqJ6htdWqo=; b=AQwlBqzqTg6oFaBohFtx9HIUAZ
	GTFRUUwgM/B/nh4qfC0bkAR72pMXFxiSQmwmXm2qAu6L+PlgJLWQLjypF7q10fNnsC5XUNSB6tkIO
	VIb2fCzc1o8Ip6t5KfUHL1ZEz1thpM5x99NziihcdDGamJ2WJ77RMtIiQO08A5AikOP756HY+7rBb
	AGe2V5zGq4CeWB8lc0ngr9PzVeYwUdIOkJSGS/n8vosijwjnBKQtGQeLgbneIoRin/Fh+Q7BSzoGz
	nOg9DZ4ZBKhuTl5Di8w/vMzqjRIHZL6mXHBy/D4O2hMbH346whBAYpCun0XNajDisYH6sUgWOBbiz
	1OmkS3xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlO-003dje-36;
	Thu, 21 Dec 2023 17:23:14 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlL-003dgO-26
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:23:13 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6d267461249so621726b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 09:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1703179388; x=1703784188; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbaMMVd6M1iDuxSIoW00jFQ0sJ8tIutmqRqJ6htdWqo=;
        b=hABrw3jl5tIpSfec2aTbjfQvyVBGYNJL6jKcBFGo/CRy1cxY53qsbBK3Q9nE6sj1Mb
         EkGVs5tumIUFr/gGdVUZUDbenYt8fA5jZ1dlIfNfnhE5k1/+rHz6Po55mC97a2q7zlpU
         8EE/TdGkhyMAvro/t+MweZriW0FP3kRTb+XkODpN/r1pEcPZfGZH+S54yuhO72VIZTEe
         Gq6AL8Wx1PtEqss9JaXIp+zJF8ki4ydocOI6oIe2tISvXTZrqB64Msh0VsCuhjxVS9v2
         h9N87JAoGMRHGKpbPCtA5L95myDo64uLw5i3MPY3ul9tvhJUGpGAcZR0yj6Nj4Lih/MH
         I5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179388; x=1703784188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbaMMVd6M1iDuxSIoW00jFQ0sJ8tIutmqRqJ6htdWqo=;
        b=ZkmgspZFIbgsL5GpbFnftBR4ZgX/w8VjYjsP6ffLk/y5Mofeb4JSyWKEFT4Y3HtVBs
         q8muYwcnsiVed2r00e1aErGTI+3aX8VouioimcwfBoDWcUT+MiF48xz5CBqxno6ge1tO
         GQ+9xZjH5CD/FBdkMpoJFxHN7h/AHi7aEURFBVYN27N74ZZVd2yp3IHXKRUhaMBnhHXO
         xtR7ILn0knpL3pLOYfTaIldYoa6bIozlh28GH7ES1ufh2cY2F1YXkFwfa9uhN2XPiuli
         LYk4pvD6y48h1OQPcVGO/jxD4B4pQqS+ETnBPY4sGYdj6jaHjCyiPdYTnSNuwP5xGtPJ
         14oQ==
X-Gm-Message-State: AOJu0YzGJFB4BTWsaJlpchUZUi77bZS0Z340rJoYgbH6dA9X3bnxSYYa
	WKTMYaSXxmhiehqzhNJXRcwyjQ==
X-Google-Smtp-Source: AGHT+IFAAPgBh+xX+ojjOPRWpd2rXJw0kIl85DDLDtDjQDFORQWgjlluEOSf2sys499dxS1Jhkts6g==
X-Received: by 2002:aa7:8207:0:b0:6d7:28e5:f2a5 with SMTP id k7-20020aa78207000000b006d728e5f2a5mr4126614pfi.65.1703179388245;
        Thu, 21 Dec 2023 09:23:08 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id t67-20020a625f46000000b006d6b91c6eb6sm1990744pfb.13.2023.12.21.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:23:07 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] driver core: Support two-pass driver shutdown
Date: Thu, 21 Dec 2023 09:22:54 -0800
Message-Id: <20231221172257.2234320-2-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231221172257.2234320-1-jallison@ciq.com>
References: <20231221172257.2234320-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092311_695752_2B8D615A 
X-CRM114-Status: GOOD (  19.67  )
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
index 67ba592afc77..a66988cbaad1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(shutdown_wait_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4769,10 +4770,15 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
+
 		if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
+			/* Only put the device on the shutdown_wait_list
+			 * if a shutdown_wait() method is also defined. */
+			if (dev->bus->shutdown_wait)
+				list_add(&dev->kobj.entry, &shutdown_wait_list);
 		} else if (dev->driver && dev->driver->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
@@ -4789,6 +4795,35 @@ void device_shutdown(void)
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
+		if (dev->bus && dev->bus->shutdown_wait) {
+			if (initcall_debug)
+				dev_info(dev,
+				"shutdown_wait called\n");
+			dev->bus->shutdown_wait(dev);
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
index ae10c4322754..6f192221b551 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,7 +48,10 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
- *
+ * @shutdown_wait:	If this method exists, devices are stored on a separate
+ * 			list after shutdown() has been called and
+ * 			shutdown_wait() is called synchronously on each device
+ * 			in this list in turn.
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
  *
@@ -90,6 +93,7 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_wait)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.39.3


