Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AB3C4167D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y2dyVCTPH7QyrMqmCIoXCdpc6AxhKpEMKqDAf3tnv3M=; b=P+RqAlJigtNvYQKh3WZeyhAixn
	0y9JY0hSyjo3OLgVueLeRa/HWb01x1A3g0yqWLKIfp8Stu5TgRHsr+GzZjPt6im+5eWdg05CQeqJ9
	tMV02YO1PE9YzbHPaX6nopAINgUdZCUMsv6vbHnX8tHcabuO4AsRuk19kJM5PS+WLkJ1NnYAPMa3T
	GvIpm13ctqnuHycc8PMvfypc1Plj5neGIlFKvH1HdplM2qABHeV73i8owHkTeQohAUWQzj37lILXr
	AENUMGjUA8P/y8ajAgWscIebZaINxh80awEk5le/U629tHsOHNXtCoumCfvVHoj29Ldxou1rHjLVf
	ZBl6SzIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7CX-00CSgj-25;
	Tue, 12 Dec 2023 18:09:49 +0000
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7CU-00CSfv-2p
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 18:09:48 +0000
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d67599613so37882665ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 12 Dec 2023 10:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702404586; x=1703009386; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2dyVCTPH7QyrMqmCIoXCdpc6AxhKpEMKqDAf3tnv3M=;
        b=il6w5kTsQ6KZoD7kb1+U4q8RRAvM9EXJMOVDGTeuXPwM6kfcHALgzdvS8OmC8JX3SO
         ujAREc8tr2sOqUBQQ3dAGArgVPEzqVeEc0XM23UP/OnDiQEGkc7JFog5t/zMOGZIaClq
         Vxu1Fmw5oNbGmWh8/140pfmTedwbanWlyq+9rt9qu09fXeD5S0PwiSbrm/G5SMQuuiog
         DC/Ffyf9IVOXtwNvbtDhH/bZu6dnlfGGdbMbbdGgqDp/CrjZWn4WqKEwosZpLYJI62N9
         egjUCFk0L6E4yCWGKYsUcdZYZJAkSjbNNNX20bOpk80rAnMMCmiwTgchl9K5yQm7g+0/
         6STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404586; x=1703009386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2dyVCTPH7QyrMqmCIoXCdpc6AxhKpEMKqDAf3tnv3M=;
        b=p8x4gYarHN6o9LAqWiogE9pDFoL0qHHQV4U5ytDG7chpnSBwRH+2HiNRJng8Y9XcC2
         kMCShMEUBTrwE4H5RWiDSXUZ44XUAaHd/ef8f5U3IJ82mclW3/frfPebEw6dbEkIysgA
         s4yWD+eX+RlmOdD6uvVWDq+5iEaolib0Jb4zdni1JC03mLBOZ/Gb+ovgMBC7hGNX6LgL
         Q626KRo4UZB5fIPrLALXvX/3C/uRHamzcsPnGaj+6j4PkflaCExo0x7DAnVeNuwj65g3
         /Rbt0CNJaNfzz22hd5URoULDUWb1mUUyTWRFVomRsypRSABZqffJoNSlLP2Xa4cpdpEn
         RMow==
X-Gm-Message-State: AOJu0YwUIIlN5xyCu2GtOdRUJZn2BAPLOB0jJGmr8TLDNo0eiXryxn/+
	3jgRfNxxVkjeWRtssQRJNLNRWQ==
X-Google-Smtp-Source: AGHT+IFBFF2oktNPurIk5bGWwhiJE90WG1KmnWikbZhNPSaGeKkqoh1gUegLaotlC3Me2GCWXiWx0w==
X-Received: by 2002:a05:6e02:118f:b0:35d:5a60:fb7b with SMTP id y15-20020a056e02118f00b0035d5a60fb7bmr7399649ili.116.1702404585796;
        Tue, 12 Dec 2023 10:09:45 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id x3-20020a636303000000b005a9b20408a7sm8419861pgb.23.2023.12.12.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:09:45 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Date: Tue, 12 Dec 2023 10:09:36 -0800
Message-Id: <20231212180938.397403-2-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212180938.397403-1-jallison@ciq.com>
References: <20231212180938.397403-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_100946_917935_461C39DD 
X-CRM114-Status: GOOD (  19.28  )
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
backward compatibility.

This changes the common device shutdown code to enable devices to
participate in asynchronous shutdown implementation.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/base/core.c        | 39 +++++++++++++++++++++++++++++++++++++-
 include/linux/device/bus.h | 10 ++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..d9745822fb50 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(async_shutdown_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4769,7 +4770,14 @@ void device_shutdown(void)
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
@@ -4789,6 +4797,35 @@ void device_shutdown(void)
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
index ae10c4322754..cbcb001f6336 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,6 +48,14 @@ struct fwnode_handle;
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
@@ -90,6 +98,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_pre)(struct device *dev);
+	void (*shutdown_post)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.39.3


