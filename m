Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7840C38A2A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 08:19:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A815D20753
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 08:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pZ8rqjTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A815D20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iGLweekBDTBVYOdjw2bfEt2wpzoI2YFlbRTZ85aafwc=; b=pZ8rqjTfsOs5D2WEfM2nPlCbV
	Mgg0Z1jOSiGHL9eR2FYnyxneMLQ4/3bT+800H2UKtFz/UbH4dBF2kNDIQl4Z5xy9vHPNXZc9US+RF
	vL3QacbXoyZXN9x+cjIIUjrlZWDE0mJe9ALIRYNefg4ScWc3ucj3ELXlFcINwgFc7kpKvntFeP2ID
	HtKMkli1gk3wEn2dJo68nTcFjFAmszJo5y8T4CXyl4sttsK4fi8uKS7d08bMwExEwnEGBY2e/ZBEX
	vxm4IiWazUGFST/U7u5ayx66/G/7CBIRXXMSwc46veGHaPFQL5TuGLLi2ApBwp+sgfznCyKZzAH2S
	OKO2zG0vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWbkC-0007Nu-Mn; Thu, 07 May 2020 08:19:00 +0000
Received: from lhrrgout.huawei.com ([185.176.76.210] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWbk9-0007NJ-MP
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 08:18:59 +0000
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 538FBC69A3C2032323B8;
 Thu,  7 May 2020 09:18:55 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.227) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 7 May 2020
 09:18:54 +0100
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
From: John Garry <john.garry@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <2ecb88b5-b585-52ed-bb84-5b486868743a@huawei.com>
 <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
Message-ID: <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
Date: Thu, 7 May 2020 09:18:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.3.227]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_011858_024768_FAE28465 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Alexey Dobriyan <adobriyan@gmail.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 06/05/2020 18:02, John Garry wrote:
> 
>>
>> ...which is a bit of an achievement with the DMA API, but most likely 
>> implies that a prior dma_unmap was called with the wrong size, such 
>> that we only unmapped part of the IOVA region that has now been reused.


So I quickly captured this, and I can look further when I get access to 
the HW again later today:

