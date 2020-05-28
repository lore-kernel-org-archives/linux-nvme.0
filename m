Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 19:11:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B139B2075A
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 19:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NcjOl5Mf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df0fmXMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B139B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v9vMszjcP6ZxLhV1wXmcDoYbochlSmlnouomN49TTTI=; b=NcjOl5Mfa/Ndmv
	Ar18YYWwWk84O6CXQx2RRcYc7zG2NkLpxWsa0T3nk1WU9/djTbjeQFQWO8Acrv8i1xy1CA576gjvG
	uClO2tZ1ro3g3SeN0zwThnZSF6Ls6AgyL0BVACYPdHmmLp6iEEfKnRG8x62lVboqzxDLKH2lh71Xa
	f1mFUMOMu4O6AuwT419NVYMoTNA+5FiD4NmXEF0GAPAq9tuh+Oo+3hzj/o410OFvcebbDDeHkgI90
	iICaHKmJtTnDRVIUloQGeGn1wqr0wgygwzRWRa2Jmh+73RR9fYY7ZnKiIzDzk53YfOmGaOmhh6ael
	zAqDwp9nda/JFX+cJhPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeNw4-0000DA-05; Thu, 28 May 2020 19:11:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeNw1-0000Ck-Mx
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 19:11:23 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B1CE2207BC;
 Thu, 28 May 2020 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590693081;
 bh=388jovjOXCiQP4qLNBBSVu6nGhIP80psiUikZcHSvNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Df0fmXMqqAVQjFPkBLiQ9itUvC5d2zZr+zU8G0NiGagZVb7zx4t9w5QZEzD+++6Ct
 YEwNQt0OQWv8vAAg6SAuPuF/IBY07Jv6XPXyIJDvxke9JQmyZgFeHpeJrtR+CXFZUC
 CUrqHcuUQQ8dg/9Rwy+85Hsg5xORMbHH3m/laQrk=
