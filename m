Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2970DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:59:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9730650DD
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9730650DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KiPKo3t+O2WeFxf4ZQXk8yG24gmuKtpwRC4blcaIoyM=; b=m7SuPd7uYw+SGfIlUTPR8hKhSI
	WvsQkiuCtWXKzyLMGkb55Px7NfxOEMjGJdSGYNNks7gdjMUOs/esXjp3yBJkowgel1VJqMZtJdYlE
	KL50utJKXSpycXoYyG5LKsSoIDaIBDrwVK7ppturhVdltY+mVcwLKNoGW50tIzaSNP8HELw7ELtXq
	EWuDD+hWoAeGTQtgfuchqpXIZnhtkIthSSn4p+7FtSyckMEfjfI0bAnq2Iyzfzve+TCUo7rsgo/RJ
	6LQMhcWhZngQ+7sa3Xwx+MX5YcS04gc+aV3GpMf8HSwWOcnG6JZPbIXejy+vVBfSrMMnihH7hsqBd
	7PPQmcbQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHdH5-007QPG-KK; Thu, 04 Mar 2021 01:59:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHaHC-006niC-4t
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 22:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614812581; x=1646348581;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3xstWBIbQheMokGwD1gVP5tBeQieIjqYZmZpjNmHzc8=;
 b=pZHATxUS5DmMThXzviR1SLNhCGs3wNnJE0wbIy13w40kPQ4CoVfo7PvT
 YfxLw20YFRqO+fQTjvbrjumSWiFFGX9K93AM6CLPUDufGQbvKRdfdZdPL
 FA6DjZYqUNqfZQAiXvFGr0Ewr8tsFkBRK9UP1x7uJofyDF3CY7dsVqOqP
 wcCDp/vALildUXPz3Bf/nvwAnZlvdj4VUoBVcjPDtsfpMXjhSuXUilv1P
 7ex57nDiFQDkWjwUCTDAjb8NJOEgeXmXnUM+nCssnYZ3K+gMpNrbuOEmp
 5ylmcjPQj3/GZEdzKTlh6ciGSZ/pDROsgy/Zn0AUeCK4wn/lklx6osfXq A==;
IronPort-SDR: hDlsAGAKEwbpLIkGs7BuwP/B1ykoI6yj2unwJSKg06gPsgVe9FAiaderPQ3a6Q+Sy1XtxXz/et
 0OwVcWXcSJCTwEz4j0Ez0zJyBY4JOfRIhYI/gVTwtMxUlm2Vs0n7DTcR+pnaJVWQBnpL8t+Tzx
 Kb1g04qCc0zSgjmRfUkSQPAlt0jN3I5kFlaI9WuaIxOaduFsCM8ovs1AcMTMWsJ5KLCsPFJRTU
 sMfxBUI9cjM8Tcy4kIqnQ6nDWnRpNdJpSvrbEYiZGMMMugdgrCh96z+UECkRNLyL8ItSy9ywgf
 8Wk=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; d="scan'208";a="265592005"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 07:02:45 +0800
IronPort-SDR: 1rLhlbQepE9sqsCmGaonkEk5BqOOe7i5TOsnZmDHHq92TMtuTiGWcnHF+6JyGQ4GVql15F219r
 Qu7V2JJLZ8hcxn/JFIsfohJod0PehIkZORaHLxigGJ9SEUZIZ/1GNmwOUwof2WcLaalpwQJXeY
 weWoLcPfmwQ87N38DGpE65DFw78RQ9kSwglJ+FRiVNt7afv1jnsUy5PshnLpZIXZU2JNxjG4WY
 BwCG3D4iVGnQugxBo6urTfMKi8iy/iWoOJWGqJsUkLh7mc8e/q1XsihdzG5Wge3DXe8eJNPS/L
 mpogUmBBRLJsshabH+9FUq95
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 14:28:33 -0800
IronPort-SDR: TjwRZ/3P4q1eXGg2AZluz94dzpPcqvGGNgaee/BIpBc3sV6h9y++v0IZoPGJ7/7NkwVOz6nOzg
 QFT5Y1fco7th4iN0fZvfJEwXaK6iGSb1it2z/508ES3bJ38RmRkOtYmOamQPY4KIEjFBo7bhZ5
 N+JPjrhtuky6VQI1WdN6CzxroWgWHw60JICOlPOjytgmeu6Ps90EJ6I2uEiKlyzpS9zXfaGBqY
 W39e7xORvK0BrfUWjNlZhiTuimvJLYcnl6D59RQDttRKOZWZPC+NEBkTR4DgiB2fijezZZJ+P3
 7eU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 14:47:20 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvme: fix warning in nvme_update_zone_info()
Date: Wed,  3 Mar 2021 14:47:17 -0800
Message-Id: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
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

