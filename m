Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D314DD3B7EA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QsnMctOIp10ILj1iGDxBOjBn8xobdvJt3f69X4PTcHM=; b=v0iY8cqDXOPDZPg3x1aU3A2K9d
	nNsLrxz0/xh05Ki1sqOI8hIEXI86y2bdum1nFzwkBU+N963aW8KbVZhZnkzqqtAgREzLeXXAvUINv
	IvK+Pyob1/Goo3Z0+M1MTT0LkrAHyj4xh/4TbjygpNGKs1BERtZRfCrR6pPQQr2zT4SI4v+SPiM6k
	wVbbUr986pH2cRgaZqKc46Ruep0Wfk/S2Q6Qp11y5AEszhRC109BBzRBLfKroF70+R0AqJj8ZRot2
	luwlX8+/M0WJvVV/8q/Tw2z6kI0wc/3gG4K+gUbqaGzLLOcsWtfYtCZWNcv9S/kmcWDxq7wuqQ7CF
	EUalrZzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSwEd-0000000EDEV-0t4k;
	Tue, 09 Dec 2025 11:50:27 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSwEa-0000000EDDw-2ktu
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 11:50:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA6A1691;
	Tue,  9 Dec 2025 03:50:16 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B89CA3F762;
	Tue,  9 Dec 2025 03:50:21 -0800 (PST)
Message-ID: <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
Date: Tue, 9 Dec 2025 11:50:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
To: Sebastian Ott <sebott@redhat.com>, linux-nvme@lists.infradead.org,
 iommu@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Will Deacon <will@kernel.org>, Carlos Maiolino <cem@kernel.org>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_035024_798578_9B9E6D8E 
