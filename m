Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC1AC4707C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 21:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zjJXf3dlVfBZpJFa4o7hrlYbSveCH4GtmYG943KOpVs=; b=pL1p0AehRTxxAqAa2Kh4BTRAAb
	FYMEMNETv6MRqeteG3Ry6Iu67e7plPjAGg/WEIIc0CaQCdiq7eCTMbDBv0dng15ruWLiCofZwkwoY
	eLGgd02hliJhIUukEmNRr9ilgd+7uvoHhzE2o65YzBqQPHJAlLyTjXe1bjFa/ObO23QCwV6xEyxIm
	1QCxLNfG1GMmMqlnHj8EV3bAy4ES8V9rrShEbDQKDYUlE/+IjDiYoHekgpi+BzvVAPdNB8cB+38Dx
	8MGOD+GquCmmyOpI6s3QpCZOvDHcTD6XDwE01vF/dx9ZxnfVUtaC5co+pQjJZpfHpJTgfi5SQaFm9
	4bTga8kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PS-00C6nk-3B;
	Wed, 03 Jan 2024 21:04:18 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL8PP-00C6mM-2l
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 21:04:17 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6d9cb95ddd1so2385705b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1704315854; x=1704920654; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjJXf3dlVfBZpJFa4o7hrlYbSveCH4GtmYG943KOpVs=;
        b=C8ytWEWUmuifgkDum8T68Qmh8PCPDfEMLXw8MgD99sBpw2ocvz+J5itm0JQMiDMr+q
         PeFNwhqsrkaMP7cgUCdcfjf6Z+0PBDR9rj/8LSrDNhXZmR6f2FhyRgOZ2Zxx3wpkz007
         ekBekYZyd6QMZ5J7ENflNDa9EwYF/IpdjKH6N+1130x5fYXGUn3yIgJTVimSgdGQgR2n
         O35Cm8Zqo6vTXcPVP4mnLGTJx1lGaJwIPiReTtYk8mji2AUMMcICY8HNJmlY3dvrmOsT
         UefDbtUhlMbVZzNsI3MjxFj7TyTRaQUoMW9QI8UjpBnq9UF1xwQpyapaxXoadek7HuXU
         4/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315854; x=1704920654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjJXf3dlVfBZpJFa4o7hrlYbSveCH4GtmYG943KOpVs=;
        b=aY1BBCCpWf+IfXT6ptQzAeZB+Fe2GK1riY4UoTwB8M2SHpZFJak8tCANCpDYwqG5I4
         4zS/u3n8917wqrBX7MpFZcBD0qm5rYkXTAenafpQzlW0opQQMtnIPYqneLcpfGnUeovz
         iPphavvOxfIXqdaMZRTcQm63DIm7AZjlaB4TC0PkbH0h28RPntxXbeTVAr+nEQE4tXJo
         EFXj2li58yWX6GnvfaNEqMa5DZuklKK3IK5/l2h550QghevtaHss8vzIUlr51B8s/e1A
         fTlPJv/O6l7iPFTlhUWvBFtJP5iercrEmzBEeWzSS9p0fUZR8x/WKYIVQwsuGOYm1J1D
         M+AA==
X-Gm-Message-State: AOJu0YwMdKw9eLjOuoh2abCqJvVHeM5G4HT6IowByjBpxCFzTKcM/SBT
	TA/eyfXKrr6u6AQOyOG7tWi+gRHv46MN7g==
X-Google-Smtp-Source: AGHT+IHepTzUStQk6rdX4Q9DnD0Un04czqgLsROKf/7I8/goQH3KJz+GF9JvQenefS8YEanzIZ+S0w==
X-Received: by 2002:a17:903:2983:b0:1d4:5282:f26a with SMTP id lm3-20020a170903298300b001d45282f26amr9617884plb.118.1704315854426;
        Wed, 03 Jan 2024 13:04:14 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d414a00fd9sm22505837plb.29.2024.01.03.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 13:04:14 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/5] driver core: Support two-pass driver shutdown
Date: Wed,  3 Jan 2024 13:04:01 -0800
Message-Id: <20240103210405.3593499-2-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240103210405.3593499-1-jallison@ciq.com>
References: <20240103210405.3593499-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_130415_891437_094D28BE 
X-CRM114-Status: GOOD (  20.07  )
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
 drivers/base/core.c        | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h |  6 +++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..e1f4c54de3e1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4725,6 +4725,7 @@ EXPORT_SYMBOL_GPL(device_change_owner);
 void device_shutdown(void)
 {
 	struct device *dev, *parent;
+	LIST_HEAD(shutdown_wait_list);
 
 	wait_for_device_probe();
 	device_block_probing();
@@ -4769,10 +4770,17 @@ void device_shutdown(void)
 				dev_info(dev, "shutdown_pre\n");
 			dev->class->shutdown_pre(dev);
 		}
+
 		if (dev->bus && dev->bus->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
 			dev->bus->shutdown(dev);
+			/*
+			 * Only put the device on the shutdown_wait_list
+			 * if a shutdown_wait() method is also defined.
+			 */
+			if (dev->bus->shutdown_wait)
+				list_add(&dev->kobj.entry, &shutdown_wait_list);
 		} else if (dev->driver && dev->driver->shutdown) {
 			if (initcall_debug)
 				dev_info(dev, "shutdown\n");
@@ -4789,6 +4797,35 @@ void device_shutdown(void)
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
index ae10c4322754..5a36af80cabe 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,7 +48,10 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
- *
+ * @shutdown_wait:	If this method exists, devices are stored on a separate
+ *			list after shutdown() has been called and
+ *			shutdown_wait() is called synchronously on each device
+ *			in this list in turn.
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


