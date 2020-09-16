Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E836C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 15:36:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B272220E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ikl9vErf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcenMNS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B272220E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0XtW1ppNu28gnggqeYv6e+PEZZN11y+tZOOc+XkQ7TY=; b=Ikl9vErfcRqdBBgE1W0eezLCjq
	q1lh83w5kCeEBAamlp8IhFsMpzy7A7h0N9d56nlkl+PaaFgUM2OopjfPF7B5p3ZhAPIXXEzDAVbxY
	/EZgqygjL6fTCqqQldfH0e0SuBuwDr+jX5KJC9ssr80a71OJvFu0usqP6QhxJRn+vu+tEkONx/7UM
	iT/zah5g22B/jmhG7L0RphGUfnNr9OgKJ2OAaZ40BottzpxpcE87/ZUMoBozKFZl/7pfTqp/u1mcW
	8nFU4o+jFyuazTf9cs+5nPivwcQw8N3B+SRltClbocljQygAdTDRRsJgy1sQzyrDhxiUnvqeQ193F
	4S9iHJYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIZUE-0000lb-15; Wed, 16 Sep 2020 15:36:46 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIZUB-0000lD-GG
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 15:36:44 +0000
Received: by mail-qk1-x741.google.com with SMTP id n133so8569480qkn.11
 for <linux-nvme@lists.infradead.org>; Wed, 16 Sep 2020 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IpA99NuQHHy5sToYDf3cpIdrwgKXe1QT7oMjxy2J1Cc=;
 b=QcenMNS4mtTZfqVpP6pJ0b/Lx38uw5bt1b7TS9Wp4NVKqpl0tE64wwscqVMFD0uOMW
 5cRyXdTKHhYgLrIy7zdwyeTA2uK4eW0TAHA6/VTmsQvV+Ior9mJWDDGZY+ZUe9Siucu6
 ltSSlqFgOM+O4PPm5526umKR7ZNXBOlgskSdb6BNZigzhxrdxYS6ROlVsKwNNZ5JVWgA
 xYQZKk2F0cazjRP6S+svXDfiWN1dNMlYG6cGpcPa+jwWXCmf/7MGH3wv7O39+150eqcd
 r9SeCgOpkY9U5ywpl2pVmprdtpmUTaVmyG1szYXyE0zp2MfoLlSPxBBm9kvzTzUAixsx
 zBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IpA99NuQHHy5sToYDf3cpIdrwgKXe1QT7oMjxy2J1Cc=;
 b=a0qVQPRUir7erjPBCkt97NuMfwURxXNsHj63y+IwkxpzbsZP8OzLjIIQWoiL8Ui11/
 vUtuMfoNzGB0E5L2ivy9CrowEqrmvbg7KuQrbHo3IF4XtH5YxEUzubd9FlxO4f0/XcL/
 l8yVvTAYs90M/ABX0B3OaUBayMn6I5gTVNlq3h2Rx2TyyJE2ODdIRSjnFBXs7Rp/gtsW
 wPdQVez0lf7z/5gRrhMRk8prPRCarY3oJ3BIfMPQZvYwQReBiUCXa4UL7h1q1202wV6M
 3raGNFYgYvjf51CmsZGs/fmO6MdLtLl6gNBV2iH14+xMAebd0DwFEVzHn0MuSwX9N8Mf
 QJ4g==
X-Gm-Message-State: AOAM531yWBh6NUFgcHOYYCRdvrPO/jzD53DKmEpo8UTWuCSDxwNmSfXa
 9FUvU5olELVa7Z1ixXDRATs=
X-Google-Smtp-Source: ABdhPJw3ukEQEucXC7366DLV85dnG2atjH4Dm81p2W5dbe67Xtnce1JXL42mq26I4TVOKAuSfM0wgw==
X-Received: by 2002:ae9:efd2:: with SMTP id
 d201mr15978248qkg.348.1600270600495; 
 Wed, 16 Sep 2020 08:36:40 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:d54e:5074:9d44:3698])
 by smtp.googlemail.com with ESMTPSA id r34sm20430127qtr.18.2020.09.16.08.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 08:36:40 -0700 (PDT)
