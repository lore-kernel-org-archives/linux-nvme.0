Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C354C4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4E12225F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 23:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1aRJV8XM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZJAjJRxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4E12225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q3VP6Ym5HJwTYSk1GOyW/POAOADWuZ5HNoCmZy9jF7k=; b=1aRJV8XMmybZPSAzfNKLNZwpO1
	BHwY47AIdzFIO84LEJ0kzuLu+TrYibZViKunBW+qyemwCT4jEgx8eEOtARXoPcs7LV6qe8daalPxo
	tD2GJNcE0Wnxp6wWx9fOCvSTaOgA2FKQovypS2czceq4gTlYI6woduKOfxWd3IzdtULAVbl5ZhyXA
	oalkfPEVnbGHcH81gbPewkOOXQoIEhsw22E1SWZNQIxoiMFVuyfEUEzJbfyiR0xZOIaCkYMH27thm
	JG5dHw5VNQgwGgh3u4GIr5oOaLLenS1H3HiZUT9aEavPP4pzr5AgDC/AqLIqpn1vlPJGHbfF8m9Z2
	g1SsBILw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVNZY-0001Pl-Tq; Wed, 21 Oct 2020 23:31:12 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVNZR-0001Au-Mq
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 23:31:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603323066; x=1634859066;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=s8dG5iWlrJWhi+mcrBQLEdZ6EOpOOjyopN1wH9ihwDM=;
 b=ZJAjJRxFUfmrzPgqQMY/FlQYiy2hv83rtZJDqba3EteFnmOAmOQWimIQ
 +8XZvddHo5y7d5R5FpNHlSfWCiqi6+qBPAsMGgKkDO2P0A43gWguArFFg
 u68nexDwvHihQp/UWAeFiAw4sBly8xpj+fBc812n8JredwR8rVEUx84md
 TJwTksr5g0X0cJ2eZTxJ5l6GK/LmBaHY3ByiGR24rommmr0/WV3JOmb0U
 BkvlsauwAF4SUz9hHbkvw+im58sWg3nMNLJAhxTkfouYtpPasprXjXfTR
 2Duklr/LTLjLGpoJ+g8EwAn+zmg8i9nd3uPI2g2AgGcbDgQic33ZMq58B g==;
IronPort-SDR: Av9FWEFR2jrr7VpfyMXZ+pFwEQKRVVAlPZ5DHkYQkm+p1mLOiWVIYuhxn1t+C6pnwsDnygHhc9
 5ZiWuIoVsXs2kcwk39rOCRxtlmhLx5dD36UffNpYHJkzuZzp7RgXL9T1JjopvSzuI5A3wz00wD
 DEocqHOFOgdvdIBhnUpcd+BESicmZP1R03TkUXI7RV/cFfxmNJ1vWWqyow6XFOvWbo3Or+n5Tw
 TLAhsNncid095ZN69rBpAckqMRlnUlslCNG7OeYyOObBeqkU4/urfHDYS15x2D8kzz+EtyaVTT
 VSg=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="151791867"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 07:29:02 +0800
IronPort-SDR: PZ7PQ4lpaDhp8iPICCvTKuGJ1dN0sKBMvhXzEgWpRmTNH5cU3Aj/GMXz7wIOG4niVmhjhLH+2v
 6kHoSyvMhoTVlaC0w0kb6zUdhLUPyd3LJvSm0esPJk9ToBhVs6aP8RUn91VKWTbdY9LyhZCNur
 E1OFkYyNgZHGnG7QDq58KFbIP4fWexNtoKQMRWeNzQCcRcl3lrzvXBmzIegM3idPx0QLoWrjVr
 qxzmivRjBj6oJFrWDHTQiY8pe3B9+jMalfGmJTgzvbD/9JOYMqmli2hYWROBfEYlTip+Zu8IdX
 8p46ojaB4YAv3XHERcGbkVQC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 16:14:34 -0700
IronPort-SDR: kl9V9c0pKbN+Fj6zpHeEYf/82ZqXQzsQo/J90dFpQZNAhWsgmpJqjpukyD+hPvoVx1cuvMqCzK
 xW0X9u7y741n3rhrndKV3GPjckO0TX/zisDq2eTThhcUw/Z8DFUGwLwHAvj/5/JZs7tpuVmfqu
 m8gFLPfs28MgA06BK26LVn+NTsyEsh3FfMW0CzdwxvSeUBixTBndOpaIwzIdJDwypry9nrbUGL
 KpM5DG+PgNWxQTcma+YQk+AhYcQz4GoPLYcHzpbMaJm4WSO31if9CMZULRnywKEeGReSDd5wYl
 cNM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Oct 2020 16:29:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fix the Oops in the tracing for flush cmd
