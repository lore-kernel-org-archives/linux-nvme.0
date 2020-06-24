Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E5AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 00:20:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2522053B
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 00:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E/2ktiYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2522053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1ptYIysxEzh49qPDGyR1/G+ggIVQ9uocwv5GMMPVgwI=; b=E/2ktiYHnSSFjL+ufsKDEbEIz
	2UJOrT9UmKCvraAQ85UaZTlcpFnFPP/DJbqxAmthkGv5BmzWCWZC8R2F2wq2vpWfVrASj+fI+EOPh
	lf0QNRfbdyrQ/2GO9QGXaj0lc+6aQZ5a0XrDpl6Xpvj8E6OmiiRd58Z2EJu0TQooCKuO/PkOMak8U
	B4aGmSHIX5TNpNt0JYemg0dc/+AZDc9ATZU7XEkwa0XR19vVnrQms1MVSH0osBoyRxOJvnBSP6SlO
	CNFqgfOKcyWEPvIlla6JimFlh5u2LrcgWIaYchgIDSjc+YowqZw4UGfaV7q7X6GwsGRTf4BxoFHKB
	FneoqgDjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnt9J-0001yQ-KN; Wed, 24 Jun 2020 00:20:21 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnt84-0001d8-4X
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 00:19:05 +0000
Received: by mail-pg1-f196.google.com with SMTP id b5so428145pgm.8
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 17:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=41dFWGKw6RLFkmaiH8YvPeuP0PYbYbBgWU42eAmQies=;
 b=GUPCGcmSxXPMP7Qwe8C6yK/CnEyp3B+qvQ9twzcgvquoYUJ0PcpbCbPWwEwZMabC/y
 Z4rAOQNRO0/rQ1aLZ5Y5rTgUYW2YTzzzGr3YeZvG3OZMT5AytL5tFkf2ILPfiKNXwmni
 a2395e9cery5mkTpmLsBUcdDWwqcDZcHT1E9L6J7md7zXZJV5ewY6ihIGA4plmD9fdnw
 JbudTJSBUYukq8YZ51sIvyIrZxJYU79fI8z7REqhuWE0IEF/i06rY9MeVbe9hh6+4BMM
 wk8C59w8tR3ixxrncy4bOBadTkueqZQTmt3UkBvNtW7i3zUGrr8AOJuoZjSeEFIaHZNn
 /ClQ==
X-Gm-Message-State: AOAM533Vs/LxYgEWOaEcLUF/NQpV50fKcLfKIZNtmCQ3dZDZJcHKN5yc
 9kTPm90AqSjxXw5D0BEMaE4GyIvx
X-Google-Smtp-Source: ABdhPJww7ZVB+Axlle31k8AynlMye6mvmbc6xfHhYFZXbj7b0hjzInw56uu6OsBafJfUiII0d3XAOA==
X-Received: by 2002:a63:4543:: with SMTP id u3mr13070122pgk.398.1592957942304; 
 Tue, 23 Jun 2020 17:19:02 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id d2sm14571840pgp.56.2020.06.23.17.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 17:19:01 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 for-5.8-rc 5/6] nvme-multipath: fix bogus request queue
 reference put
Date: Tue, 23 Jun 2020 17:18:52 -0700
Message-Id: <20200624001853.5408-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624001853.5408-1-sagi@grimberg.me>
References: <20200624001853.5408-1-sagi@grimberg.me>
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The mpath disk node takes a reference on the request mpath
request queue when adding live path to the mpath gendisk.
However if we connected to an inaccessible path device_add_disk
is not called, so if we disconnect and remove the mpath gendisk
we endup putting an reference on the request queue that was
never taken [1].

Fix that to check if we ever added a live path (using
NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
reference.

[1]:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 1372 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
CPU: 1 PID: 1372 Comm: nvme Tainted: G           O      5.7.0-rc2+ #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014
RIP: 0010:refcount_warn_saturate+0xa6/0xf0
RSP: 0018:ffffb29e8053bdc0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8b7a2f4fc060 RCX: 0000000000000007
RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff8b7a3ec99980
RBP: ffff8b7a2f4fc000 R08: 00000000000002e1 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: fffffffffffffff2 R14: ffffb29e8053bf08 R15: ffff8b7a320e2da0
FS:  00007f135d4ca800(0000) GS:ffff8b7a3ec80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005651178c0c30 CR3: 000000003b650005 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 disk_release+0xa2/0xc0
 device_release+0x28/0x80
 kobject_put+0xa5/0x1b0
 nvme_put_ns_head+0x26/0x70 [nvme_core]
 nvme_put_ns+0x30/0x60 [nvme_core]
 nvme_remove_namespaces+0x9b/0xe0 [nvme_core]
 nvme_do_delete_ctrl+0x43/0x5c [nvme_core]
 nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
 kernfs_fop_write+0xc1/0x1a0
 vfs_write+0xb6/0x1a0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x52/0x1a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported-by: Anton Eidelman <anton@lightbitslabs.com>
Tested-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 505f5f43cd69..de280d156bbb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -691,6 +691,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
+	if (!test_bit(NVME_NS_HEAD_HAS_DISK, &head->flags)) {
+		/*
+		 * if device_add_disk wasn't called, prevent
+		 * disk release to put a bogus reference on the
+		 * request queue
+		 */
+		head->disk->queue = NULL;
+	}
 	put_disk(head->disk);
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
