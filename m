Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8584C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:References:Mime-Version:Message-Id:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vu+tbewZC1L8tNZcdnISH4xxfmEZ4vDTSNrfXZHLvPE=; b=2gX6x9tXsXon+1z/EtEu5yLdWg
	7TwRwt5MapxsczJmL/zUPE6Ig+dUDcx53ONitcaI/JHdgL5/CmBvWMAZT59bFyiFp7Khn7ik4e7lY
	JLY7eqsAaKWSYAWDzsz+yawwrJZEBiUQoDCK4SsE+gwahIQd9vyJCj4yRw/CAcq3HyYp8tnf+w/p3
	KH97NufVLc0Bh50aUwH40ay4ZfL9hVmS8Od+vFEkjAXTCdrUmpmgXz1ApDZvHiEO9XeLTfvLhx7ms
	C3mzrFYhou9hYnrGgIeDOgKJ65QVyR19PYXEz6mDoJ3mKfhmZ+Q/zD3v3QXXyZqUFB/8z/ZajhGQt
	NJMGw+5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nePEz-00FzEd-PW; Tue, 12 Apr 2022 22:44:05 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nePEw-00FzDx-Fh
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 22:44:03 +0000
Received: by mail-yb1-xb49.google.com with SMTP id
 q196-20020a25d9cd000000b006419cbfbe34so270706ybg.9
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=vu+tbewZC1L8tNZcdnISH4xxfmEZ4vDTSNrfXZHLvPE=;
 b=A+K8pYUBsHgL6smGFqlwdaGolyd1WSaLs2CJu781D2KugJNhkIcxatZ/BkJUcRGwsD
 BmMWeCu8OCCkYzco2VjqflXFLm4AzUcmyxBs8n0TaTIOMdjnESI5O2EicQhFPqdp0NN7
 fNiyrKG7UB9dFuczLb0Wysld+4bWa7aodWBsavyrCBP88t2S53hrfnrN7MzPLGFKXvHr
 /YhN1rKHnO9BC7DT3iaP6/lwbF2qGlgqPA2iURWyhzsLr3eeV+hiMP26g5hWkgmt/66H
 sKWrEKFx8HcrbShKcF+wKv41p4dD63z1a0Mbz7JP0apEU6pOYr5sI9IPmD2PxHm6FdIA
 oUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=vu+tbewZC1L8tNZcdnISH4xxfmEZ4vDTSNrfXZHLvPE=;
 b=koaNF/4gR+agGpPPTx0LL4PboY8xEv7HdfhIJkp0s74YW5PjbcluOnX3JZM7Ii7Rhd
 pJp7WxsHJ5FBMU2cq20PdOHUuXGukrI2zazCbXTzGwArywwd9xCrRUa7GKgdNFT4xWXV
 DI+FoCehx8i2BAElzC1jYowP58isLSgV4yYsyDnAe3f0aqVzxz+ct3RNbVV3wJqtINuA
 nT4mbrrKY1TDQwUwRfkLzcHguGgACOVL1DRgRXj3Hgs11MfSIanOcdoirC8GfVDPtY62
 mh3MscxyN7lzB//cnl4i1thunKs+W7Tmlk5rBVs9UY6dn0q0uBMwZ/tow9uPUVGCHy/5
 6PLg==
X-Gm-Message-State: AOAM532DHxrqPEB+iLGSyGPO1+wOSvCE+/eTcUHT2gpAPeMvFprdqdRf
 SM7RJehg/I6hbF3DS6JG1GblOGX6Bj2VtMU=
X-Google-Smtp-Source: ABdhPJwYB6gmE/AnTTYvT4XgOL27Ob0XRx2o/4au0mtEC42h0VLwXwN0PWba0iF+eWL2UPJd2GUmprS1JHEoLq4=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:8573:aa64:c3e8:ebc])
 (user=tansuresh job=sendgmr) by 2002:a81:1e42:0:b0:2ec:3343:6b3e with SMTP id
 e63-20020a811e42000000b002ec33436b3emr9165499ywe.171.1649803441033; Tue, 12
 Apr 2022 15:44:01 -0700 (PDT)
Date: Tue, 12 Apr 2022 15:43:46 -0700
In-Reply-To: <20220412224348.1038613-1-tansuresh@google.com>
Message-Id: <20220412224348.1038613-2-tansuresh@google.com>
Mime-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
From: Tanjore Suresh <tansuresh@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-pci@vger.kernel.org, Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_154402_566553_3C29B41B 
X-CRM114-Status: GOOD (  20.70  )
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
2.36.0.rc0.470.gd361397f0d-goog


