Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76288C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hweC0yGkUBskdfzYZ5VPbAI3FjUrfkbQmkkuVMgbP0Q=; b=QZz0ZM0UN8lx9wL4wtQQL4n1pQ
	itkt9BKlTNjBdCCdGNo6xSac8xxFRiXqbj4XV3+K1UIH+B98BQ8dwdDD75tGFKDIsqf8Q19lu4flt
	Hn7H2vgYUV/uvgcVzNr8JM+Kqax747hZmBZS7bXnwNjeuIB+7wDyYwtCJn5G2/iuECCOyzYjrsoQS
	hojcsZsZNOPQcRF8nZnjkQBvGv7B2BA6dM3gKRDEVObfnZD38WARhyWhbaoPd2xXl7zSFMvQcNmlo
	59z0mhORsfxyWfQcXUa27fnkSAiaNEUs/A/ctYcV+oDGOXHIZvfK1xaxhjtjiqcyKznB0wGmaEFzH
	IQy7dXMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf4-0000000Bx5O-2osf;
	Wed, 07 Feb 2024 21:40:54 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpf0-0000000Bx4B-3se6
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:40:52 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d72f71f222so9775995ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Feb 2024 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707342050; x=1707946850; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hweC0yGkUBskdfzYZ5VPbAI3FjUrfkbQmkkuVMgbP0Q=;
        b=A2JuP0NCm+tYgg988R4wF9+wrjl/Ozos4aNwjxUwHrSngU9u0GBmup+AdAZx3Jmj1f
         ST4yLU5VtHXci9pp56cbLrEwYVY2qey9rb+9xWBNBCnPPXH4aD3NVq/YvDm8VJOrhCN2
         YfU+eYrFp2BuNz1hFZM44sETpICpoKCbTAD4Bpdd0y2Ht2lmJuD2KSDED3+Fr7Yytxo+
         c2DnQhfNJ26pcswFd0NDCnUi9TWShAVXx50wjh4QOQiHsEVntTLkoXZJ0ijxPKFOx1WR
         ndnb03mop9DfsJWfgJKwijfzfLx7LhX3G1iouPJFYu5wmCkkySI0juwmIgOJ2UI1wZrE
         R/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342050; x=1707946850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hweC0yGkUBskdfzYZ5VPbAI3FjUrfkbQmkkuVMgbP0Q=;
        b=s+g+kLugxc5dHkmKOnNGuP7+PZQUCyWkkS9p5IQvfoNsuFv06abVYWNUX4cxKrFU43
         6m4yuel4v3e6F/wQoOVHN93/DCHzAGAi7QDswiAygwu2wenS5Cl2YuURD1eTlZFpqqCg
         myQczrn+hy6oovb0RtBgN1rCZ/RC5GLH+vwQZXjwyG4c/QyILI4g6XZJNaO5z8QF2XIZ
         QZNS2wSUFK67+uVScY2iWlRYzIDyGDP+M9CCtIelxuSKbhra9F6se+Na92NMPKpcMPdy
         L6DtRUW4Sul5tl1JHX7vGl9khFauFSk82srQM/amkS82OM4efZM1j1uJV8HpHMlRg95F
         jG4A==
X-Gm-Message-State: AOJu0Yw+8Mz44vJ3Led2hhViVFcNBQ11KEjkq4y2/wt+hhd/sxuiPCCT
	MmYuK55KI6SMjwvw5S4vqpRq4ns4yH3NjuDiuUExVTFf+XtXN79lbzYbi1vuPe8=
X-Google-Smtp-Source: AGHT+IHeFB02NED9tHvG1yWlJeHGIUxBN9BP5uZJ2Ucb7EEvxaVA0vkW6jLdqQU2Q7FjgcUXqHylrA==
X-Received: by 2002:a17:902:cf4a:b0:1d8:ee40:a96b with SMTP id e10-20020a170902cf4a00b001d8ee40a96bmr7173300plg.10.1707342050244;
        Wed, 07 Feb 2024 13:40:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG+l77hIR8z4qdxl/jI+pvm0X9a1KGZ4r/oh4cZqx9UXz/t1BsXbt5MgHYZdH0qnT5vjBNE6lye6XD995VYJDjii8HeXCRHYmB75v8G5JTpXI9g8XiZkOTR/DITA+SqlpHCEmomNkrky3YAgLSRjNAJPX8RvnYVdoywrXK+TSEqTmOhYJF4PBnal7o4wdIR3tjeusU7O73nXACHaoNHQ41GyEyvyXbiRWCEsFNmi2wANqldkw5h9WMf1NBvGqAW9n5GkW6iB1spOK1
Received: from localhost.localdomain ([50.76.39.125])
        by smtp.gmail.com with ESMTPSA id ml7-20020a17090334c700b001d7274cbd33sm1939005plb.121.2024.02.07.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:40:49 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	sagi@grimberg.me,
	djeffery@redhat.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/5] driver core: Support two-pass driver shutdown.
Date: Wed,  7 Feb 2024 13:40:40 -0800
Message-Id: <20240207214044.2374295-2-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207214044.2374295-1-jallison@ciq.com>
References: <20240207214044.2374295-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_134051_006520_8E61D0AE 
X-CRM114-Status: GOOD (  20.12  )
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
index 14d46af40f9a..c8b0d4c9abed 100644
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
@@ -4789,6 +4797,33 @@ void device_shutdown(void)
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
+		if (initcall_debug)
+			dev_info(dev,
+			"shutdown_wait called\n");
+		dev->bus->shutdown_wait(dev);
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+		put_device(dev);
+		put_device(parent);
+	}
 }
 
 /*
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 5ef4ec1c36c3..a4132c44dac3 100644
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
@@ -87,6 +90,7 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	void (*shutdown_wait)(struct device *dev);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);
-- 
2.39.3


