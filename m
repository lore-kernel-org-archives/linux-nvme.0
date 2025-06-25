Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B17C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f60N3EWufzAACjrb2TEVwWx0frS0X8r/okvyufls31E=; b=XLkEYTobU0e1td1oJHSIdF+v/B
	mONOb4svglLk2MPMOGEITIUY39a1UjQIRcliespA2Rxaf8kI7dBZZ2djFWTRDydZQTYB+wbxYYt+f
	x2ClfmuWydwbZUa7p/tUKpszIuEjsm2jO4+WLFWYOr8SoCWH0qdFPcypzfaNXfWLlsGUjZE2Awi2Z
	lEUYhj/DfSyM0zZJ7iQZrznfANAL0fhiIpo6sS2hz9EE63wkR5IoGL3GU/uACnUKEElgHjX89ia8R
	KP8Wl3Ie2+QsngReRT8ejwf8XMe+BdtcSdjpq6aOnoZPJn8P7MumlRNs2R1ee9gEBgoQDlxX/r2ge
	6mP/e9Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWrs-00000009tFc-3NJN;
	Wed, 25 Jun 2025 20:37:16 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWaP-00000009p8P-0YJZ
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 20:19:19 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-40a6692b75cso246859b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750882752; x=1751487552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f60N3EWufzAACjrb2TEVwWx0frS0X8r/okvyufls31E=;
        b=Im0O0RJZS2LahtN2gAVCpM6dj+K7YIriIxEyakDFDK4tfmH8pv5aXCiBpYPy4f++on
         xMN5BEqiCy7RV0POmNF/j8++asPeAR5KqJYqm5lNGbRZlPYuFQ3xjcVJmyiAymuhYdB9
         9IcDxKHMlDsvyMVDziG07EV8CKWoI0FlrBFSrgSz1/kSFP8hKKnB8IV7Vzs6OgoRtvrg
         Xv28znxpvZSS1y4KYmVIwwjXqTCRiAh8iqShBLCsr/C5l1GqvvxE+7WLChhEiOVuevob
         vXLZjBwZONASEU5P/sjOmd3XKOPcFIy3iIJmcATOoucetmIqK5hw/QwsGPMjiwvZsXPx
         EcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750882752; x=1751487552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f60N3EWufzAACjrb2TEVwWx0frS0X8r/okvyufls31E=;
        b=puWFSsXUQd5MjgLtZMk4NsT618MSDRRynSuw+Dp/mUiPO7SvxbPfd3KenmEbrPQdlq
         pXvjvgqWgExrohMWUCo3SxtxJKjbCHIMnxr8u/HN3MLKlecXXMJBjdwbgpw9y/iAOP1l
         ApNfPl4z40yLObpKQUh2vZ9r15DCUzC294roUlcyxJ/0gRU20kW2BwoZ/4BQQbWQGmq+
         iU/ubVkP6ObYknEhm9TRdG3GulgxD7wJdP9GEMdVhPkTByVLwEmjguOCzcDtMWrBkf9x
         zEggvTSETYmFuIirpmTIMM7cF3iKUnwkniMhsrw1mRiK4idxlHec0GRT0rObSIF+p6td
         u3ag==
X-Forwarded-Encrypted: i=1; AJvYcCVf3QLOo1uEgZyiBjqHfRxKuFMYFkBmnunDSpu/TLR0jmPl4988jiIwhF7balnKCXSqWxrnvL1sk3RB@lists.infradead.org
X-Gm-Message-State: AOJu0YxUkatWN2RvIRzSK2q7dQ1YOske1mI1XIXS3lvmH3+IHtEwWw9l
	at28YvE1D/i0BY6KFIteok6tYM7hilCbO7aNW5q3eX7WLq7uF4LQ34hM
X-Gm-Gg: ASbGnct7Zovy17LftUzzf442UVAv/NKK+P79PNTg5FwPgdQtR39cS7M18QZQa5S/ylq
	hKcxudQxaJe3n117IxNhsejc6UttVDHgijFK4nVesw95HoGQ6a2ayVoI/MowOZqnopwQwEBcj35
	B27RMAlSidBGAn9tqofpzCCm0R06dpOaB1y8DopsC7BqCZjyE1oR28ObEI/4YLb6h3ML1xFQ7+h
	gHlPSSBD98IDH5uWLUhIOi1yCWDk7cTTBgdXT8rbV8zx2QH56QMGpemyoXGMqad2I/j+dS/5IyG
	mS8zAVnxxkDEwgVSS3u+YMwtgarqdgM3SPd7lLQrzxhMrG+y8FUgru7UQKr+broxo2I7fahZSgU
	zrLTj6Go=
X-Google-Smtp-Source: AGHT+IE1GiyMI3FcPixO8wBehxm6oIdPGjQDw2GVFgAwIwdC14AZtTmqP0n8EzwJ7ZQqJDCh44hL0g==
X-Received: by 2002:a05:6808:150f:b0:40a:a633:b1f8 with SMTP id 5614622812f47-40b05a81997mr3795477b6e.9.1750882752169;
        Wed, 25 Jun 2025 13:19:12 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d22c23sm2319188b6e.42.2025.06.25.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:19:11 -0700 (PDT)
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
Subject: [PATCH v10 3/5] driver core: separate function to shutdown one device
Date: Wed, 25 Jun 2025 15:18:51 -0500
Message-Id: <20250625201853.84062-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_131913_170574_E3AF25DA 
X-CRM114-Status: GOOD (  16.55  )
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
shutown for a single device. This is in preparation for making device
shutdown asynchronous.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 58c772785606..39502621e88e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4786,6 +4786,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
+	if (dev->parent)
+		put_device(dev->parent);
+	put_device(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -4822,36 +4857,7 @@ void device_shutdown(void)
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


