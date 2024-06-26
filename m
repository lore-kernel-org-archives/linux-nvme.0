Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6152AC3064D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/t53QVoqoslUPlZCx8x17h7LOVaKiKwVjI+I5ylRm50=; b=mgPoPi8UQvOEomZlezBMNG8BYs
	j6FRKqhRnq+R6recUgBN8tD6EshezlB/NHmen3Od4n9Kzq1lo+uokXj5kwSntpwg6tLbZbo1k9uFe
	MiNijOqToxHjzA4m9y+KlrHX6jKOjJLYxFADrquHEtWkS7GN/QlDrx8U6YuKz6ZPgPfY3IbhbEJUH
	uLduLO/kc81tiPFN5xt5ilVr7DVtHdAbe1pe+WSFvCwS3PSx+ThLzS27raUe/B4jdp/rI9kg/KS4l
	vjxgQZAHeCTqEBjJkCz0V4yz43pGC3V9guo5VpkuDWlRWvWVHLJ8JgwmokfrYU1TjHM+ff1f1tJ91
	yjo+y6Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbu-000000086LW-3vTS;
	Wed, 26 Jun 2024 19:47:18 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYbp-000000086Hf-1s1G
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:47:15 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6b4febddfd3so32731496d6.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431232; x=1720036032; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t53QVoqoslUPlZCx8x17h7LOVaKiKwVjI+I5ylRm50=;
        b=NYwuz6lHfJEidBCK8zc2uHJF3XfFpyBYstaQG2hZlPh4fFTycYLeGMJCzVqPPMCeUi
         vTLDWa1Qm3yH5w3YYBI/AgD1iOV50XWGOIj66Q60MRKoC6SPTxMjavS/NsvvdFpuSc50
         iKtA1tv9yKMucU33oWdbFuEwTeJ1wyO1VDZGgKgKCcj5QheRnkoQKtsg1F2wcLpcDrs/
         Hro4+BZSy7caOqds7np/65gn2xSTdoSVhr3KpUZXN9Z++bRbdhM9CogsmtQdXcszzETE
         dRFTMBTbI1/WTt6j3/4I4w/ySKdoP4yUSbEmAzHP9mDmkpaOL5QtT5/vb2OQoZdjqvni
         bfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431232; x=1720036032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t53QVoqoslUPlZCx8x17h7LOVaKiKwVjI+I5ylRm50=;
        b=Y4zIZbnVrkGAvXBDtY4WBKcHlobQKmIu5tReSM+NXl5ruBzGQD0WBOykNoOGGoXEAG
         sBd7ugKhYBERrVsfxCUSmHX9Ls0y/82p3NITI01M01RndVYRQFcRa7YDYN5x2NqDngz6
         HtigbTEx753O3evnkJfJuf69GqdmjCwiG2YSb/XbW6z5SbG44RBpBIs7u9LzlU6A1lpY
         iI/B+UA6RlRHLUpwRvuwO4TPMaZihnge5n5q40dofgjtJSLGkZOYh3F1YvzECka5pagP
         sJOy127FnqDkY5ikW+W0m+TQpQcKt/LR9JBp1IINYHyQc4rdolgFsSIKL7A5KQ27LWWr
         rhBw==
X-Forwarded-Encrypted: i=1; AJvYcCVRYS6MrhsHvhKZ8Y467CVv2ifcA/LYh3j3mKZ7SDpyBNgOZBNvTeZx4XqziMqW7UfO7inPrM4+H/Zop9ogfOtJg8iAP0G2oKYv6LmNl9k=
X-Gm-Message-State: AOJu0YytwCaxqlcy7PYEKJcvE9SSZQdz69HuASd/7tHBw6B286WT7XpV
	Q6iqjpOce3C97hjCIA6rXUH6lBP+tflzNajjUOSjA7tM3GIeZ9eV
X-Google-Smtp-Source: AGHT+IFBvOA+iyHRobdSxdaxMTRLIM1evBlCzixHNIMYcGypuDRbefQ1cYpWHTm6lnaQXv9sHGFacA==
X-Received: by 2002:a0c:e441:0:b0:6af:2344:5811 with SMTP id 6a1803df08f44-6b540afb170mr122808676d6.55.1719431232429;
        Wed, 26 Jun 2024 12:47:12 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:12 -0700 (PDT)
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
Subject: [PATCH v7 2/4] driver core: separate function to shutdown one device
Date: Wed, 26 Jun 2024 14:46:48 -0500
Message-Id: <20240626194650.3837-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_124713_550441_D303C5BB 
X-CRM114-Status: GOOD (  16.37  )
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
index 03edf7a7ec37..4be6071c2175 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4778,6 +4778,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4814,36 +4849,7 @@ void device_shutdown(void)
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


