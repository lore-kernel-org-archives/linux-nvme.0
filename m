Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E5AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 05:38:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E25320709
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 05:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E25320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vOudZHr9E/T4wLwXCCYdYXnVIllfli4VfdpL8jZQ6+I=; b=EWNg8QaCMISxvXaJF/UMXy5cE2
	9WgyJl8N9W7VPUcHYeE+VXFNnXiSkYNhEMKHKdlB62nM9HFCztQDr/CZOeaGgeE/uXhdzju7rN7N/
	KEx+ZU3LjgN2gRz0vL2SemEJErpf1/7AV/lXSrAS/Vz/289l3IdeqK1avOQvvbEJ8E9pEZRrAA2Lc
	xguPvpZVPB7RfJ2vhXFw3+DlstRfEAxXwYW5mCYl5dXaCwcQp5ndkbN6cbtcZnptuWzwUublJFLwW
	YEt+W9WIlDLQN2KyisrRt7m79/iK0vUKrXnduxch+Pn2xDC5QtZxI/1pgw9VlhOTlwOA9RwRRj+sF
	mNz4/Frw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4dWU-000863-7b; Wed, 27 Jan 2021 05:37:46 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4dWS-00085f-1F
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 05:37:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611725863; x=1643261863;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3d2QpFwVqA+EAwziR0sxGf4TezRzuprvOs57VuIcJj4=;
 b=cITWkJKcOj9EL3c0DkVIOCo3nibf8EEdTOOj7v8ixTeeysmmxBL+PYBW
 tijG193rZgRvOdmcG8p0yrqhCzIEqf0yBj0lxVpgOTSP+oWdFDBoeNU91
 AjxxLlQDeWjMgkZyBSVWJq/JAt94kp6/WW1DMDlyI0zuKQioyWyAaZOlO
 OJnqp7MtOPMsfg7H/s2EcLiqIDr/4GXk+aIUeyktL2Dpaof+pIasxxQYM
 zKcGqqg7nxknpYdn8Cs2euMond5Qr8GuRBYubmc/71h9UKUUsq+fj6cPd
 GKGvWtUNhAr6wcuKPTXrYLp1+gwrWGhxNA4YHRMyo3PEO3uXAs+KNQ84F w==;
IronPort-SDR: qiOqLeGTYknuwghhT42Fg3po7JK+B34MR2wE2bzOmy2cU+QLLcE7CqzMQQGt1hGuKvgNbi0nEi
 WCR9Yl6C4YKACx5Eq71N3fXdC+sX1q/7tIlP1ZztYxdeUqkvLtztGeXT12KjoG1lpJmoXLxGON
 VwF9ObMAwa3hFJzd2IjmBpPhCZsLnIcX8Y5dE1b4w1ZyRjmocZQToNe+I4wQ7o8zzI8MdATB4X
 B300J42Kh/PPxXh3lihcXaTB2//MCjII8nevD8TGlQMrvja289OhsE7NNyGV5hYEZSHUVmxeae
 674=
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; d="scan'208";a="162865920"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 13:37:40 +0800
IronPort-SDR: FUFy3dZ55b/pdRYRfXzy2bl69z0GpPQoriK7Zuiwgmh0ZCch8/kue9OqDaWPDjGj2X+zjhv65Z
 qWsvX0fLtWD8bZwdWsDIjZrQjJD0PN6jMI9E2DlpcdDTPlBD8//vfJsYSlI8o9WEmZTRfvL6a5
 XsO4PjZqhQm2CE4FSYxuXOz0NabUnVXNdBotNGz2c/cIxfbYeicuUVb/m8DhxmTefV8trMwtx0
 WqYG9lrLHyzG2n/DsWn5ptMO/XLu0CjtOSLpkGyCxhur+kySCNDRRXl+Cmj4/zIDsbSGF01q1D
 av73LfdRTngjeDoTawxYb6E0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 21:20:03 -0800
IronPort-SDR: p2RVAto3NVZEFEdYg56+AOpjFxHaZlO32pDzXYz9ZiALpMijuVvecEucsyuBUv+UyZUOOFmqm/
 /aI4710kLPvPyY1kqDU8ku+BZFb7Sg7uNJQunWXBu+6KunD/y61O+xTCe6RV9gNeZopBPpDe5q
 4AfW8wCT4lM1Jdbme/0VwT8+roaRYJzwKuibj85uRQ8c/ctG4Y619e21GKBiBF3s43PKBrnBeg
 Hr/PnkyeIcums+8I5XfC525qYVz0jlLqLcWO7UgP878eS4ROYxgOAg74otvwt629mWP6uqpdwF
 wLE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2021 21:37:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-core: check bdev value for NULL
