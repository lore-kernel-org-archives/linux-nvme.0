Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FCFCAC59E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2024 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qnpem1ad9XMHCNEO0doEltppxSVMaPU0TbCxRa1UzLo=; b=3q0p6PcQNLO81pJfgRG3yzlaJ/
	B2N3Q4xSyBjOShMVo9b10ff+m1GyrvsR7cpaJ+p+SdakWyMW/SNdtbn4PiaKZBNQeXbWUPMgSav0w
	3BsDpjSAZkyHReZ6El+p0sSh8/M5842gwOsr/E21wbetly6I4olJS70ABGNL3jAnOZzGKEVhL0G8u
	BAw1p4fcqhSZlXJs39tiLGBryjxY8N1WIac3+EF0fS9igc7xpgoA114B0zpkyjli6V9XS0Reiu13b
	jzLB+VvML9qYC4rrmqXVRGUdlJeIUZ0qWMA1ZZxv2WPAtqQnLxf9C1LzbZL4QOoxf0KRfLs/s8tlQ
	6a9OO79Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqecS-00000006qQc-1maZ;
	Tue, 17 Sep 2024 20:16:16 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqeba-00000006qI8-0IhK
	for linux-nvme@lists.infradead.org;
	Tue, 17 Sep 2024 20:15:23 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-712359d2c52so57583a34.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2024 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726604120; x=1727208920; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnpem1ad9XMHCNEO0doEltppxSVMaPU0TbCxRa1UzLo=;
        b=ZybXNMhuCE31Y/ePiK87e40qU1x94rKUcGmsG+uDwey3vNardeBPnbdr6YK++ioofA
         CR24/pzv4G50r9Ew43ykaRJUMV91Nhsch12JBV6XOWZviI8Co4XRvkRDMkoU4TmQMXq3
         jPUofKZ36a/eCG4etwNt2ZedttkJAZCTsf/JmU4um+tVDVHIkxyMNOyj5JkQn67yk+CR
         QofWjliju2YZN8FY4m3CpUMLphOqI3he98AFyYxkB9NXeqmQHoBBG5Qb4ZRztYIC2nAR
         Q/iOhXU9EDAgykQmKisRncScp23V53IZOdRziLTKBOfuPqxSYwKabFvOk6Ul0XIG3dSm
         MkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726604120; x=1727208920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnpem1ad9XMHCNEO0doEltppxSVMaPU0TbCxRa1UzLo=;
        b=C3F4W5xNso5+/yKA7uk4BNDwich9z2+iwhtsC7+P4jnSJW42p9Id8fr5gwWJO5QGsB
         O+08l6Pdp7h+pQZIxdxkQ5sG+XTOi8SYij11f4cRe7rqW3TsNJIXAwu0iLx2ONYFV61f
         Czf7Fub/YaWp4IYLfgzUs2BL012eDEMFzLwpJU5RKnZYUUaeTAt/FAgHRYcZ1BWKF5Gg
         fzPCnuE2O1z09fyzi/R1uigU6o2dp2SucCzuQPsevCx3FJObe1kK144HSCXv9Ak4Xcp7
         jMc0DfhcPZeZWu3YRRT94ueVPwGRkjL3OojCHiqRMGGiELWOBVyvYWQxnoaDIoqslhav
         Kw5w==
X-Forwarded-Encrypted: i=1; AJvYcCVVE7AOWmMMczGFayypeJHExyceMyCPWaStSghBQGMmkt9kamDfJ0BuBkRwidylXqTpiGm/hDq3wIjY@lists.infradead.org
X-Gm-Message-State: AOJu0YzengnYnvr+CP0ewyWP9Q3bZDYdACabh7FtDdNjuRRjMhfa+HSM
	LdIB9eDVQpEcrwM9ugWuOx1Q1Oye/3k9ba8R9WpDyWsFOLJAp9yV
X-Google-Smtp-Source: AGHT+IHYsJ26P2MaX5MBeePofbG6Q73+J96JWmdrsHLigQQKy8YEHdjmxWSVwl73tuTml2XudIBiFw==
X-Received: by 2002:a05:6830:4121:b0:709:41c4:6a5 with SMTP id 46e09a7af769-71109b666c7mr8531945a34.3.1726604120676;
        Tue, 17 Sep 2024 13:15:20 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71239e9fef8sm1658393a34.29.2024.09.17.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:15:20 -0700 (PDT)
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
Date: Tue, 17 Sep 2024 15:15:17 -0500
Message-Id: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_131522_130799_44753C6C 
X-CRM114-Status: GOOD (  14.39  )
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

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
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


