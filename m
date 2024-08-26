Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC84C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I1W5RtIb5kX2KU9HuHbGgzinaQBg044fjfzMERcPLgI=; b=Xl/JdCQGdRk9mLWozgLcuL23Z1
	zn4X/sC2Yte+imOyrE8ZwR2X9iGtftFwmkXFqcixTORyQJhV6OhNJP33+UDJ7v/9lhlOGVCACPnn/
	aeKdoR+7IcHzg0P7756zClDHPhMqh4987apbi8z56BD5daWhxeFm5rVKmmbQZwyxmXRG4/lBtMKjR
	pfnx8Cl8ICHIansEJhrwB9ADxXstXUb7EJTZb9kOw0HCOpbvwnB3/vLI5j0/xhInX3Au8RImQ5Fma
	vWSYc3WL/Na21VWl/Sk7g8ESAONrWyQhhNcsqJsu0bsRt4KZFBXEu24DI4O71fUwzMaYckHsHCgFe
	VACm8hLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibuF-00000007s9k-0X23;
	Mon, 26 Aug 2024 15:45:23 +0000
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sialq-00000007fVa-0J7X
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 14:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724682758; x=1756218758;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=I1W5RtIb5kX2KU9HuHbGgzinaQBg044fjfzMERcPLgI=;
  b=KYrXxDxrC1MO03KOEZKPxneAo6P4D9GFQggCv41Z6SzGbC6exWXzB1gc
   D13aHG2xWbSmCXTGiMxuoPFDZQ6FQ+JDbG/6NDuFBGF/8ciwiSKA+t7nu
   JFJ9iwAQSVV4svOjmhd0NmhhJluprL3XtdcVZRECnir5LVljFBj7tqsjA
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,177,1719878400"; 
   d="scan'208";a="119022431"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 14:32:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:40486]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.206:2525] with esmtp (Farcaster)
 id d59728fa-5370-4ad3-a683-58c8841c6a54; Mon, 26 Aug 2024 14:32:32 +0000 (UTC)
X-Farcaster-Flow-ID: d59728fa-5370-4ad3-a683-58c8841c6a54
Received: from EX19EXOUWA001.ant.amazon.com (10.250.64.209) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 26 Aug 2024 14:32:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19EXOUWA001.ant.amazon.com (10.250.64.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 26 Aug 2024 14:32:32 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Mon, 26 Aug 2024 14:32:31 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 6F18B20854; Mon, 26 Aug 2024 14:32:31 +0000 (UTC)
From: <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>
Subject: BUG Report: kernel NULL pointer dereference in bio_integrity_advance()
Date: Mon, 26 Aug 2024 14:32:31 +0000
Message-ID: <mb61pcylvnym8.fsf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_073238_238780_45D6BC3D 
X-CRM114-Status: GOOD (  14.04  )
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


Hi,

I saw that running the following command on 5.4, 5.10, 5.15 stable
kernels crashes the system with a NULL pointer dereference:

 root@pjy:~# touch test.txt
 root@pjy:~# nvme io-passthru /dev/nvme0 --opcode=0x1 --input-file=test.txt --data-len=1 --write --namespace=1 --metadata-len=1
 nvme nvme0: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
 Unable to handle kernel NULL pointer dereference at virtual address 000000000000000a
 Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106500000
 [000000000000000a] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in: crct10dif_ce nvme nvme_core fuse drm dm_mod ip_tables x_tables ipv6
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.1-gb6abb62daa55 #1
 Hardware name: linux,dummy-virt (DT)
 pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : bio_integrity_advance+0x4c/0x100
 lr : bio_advance+0x34/0x120
 sp : ffff800010003d90
 x29: ffff800010003d90 x28: ffff800011d234c0 x27: ffff80001151ff20
 x26: ffff0000be180310 x25: 00000000000000b1 x24: 0000000000000001
 x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000c6733640
 x20: ffff0000c47afa00 x19: ffff0000c5f81108 x18: 0000000000000001
 x17: ffff8000edf70000 x16: ffff800010004000 x15: 0000000000004000
 x14: 0000000000000001 x13: 0000000000000002 x12: 0000000000000400
 x11: 0000000000000040 x10: ffff0000c0034168 x9 : ffff0000c0034160
 x8 : ffff0000c0424550 x7 : 0000000000000000 x6 : 0000000000000000
 x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : ffff0000c5f81100 x1 : 0000000000000001 x0 : 0000000000000000
 Call trace:
  bio_integrity_advance+0x4c/0x100
  bio_advance+0x34/0x120
  blk_update_request+0x174/0x400
  blk_mq_end_request+0x2c/0x150
  nvme_complete_rq+0x4c/0x10c [nvme_core]
  nvme_pci_complete_rq+0x4c/0xa4 [nvme]
  nvme_process_cq+0x144/0x250 [nvme]
  nvme_irq+0x18/0x30 [nvme]
  __handle_irq_event_percpu+0x40/0x15c
  handle_irq_event+0x64/0x140
  handle_fasteoi_irq+0xa8/0x1a0
  handle_domain_irq+0x64/0x94
  gic_handle_irq+0xbc/0x140
  call_on_irq_stack+0x2c/0x60
  do_interrupt_handler+0x54/0x60
  el1_interrupt+0x30/0x80
  el1h_64_irq_handler+0x1c/0x2c
  el1h_64_irq+0x78/0x7c
  finish_task_switch.isra.0+0x98/0x260
  __schedule+0x2a4/0x714
  schedule_idle+0x2c/0x50
  do_idle+0x190/0x2cc
  cpu_startup_entry+0x28/0x80
  rest_init+0xe8/0x100
  arch_call_rest_init+0x14/0x20
  start_kernel+0x634/0x674
  __primary_switched+0xc0/0xc8
 Code: f9402800 f84c8c04 f100009f 9a9f1000 (39402804)
 ---[ end trace 515229a85ac6ccf1 ]---
 Kernel panic - not syncing: Oops: Fatal exception in interrupt
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x11000471,20000846
 Memory Limit: none
 ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

This is because in the function:

void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
{
	struct bio_integrity_payload *bip = bio_integrity(bio);
	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);

	bip->bip_iter.bi_sector += bio_integrity_intervals(bi, bytes_done >> 9);
	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
}

