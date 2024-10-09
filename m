Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC0BCEE33B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuL/8aIw/afMIlL0zgRWmNHbdROCz4p8+8UOkY7QcKo=; b=NjF0LVl/fJ2mPjDb9Zr17y6cG9
	d4oN1ihrnPf7tyM5JLOdTSfXQxkUzWMfiah4eC1PrvazAe1gLlYM7wWwJdHcummahQ3ykxe7WCTvC
	jk10TtVH+f/DWT1hvh2KKrolOcHfvQ2SIUJwMOJke60rERlDdyGDK0KLSZZjP4cJraY0eZF1KTm8I
	HoHprgrkz0CbrNEXlU3VJz27+oS9y5Ajry2ZABLEMyIpfwC1Pn3h8kDRD6Aec8gX93/MWSHEwe0SA
	povm7cBHWTnf3BiOC0b5pDZo9oxgv1d+4vVqqUxwyibjFPYm6waT5wPChxJ1c+skGm4IsUiKgjc+N
	3QuMn4jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syaxb-0000000AISC-0OkX;
	Wed, 09 Oct 2024 17:58:55 +0000
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syawg-0000000AICI-22VK
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 17:58:00 +0000
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5d5eec95a74so29120eaf.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Oct 2024 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496677; x=1729101477; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuL/8aIw/afMIlL0zgRWmNHbdROCz4p8+8UOkY7QcKo=;
        b=SWxqvaK/GbTl4yvN4r+1x4eLqWaUIckOBfLp9XtahBxb/PrPEqbCXT++aViVT2sxj7
         wvT1U9OMN23u7/G+rTnNqZCq1HuMET2cP7zDq5ZIMXYBp4GpvaFnbET8YZgGN1KnBIQS
         3NYlP+SqWqETnyHsJWqAW85PZtly2zRjrP/YTnROiXU2YiBGt6yAwnLn5Z7tM2qjsZFY
         3jgVQQxvgKoWySoljkHEBZyLJdg9F7qoCMv9bKvwntytepC9GJiPbueXWoNUTqRo77Ft
         3mYQGCh51Ya39XxEMR9RzIQD4H4clI6HaYqff3WnRXP0GUSzefMZouk3DCnCzAKyfc1i
         dzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496677; x=1729101477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuL/8aIw/afMIlL0zgRWmNHbdROCz4p8+8UOkY7QcKo=;
        b=eCDL4WaVw8Ga6qzkCfa+OPHXpw45GsMtlJQqE+UTsKvoAo+no6hEv+8P7bQXxQZz90
         71nSoo31PNGdEQqREad4xNiKGKTcA5GPD5uYIcaSAjnKoUiquAEdgjmUnJN9Sm9XB6Z3
         tcXwy/DXJhQPb/lLYNQnaeEH+Ly0zVBXx+H3iNBJF6G0hhmwVMRGuJXAb+gI2Dt6+l9F
         nCXJQL9nCH527N8gZUDxuVtV8QiPwqwDeVtej9rG2q7N7FyH4oVUTvlfyMT/MVi/Uzp1
         76hk+tk2pn80mI1EN3BXxHQNyqdCorF/dMIV/kG65N87y25I2hiB/U4lPCe1kXTsxf3t
         Vr2w==
X-Forwarded-Encrypted: i=1; AJvYcCWBaz+jQp6ZEsi7A+LLkCN7saYfSZHXdOcF/GNSVLLBkQ+u51E9ajVt9P+D15eJ2PzTs0MErEn0JTZ2@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9lPzTC58M2DtuoMCKF0jaRI93+txWbj7+m47Ocm4vZo1kphda
	nbZ/YKRhQlvNts3Go0djaAqIGmFAA/3nrmqdl53eOeMmqyJiA39x
X-Google-Smtp-Source: AGHT+IE/e+vGPUrJ26IlI7cLrBAxrlVYHJ5MhFchi6chEvdYi6UN+vPbB7ACvmCE2pKN5Yd2RD2hpQ==
X-Received: by 2002:a05:6820:1992:b0:5e5:c49a:b53 with SMTP id 006d021491bc7-5e987c3014amr2857685eaf.7.1728496677079;
        Wed, 09 Oct 2024 10:57:57 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:56 -0700 (PDT)
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
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v9 2/4] driver core: separate function to shutdown one device
Date: Wed,  9 Oct 2024 12:57:44 -0500
Message-Id: <20241009175746.46758-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_105758_573863_EF3FEBF0 
X-CRM114-Status: GOOD (  16.35  )
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
index 2bf9730db056..4482382fb947 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4779,6 +4779,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4815,36 +4850,7 @@ void device_shutdown(void)
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


