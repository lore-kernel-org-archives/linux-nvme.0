Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB353C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5B720791
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vW81eNKq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4n7OKnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5B720791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ly9q7jxR413NWwnY+L0Q6avbg2XNqFqdAJeWSbKBVK8=; b=vW81eNKq6DgZnP9d9Dyn1WHQa
	mdxiv5h3ssH7Zg70eaYyC4Gj66uWTPeUOmLj+klWF/JIgYedH4/MWPFQG+oybEMtej1vHMGl6128w
	e1VhVX9k8iyPOit0yJQ6ixCb2Zfs1nezxeqURtD5IvfAXmgJa4zF57EJfOj5Uj0oabb/O55j6rnbf
	dqnI53e9T1gT+OIe/EVrqQjS+SrsDisMUTRUQy3Ogkwg1ng2EsNtCz7SlTo33WsN2b4pZOYVdwpnp
	iJmgI3830cWvzBdlNQQuQUlTucVWnrdH5U8uPpMSd0cKv+xpbt/TMb/Ypn5dC9DX3ARGoo/bykMx1
	sUpYo/n9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5C8G-00013X-Rh; Mon, 10 Aug 2020 18:02:48 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5C8A-00010q-Hx
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:02:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597082563; x=1628618563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=agk04BXoexxfxsSCNQrsg5vEDPY++KLi7pEYJ/Gzc8E=;
 b=F4n7OKnZSF35u2TPi3/KK4lUknv9DxP31lQ2WGtZcf9F55uH2Z05lgGx
 z3TwV2xURchSdin79UPzCYcYUyWSwOvQBj/LO1DoRf4moOltVdGFDoz4I
 oGiM87pacqNj6VJiiY+m3W5akPvEATC6szzIZPQnlF/6QR7JMSrY41T4n
 73JrfICsTeJcJg2TQB/wyHoKqXOPOmvtY/h2FrSOK5EtlVpjMBUJYKpjc
 2+67rWcXq2uUCBTwqOmmjEt4+FElq6dipmxqcHU8vQc0Qb1ZL6lLj6Skm
 HXdCXZ1XkLSkuvKCk/zwtSDp2YdK9bH26vGcdKFNVroGTxwwZTAEhQdOf g==;
IronPort-SDR: gWvUWdowApr2FOsbcp8AHN7prCyw7X0tmVNuTe1PHBjeiYNbbr43B3iFCJY7398huqAM3dqxah
 MAVEP7v+TJqIFZhla/Ef8zeO1YfJZd2mFet4tH6RjFUVsw7NvnLLfEX10va58wkuDwYLlHmpI9
 LypxQtf1nOFC4rAy2lu60mZwI3uVgPYnU4iyKcQ2B7ycJ1/Mr6a2NVZhb8hxs0IeRz6z9YF+VT
 vhtJQ7MI/Cv11rGz0fVKM32gna7QsG4gbgUBPS4HyCwS1HkSUpNwL+EB1GmapdJbV5DtIS5qIq
 YT8=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144647708"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:02:26 +0800
IronPort-SDR: k71bNuK1ilCjfQlSOLj/sz3h6klMga2aoaBggCKp9Gi+IgevmIhnXojhHxZ14TeZID0WtpNb5j
 esbjwvb2mtcQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 10:50:19 -0700
IronPort-SDR: TX22IMWqHs6faWl838AyMQpi+94JMGbOdP6akXt0seTDuHscj4bYfxiqDjysZzuchEdyqY4ivZ
 T/yak6jwXxmg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:02:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [RESEND PATCH V2 2/3] nvmet: fix oops in pt cmd execution
