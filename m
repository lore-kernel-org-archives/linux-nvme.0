Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEAEC52D7C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M1s37SmFSoutq4Cla0ROl94+jxjLFGaNMPkeu36ZGaw=; b=tvKDL/26NvNmCjfCTI/S89cLtR
	k0Yfqc3pUN3CP93yOrM+6S5v3ba8tpsDR73Azy7zkXDY/FbL694Ia3GkobezscAfyOx6Kotn7td5K
	y/C7MOSE0oT8QNvr0XsKFGgu/ejWgIN3XdLXpxL5X4GWpvZNh5N66mMDsiwylhzIyX9QVVYLlJEiI
	gy0KEqEqD9Pa3Dac++CeLe4ZkncgomgK7+YtwwTE9d632izuzUWND/hkYGimwqE5SjaM4uj62HjXy
	ozPNlHZ6nSPIXaiL6XqJ29dbdDree9oONq6RcF0APaSGHSFsyEWes/9QFHnH47uW/Uh0L7/O5EtRl
	L2DVk/VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPr-0000000EDce-2vDv;
	Thu, 22 Aug 2024 20:28:19 +0000
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEPo-0000000EDam-48SN
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:28:18 +0000
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5d608060241so943358eaf.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Aug 2024 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358496; x=1724963296; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1s37SmFSoutq4Cla0ROl94+jxjLFGaNMPkeu36ZGaw=;
        b=aRdQE+lwgsEjNct0nitlwsQTvXicx8pa8k2psmDKeGscBB/j9UCQGIL6Jaxm4Evfs5
         NAw6ABtRQslxFz5JalASGDe+RKGCHdW4EbN0qTMZxF7cglMXi4yX7J4WncbPkF1tDBi8
         XmXXBPluVrV2Ow95+h12x66+8OgFjXth1i3FP75moJ6NnL0zl4ftvJ9VoZ25OKAfe1s2
         NYti0Y4WpFFp3rbuH4nz1565C63rLtt7oJSpE3exEx7vkS50ReMTjSexjuECQxk3Wbmy
         wUy22XKwva2k9OzrtF4r3WJgGcaWWfABFVYYa9kS6wjtcCW7eFl2YNqOKZ9GmN8dpWac
         14IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358496; x=1724963296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1s37SmFSoutq4Cla0ROl94+jxjLFGaNMPkeu36ZGaw=;
        b=GQUpteafK0c7iEZh1rntTouH9NfcU8h+Z9D5nj79DI4G/pjHXYEkF2BOp49SkoZUbc
         3MpDOmrO1TY1t5s9iYvct1D1DP6GaEhVqEo045V9IAu6jt0tEWnW0AY/1vmFSGkiLaYi
         RWx9sn3xMLBDVLlzcTeDHkv6UOMyGC8/kWCLRX5AuvVCfgKdoE+SwEPYL875KKiOsbkD
         gAU5ngOZyMSD9LxItqyR2g4LsccFQ4uHRwtF6topOvBFU5vDZXLmIdVvHOg/rjHma24Y
         Vnr1JAdNLsTvq6gBq36194Vd75iWKzo4Jw9w1eI9HPMHmGy4VnjqRVdFG0SKoacdocOo
         0I3g==
X-Forwarded-Encrypted: i=1; AJvYcCUNHsmQrPHBhZ1daJQsv1mXFlJA6uoOmCIaK/vW1Ez7jc44aDLSadJ5xIYxR1Xq7I9UXc8X27B6aNfd@lists.infradead.org
X-Gm-Message-State: AOJu0YxvwEmrOfD0ec4KRcjz5vcXPxY+HrWPJGHAb2QyycXGSnJSA7JM
	ydRn7+3n19pfVPOebxuTOMViXqqaw2wlV5FhYL+sqmBYPkvHnRnK
X-Google-Smtp-Source: AGHT+IESHeMuha44i7IqObiLapfOnL+cMBaJAbHcBE9nj4YdYiZRc6zMz0Cm5JYiCByoc907pOT7Yg==
X-Received: by 2002:a05:6808:30a6:b0:3d9:e22a:97a4 with SMTP id 5614622812f47-3de19576b43mr8046514b6e.36.1724358496188;
        Thu, 22 Aug 2024 13:28:16 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:15 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 2/4] driver core: separate function to shutdown one device
Date: Thu, 22 Aug 2024 15:28:03 -0500
Message-Id: <20240822202805.6379-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_132817_046741_1862A3DB 
X-CRM114-Status: GOOD (  16.70  )
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

Make a separate function for the part of device_shutdown() that does the
shutown for a single device.  This is in preparation for making device
shutdown asynchronous.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 13253d105062..7e50daa65ca0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4781,6 +4781,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static void shutdown_one_device(struct device *dev)
+{
+	/* hold lock to avoid race with probe/release */
+	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
+		device_lock(dev->parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
+		device_unlock(dev->parent);
+
+	put_device(dev);
+	if (dev->parent)
+		put_device(dev->parent);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -4817,36 +4852,7 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent && dev->bus && dev->bus->need_parent_lock)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent && dev->bus && dev->bus->need_parent_lock)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
+		shutdown_one_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
-- 
2.39.3


