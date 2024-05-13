Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86D7C25B5F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NhXjVujClvK0F58kHwQEM0gHvJySKG0lbsU9gs1CmJ4=; b=oRgmPucNPUYIM8xXwP6J25BnST
	Sr4oalbNPJ8eu4hM3zLqX+9U1Ami5qmvXjOkLi8799aAqAl+Ll3FvorighO7Nuxk4h0q8unjw6sr1
	qkwkiQZ3YAUIbWsSN2o8sru9sDg6Z3WmNOkV8zVlPCkMPXMUb6K4vFFcop7mIqkVIOkePa4wHfJJw
	ii9EQ6fF5bl8jPk1PMycPQcSMDiEb8monnUzU3CC4lxNQZfYL78cOZYim/3OJK6XZ5fduiPyZ4Sb0
	fuojSLZKJQnJgj6TJcX8gu/Xr1HvMk8S5KspBgPBR6STXtFYiG2QD7ZeAYARHf4A+gphrYGpfMaBe
	exknpF4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6crd-0000000ECII-2YNl;
	Mon, 13 May 2024 21:05:41 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6crY-0000000ECHo-4Bku;
	Mon, 13 May 2024 21:05:36 +0000
Date: Mon, 13 May 2024 14:05:36 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, hare@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkKAoHoC5yvNUKSE@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
 <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
 <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
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

On Mon, May 13, 2024 at 06:07:55PM +0200, Hannes Reinecke wrote:
> On 5/12/24 11:16, Luis Chamberlain wrote:
> > On Sat, May 11, 2024 at 07:43:26PM -0700, Luis Chamberlain wrote:
> > > I'll try next going above 512 KiB.
> > 
> > At 1 MiB NVMe LBA format we crash with the BUG_ON(sectors <= 0) on bio_split().
> > 
> > [   13.401651] ------------[ cut here ]------------
> > [   13.403298] kernel BUG at block/bio.c:1626!
> Ah. MAX_BUFS_PER_PAGE getting in the way.
> 
> Can you test with the attached patch?

Nope same crash:

I've enabled you to easily test with with NVMe on libvirt with kdevops,
please test.

 Luis

[   14.972734] ------------[ cut here ]------------
[   14.974731] kernel BUG at block/bio.c:1626!
[   14.976906] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   14.978899] CPU: 3 PID: 59 Comm: kworker/u36:0 Not tainted 6.9.0-rc6+ #4
[   14.981005] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   14.983782] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[   14.985431] RIP: 0010:bio_split+0xd5/0xf0
[   14.986627] Code: 5b 4c 89 e0 5d 41 5c 41 5d c3 cc cc cc cc c7 43 28 00 00 00 00 eb db 0f 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 cc cc cc cc <0f> 0b 0f 0b 4c 89 e7 e8 bf ee ff ff eb e1 66 66 2e 0f 1f 84 00 00
[   14.992063] RSP: 0018:ffffbecc002378d0 EFLAGS: 00010246
[   14.993416] RAX: 0000000000000001 RBX: ffff9e2fe8583e40 RCX: ffff9e2fdcb73060
[   14.995181] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff9e2fe8583e40
[   14.996960] RBP: 0000000000000000 R08: 0000000000000080 R09: 0000000000000000
[   14.998715] R10: ffff9e2fe8583e40 R11: ffff9e2fe8583eb8 R12: ffff9e2fe884b750
[   15.000510] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[   15.002128] FS:  0000000000000000(0000) GS:ffff9e303bcc0000(0000) knlGS:0000000000000000
[   15.003956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.005294] CR2: 0000561b2b5ce478 CR3: 0000000102484002 CR4: 0000000000770ef0
[   15.006921] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   15.008509] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   15.010001] PKRU: 55555554
[   15.010672] Call Trace:
[   15.011297]  <TASK>
[   15.011868]  ? die+0x32/0x80
[   15.012572]  ? do_trap+0xd9/0x100
[   15.013306]  ? bio_split+0xd5/0xf0
[   15.014051]  ? do_error_trap+0x6a/0x90
[   15.014854]  ? bio_split+0xd5/0xf0
[   15.015597]  ? exc_invalid_op+0x4c/0x60
[   15.016419]  ? bio_split+0xd5/0xf0
[   15.017113]  ? asm_exc_invalid_op+0x16/0x20
[   15.017932]  ? bio_split+0xd5/0xf0
[   15.018624]  __bio_split_to_limits+0x90/0x2d0
[   15.019474]  blk_mq_submit_bio+0x111/0x6a0
[   15.020280]  ? kmem_cache_alloc+0x254/0x2e0
[   15.021040]  submit_bio_noacct_nocheck+0x2f1/0x3d0
[   15.021893]  ? submit_bio_noacct+0x42/0x5b0
[   15.022658]  block_read_full_folio+0x2b7/0x350
[   15.023457]  ? __pfx_blkdev_get_block+0x10/0x10
[   15.024284]  ? __pfx_blkdev_read_folio+0x10/0x10
[   15.025073]  ? __pfx_blkdev_read_folio+0x10/0x10
[   15.025851]  filemap_read_folio+0x32/0xb0
[   15.026540]  do_read_cache_folio+0x108/0x200
[   15.027271]  ? __pfx_adfspart_check_ICS+0x10/0x10
[   15.028066]  read_part_sector+0x32/0xe0
[   15.028701]  adfspart_check_ICS+0x32/0x480
[   15.029334]  ? snprintf+0x49/0x70
[   15.029875]  ? __pfx_adfspart_check_ICS+0x10/0x10
[   15.030592]  bdev_disk_changed+0x2a2/0x6e0
[   15.031226]  blkdev_get_whole+0x5f/0xa0
[   15.031827]  bdev_open+0x201/0x3c0
[   15.032360]  bdev_file_open_by_dev+0xb5/0x110
[   15.032990]  disk_scan_partitions+0x65/0xe0
[   15.033598]  device_add_disk+0x3e0/0x3f0
[   15.034172]  nvme_scan_ns+0x5f0/0xe50 [nvme_core]
[   15.034862]  nvme_scan_work+0x26f/0x5a0 [nvme_core]
[   15.035568]  process_one_work+0x189/0x3b0
[   15.036168]  worker_thread+0x273/0x390
[   15.036713]  ? __pfx_worker_thread+0x10/0x10
[   15.037312]  kthread+0xda/0x110
[   15.037779]  ? __pfx_kthread+0x10/0x10
[   15.038316]  ret_from_fork+0x2d/0x50
[   15.038829]  ? __pfx_kthread+0x10/0x10
[   15.039364]  ret_from_fork_asm+0x1a/0x30
[   15.039924]  </TASK>