X-CRM114-Status: GOOD (  11.52  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2025-12-09 11:43 am, Sebastian Ott wrote:
> Hi,
> 
> got the following warning after a kernel update on Thurstday, leading to a
> panic and fs corruption. I didn't capture the first warning but I'm pretty
> sure it was the same. It's reproducible but I didn't bisect since it
> borked my fs. The only hint I can give is that v6.18 worked. Is this a
> known issue? Anything I should try?

nvme_unmap_data() is attempting to unmap an IOVA that was never mapped, 
or has already been unmapped by someone else. That's a usage bug.

Thanks,
Robin.

> [64906.234244] WARNING: drivers/iommu/io-pgtable-arm.c:639 at 
> __arm_lpae_unmap+0x358/0x3d0, CPU#94: kworker/94:0/494
> [64906.234247] Modules linked in: mlx5_ib ib_uverbs ib_core qrtr rfkill 
> sunrpc mlx5_core cdc_eem usbnet mii acpi_ipmi ipmi_ssif ipmi_devintf 
> ipmi_msghandler mlxfw arm_cmn psample arm_spe_pmu arm_dmc620_pmu vfat 
> fat arm_dsu_pmu cppc_cpufreq fuse loop dm_multipath nfnetlink zram xfs 
> nvme mgag200 ghash_ce sbsa_gwdt nvme_core i2c_algo_bit xgene_hwmon 
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev
> [64906.234269] CPU: 94 UID: 0 PID: 494 Comm: kworker/94:0 Tainted: 
> G        W           6.18.0+ #1 PREEMPT(voluntary) [64906.234271] 
> Tainted: [W]=WARN
> [64906.234271] Hardware name: HPE ProLiant RL300 Gen11/ProLiant RL300 
> Gen11, BIOS 1.50 12/18/2023
> [64906.234272] Workqueue: xfs-buf/nvme1n1p1 xfs_buf_ioend_work [xfs]
> [64906.234383] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [64906.234385] pc : __arm_lpae_unmap+0x358/0x3d0
> [64906.234386] lr : __arm_lpae_unmap+0x100/0x3d0
> [64906.234387] sp : ffff800083d4bad0
> [64906.234388] x29: ffff800083d4bad0 x28: 00000000f3460000 x27: 
> ffff800081bb28e8
> [64906.234391] x26: 0000000000001000 x25: ffff800083d4be00 x24: 
> 00000000f3460000
> [64906.234393] x23: 0000000000001000 x22: ffff07ff85de9c20 x21: 
> 0000000000000001
> [64906.234395] x20: 0000000000000000 x19: ffff07ff9d540300 x18: 
> 0000000000000300
> [64906.234398] x17: ffff887cbd289000 x16: ffff800083d48000 x15: 
> 0000000000001000
> [64906.234400] x14: 0000000000000fc4 x13: 0000000000000820 x12: 
> 0000000000001000
> [64906.234402] x11: 0000000000000006 x10: ffff07ffa1b9c300 x9 : 
> 0000000000000009
> [64906.234405] x8 : 0000000000000060 x7 : 000000000000000c x6 : 
> ffff07ffa1b9c000
> [64906.234407] x5 : 0000000000000003 x4 : 0000000000000001 x3 : 
> 0000000000001000
> [64906.234409] x2 : 0000000000000000 x1 : ffff800083d4be00 x0 : 
> 0000000000000000
> [64906.234411] Call trace:
> [64906.234412]  __arm_lpae_unmap+0x358/0x3d0 (P)
> [64906.234414]  __arm_lpae_unmap+0x100/0x3d0
> [64906.234415]  __arm_lpae_unmap+0x100/0x3d0
> [64906.234417]  __arm_lpae_unmap+0x100/0x3d0
> [64906.234418]  arm_lpae_unmap_pages+0x74/0x90
> [64906.234420]  arm_smmu_unmap_pages+0x24/0x40
> [64906.234422]  __iommu_unmap+0xe8/0x2a0
> [64906.234424]  iommu_unmap_fast+0x18/0x30
> [64906.234426]  __iommu_dma_iova_unlink+0xe4/0x280
> [64906.234428]  dma_iova_destroy+0x30/0x58
> [64906.234431]  nvme_unmap_data+0x88/0x248 [nvme]
> [64906.234434]  nvme_poll_cq+0x1d4/0x3e0 [nvme]
> [64906.234438]  nvme_irq+0x28/0x70 [nvme]
> [64906.234441]  __handle_irq_event_percpu+0x84/0x370
> [64906.234444]  handle_irq_event+0x4c/0xb0
> [64906.234447]  handle_fasteoi_irq+0x110/0x1a8
> [64906.234449]  handle_irq_desc+0x3c/0x68
> [64906.234451]  generic_handle_domain_irq+0x24/0x40
> [64906.234454]  gic_handle_irq+0x5c/0xe0
> [64906.234455]  call_on_irq_stack+0x30/0x48
> [64906.234457]  do_interrupt_handler+0xdc/0xe0
> [64906.234459]  el1_interrupt+0x38/0x60
> [64906.234462]  el1h_64_irq_handler+0x18/0x30
> [64906.234464]  el1h_64_irq+0x70/0x78
> [64906.234466]  arm_lpae_init_pte+0x228/0x238 (P)
> [64906.234467]  __arm_lpae_map+0x2f8/0x378
> [64906.234469]  __arm_lpae_map+0x114/0x378
> [64906.234470]  __arm_lpae_map+0x114/0x378
> [64906.234472]  __arm_lpae_map+0x114/0x378
> [64906.234473]  arm_lpae_map_pages+0x108/0x240
> [64906.234475]  arm_smmu_map_pages+0x24/0x40
> [64906.234477]  iommu_map_nosync+0x124/0x310
> [64906.234479]  iommu_map+0x2c/0xb0
> [64906.234481]  __iommu_dma_map+0xbc/0x1b0
> [64906.234484]  iommu_dma_map_phys+0xf0/0x1c0
> [64906.234486]  dma_map_phys+0x190/0x1b0
> [64906.234488]  dma_map_page_attrs+0x50/0x70
> [64906.234490]  nvme_map_data+0x21c/0x318 [nvme]
> [64906.234493]  nvme_prep_rq+0x60/0x200 [nvme]
> [64906.234496]  nvme_queue_rq+0x48/0x180 [nvme]
> [64906.234499]  blk_mq_dispatch_rq_list+0xfc/0x4d0
> [64906.234502]  __blk_mq_sched_dispatch_requests+0xa4/0x1b0
> [64906.234504]  blk_mq_sched_dispatch_requests+0x38/0xa0
> [64906.234506]  blk_mq_run_hw_queue+0x2f0/0x3d0
> [64906.234509]  blk_mq_issue_direct+0x12c/0x280
> [64906.234511]  blk_mq_dispatch_queue_requests+0x258/0x318
> [64906.234514]  blk_mq_flush_plug_list+0x68/0x170
> [64906.234515]  __blk_flush_plug+0xf0/0x140
> [64906.234518]  blk_finish_plug+0x34/0x50
> [64906.234520]  xfs_buf_submit_bio+0x158/0x1a8 [xfs]
> [64906.234630]  xfs_buf_submit+0x80/0x268 [xfs]
> [64906.234739]  xfs_buf_ioend_handle_error+0x254/0x480 [xfs]
> [64906.234848]  __xfs_buf_ioend+0x18c/0x218 [xfs]
> [64906.234957]  xfs_buf_ioend_work+0x24/0x60 [xfs]
> [64906.235066]  process_one_work+0x22c/0x658
> [64906.235069]  worker_thread+0x1ac/0x360
> [64906.235072]  kthread+0x110/0x138
> [64906.235074]  ret_from_fork+0x10/0x20
> [64906.235075] ---[ end trace 0000000000000000 ]---
> 
> Thanks,
> Sebastian
> 