This fixes the issue related to the chunk size sector settings that
indirectly affects the zone append max sectors settings.

Move setting up the max zone append sectors into nvme_revalidate_zones()
that removes the following warning:-

[  256.958075] nvme nvme0: pci function 0000:00:04.0
[  256.991839] nvme nvme0: 64/0/0 default/read/poll queues
[  256.995731] ------------[ cut here ]------------
[  256.995733] WARNING: CPU: 49 PID: 362 at block/blk-settings.c:252 blk_queue_max_zone_append_sectors+0x39/0x40
[  256.995739] Modules linked in: nvme(OE) nvme_core(OE) xt_CHECKSUM xt_MASQUERADE tun bridge stp llc ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_security iptable_raw ebtable_filter ebtables rfkill ip6table_filter ip6_tables iptable_filter intel_rapl_msr intel_rapl_common kvm_amd ccp kvm btrfs irqbypass bochs_drm crct10dif_pclmul drm_vram_helper ppdev crc32_pclmul blake2b_generic ghash_clmulni_intel drm_ttm_helper xor ttm aesni_intel drm_kms_helper crypto_simd cryptd syscopyarea sysfillrect sysimgblt fb_sys_fops drm i2c_piix4 nfsd raid6_pq parport_pc joydev i2c_core pcspkr parport sg auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ata_generic pata_acpi virtio_net net_failover failover ata_piix virtio_pci virtio_ring crc32c_intel libata t10_p
 i
[  256.995788]  virtio serio_raw floppy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: nvme_core]
[  256.995793] CPU: 49 PID: 362 Comm: kworker/u128:32 Tainted: G        W  OE     5.11.0nvme+ #20
[  256.995796] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-44-g88ab0c15525c-prebuilt.qemu.org 04/01/2014
[  256.995797] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[  256.995823] RIP: 0010:blk_queue_max_zone_append_sectors+0x39/0x40
[  256.995826] Code: fa 01 76 03 0f 0b c3 8b 87 28 04 00 00 39 87 20 04 00 00 0f 46 87 20 04 00 00 39 f0 0f 47 c6 85 c0 74 07 89 87 58 04 00 00 c3 <0f> 0b eb f5 0f 1f 00 0f 1f 44 00 00 66 89 b7 6c 04 00 00 c3 0f 1f
[  256.995827] RSP: 0018:ffffb53f40e53c00 EFLAGS: 00010246
[  256.995832] RAX: 0000000000000000 RBX: ffff909fcc756780 RCX: 0000000000000000
[  256.995834] RDX: 0000000000000001 RSI: 0000000000000400 RDI: ffff909fc43c07e8
[  256.995835] RBP: ffff90a007413000 R08: ffff90a6dfa6ba58 R09: 0000003bd567254e
[  256.995836] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffb53f40e53c08
[  256.995836] R13: 0000000000000b00 R14: ffff909fc43c07e8 R15: 0000000000000000
[  256.995838] FS:  0000000000000000(0000) GS:ffff90a6dfa40000(0000) knlGS:0000000000000000
[  256.995840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  256.995841] CR2: 00007fc9005345b0 CR3: 00000001041c8000 CR4: 00000000003506e0
[  256.995843] Call Trace:
[  256.995845]  nvme_update_zone_info+0x1b7/0x200 [nvme_core]
[  256.995851]  nvme_update_ns_info+0x55a/0x5c0 [nvme_core]
[  256.995856]  ? pm_runtime_init+0x85/0xb0
[  256.995859]  nvme_alloc_ns+0x2a0/0x7d0 [nvme_core]
[  256.995865]  ? __cond_resched+0x15/0x30
[  256.995868]  nvme_validate_or_alloc_ns+0xa1/0x180 [nvme_core]
[  256.995873]  nvme_scan_work+0x13e/0x270 [nvme_core]
[  256.995881]  process_one_work+0x1aa/0x340
[  256.995885]  worker_thread+0x30/0x390
[  256.995886]  ? rescuer_thread+0x350/0x350
[  256.995887]  kthread+0x116/0x130
[  256.995889]  ? __kthread_parkme+0x70/0x70
[  256.995890]  ret_from_fork+0x22/0x30
[  256.995894] ---[ end trace 34558f0693930871 ]---

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/zns.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index c7e3ec561ba0..bc2f344f0ae0 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -9,7 +9,13 @@
 
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
-	return blk_revalidate_disk_zones(ns->disk, NULL);
+	struct request_queue *q = ns->queue;
+	int ret;
+
+	ret = blk_revalidate_disk_zones(ns->disk, NULL);
+	if (!ret)
+		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+	return ret;
 }
 
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
@@ -107,7 +113,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
-	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
 free_data:
 	kfree(id);
 	return status;
-- 
2.22.1




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