Date: Thu, 28 May 2020 12:11:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
Message-ID: <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_121121_789063_6EB8969C 
X-CRM114-Status: UNSURE (   8.80  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 28, 2020 at 11:39:10AM -0700, Alan Adamson wrote:
> Still seeing a hang.
 =

Is it really stuck or are you just not waiting long enough?

The default timeout is 30 seconds, and we wait that long once after
submission, and again after abort for a total of 60 seconds.

But then there's also the retry logic, which by default will retry a
non-permanenet error 5 times (a cancelled request normally qualifies for
retries).

An top of all that, you have to add the time it takes to initialize your
controller. Your controller appears to init quite fast, so that part is
probably negligable for you.

You can expect your fake timeout with 100% probablility to take 150
seconds minimum to return a retryable request. Your "stuck" task has
only been waiting 122 seconds.
 =

> [=A0 182.883552] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [=A0 182.883608] nvme nvme0: Abort status: 0x0
> [=A0 213.088659] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [=A0 213.109414] nvme nvme0: Shutdown timeout set to 10 seconds
> [=A0 213.112785] nvme nvme0: 56/0/0 default/read/poll queues
> [=A0 213.112880] FAULT_INJECTION: forcing a failure.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name fail_io_timeout, interval=
 1, probability 100, space 0,
> times 998
> [=A0 213.112882] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [=A0 213.112883] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [=A0 213.112883] Call Trace:
> [=A0 213.112884]=A0 <IRQ>
> [=A0 213.112887]=A0 dump_stack+0x6d/0x9a
> [=A0 213.112888]=A0 should_fail.cold.5+0x32/0x42
> [=A0 213.112889]=A0 blk_should_fake_timeout+0x26/0x30
> [=A0 213.112890]=A0 blk_mq_complete_request+0x15/0x30
> [=A0 213.112893]=A0 nvme_irq+0xd9/0x1f0 [nvme]
> [=A0 213.112896]=A0 __handle_irq_event_percpu+0x44/0x190
> [=A0 213.112897]=A0 handle_irq_event_percpu+0x32/0x80
> [=A0 213.112898]=A0 handle_irq_event+0x3b/0x5a
> [=A0 213.112900]=A0 handle_edge_irq+0x87/0x190
> [=A0 213.112901]=A0 do_IRQ+0x54/0xe0
> [=A0 213.112903]=A0 common_interrupt+0xf/0xf
> [=A0 213.112903]=A0 </IRQ>
> [=A0 213.112905] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [=A0 213.112906] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44=
 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <=
45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [=A0 213.112907] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [=A0 213.112908] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [=A0 213.112909] RDX: 000000319e847448 RSI: 0000000031573862 RDI:
> 0000000000000000
> [=A0 213.112909] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [=A0 213.112910] R10: 011c655cc6d029f4 R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [=A0 213.112911] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [=A0 213.112913]=A0 cpuidle_enter+0x2e/0x40
> [=A0 213.112915]=A0 call_cpuidle+0x23/0x40
> [=A0 213.112916]=A0 do_idle+0x230/0x270
> [=A0 213.112917]=A0 cpu_startup_entry+0x1d/0x20
> [=A0 213.112919]=A0 start_secondary+0x170/0x1c0
> [=A0 213.112920]=A0 secondary_startup_64+0xb6/0xc0
> [=A0 243.293996] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [=A0 243.294050] nvme nvme0: Abort status: 0x0
> [=A0 273.498939] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [=A0 273.509832] nvme nvme0: new error during reset
> [=A0 273.519648] nvme nvme0: Shutdown timeout set to 10 seconds
> [=A0 273.523310] nvme nvme0: 56/0/0 default/read/poll queues
> [=A0 273.523397] FAULT_INJECTION: forcing a failure.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name fail_io_timeout, interval=
 1, probability 100, space 0,
> times 997
> [=A0 273.523399] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [=A0 273.523400] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [=A0 273.523400] Call Trace:
> [=A0 273.523401]=A0 <IRQ>
> [=A0 273.523404]=A0 dump_stack+0x6d/0x9a
> [=A0 273.523405]=A0 should_fail.cold.5+0x32/0x42
> [=A0 273.523406]=A0 blk_should_fake_timeout+0x26/0x30
> [=A0 273.523407]=A0 blk_mq_complete_request+0x15/0x30
> [=A0 273.523410]=A0 nvme_irq+0xd9/0x1f0 [nvme]
> [=A0 273.523412]=A0 __handle_irq_event_percpu+0x44/0x190
> [=A0 273.523413]=A0 handle_irq_event_percpu+0x32/0x80
> [=A0 273.523415]=A0 handle_irq_event+0x3b/0x5a
> [=A0 273.523416]=A0 handle_edge_irq+0x87/0x190
> [=A0 273.523417]=A0 do_IRQ+0x54/0xe0
> [=A0 273.523419]=A0 common_interrupt+0xf/0xf
> [=A0 273.523420]=A0 </IRQ>
> [=A0 273.523422] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [=A0 273.523423] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44=
 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <=
45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [=A0 273.523424] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [=A0 273.523425] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [=A0 273.523425] RDX: 0000003faf43ca28 RSI: 0000000031573862 RDI:
> 0000000000000000
> [=A0 273.523426] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [=A0 273.523426] R10: 011c658143e5b34c R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [=A0 273.523427] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [=A0 273.523429]=A0 cpuidle_enter+0x2e/0x40
> [=A0 273.523431]=A0 call_cpuidle+0x23/0x40
> [=A0 273.523432]=A0 do_idle+0x230/0x270
> [=A0 273.523433]=A0 cpu_startup_entry+0x1d/0x20
> [=A0 273.523435]=A0 start_secondary+0x170/0x1c0
> [=A0 273.523436]=A0 secondary_startup_64+0xb6/0xc0
> [=A0 303.704204] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [=A0 303.704245] nvme nvme0: Abort status: 0x0
> [=A0 333.909140] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [=A0 333.928010] nvme nvme0: new error during reset
> [=A0 333.934087] nvme nvme0: Shutdown timeout set to 10 seconds
> [=A0 333.937470] nvme nvme0: 56/0/0 default/read/poll queues
> [=A0 333.937571] FAULT_INJECTION: forcing a failure.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name fail_io_timeout, interval=
 1, probability 100, space 0,
> times 996
> [=A0 333.937588] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [=A0 333.937588] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [=A0 333.937589] Call Trace:
> [=A0 333.937590]=A0 <IRQ>
> [=A0 333.937592]=A0 dump_stack+0x6d/0x9a
> [=A0 333.937593]=A0 should_fail.cold.5+0x32/0x42
> [=A0 333.937594]=A0 blk_should_fake_timeout+0x26/0x30
> [=A0 333.937595]=A0 blk_mq_complete_request+0x15/0x30
> [=A0 333.937598]=A0 nvme_irq+0xd9/0x1f0 [nvme]
> [=A0 333.937600]=A0 __handle_irq_event_percpu+0x44/0x190
> [=A0 333.937602]=A0 handle_irq_event_percpu+0x32/0x80
> [=A0 333.937603]=A0 handle_irq_event+0x3b/0x5a
> [=A0 333.937604]=A0 handle_edge_irq+0x87/0x190
> [=A0 333.937606]=A0 do_IRQ+0x54/0xe0
> [=A0 333.937607]=A0 common_interrupt+0xf/0xf
> [=A0 333.937608]=A0 </IRQ>
> [=A0 333.937610] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [=A0 333.937611] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44=
 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <=
45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [=A0 333.937612] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [=A0 333.937613] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [=A0 333.937613] RDX: 0000004dc03adbda RSI: 0000000031573862 RDI:
> 0000000000000000
> [=A0 333.937614] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [=A0 333.937615] R10: 011c65a5c18bd252 R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [=A0 333.937615] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [=A0 333.937617]=A0 cpuidle_enter+0x2e/0x40
> [=A0 333.937619]=A0 call_cpuidle+0x23/0x40
> [=A0 333.937620]=A0 do_idle+0x230/0x270
> [=A0 333.937621]=A0 cpu_startup_entry+0x1d/0x20
> [=A0 333.937623]=A0 start_secondary+0x170/0x1c0
> [=A0 333.937624]=A0 secondary_startup_64+0xb6/0xc0
> [=A0 364.114200] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [=A0 364.114241] nvme nvme0: Abort status: 0x0
> [=A0 369.745713] INFO: task kworker/u114:2:1182 blocked for more than 122
> seconds.
> [=A0 369.745758]=A0=A0=A0=A0=A0=A0 Not tainted 5.7.0-rc7+ #2
> [=A0 369.745787] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les
> this message.
> [=A0 369.745808] kworker/u114:2=A0 D=A0=A0=A0 0=A0 1182=A0=A0=A0=A0=A0 2 =
0x80004000
> [=A0 369.745817] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [=A0 369.745818] Call Trace:
> [=A0 369.745823]=A0 __schedule+0x2dc/0x710
> [=A0 369.745828]=A0 ? __kfifo_to_user_r+0x90/0x90
> [=A0 369.745829]=A0 schedule+0x44/0xb0
> [=A0 369.745831]=A0 blk_mq_freeze_queue_wait+0x4b/0xb0
> [=A0 369.745833]=A0 ? finish_wait+0x80/0x80
> [=A0 369.745834]=A0 blk_mq_freeze_queue+0x1a/0x20
> [=A0 369.745837]=A0 nvme_update_disk_info+0x62/0x3b0 [nvme_core]
> [=A0 369.745839]=A0 __nvme_revalidate_disk+0x8d/0x140 [nvme_core]
> [=A0 369.745842]=A0 nvme_revalidate_disk+0xa4/0x140 [nvme_core]
> [=A0 369.745843]=A0 ? blk_mq_run_hw_queue+0xba/0x100
> [=A0 369.745847]=A0 revalidate_disk+0x2b/0xa0
> [=A0 369.745850]=A0 nvme_validate_ns+0x46/0x5b0 [nvme_core]
> [=A0 369.745852]=A0 ? __nvme_submit_sync_cmd+0xe0/0x1b0 [nvme_core]
> [=A0 369.745855]=A0 nvme_scan_work+0x25a/0x310 [nvme_core]
> [=A0 369.745859]=A0 process_one_work+0x1ab/0x380
> [=A0 369.745861]=A0 worker_thread+0x37/0x3b0
> [=A0 369.745862]=A0 kthread+0x120/0x140
> [=A0 369.745863]=A0 ? create_worker+0x1b0/0x1b0
> [=A0 369.745864]=A0 ? kthread_park+0x90/0x90
> [=A0 369.745867]=A0 ret_from_fork+0x35/0x40

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