From: Tong Zhang <ztong0001@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix use-after-free during booting
Date: Wed, 16 Sep 2020 11:36:05 -0400
Message-Id: <20200916153605.5253-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_113643_552204_9ABC2E37 
X-CRM114-Status: GOOD (  13.22  )
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
Cc: Tong Zhang <ztong0001@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

if a nvme controller is not responding during probing, a use-after-free
condition could happen

[  215.396884] nvme nvme0: Identify Controller failed (-4)
[  215.397239] nvme nvme0: Removing after probe failure status: -5
[  215.409079] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[  215.409526] Buffer I/O error on dev nvme0n1, logical block 1, async page read
[  215.409924] Buffer I/O error on dev nvme0n1, logical block 2, async page read
[  215.410317] Buffer I/O error on dev nvme0n1, logical block 3, async page read
[  215.410706] Buffer I/O error on dev nvme0n1, logical block 4, async page read
[  215.411103] Buffer I/O error on dev nvme0n1, logical block 5, async page read
[  215.411498] Buffer I/O error on dev nvme0n1, logical block 6, async page read
[  215.411893] Buffer I/O error on dev nvme0n1, logical block 7, async page read
[  215.412272]  nvme0n1: unable to read partition table
[  215.412581] nvme0n1: partition table beyond EOD, truncated
[  215.966867] ------------[ cut here ]------------
[  215.967167] WARNING: CPU: 1 PID: 7 at block/genhd.c:838 __device_add_disk+0x79c/0x7c0
[  215.967558] Modules linked in:
[  215.967717] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.8.0+ #59
[  215.968618] Workqueue: nvme-wq nvme_scan_work
[  215.968849] RIP: 0010:__device_add_disk+0x79c/0x7c0
[  215.969098] Code: 85 30 04 00 00 48 89 44 24 20 e9 41 fa ff ff 48 89 df e8 07 e5 ca ff 80 a5 dc 00 00 00 ef e9 88 fc ff ff 0f 0b e9 81 fc ff ff <0f>
0b e9 a1 fc ff ff 0f 0b e9 b5 fa ff ff 0f 0b e9 51 ff ff ff e8
[  215.970032] RSP: 0000:ffff88806c06f9f0 EFLAGS: 00010246
[  215.970297] RAX: 0000000000000000 RBX: ffff88806c233400 RCX: ffffffff9ce3e74e
[  215.970653] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff888066135560
[  215.971015] RBP: ffff88806b2ce800 R08: 0000000000000001 R09: ffffed100cc26aad
[  215.971373] R10: ffff888066135567 R11: ffffed100cc26aac R12: ffff88806c40f940
[  215.971731] R13: ffff88806b2ce8a0 R14: ffff88806b2ce808 R15: ffff88806b2cebd8
[  215.972094] FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
[  215.972497] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  215.972789] CR2: 0000000000000000 CR3: 0000000024e0e000 CR4: 00000000000006e0
[  215.973153] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  215.973513] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  215.973875] Call Trace:
[  215.974007]  ? blk_alloc_devt+0x140/0x140
[  215.974213]  ? __hrtimer_init+0xb6/0xf0
[  215.974411]  ? rwsem_down_read_slowpath+0x7d0/0x7d0
[  215.974659]  ? __nvme_revalidate_disk+0x1ba/0x420
[  215.974905]  nvme_validate_ns+0x54c/0xe70
[  215.975113]  ? nvme_dev_ioctl+0x190/0x190
[  215.975318]  ? __blk_mq_free_request+0xe3/0x130
[  215.975549]  ? __nvme_submit_sync_cmd+0x153/0x300
[  215.975789]  ? kasan_unpoison_shadow+0x33/0x40
[  215.976022]  nvme_scan_work+0x20f/0x35f
[  215.976220]  ? nvme_fw_act_work+0x210/0x210
[  215.976434]  ? free_object+0x50/0x50
[  215.976619]  ? try_to_wake_up+0x37c/0x900
[  215.976619]  ? try_to_wake_up+0x37c/0x900
[  215.976843]  ? read_word_at_a_time+0xe/0x20
[  215.977057]  ? strscpy+0xbf/0x190
[  215.977229]  process_one_work+0x4ad/0x7e0
[  215.977435]  worker_thread+0x73/0x690
[  215.977623]  ? process_one_work+0x7e0/0x7e0
[  215.977842]  kthread+0x199/0x1f0
[  215.978011]  ? kthread_create_on_node+0xd0/0xd0
[  215.978240]  ret_from_fork+0x22/0x30
[  215.978423] ---[ end trace e8b38966135fe74b ]---
[  215.987504] refcount_t: underflow; use-after-free.
[  215.987772] WARNING: CPU: 1 PID: 7 at lib/refcount.c:28 refcount_warn_saturate+0xc5/0x110
[  215.988641] Modules linked in:
[  215.988827] CPU: 1 PID: 7 Comm: kworker/u4:0 Tainted: G        W         5.8.0+ #59
[  215.989784] Workqueue: nvme-wq nvme_scan_work
[  215.990013] RIP: 0010:refcount_warn_saturate+0xc5/0x110
0b e9 76 ff ff ff 80 3d cc 0f f6 01 00 0f 85 69 ff ff ff 48 c7
[  215.991220] RSP: 0000:ffff88806c06fb60 EFLAGS: 00010282
[  215.991485] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[  215.991850] RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffed100d80df5e
[  215.992209] RBP: ffff8880661355b0 R08: 0000000000000001 R09: ffffed100d80df32
[  215.992568] R10: 0000000000000003 R11: ffffed100d80df31 R12: ffff88806b2ce830
[  215.992937] R13: ffff88806b2ce800 R14: ffff88806bf47a78 R15: ffff88806bdb6a88
[  215.993294] FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
[  215.993700] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  215.993997] CR2: 0000000000000000 CR3: 0000000024e0e000 CR4: 00000000000006e0
[  215.994356] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  215.994714] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  215.995077] Call Trace:
[  215.995208]  disk_release+0x114/0x130
[  215.995397]  device_release+0x3c/0xd0
[  215.995586]  kobject_put+0xa5/0x120
[  215.995767]  nvme_put_ns+0x40/0xa0
[  215.995950]  nvme_remove_invalid_namespaces+0x1bd/0x210
[  215.996214]  ? nvme_ns_remove+0x2c0/0x2c0
[  215.996420]  nvme_scan_work+0x258/0x35f
[  215.996618]  ? nvme_fw_act_work+0x210/0x210
[  215.996841]  ? free_object+0x50/0x50
[  215.997027]  ? try_to_wake_up+0x37c/0x900
[  215.997233]  ? read_word_at_a_time+0xe/0x20
[  215.997446]  ? strscpy+0xbf/0x190
[  215.997617]  process_one_work+0x4ad/0x7e0
[  215.997830]  worker_thread+0x73/0x690
[  215.998021]  ? process_one_work+0x7e0/0x7e0
[  215.998234]  kthread+0x199/0x1f0
[  215.998401]  ? kthread_create_on_node+0xd0/0xd0
[  215.998632]  ret_from_fork+0x22/0x30
[  215.998822] ---[ end trace e8b38966135fe74c ]---

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d543bc1747fd..cdd40aab10e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -481,6 +481,8 @@ static void nvme_free_ns(struct kref *kref)
 	if (ns->ndev)
 		nvme_nvm_unregister(ns);
 
+	/* prevent double queue cleanup */
+	ns->disk->queue = NULL;
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