Date: Tue, 26 Jan 2021 21:37:38 -0800
Message-Id: <20210127053738.4922-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_003744_275279_EABAADE5 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: axboe@fb.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme-core sets the bdev to NULL when admin comamnd is issued from
IOCTL in the following path e.g. nvme list :-

block_ioctl()
 blkdev_ioctl()
  nvme_ioctl()
   nvme_user_cmd()
    nvme_submit_user_cmd()

The commit 309dca309fc3 ("block: store a block_device pointer in struct bio")
now uses bdev unconditionally in the macro bio_set_dev() and assumes
that bdev value is not NULL which results in the following crash in
since thats where bdev is actually accessed :-

void bio_associate_blkg_from_css(struct bio *bio,
				 struct cgroup_subsys_state *css)
{
	if (bio->bi_blkg)
		blkg_put(bio->bi_blkg);

	if (css && css->parent) {
		bio->bi_blkg = blkg_tryget_closest(bio, css);
	} else {
-------------->	blkg_get(bio->bi_bdev->bd_disk->queue->root_blkg);
		bio->bi_blkg = bio->bi_bdev->bd_disk->queue->root_blkg;
	}
}
EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);

<1>[  345.385947] BUG: kernel NULL pointer dereference, address: 0000000000000690
<1>[  345.387103] #PF: supervisor read access in kernel mode
<1>[  345.387894] #PF: error_code(0x0000) - not-present page
<6>[  345.388756] PGD 162a2b067 P4D 162a2b067 PUD 1633eb067 PMD 0
<4>[  345.389625] Oops: 0000 [#1] SMP NOPTI
<4>[  345.390206] CPU: 15 PID: 4100 Comm: nvme Tainted: G           OE     5.11.0-rc5blk+ #141
<4>[  345.391377] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba52764
<4>[  345.393074] RIP: 0010:bio_associate_blkg_from_css.cold.47+0x58/0x21f

<4>[  345.396362] RSP: 0018:ffffc90000dbbce8 EFLAGS: 00010246
<4>[  345.397078] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
<4>[  345.398114] RDX: 0000000000000000 RSI: ffff888813be91f0 RDI: ffff888813be91f8
<4>[  345.399039] RBP: ffffc90000dbbd30 R08: 0000000000000001 R09: 0000000000000001
<4>[  345.399950] R10: 0000000064c66670 R11: 00000000ef955201 R12: ffff888812d32800
<4>[  345.401031] R13: 0000000000000000 R14: ffff888113e51540 R15: ffff888113e51540
<4>[  345.401976] FS:  00007f3747f1d780(0000) GS:ffff888813a00000(0000) knlGS:0000000000000000
<4>[  345.402997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  345.403737] CR2: 0000000000000690 CR3: 000000081a4bc000 CR4: 00000000003506e0
<4>[  345.404685] Call Trace:
<4>[  345.405031]  bio_associate_blkg+0x71/0x1c0
<4>[  345.405649]  nvme_submit_user_cmd+0x1aa/0x38e [nvme_core]
<4>[  345.406348]  nvme_user_cmd.isra.73.cold.98+0x54/0x92 [nvme_core]
<4>[  345.407117]  nvme_ioctl+0x226/0x260 [nvme_core]
<4>[  345.407707]  blkdev_ioctl+0x1c8/0x2b0
<4>[  345.408183]  block_ioctl+0x3f/0x50
<4>[  345.408627]  __x64_sys_ioctl+0x84/0xc0
<4>[  345.409117]  do_syscall_64+0x33/0x40
<4>[  345.409592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[  345.410233] RIP: 0033:0x7f3747632107

<4>[  345.413125] RSP: 002b:00007ffe461b6648 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
<4>[  345.414086] RAX: ffffffffffffffda RBX: 00000000007b7fd0 RCX: 00007f3747632107
<4>[  345.414998] RDX: 00007ffe461b6650 RSI: 00000000c0484e41 RDI: 0000000000000004
<4>[  345.415966] RBP: 0000000000000004 R08: 00000000007b7fe8 R09: 00000000007b9080
<4>[  345.416883] R10: 00007ffe461b62c0 R11: 0000000000000206 R12: 00000000007b7fd0
<4>[  345.417808] R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000

Add a NULL check before we set the bdev for bio.

This issue is found on block/for-next tree.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba5df80881ea..1a3cdc6b1036 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1133,7 +1133,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		if (ret)
 			goto out;
 		bio = req->bio;
-		bio_set_dev(bio, bdev);
+		if (bdev)
+			bio_set_dev(bio, bdev);
 		if (bdev && meta_buffer && meta_len) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