Date: Mon, 10 Aug 2020 11:02:17 -0700
Message-Id: <20200810180218.5857-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
References: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_140242_890880_F7DFF0F1 
X-CRM114-Status: GOOD (  16.41  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the existing NVMeOF Passthru core command handling on failure of
nvme_alloc_request() it errors out with rq value set to NULL. In the
error handling path it calls blk_put_request() without checking if
rq is set to NULL or not which produces following Oops:-

[ 1457.346861] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1457.347838] #PF: supervisor read access in kernel mode
[ 1457.348464] #PF: error_code(0x0000) - not-present page
[ 1457.349085] PGD 0 P4D 0
[ 1457.349402] Oops: 0000 [#1] SMP NOPTI
[ 1457.349851] CPU: 18 PID: 10782 Comm: kworker/18:2 Tainted: G           OE     5.8.0-rc4nvme-5.9+ #35
[ 1457.350951] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e3214
[ 1457.352347] Workqueue: events nvme_loop_execute_work [nvme_loop]
[ 1457.353062] RIP: 0010:blk_mq_free_request+0xe/0x110
[ 1457.353651] Code: 3f ff ff ff 83 f8 01 75 0d 4c 89 e7 e8 1b db ff ff e9 2d ff ff ff 0f 0b eb ef 66 8
[ 1457.355975] RSP: 0018:ffffc900035b7de0 EFLAGS: 00010282
[ 1457.356636] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
[ 1457.357526] RDX: ffffffffa060bd05 RSI: 0000000000000000 RDI: 0000000000000000
[ 1457.358416] RBP: 0000000000000037 R08: 0000000000000000 R09: 0000000000000000
[ 1457.359317] R10: 0000000000000000 R11: 000000000000006d R12: 0000000000000000
[ 1457.360424] R13: ffff8887ffa68600 R14: 0000000000000000 R15: ffff8888150564c8
[ 1457.361322] FS:  0000000000000000(0000) GS:ffff888814600000(0000) knlGS:0000000000000000
[ 1457.362337] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1457.363058] CR2: 0000000000000000 CR3: 000000081c0ac000 CR4: 00000000003406e0
[ 1457.363973] Call Trace:
[ 1457.364296]  nvmet_passthru_execute_cmd+0x150/0x2c0 [nvmet]
[ 1457.364990]  process_one_work+0x24e/0x5a0
[ 1457.365493]  ? __schedule+0x353/0x840
[ 1457.365957]  worker_thread+0x3c/0x380
[ 1457.366426]  ? process_one_work+0x5a0/0x5a0
[ 1457.366948]  kthread+0x135/0x150
[ 1457.367362]  ? kthread_create_on_node+0x60/0x60
[ 1457.367934]  ret_from_fork+0x22/0x30
[ 1457.368388] Modules linked in: nvme_loop(OE) nvmet(OE) nvme_fabrics(OE) null_blk nvme(OE) nvme_corer
[ 1457.368414]  ata_piix crc32c_intel virtio_pci libata virtio_ring serio_raw t10_pi virtio floppy dm_]
[ 1457.380849] CR2: 0000000000000000
[ 1457.381288] ---[ end trace c6cab61bfd1f68fd ]---
[ 1457.381861] RIP: 0010:blk_mq_free_request+0xe/0x110
[ 1457.382469] Code: 3f ff ff ff 83 f8 01 75 0d 4c 89 e7 e8 1b db ff ff e9 2d ff ff ff 0f 0b eb ef 66 8
[ 1457.384749] RSP: 0018:ffffc900035b7de0 EFLAGS: 00010282
[ 1457.385393] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
[ 1457.386264] RDX: ffffffffa060bd05 RSI: 0000000000000000 RDI: 0000000000000000
[ 1457.387142] RBP: 0000000000000037 R08: 0000000000000000 R09: 0000000000000000
[ 1457.388029] R10: 0000000000000000 R11: 000000000000006d R12: 0000000000000000
[ 1457.388914] R13: ffff8887ffa68600 R14: 0000000000000000 R15: ffff8888150564c8
[ 1457.389798] FS:  0000000000000000(0000) GS:ffff888814600000(0000) knlGS:0000000000000000
[ 1457.390796] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1457.391508] CR2: 0000000000000000 CR3: 000000081c0ac000 CR4: 00000000003406e0
[ 1457.392525] Kernel panic - not syncing: Fatal exception
[ 1457.394138] Kernel Offset: disabled
[ 1457.394677] ---[ end Kernel panic - not syncing: Fatal exception ]---

We fix this Oops by adding a new goto label out_put_req and reordering
the blk_put_request call to avoid calling blk_put_request() with rq
value is set to NULL. Here we also update the rest of the code
accordingly.

Fixes: 06b7164dfdc0 ("nvmet: add passthru code to process commands")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index e7dbca12785d..aecabf423df2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -238,7 +238,6 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 
 	rq = nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
 	if (IS_ERR(rq)) {
-		rq = NULL;
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
 	}
@@ -247,7 +246,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
 			status = NVME_SC_INTERNAL;
-			goto out_put_ns;
+			goto out_put_req;
 		}
 	}
 
@@ -274,12 +273,13 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 
 	return;
 
+out_put_req:
+	blk_put_request(rq);
 out_put_ns:
 	if (ns)
 		nvme_put_ns(ns);
 out:
 	nvmet_req_complete(req, status);
-	blk_put_request(rq);
 }
 
 /*
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
