Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02879C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 13:05:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D785613B6
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 13:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D785613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EMZSdsUTVWCIMj59JLaCKHotZRlO5pJab7AFjAwfsuw=; b=NcgS8yK8z1/tA6H/eb0cqBkfy0
	SOtvw9FLye3z1bJYFIzdAv8KZjRhFe3P+tbcLznSANWtaMfnez3f4EMHU0tOifcj3NsG0bP0BKRbj
	KfH9b/f7Q0hc26qCvlKneH8Ef1jsMYs/ZOQMTL7IpWwz5iS9A13kxd4s8XOJPCuqj9CUzz8JNULp3
	4OsZme5YeZYoncIA3hWV8ZE4LbiNt5jVDPSGZOD0T0+Lrcuz5sda3pnXfcVESnqJ25xG+O/LTYYLr
	4pK4/cdf1HBLAs0E5N+aPXXK41ioaeThoYjGsf2MRHjwzqD+abO+GKtuqAPSe7LFHWKo2tq+UosCf
	ueYp80Ng==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhB12-005ZxI-Fb; Thu, 13 May 2021 13:04:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhB10-005Zx8-7Q
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 13:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=oZTbN3XIRG/Y9RhohN4pS+JB8UYPlexsuGmz+x82qLQ=; b=NIvJdLiZQERk/JRQoIN/JOqgOd
 oLIdqlA5GreHJTeU8d3jYjtrkR76dbn6rm1CMLsTpd2z8XAkyg9CfyxyMKzTEohs7TtWbNEzEuBW5
 HBG4+0Gh9mJzq5ZM2RwTTuJPO/JklGC99to5b0NxElehW8GEmoVatSeM3RPHMwdf/tbLOFywqNUdw
 n9Nb4lb484s5QfaOIP95SwIDjbC2IK17GEGURx5fL2m5q6LF4APnZdim59PNRnZc+ZUQGEpVJV8nD
 YbRiQWQBKpVoNPE4wA5s9P30QJYpCf/1ejwaiHC31L0b4u7QgPPxxXuWrKvIn59l6hoj7W1EAHz77
 QAPj1luw==;
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhB0x-00BG3s-Fa
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 13:04:33 +0000
Received: by mail-pl1-x630.google.com with SMTP id p17so14322542plf.12
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oZTbN3XIRG/Y9RhohN4pS+JB8UYPlexsuGmz+x82qLQ=;
 b=ldAfE87UJZwzmgRwxxUhIzPLEX27zlweHiPXip1/S9hZ9tWoqf5Y2v7pdNrA092ul9
 bsVU8oHwKPo5FQt7Ye2FJBSuhIDWFdFmxQ9EFjnsTuh+6iWdZ3X6Xfql4bqzz6k7NSin
 2Itw+U/VNayT8UO7UchSDbBaW9SdtEyll1HbDWM8QPGkA2iDKt3EXzVbfudnr3iZjaBy
 8v/2n7osIXl913Z62/CN+Dv+1R7qSUaq6NgxoSTC+AavpgUe8vTcVr/zv7TuLHaHOD31
 t8vnOBzI+0GYQzGDEbdFHqp8DDoKT/d5ZFEL332Zg5eYeRnjXHz/jhfqIS4lQV28F57k
 tMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oZTbN3XIRG/Y9RhohN4pS+JB8UYPlexsuGmz+x82qLQ=;
 b=SqcWEqTrW4WFX2uVMmjvQehZGF696RF4PIWyNZEvemkIEKOoDlxpH7tQlc5UHJvvhe
 9F1bcTV7ko97O4IgbYtOg4uP4IfaC7bCylo5LZpqbmXcJIKinX/ReQrpG7gFYN2J2aqj
 JYCODj/FwxmLKb3xFtt0mPMN2SNKHBtxeFc6P9rs4rdAp7gfDp4GUOKgEMdl7dffMav1
 u1He5rJDU5vgC79FyEbBzE5ox17qpPpQ0x25rpEB2whMd8k20lUCxHAjpm1ltETgM/Jd
 76cqho0IWajjdAa06QEDXEQQM7tm5BWf3YXYFujxmdkcXyD16z9RDP0vAPoCpw60H0Vp
 w6Yg==
X-Gm-Message-State: AOAM531k2fvqdkaASWiTTdek/g0Fx8iVz5h6sBxLOELCeVYUDfM68Fag
 Y7sXibsf+dcQvrykp3bsEv4=
