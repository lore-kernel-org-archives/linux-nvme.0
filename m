Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCABC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 03:52:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ADD60F21
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 03:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0ADD60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+YqAGI8nwv1ll37n1e8nKRPgPaN/ctDywEMHAYf2nhw=; b=RK6S4Iat4IyVFi
	YIRbfdjxX59uwy7VBc0ygqjCw5OjZCj0Osm78I25JyWqzrslc3WgjDC/nFTkXMMtFjG2CvcMFdhe6
	i1K6oopG9jUdcbHnXY/LFXF6ognPHx31U/q3Aq8Xf2ADuma1vEkevQjigCq7cVxdYTvz8utnEx/y3
	oDtPW91NiPrt+Y4ubZ3L9HiUF8Y5asi1WjECSs38+CaZlVX64d/7ztMqzzVj+W0XecHm9HYa6aPSX
	iQn76P8PSvoEnr+eCpcvh5UNcLOSW6fVqtUeRi/3RB9ZZFEqF5DOv2ZDT+Jify+vgvh7g+Qq8Bdt6
	Won0cT+k39bjSPIs+AcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN5fs-00HCm0-5d; Mon, 06 Sep 2021 03:52:00 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN5ff-00HCl2-CO
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 03:51:49 +0000
Received: from dggeme770-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H2vVc2tk2zbkY2;
 Mon,  6 Sep 2021 11:47:36 +0800 (CST)