Here blk_get_integrity() returns NULL and bio_integrity_bytes() uses it
without checking for NULL.

This issue is also present in mainline but doesn't trigger because after

d4aa57a1cac3 ("block: don't bother iter advancing a fully done bio")

bio_advance() is not called for this reproducer, but this bug might be
triggerable through another path.

I want to send a patch to fix this but need some help to understand
where the change has to be made.

in 5.15 for example:

void bio_advance(struct bio *bio, unsigned bytes)
{
	if (bio_integrity(bio))
		bio_integrity_advance(bio, bytes);

	bio_crypt_advance(bio, bytes);
	bio_advance_iter(bio, &bio->bi_iter, bytes);
}

Here bio_integrity(bio) returns non-null and therefore
bio_integrity_advance() is called but in that fuction,
blk_get_integrity(bio->bi_bdev->bd_disk) returns NULL because for this
disk bi->profile is NULL.

So, the problem is that bi->profile is NULL for this disk but
bio->bi_integrity is non-NULL for this bio.


Please help me debug this further.


P.S. - Reproducing using qemu.
Here are the commands I used:

qemu-system-aarch64 -machine 'virt,gic-version=3' -cpu 'cortex-a57' -smp \
 2 -m 4G -drive format=raw,file=rootfs -device \
 virtio-net-device,netdev=net -netdev user,id=net,hostfwd=tcp::2222-:22 \ 
 -kernel linux/arch/arm64/boot/Image -nographic -append "root=/dev/vda rw \
 console=ttyAMA0 debug earlyprintk=serial slub_debug=UZ nokaslr" -gdb \
 tcp::1234 -d guest_errors,unimp -D log.txt -drive \
 file=nvm.img,if=none,id=nvm -device nvme,serial=deadbeef,drive=nvm

Kernel is v5.15.1 compiled with arm64 defconfig

The following commands will then crash the kernel:
# touch test.txt
# nvme io-passthru /dev/nvme0 --opcode=0x1 --input-file=test.txt --data-len=1 --write --namespace=1 --metadata-len=1


Thanks,
Puranjay

