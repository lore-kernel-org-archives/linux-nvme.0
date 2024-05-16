Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563FAC25B77
	for <linux-nvme@archiver.kernel.org>; Thu, 16 May 2024 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdxvUmUr/n3drhohz+SzK2EeawufACujFjOU7myXx/g=; b=d6C4jKWoNc5mk3Ros/Ul10lkZ7
	sIs/sDUpOM8jdzYUjGpkXUKIN08SA0DmCHIb7QUUopjbecPcMENbRv4FILBcy75CjrCfh4GeffzEI
	bJ6lDgEj23eFHB6PC4mxVptM8tuBYMJUlzUaLvIVpjoeR6hOedOZWwXydf7QtMCJTGtTd9TNgmlTu
	dYGjewxJMkrXGaN8KZI0y/R/J9GcUEYlOKWH21MKRLOMISifTHzvIor+oE+2G0kHPMygDgFneCwLG
	+L/zfOzak/C9a3mqSDdG246Ml+2LGnXvfhT9uIJG63ucqbyeN4r8n+X4SA6LC9Zo5LYzJms/gGjdH
	by+lx9SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMZ-00000005NOM-0fRY;
	Thu, 16 May 2024 15:49:47 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7dMV-00000005NL8-0y5i
	for linux-nvme@lists.infradead.org;
	Thu, 16 May 2024 15:49:45 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6f0e4212d5aso262240a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 May 2024 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874581; x=1716479381; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdxvUmUr/n3drhohz+SzK2EeawufACujFjOU7myXx/g=;
        b=fCWQ0tpn4DJeE3PytTcJyhZkygHapiwRgCzbnkaFuz9EU7eAAviCa/ZONrwXStpq5a
         vWr+g+YOu9jY9T8PbtnqS+8MwNyQFjsEu3ryITQIV64v3Qs7EGBPr60kYfArL67Y9dKS
         SgZ5A/WtHKJ5chdT6M/orRqLtdEl1InbOupPyi0cMLJLs7il8jOLRvJ1MDR1s+IZQglE
         6NqwmA1Vd4fNFEBiMuxcZBEX9RI23xFOl3wD536Va/+D+WD9QLUSjnS4XS2igS5y2GYa
         vQEcLG62233VcFr4OJPE/3Y/qtHY9/CXjr+vBtI36bT+wQCtConqb3mb+mti+hxTWzct
         LU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874581; x=1716479381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdxvUmUr/n3drhohz+SzK2EeawufACujFjOU7myXx/g=;
        b=dkxUsCB/PQTEBGTN7eIX7QZf2rcH6ufR8VNdcLimrxtqV5WMotroS1KLww3C5myU2d
         586yGLN9b55HHupoEdMUa7+eWRelOQX7m74si0N2kw/TMCx3Aan0/MpsHqW9NJa6ju5F
         010dxSfUlpoSRreS7Rph5gcMWdCYXnSXo+38VLFuE8o4Jqs+fQKxruuHlGMycGQ9eLT5
         YrT1jHSvEaWpYov+CCMHzChoV7IL3/a2obxBSbAUBUuJxLleK98kM6b6jNQr1uQQqevU
         /SDQUgyvqu8bnnUdTWRG1TJmlXRDoFhgAPAlPx/PWjYlrIgnboFOaFhLJfyxzS8Yy3F+
         Ct6w==
X-Forwarded-Encrypted: i=1; AJvYcCXCBYbiFlLTv+pdZ1uwyoep+s30dSSACfXIyrEs0CuRPXwU0PwgLJ2Q4lu8GPLKtX0AHz1O1Ob0nso/lqiaouy1Bz7hhuWmORgAUtHvc/s=
X-Gm-Message-State: AOJu0Ywaa8SUzl90jmdv3IOK20QIWxbx/v3rzkf0NrzqnKF29a9oql3o
	lOEyfjeLVmoho11UaF0XwIsfp4G1KxTr2CjPuy4X4+l+ZVSVpL+A
X-Google-Smtp-Source: AGHT+IHTwAQvrUcBgReDLYo3j6uEenDDM0m6mgD/4TKTn44LluYWEepiGRIUA0sp3FRMMd0xbjb3LA==
X-Received: by 2002:a05:6870:c45:b0:239:7802:cd5 with SMTP id 586e51a60fabf-24172a4205emr22868219fac.6.1715874580898;
        Thu, 16 May 2024 08:49:40 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:40 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 2/4] driver core: separate function to shutdown one device
Date: Thu, 16 May 2024 10:49:18 -0500
Message-Id: <20240516154920.221445-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240516_084943_307286_167C4D42 
X-CRM114-Status: GOOD (  16.27  )
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
index e63177314e86..e76cba51513a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4819,6 +4819,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4855,36 +4890,7 @@ void device_shutdown(void)
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