Date: Wed, 21 Oct 2020 16:28:59 -0700
Message-Id: <20201021232859.4915-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_193105_875956_29C517B8 
X-CRM114-Status: GOOD (  16.40  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When target side trace in turned on and flush command is issued from the
host it results in the following Oops.

[  856.789724] BUG: kernel NULL pointer dereference, address: 0000000000000068
[  856.790686] #PF: supervisor read access in kernel mode
[  856.791262] #PF: error_code(0x0000) - not-present page
[  856.791863] PGD 6d7110067 P4D 6d7110067 PUD 66f0ad067 PMD 0
[  856.792527] Oops: 0000 [#1] SMP NOPTI
[  856.792950] CPU: 15 PID: 7034 Comm: nvme Tainted: G           OE     5.9.0nvme-5.9+ #71
[  856.793790] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e3214
[  856.794956] RIP: 0010:trace_event_raw_event_nvmet_req_init+0x13e/0x170 [nvmet]
[  856.795734] Code: 41 5c 41 5d c3 31 d2 31 f6 e8 4e 9b b8 e0 e9 0e ff ff ff 49 8b 55 00 48 8b 38 8b 0
[  856.797740] RSP: 0018:ffffc90001be3a60 EFLAGS: 00010246
[  856.798375] RAX: 0000000000000000 RBX: ffff8887e7d2c01c RCX: 0000000000000000
[  856.799234] RDX: 0000000000000020 RSI: 0000000057e70ea2 RDI: ffff8887e7d2c034
[  856.800088] RBP: ffff88869f710578 R08: ffff888807500d40 R09: 00000000fffffffe
[  856.800951] R10: 0000000064c66670 R11: 00000000ef955201 R12: ffff8887e7d2c034
[  856.801807] R13: ffff88869f7105c8 R14: 0000000000000040 R15: ffff88869f710440
[  856.802667] FS:  00007f6a22bd8780(0000) GS:ffff888813a00000(0000) knlGS:0000000000000000
[  856.803635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  856.804367] CR2: 0000000000000068 CR3: 00000006d73e0000 CR4: 00000000003506e0
[  856.805283] Call Trace:
[  856.805613]  nvmet_req_init+0x27c/0x480 [nvmet]
[  856.806200]  nvme_loop_queue_rq+0xcb/0x1d0 [nvme_loop]
[  856.806862]  blk_mq_dispatch_rq_list+0x123/0x7b0
[  856.807459]  ? kvm_sched_clock_read+0x14/0x30
[  856.808025]  __blk_mq_sched_dispatch_requests+0xc7/0x170
[  856.808708]  blk_mq_sched_dispatch_requests+0x30/0x60
[  856.809372]  __blk_mq_run_hw_queue+0x70/0x100
[  856.809935]  __blk_mq_delay_run_hw_queue+0x156/0x170
[  856.810574]  blk_mq_run_hw_queue+0x86/0xe0
[  856.811104]  blk_mq_sched_insert_request+0xef/0x160
[  856.811733]  blk_execute_rq+0x69/0xc0
[  856.812212]  ? blk_mq_rq_ctx_init+0xd0/0x230
[  856.812784]  nvme_execute_passthru_rq+0x57/0x130 [nvme_core]
[  856.813461]  nvme_submit_user_cmd+0xeb/0x300 [nvme_core]
[  856.814099]  nvme_user_cmd.isra.82+0x11e/0x1a0 [nvme_core]
[  856.814752]  blkdev_ioctl+0x1dc/0x2c0
[  856.815197]  block_ioctl+0x3f/0x50
[  856.815606]  __x64_sys_ioctl+0x84/0xc0
[  856.816074]  do_syscall_64+0x33/0x40
[  856.816533]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  856.817168] RIP: 0033:0x7f6a222ed107
[  856.817617] Code: 44 00 00 48 8b 05 81 cd 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 8
[  856.819901] RSP: 002b:00007ffca848f058 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  856.820846] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f6a222ed107
[  856.821726] RDX: 00007ffca848f060 RSI: 00000000c0484e43 RDI: 0000000000000003
[  856.822603] RBP: 0000000000000003 R08: 000000000000003f R09: 0000000000000005
[  856.823478] R10: 00007ffca848ece0 R11: 0000000000000202 R12: 00007ffca84912d3
[  856.824359] R13: 00007ffca848f4d0 R14: 0000000000000002 R15: 000000000067e900
[  856.825236] Modules linked in: nvme_loop(OE) nvmet(OE) nvme_fabrics(OE) null_blk nvme(OE) nvme_corel

Fix this problem by adding a check for NULL namesapce in
drivers/nvme/target/trace.h:__assign_disk_name().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 0458046d6501..efb79cf898ac 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -54,7 +54,8 @@ static inline void __assign_disk_name(char *name, struct nvmet_req *req,
 
 	if ((init && req->sq->qid) || (!init && req->cq->qid)) {
 		ns = nvmet_find_namespace(ctrl, req->cmd->rw.nsid);
-		strncpy(name, ns->device_path, DISK_NAME_LEN);
+		if (ns)
+			strncpy(name, ns->device_path, DISK_NAME_LEN);
 		return;
 	}
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