Received: from huawei.com (10.29.88.127) by dggeme770-chm.china.huawei.com
 (10.3.19.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 11:51:35 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>
Subject: [PATCH 0/1] fix a panic cause by use qp after free 
Date: Mon, 6 Sep 2021 11:51:33 +0800
Message-ID: <20210906035134.14789-1-liruozhu@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme770-chm.china.huawei.com (10.3.19.116)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_205147_800652_15F9026A 
X-CRM114-Status: UNSURE (   8.46  )
X-CRM114-Notice: Please train this message.
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

We got a panic when host received a rej cm event soon after a connect
error cm event.
When host get connect error cm event, it will destroy qp immediately.
But cm_id is still valid then.Another cm event rise here, try to access
the qp which was destroyed.Then we got a kernel panic blow:

[87816.777089] [20473] ib_cm:cm_rep_handler:2343: cm_rep_handler: Stale connection. local_comm_id -154357094, remote_comm_id -1133609861
[87816.777223] [20473] ib_cm:cm_init_qp_rtr_attr:4162: cm_init_qp_rtr_attr: local_id -1150387077, cm_id_priv->id.state: 13
[87816.777225] [20473] rdma_cm:cma_rep_recv:1871: RDMA CM: CONNECT_ERROR: failed to handle reply. status -22
[87816.777395] [20473] ib_cm:ib_send_cm_rej:2781: ib_send_cm_rej: local_id -1150387077, cm_id->state: 13
[87816.777398] [20473] nvme_rdma:nvme_rdma_cm_handler:1718: nvme nvme278: connect error (6): status -22 id 00000000c3809aff
[87816.801155] [20473] nvme_rdma:nvme_rdma_cm_handler:1742: nvme nvme278: CM error event 6
[87816.801160] [20473] rdma_cm:cma_ib_handler:1947: RDMA CM: REJECTED: consumer defined
[87816.801163] nvme nvme278: rdma connection establishment failed (-104)
[87816.801168] BUG: unable to handle kernel NULL pointer dereference at 0000000000000370
[87816.801171] PGD 0 P4D 0 
[87816.801174] Oops: 0000 [#1] SMP PTI
[87816.801177] CPU: 21 PID: 20473 Comm: kworker/21:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-147.el8.x86_64 #1
[87816.801179] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.57 02/26/2017
[87816.801185] Workqueue: ib_cm cm_work_handler [ib_cm]
[87816.801201] RIP: 0010:_ib_modify_qp+0x6e/0x3a0 [ib_core]
[87816.801203] Code: 8b 7d 00 25 80 00 00 00 89 44 24 04 0f 85 fe 01 00 00 89 d8 45 31 e4 25 00 40 00 00 89 44 24 08 0f 85 00 01 00 00 48 c1 e5 04 <48> 03 af 70 03 00 00 f7 45 08 00 00 b0 00 74 7d f6 c7 10 74 36 41
[87816.801204] RSP: 0018:ffff9b6805f23bd8 EFLAGS: 00010202
[87816.801206] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[87816.801207] RDX: 0000000000000001 RSI: ffff9b6805f23c48 RDI: 0000000000000000
[87816.801208] RBP: 0000000000000010 R08: 000000000048ef34 R09: 0000000000000004
[87816.801209] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[87816.801210] R13: ffff8d351b5ef800 R14: ffff9b6805f23c48 R15: ffff8d353bdbd0e0
[87816.801212] FS:  0000000000000000(0000) GS:ffff8d36afa40000(0000) knlGS:0000000000000000
[87816.801213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[87816.801214] CR2: 0000000000000370 CR3: 0000000367e0a004 CR4: 00000000001606e0
[87816.801215] Call Trace:
[87816.801223]  cma_modify_qp_err+0x52/0x80 [rdma_cm]
[87816.801228]  ? __dynamic_pr_debug+0x8a/0xb0
[87816.801232]  cma_ib_handler+0x25a/0x2f0 [rdma_cm]
[87816.801235]  cm_process_work+0x60/0xe0 [ib_cm]
[87816.801238]  cm_work_handler+0x13b/0x1b97 [ib_cm]
[87816.801243]  ? __switch_to_asm+0x35/0x70
[87816.801244]  ? __switch_to_asm+0x41/0x70
[87816.801246]  ? __switch_to_asm+0x35/0x70
[87816.801248]  ? __switch_to_asm+0x41/0x70
[87816.801252]  ? __switch_to+0x8c/0x480
[87816.801254]  ? __switch_to_asm+0x41/0x70
[87816.801256]  ? __switch_to_asm+0x35/0x70
[87816.801259]  process_one_work+0x1a7/0x3b0
[87816.801263]  worker_thread+0x30/0x390
[87816.801266]  ? create_worker+0x1a0/0x1a0
[87816.801268]  kthread+0x112/0x130
[87816.801270]  ? kthread_flush_work_fn+0x10/0x10
[87816.801272]  ret_from_fork+0x35/0x40
[87816.801274] Modules linked in: nft_chain_route_ipv4 xt_CHECKSUM nft_chain_nat_ipv4 ipt_MASQUERADE nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 nft_counter nft_compat nf_tables nfnetlink tun bridge 8021q garp mrp stp llc vfat fat ib_isert iscsi_target_mod ext4 mbcache jbd2 ib_srpt target_core_mod ib_srp scsi_transport_srp nls_utf8 isofs loop intel_rapl sb_edac x86_pkg_temp_thermal coretemp kvm_intel rpcrdma kvm sunrpc irqbypass rdma_ucm ib_iser crct10dif_pclmul joydev ib_umad libiscsi crc32_pclmul ib_ipoib ghash_clmulni_intel scsi_transport_iscsi intel_cstate intel_uncore intel_rapl_perf ipmi_si ipmi_devintf pcspkr ipmi_msghandler wdat_wdt mei_me i2c_i801 sg mei lpc_ich acpi_power_meter xfs libcrc32c mlx5_ib ib_uverbs sr_mod cdrom sd_mod ahci
[87816.801314]  libahci crc32c_intel libata megaraid_sas tg3 dm_mirror dm_region_hash dm_log dm_mod mlx5_core mlxfw nvme_rdma(OE) nvme_fabrics(OE) nvme_core(OE) rdma_cm iw_cm ib_cm ib_core
[87816.801325] CR2: 0000000000000370

Try to fix it with following patch.

Ruozhu Li (1):
  nvme-rdma: destroy cm id before destroy qp to avoid use after free

 drivers/nvme/host/rdma.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