oard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-1.1/input1
[   19.715413] hns3 0000:bd:00.0 eth0: link up
[  130.359047] random: crng init done
[  150.778579] rcu: INFO: rcu_preempt self-detected stall on CPU
[  150.784307] rcu:     32-....: (462 ticks this GP) 
idle=7ce/1/0x40000000000000
04 softirq=125/125 fqs=2609
[  150.793582]  (t=5254 jiffies g=333 q=7212724)
[  150.797921] Task dump for CPU 32:
[  150.801221] fio             R  running task        0  1084   1054 
0x00000002
[  150.808238] Call trace:
[  150.810683]  dump_backtrace+0x0/0x1a8
[  150.814331]  show_stack+0x14/0x1c
[  150.817633]  sched_show_task+0x16c/0x180
[  150.821540]  dump_cpu_task+0x40/0x4c
[  150.825102]  rcu_dump_cpu_stacks+0xb8/0xf8
[  150.829179]  rcu_sched_clock_irq+0x838/0xbe0
[  150.833431]  update_process_times+0x2c/0x50
[  150.837597]  tick_sched_handle.isra.14+0x34/0x54
[  150.842193]  tick_sched_timer+0x48/0x88
[  150.846012]  __hrtimer_run_queues+0x104/0x154
[  150.850349]  hrtimer_interrupt+0xe0/0x240
[  150.854346]  arch_timer_handler_phys+0x2c/0x38
[  150.858770]  handle_percpu_devid_irq+0x78/0x124
[  150.863281]  generic_handle_irq+0x2c/0x40
[  150.867272]  __handle_domain_irq+0x64/0xb0
[  150.871353]  gic_handle_irq+0x94/0x194
[  150.875086]  el1_irq+0xb8/0x180
[  150.878213]  efi_header_end+0xb4/0x230
[  150.881948]  irq_exit+0xc8/0xd0
[  150.885076]  __handle_domain_irq+0x68/0xb0
[  150.889153]  gic_handle_irq+0x94/0x194
[  150.892885]  el1_irq+0xb8/0x180
[  150.896016]  _raw_spin_unlock_irqrestore+0x14/0x3c
[  150.900787]  debug_dma_assert_idle+0x10c/0x1f8
[  150.905215]  wp_page_copy+0x94/0x8c0
[  150.908774]  do_wp_page+0xa4/0x54c
[  150.912162]  __handle_mm_fault+0x6dc/0x1008
[  150.916326]  handle_mm_fault+0xf0/0x1b0
[  150.920148]  do_page_fault+0x250/0x3dc
[  150.923881]  do_mem_abort+0x3c/0x9c
[  150.927354]  el0_sync_handler+0xb0/0x12c
[  150.931259]  el0_sync+0x140/0x180
[  150.934559] Task dump for CPU 39:
[  150.937859] fio             R  running task        0  1059   1054 
0x00000002
[  150.944875] Call trace:
[  150.947313]  __switch_to+0xf8/0x158
[  150.950787]  0xffff800024863c58
[  150.953914] Task dump for CPU 52:
[  150.957214] fio             R  running task        0  1072   1054 
0x00000002
[  150.964230] Call trace:
[  150.966667]  __switch_to+0xf8/0x158
[  150.970139]  0xffff8000248cbc58
[  150.973266] Task dump for CPU 58:
[  150.976566] fio             R  running task        0  1078   1054 
0x00000002
[  150.983581] Call trace:
[  150.986020]  __switch_to+0xf8/0x158
[  150.989492]  0xffff8000248fbc58
[  176.682259] ------------[ cut here ]------------
[  176.686874] WARNING: CPU: 0 PID: 1114 at 
drivers/iommu/io-pgtable-arm.c:603 _
_arm_lpae_unmap+0x4a0/0x4c4
[  176.696310] Modules linked in:
[  176.699355] CPU: 0 PID: 1114 Comm: fio Not tainted 
5.7.0-rc4-g6ef3717-dirty #
146
[  176.706716] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V
3.B220.02 03/27/2020
[  176.715548] pstate: 80400089 (Nzcv daIf +PAN -UAO)
[  176.720319] pc : __arm_lpae_unmap+0x4a0/0x4c4
[  176.724656] lr : __arm_lpae_unmap+0xf4/0x4c4
[  176.728907] sp : ffff8000100039d0
[  176.732208] x29: ffff8000100039d0 x28: ffff800010003d28
[  176.737496] x27: ffffa6c8a06deec8 x26: 0000000000001000
[  176.742784] x25: ffff800010003d28 x24: 0000000000001000
[  176.748071] x23: 00000000ef371000 x22: 0000000000000000
[  176.753359] x21: ffff002fdce3bd88 x20: 0000000000000000
[  176.758646] x19: ffff002fdce3bc00 x18: 0000000000000000
[  176.763934] x17: 0000001fffffffff x16: 000000000000021e
[  176.769221] x15: 000000000001ffff x14: 0000000000000001
[  176.774509] x13: 0000000000000025 x12: 0000000000000025
[  176.779796] x11: 000000000000ffff x10: ffffa6c8a0e151e0
[  176.785084] x9 : ffff2027c72a7b88 x8 : 000000000000000c
[  176.790371] x7 : 0000000000000b88 x6 : 0000000000000009
[  176.795658] x5 : ffff2027c72a7000 x4 : 0000000000000003
[  176.800945] x3 : 00000000000ef371 x2 : 0000000000000009
[  176.806232] x1 : ffff800010003d28 x0 : 0000000000000000
[  176.811521] Call trace:
[  176.813956]  __arm_lpae_unmap+0x4a0/0x4c4
[  176.817947]  __arm_lpae_unmap+0xf4/0x4c4
[  176.821844]  __arm_lpae_unmap+0xf4/0x4c4
[  176.825748]  __arm_lpae_unmap+0xf4/0x4c4
[  176.829654]  arm_lpae_unmap+0x68/0x7c
[  176.833301]  arm_smmu_unmap+0x18/0x20
[  176.836947]  __iommu_unmap+0xa8/0xfc
[  176.840507]  iommu_unmap_fast+0xc/0x14
[  176.844239]  __iommu_dma_unmap+0x70/0xd8
[  176.848143]  iommu_dma_unmap_page+0x38/0x88
[  176.852310]  nvme_unmap_data+0x238/0x23c
[  176.856216]  nvme_pci_complete_rq+0x28/0x58
[  176.860384]  blk_mq_complete_request+0x114/0x150
[  176.864979]  nvme_irq+0xbc/0x204
[  176.868196]  __handle_irq_event_percpu+0x5c/0x144
[  176.872879]  handle_irq_event_percpu+0x1c/0x54
[  176.877304]  handle_irq_event+0x44/0x74
[  176.881121]  handle_fasteoi_irq+0xa8/0x160
[  176.885198]  generic_handle_irq+0x2c/0x40
[  176.889189]  __handle_domain_irq+0x64/0xb0
[  176.893267]  gic_handle_irq+0x94/0x194
[  176.897001]  el1_irq+0xb8/0x180
[  176.900129]  el0_svc_common.constprop.3+0x34/0x170
[  176.904898]  do_el0_svc+0x70/0x88
[  176.908199]  el0_sync_handler+0xf0/0x12c
[  176.912104]  el0_sync+0x140/0x180
[  176.915404] ---[ end trace c76e980b98b6531c ]---
[  176.920011] ------------[ cut here ]------------
[  176.924608] WARNING: CPU: 0 PID: 1114 at 
drivers/iommu/dma-iommu.c:471 __iomm
u_dma_unmap+0xd0/0xd8
[  176.933524] Modules linked in:
[  176.936566] CPU: 0 PID: 1114 Comm: fio Tainted: G        W 
5.7.0-rc4-
g6ef3717-dirty #146
[  176.945308] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V
3.B220.02 03/27/2020
[  176.954138] pstate: 80400089 (Nzcv daIf +PAN -UAO)
[  176.958907] pc : __iommu_dma_unmap+0xd0/0xd8
[  176.963157] lr : __iommu_dma_unmap+0x70/0xd8
[  176.967407] sp : ffff800010003cd0
[  176.970707] x29: ffff800010003cd0 x28: ffff002fc25fd280
[  176.975995] x27: ffffa6c8a06deec8 x26: 0000000000001000
[  176.981283] x25: 0000000000000012 x24: ffff2027cbe74000
[  176.986570] x23: ffff002fdce3bd88 x22: 00000000ef371000
[  176.991858] x21: ffff800010003d28 x20: ffff002fd782a000
[  176.997146] x19: 0000000000001000 x18: 0000000000000000
[  177.002433] x17: 0000001fffffffff x16: 000000000000021e
[  177.007720] x15: 000000000001ffff x14: 0000000000000001
[  177.013008] x13: 0000000000000025 x12: 0000000000000025
[  177.018296] x11: 000000000000ffff x10: ffffa6c8a0e151e0
[  177.023583] x9 : ffff2027c72a7b88 x8 : 000000000000000c
[  177.028870] x7 : 0000000000000b88 x6 : 0000000000000009
[  177.034158] x5 : ffff2027c72a7000 x4 : 0000000000000000
[  177.039445] x3 : 00000000000ef371 x2 : 0000000000000009
[  177.044732] x1 : ffff800010003d28 x0 : 0000000000000000
[  177.050020] Call trace:
[  177.052454]  __iommu_dma_unmap+0xd0/0xd8
[  177.056359]  iommu_dma_unmap_page+0x38/0x88
[  177.060525]  nvme_unmap_data+0x238/0x23c
[  177.064431]  nvme_pci_complete_rq+0x28/0x58
[  177.068596]  blk_mq_complete_request+0x114/0x150
[  177.073191]  nvme_irq+0xbc/0x204
[  177.076405]  __handle_irq_event_percpu+0x5c/0x144
[  177.081088]  handle_irq_event_percpu+0x1c/0x54
[  177.085512]  handle_irq_event+0x44/0x74
[  177.089329]  handle_fasteoi_irq+0xa8/0x160
[  177.093409]  generic_handle_irq+0x2c/0x40
[  177.097399]  __handle_domain_irq+0x64/0xb0
[  177.101476]  gic_handle_irq+0x94/0x194
[  177.105209]  el1_irq+0xb8/0x180
[  177.108337]  el0_svc_common.constprop.3+0x34/0x170
[  177.113106]  do_el0_svc+0x70/0x88
[  177.116407]  el0_sync_handler+0xf0/0x12c
[  177.120312]  el0_sync+0x140/0x180
[  177.123612] ---[ end trace c76e980b98b6531d ]---
[  177.128213] ------------[ cut here ]------------
[  177.132810] DMA-API: nvme 0000:85:00.0: device driver tries to free 
DMA memor
y it has not allocated [device address=0x00000000ef371000] [size=4096 bytes]
[  177.146484] WARNING: CPU: 0 PID: 1114 at kernel/dma/debug.c:1017 
check_unmap+
0x698/0x86c
[  177.154536] Modules linked in:
[  177.157578] CPU: 0 PID: 1114 Comm: fio Tainted: G        W 
5.7.0-rc4-
g6ef3717-dirty #146
[  177.166322] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V
3.B220.02 03/27/2020
[  177.175152] pstate: 60400089 (nZCv daIf +PAN -UAO)
[  177.179921] pc : check_unmap+0x698/0x86c
[  177.183827] lr : check_unmap+0x698/0x86c
[  177.187732] sp : ffff800010003c40
[  177.191032] x29: ffff800010003c40 x28: ffff002fc25fd280
[  177.196321] x27: ffffa6c8a06deec8 x26: 0000000000001000
[  177.201608] x25: 0000000000000080 x24: ffff2027cbe74000
[  177.206895] x23: ffffa6c8a1084530 x22: ffffa6c8a0dfa000
[  177.212182] x21: 00000000ef371000 x20: ffff800010003cc0
[  177.217461] x19: 00000000ef371000 x18: 0000000000000000
[  177.222740] x17: 000000000000000f x16: 00000000000001a4
[  177.228028] x15: 000000000001ffff x14: 30343d657a69735b
[  177.233316] x13: 205d303030313733 x12: 6665303030303030
[  177.238603] x11: 303078303d737365 x10: 7264646120656369
[  177.243891] x9 : ffffa6c8a0e11c80 x8 : 61636f6c6c612074
[  177.249178] x7 : 6f6e207361682074 x6 : ffff0027ffd1d1f0
[  177.254464] x5 : 0000000000000000 x4 : 0000000000000000
[  177.259752] x3 : 00000000ffffffff x2 : ffffa6c8a0e11d00
[  177.265039] x1 : 0000000100010001 x0 : 000000000000008d
[  177.270326] Call trace:
[  177.272761]  check_unmap+0x698/0x86c
[  177.276322]  debug_dma_unmap_page+0x6c/0x78
[  177.280487]  nvme_unmap_data+0x7c/0x23c
[  177.284305]  nvme_pci_complete_rq+0x28/0x58
estuary:/$

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
