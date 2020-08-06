Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506FFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B8722D03
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D2IY08lJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ohWe+aE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B8722D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VFbZeOEdsmcaswWfBqJQt/tRVbboGWv6O2xGzELw5rE=; b=D2IY08lJW43+I5G4RjOFvfqSD
	y8to+eRu2WfkSRMHkzd8g1hmWmeJf4pRa3kGi9SmPOXYWhhZL9C4cTSPThLvnWXanWg0K2ZM7CNFt
	9Wg2LFa3Eswtb0mgUdSFyPXvyd8efTOSV4JJ9sSc7NY8HKBVjFnDIdCnyroAjpMcibmP/kQOEqBzx
	yvOkm916ij24CgL1qu4uexnDCGmiiMoQVZ52s/ZfmB+sico5PmCFrGaYkPLrbP25J8dGPQnk7h9aX
	r82sqo/92vzHhlTydzSCFGb5qDl/megVaUMeuVjdghnOYfhUVmtiQW4+SUDLMPEb5mjPDfR+z+0j7
	BtCTPjHmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3aNe-0002ch-98; Thu, 06 Aug 2020 07:32:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3aNa-0002ai-7W
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 07:31:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596699117; x=1628235117;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=reimuvpuPdP79+M/ua3WQijCzRm3soWHaubXAqxgqPw=;
 b=ohWe+aE5e3DlHjbDJnNPnOhPA+naVa5BfAt/APjUfHf1X5csDx+XmWiT
 4OUDQfsa86egZlFvBUdlMUKEY4/McduKWH3nwhBDYWAAb+Z3umZ+vSooI
 uhGtfYwFJf9LjKG7vhO+hCkEVGw6zZceqBptCwnjdMq9QPzgeXMaMam02
 7nbjGQTV6It4fj5Ht3QRKTxHGxJs6RaG2qJwp+mH6FYr4MBnXk+qdsKi2
 qaiw7lA6e1YcPPS8DafT4wrRaosm8uYcikTineewltZj7AgXg8nlCUv6Q
 ZlGJjoxaYwNP7nXI5VGf6i1vfyEkxdFAMLXm5QkCweZ9gpN7G7QPobYZm Q==;
IronPort-SDR: y4ajNYNTwHEeZ2H9XGICQzyqGEIHOIkrAFrp/5PqmOrvZU386xn2jYY2mQpXjm9U9JDqW/jqwr
 NEoiVO8SWt9S2M7a/m98UxpxgDHhtN/UHDQobZerr5ijPEFNkJhSzPUB/01O5oxlfcKRzPuoLS
 XqwPUnOiXS96trX6yubYukMgGErXDZO4i90OC0TvFKWljWocldWktsPmJma0vNFTBfA+LGyq51
 c4qm2/fjVSAegfL0HDs9vU6BxmuMF0weJneR1k111Q77A7LgmTenjyzl8FoJGvbfDTPMBqJEGp
 DzM=
X-IronPort-AV: E=Sophos;i="5.75,441,1589212800"; d="scan'208";a="144279254"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 15:31:55 +0800
IronPort-SDR: 5Xm9L0iyCeMVv47oPlXTODpYVWAEgVG/rYQI4P+CJ/CR15tfs/XNPyKDAd2WHd01pvjb/27ki5
 aeYnTkGHu+HA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2020 00:19:14 -0700
IronPort-SDR: n/CU23RKkfpah+4AHomWBn4Pe77rqgwPJJdyKM+W5gxAnI1A5R8XtkCY5oOPKqQ9kRVQuzlfG4
 DsCGDb6oHRoA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Aug 2020 00:31:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Date: Thu,  6 Aug 2020 00:31:50 -0700
Message-Id: <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_033158_498888_EF3D555B 
X-CRM114-Status: GOOD (  13.80  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a check in nvmet_execute_passthru_cmd() to prevent the
following Oops :-

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

Fixes: 06b7164dfdc0 ("nvmet: add passthru code to process commands")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d91dc999a6..b56292c9a76c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -278,7 +278,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	if (ns)
 		nvme_put_ns(ns);
 	nvmet_req_complete(req, status);
-	blk_put_request(rq);
+	if (rq)
+		blk_put_request(rq);
 }
 
 /*
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
