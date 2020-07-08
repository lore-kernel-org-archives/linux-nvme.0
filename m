Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB89C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39994206DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uythYqGW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SH8nizNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39994206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qAPoqruJwMUDF1Nx33VBtlQ8nGgt6J17lRFsnRN3pXY=; b=uythYqGWaQL41lLRZ0JXjPT6n
	/FsQu+sPSu/QoOYJ2KsBmyZ/doeew2VdSn2Zpda9m5jZeaDqWDgY3lnNzEc2kc9oe8x34cXxrQ5nY
	zm38S6kzx0Wo/+V/tz+bn51d5N/Szw43t6LdYBEZylhtF5EG/aqgW8kCcFRLeVt49utTbRdbH5tak
	ZpHRAyAmFZPY0KFhmYohafoYfgl3CaL6BeHTn191MF9t4InGwgDh+OqpAxVqXWGVNsvd4jCYxCSUF
	3Inoq/txNGpnMT0cHs1iz/VmHDUgNRTvofXYh5IUD1aMPFMS62iManuYq+mumEQKqYpc9SVdTPotA
	9+kFUVbag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsyQG-0007Ov-93; Wed, 08 Jul 2020 00:58:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsyQB-0007Ne-1L
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 00:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594169927; x=1625705927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A0IqhQw/nkqNUzTDFCV+EAubPFmDakN4YCN9prq/PGo=;
 b=SH8nizNjvpz7VNLCSBoL1E7A1jsvaLd6axvgmSH6SUYcsUjJ94gVKHWC
 Njk4ugArOA6bE9zzTk9TpbzSLqL9iYfE+nX3UGQhOFMqCtos2tpl7ep/9
 4iXzbirI3VanD7w5Lgn966vU8l+KgZdqekRr1J/Mua9uJvRagRG+cHZFS
 ZoVLB+mB8GQHCSnFFtZHgiHzERnvqQahZFfiaMsjrwg83hfuKCMOkAqxV
 LB1tEhofIT4Xew3z10IpTr/bJMzL8m6ltpoAuoLl0ZzdfbkwoBpLSFdJB
 sEJ96hnVb3d0Q1/BLosFcXNHPQf4061ZQyVNzrpDg+rxg2835G4zrVpjf g==;
IronPort-SDR: paUcXgsPvm3ZHOMRyKEmAreWeTCz3XbiZbjxJ8Ys+8a+D6gRHHBv8VGHeGztke/Z0yPfYay1AK
 ogePFjluRYMeIui6aS00qlFxm/sYlBIihNeBqlOhPE/R1+xCUwjiRQMB3aGFUofc8SoFcS2qV9
 wHd9WyCUPObDkmwiGmlzQDmPbXLGVBNCGfJqHmciTRGxdT0swrq8eOlb7hfSpbn7UwQHrExZ01
 Lu5ihU6kzNrzj91uwIRxPtpa88TFGZ+P3CG/MywBJ4+XfORc1cHrwSiAJtWSEFFW7U1p3JMPsf
 3EE=
X-IronPort-AV: E=Sophos;i="5.75,325,1589212800"; d="scan'208";a="143204236"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 08:58:46 +0800
IronPort-SDR: zDE5U3rGTeaFdeef/XSdcK10L6p3PQIwDKanMTGqlOkdUmS7SUCMdA10+x0NsahEXlGP1roLri
 VwOph02fGhJgjQjWPqEeLkIiS88wO+YjM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 17:47:25 -0700
IronPort-SDR: DWOMbx0k8IygvLdSywT2WNTVl5CTiQ5rM/vSk0BB3nzA0cXVI/HwDk6oKlQQECXBFrv+8v7bqN
 mRgsPPXy1nAQ==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jul 2020 17:58:46 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 2/4] nvme-pci: don't use ctrl page size value in probe
Date: Tue,  7 Jul 2020 17:58:29 -0700
Message-Id: <20200708005831.10013-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_205847_254100_8CEB65C9 
X-CRM114-Status: GOOD (  15.02  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_probe() when calculating mempool size nvme_npages uses
dev->ctrl.page_size which is initialized in the following code path:-

Ctx insmod :
nvme_probe()
 nvme_reset_ctrl()
  queue_work(nvme_reset_work()

Ctx Workqueue :
nvme_reset_work()
 nvme_pci_configure_admin_queue()
  nvme_enable_ctrl()
   ctrl->page_size = 1 << NVME_CTRL_PAGE_SHIFT.

When nvme_pci_iod_alloc_size() is called with false as last argument it
results in following oops since dev->ctrl.page_size used before we set
it in the nvme_enable_ctrl() in above path :-

Entering kdb (current=0xffff88881fc0c980, pid 339) on processor 0 Oops: (null)
due to oops @ 0xffffffffa05f1723
CPU: 0 PID: 339 Comm: kworker/0:2 Tainted: G        W  OE     5.8.0-rc1nvme-5.9+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.4
Workqueue: events work_for_cpu_fn
RIP: 0010:nvme_probe+0x263/0x502 [nvme]
Code: 00 00 66 41 81 7c 24 3c 4d 14 0f 84 98 01 00 00 3d 0f 1e 01 00 0f 84 aa 01 00 00 8b 8b a0 0c 00 2
RSP: 0018:ffffc90000d9bdd8 EFLAGS: 00010246
RAX: 0000000000000fff RBX: ffff8887da128000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000246
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8887c29f5570 R12: ffff888813c37000
R13: 0000000000000202 R14: 0000000fffffffe0 R15: ffff888813c370b0
FS:  0000000000000000(0000) GS:ffff88880fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f23185131a0 CR3: 0000000811c54000 CR4: 00000000003406f0
Call Trace:
 local_pci_probe+0x42/0x80
 work_for_cpu_fn+0x16/0x20
 process_one_work+0x24e/0x5a0
 ? __schedule+0x353/0x840
 worker_thread+0x1d5/0x380
 ? process_one_work+0x5a0/0x5a0
 kthread+0x135/0x150
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x22/0x30

This patch uses local variable instead of dev->ctrl.page_size with the
same value which we set in the nvme_enable_ctrl().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1ac0717c04d3..cef87ad2323f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -348,8 +348,15 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
  */
 static int nvme_npages(unsigned size, struct nvme_dev *dev)
 {
-	unsigned nprps = DIV_ROUND_UP(size + dev->ctrl.page_size,
-				      dev->ctrl.page_size);
+	/*
+	 * At this point ctrl->page_size is not initialized. Use same the
+	 * values present in nvme_enable_ctrl() ctrl->page_size. Any change in
+	 * the value of ctrl->page_size in nvme_enable_ctrl() should reflect
+	 * here.
+	 */
+	unsigned int page_size = 1 << NVME_CTRL_PAGE_SHIFT;
+	unsigned nprps = DIV_ROUND_UP(size + page_size, page_size);
+
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
 
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
