Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA24BCE8D46
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2024 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jnEOZ1pExE6GXIP1uo6O5xxRyy89O+vheaw1Do4bDlo=; b=fYI+k1DASqTiIdDg0OPpzdAo10
	p3HCikeIFwIitwnrhMNjVQscbZWA0pCIV3o4L5EGZ8x4d2kTIL/tqNChaxuFbU4N+pQfVkODA4AU8
	fsTsaHiuhio4PJx5g3G5Zz7F3Nh3dSU0/UTbGTALUvSYxo6jCW+VxwXHCn3x6c4zQ/pEqrqGpN0wK
	wM4+V41V6ztUDAQq3X9eyG+dlzD5cpMo9BNn8UMs5VGkxm0MaH+xtMQZxxQqe9smK643QTRplCYhg
	0CXJPAEK+LX5F+iNiTTW+5NWlZuel6u8ej327KFPd9puTawboS7bVTNdWbNnvHSM7QD7sI08ZlnpG
	qD8kGAHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sr8pi-00000009PiQ-3WfV;
	Thu, 19 Sep 2024 04:31:58 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sr8pc-00000009Pi0-0ubg
	for linux-nvme@lists.infradead.org;
	Thu, 19 Sep 2024 04:31:53 +0000
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3e042f4636dso274374b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2024 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726720311; x=1727325111; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnEOZ1pExE6GXIP1uo6O5xxRyy89O+vheaw1Do4bDlo=;
        b=I7Asc0ofWlpdX4YdMZNzy5thv/Vk0qHZY2X+/rAdpxEI33ItdZ1uFoIv385cMF+jAa
         H7s49IB3yaocmtkkS3rW379zGJ34Get9GVRQi6EaT39kq+8X+O4wD/qY7DHfReTLu1TO
         nXKcmn7BJBpSMbsEvsOhL+ac4RZL4/vnfaCDFvPbkTHkzCerK42K+kRPkA06AHTHa2JY
         er0nw1rOJosC4lyb0jwF7tvc6fLeNkU98wi9oe/0qJGIxmkXOwkGJJEFX9+kKqDNyZpA
         A4+trmxpOOZOMJk19JgICWbB8sbt9UiOElkjFyEfR2X63IDwTNT+RsgGUkkU99I2KF+o
         8pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720311; x=1727325111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnEOZ1pExE6GXIP1uo6O5xxRyy89O+vheaw1Do4bDlo=;
        b=hjZ3fC+VeJ+unvYUcBuqKI2KITC6hOIGowMMFCfPBNaxtMioGmFb63zZdklWCOjZp9
         LSMDE4+Exh3HP1WjjCr1WsR6I08Llvteqle5naagJZ4WNiWMVmJbXDkR/L+a8wbw7ENp
         cCtjFli2c0POI0w2KSmu/sYX0jWg0jSQ9skHBvHwRgmYUecUya9KZr1bQPTkfNpkvz7m
         juA7VIdAgNzaSTyNoDZQnvtE1L60NG+U9NRUmIrY0OpV+ZppdBITbXM77umR9vz+WyOP
         dbMC81xIHlddycWsO3IbV9qG9AwmcSMNGJVzhKWqpheKSWO+b9sYE3ddB414p8OMESB4
         u33A==
X-Forwarded-Encrypted: i=1; AJvYcCUMo0KHcHfbHS98j6YMNqX/fhI2Euc2tHs7h4YUsIy95HcMAfC0JRvtYBH+YuGM7L/xUIFdEBHdsKrk@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9gFlHxUfOLkrTvcx+cpBKjs0mbqDSHjQIcGiCiw2HKaogCmUe
	tSFP+6pKZGBvyVTogEjgInUwlYU6IMU5szzsRnRIvk4LXaPeASVK
X-Google-Smtp-Source: AGHT+IFPY1p11K7SNgnXsHQAZuSMJj8nXShqm/KTnmJE87uRTzNxmpFc9IFDksQCU3rAM51H34Q8Mw==
X-Received: by 2002:a05:6808:1821:b0:3e0:6b72:f324 with SMTP id 5614622812f47-3e07a125223mr12371571b6e.20.1726720310623;
        Wed, 18 Sep 2024 21:31:50 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e26b6ac829sm207305b6e.18.2024.09.18.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 21:31:49 -0700 (PDT)
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
	Jan Kiszka <jan.kiszka@seimens.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] driver core: fix async device shutdown hang
Date: Wed, 18 Sep 2024 23:31:43 -0500
Message-Id: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_213152_290375_8C653EB1 
X-CRM114-Status: GOOD (  17.52  )
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

Modify device_shutdown() so that supplier devices do not wait for
consumer devices to be shut down first when the devlink is sync state
only, since the consumer is not dependent on the supplier in this case.

Without this change, a circular dependency could hang the system.

Fixes: 8064952c6504 ("driver core: shut down devices asynchronously")

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
The patch this fixes is in driver-core-next and linux-next.

Please let me know if this needs to be a V2 or if it needs anything
else... it is the identical patch I sent in yesterday, except I added
a "Fixes:" tag and the comments.  Thank you for the help!

 drivers/base/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837..76513e360496 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4898,8 +4898,16 @@ void device_shutdown(void)
 
 		idx = device_links_read_lock();
 		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
+				device_links_read_lock_held()) {
+			/*
+			 * sync_state_only suppliers don't need to wait,
+			 * aren't reordered on devices_kset, so making them
+			 * wait could result in a hang
+			 */
+			if (device_link_flag_is_sync_state_only(link->flags))
+				continue;
 			link->supplier->p->shutdown_after = cookie;
+		}
 		device_links_read_unlock(idx);
 		put_device(dev);
 
-- 
2.39.3