X-Google-Smtp-Source: ABdhPJxsgio0Y/sSJ4Bmdn4O6u1Iwnl2M21LcyD0yITwdtYqZD3nEkT/Jsmeah+4n39lmgIzC+zXeA==
X-Received: by 2002:a17:902:b781:b029:ef:6721:b956 with SMTP id
 e1-20020a170902b781b02900ef6721b956mr12519965pls.70.1620911068148; 
 Thu, 13 May 2021 06:04:28 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id a129sm2179845pfa.36.2021.05.13.06.04.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 May 2021 06:04:27 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH] nvmet: use new ana_log_size instead the old one
Date: Thu, 13 May 2021 21:04:10 +0800
Message-Id: <20210513130410.1186-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_060431_598599_F8C451C8 
X-CRM114-Status: GOOD (  13.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The new ana_log_size should be used instead of the old one.
Or kernel NULL pointer dereference will happen like below:

[   38.957849][   T69] BUG: kernel NULL pointer dereference, address: 000000000000003c
[   38.975550][   T69] #PF: supervisor write access in kernel mode
[   38.975955][   T69] #PF: error_code(0x0002) - not-present page
[   38.976905][   T69] PGD 0 P4D 0
[   38.979388][   T69] Oops: 0002 [#1] SMP NOPTI
[   38.980488][   T69] CPU: 0 PID: 69 Comm: kworker/0:2 Not tainted 5.12.0+ #54
[   38.981254][   T69] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   38.982502][   T69] Workqueue: events nvme_loop_execute_work
[   38.985219][   T69] RIP: 0010:memcpy_orig+0x68/0x10f
[   38.986203][   T69] Code: 83 c2 20 eb 44 48 01 d6 48 01 d7 48 83 ea 20 0f 1f 00 48 83 ea 20 4c 8b 46 f8 4c 8b 4e f0 4c 8b 56 e8 4c 8b 5e e0 48 8d 76 e0 <4c> 89 47 f8 4c 89 4f f0 4c 89 57 e8 4c 89 5f e0 48 8d 7f e0 73 d2
[   38.987677][   T69] RSP: 0018:ffffc900001b7d48 EFLAGS: 00000287
[   38.987996][   T69] RAX: 0000000000000020 RBX: 0000000000000024 RCX: 0000000000000010
[   38.988327][   T69] RDX: ffffffffffffffe4 RSI: ffff8881084bc004 RDI: 0000000000000044
[   38.988620][   T69] RBP: 0000000000000024 R08: 0000000100000000 R09: 0000000000000000
[   38.988991][   T69] R10: 0000000100000000 R11: 0000000000000001 R12: 0000000000000024
[   38.989289][   T69] R13: ffff8881084bc000 R14: 0000000000000000 R15: 0000000000000024
[   38.989845][   T69] FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
[   38.990234][   T69] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.990490][   T69] CR2: 000000000000003c CR3: 00000001085b2000 CR4: 00000000000006f0
[   38.991105][   T69] Call Trace:
[   38.994157][   T69]  sg_copy_buffer+0xb8/0xf0
[   38.995357][   T69]  nvmet_copy_to_sgl+0x48/0x6d
[   38.995565][   T69]  nvmet_execute_get_log_page_ana+0xd4/0x1cb
[   38.995792][   T69]  nvmet_execute_get_log_page+0xc9/0x146
[   38.995992][   T69]  nvme_loop_execute_work+0x3e/0x44
[   38.996181][   T69]  process_one_work+0x1c3/0x3c0
[   38.996393][   T69]  worker_thread+0x44/0x3d0
[   38.996600][   T69]  ? cancel_delayed_work+0x90/0x90
[   38.996804][   T69]  kthread+0xf7/0x130
[   38.996961][   T69]  ? kthread_create_worker_on_cpu+0x70/0x70
[   38.997171][   T69]  ret_from_fork+0x22/0x30
[   38.997705][   T69] Modules linked in:
[   38.998741][   T69] CR2: 000000000000003c
[   39.000104][   T69] ---[ end trace e719927b609d0fa0 ]---

Fixes: 5e1f689913a4 ("nvme-multipath: fix double initialization of ANA state")
Signed-off-by: Hou Pu <houpu.main@gmail.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index deb14562c96a..f81871c7128a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -817,7 +817,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	if (ana_log_size > ctrl->ana_log_size) {
 		nvme_mpath_stop(ctrl);
 		kfree(ctrl->ana_log_buf);
-		ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
+		ctrl->ana_log_buf = kmalloc(ana_log_size, GFP_KERNEL);
 		if (!ctrl->ana_log_buf)
 			return -ENOMEM;
 	}
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
