Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB0AE9B363
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJ8g+tfHdQ5ZA2CQHW3et6rxZVLqDb8QFtHsqVR0mW0=; b=OmAVGyFgcZGv0AtWcCQ7Yz7HpL
	2Ik2FFszdD1yCew7qhciEfdXwdqmzKlNhM1nzsNT/OYnkgUlp6rBmsYLm23tcMOizbDqxNYep5aRz
	AbbdZVTNR1IZRhcf9C78L2NeZOBUOPznIbOtAZhlqBSzZ6Sl8NAZXQihxSHdIS6tyUzsTXeTN40Rk
	e8HZWFZUjOSyEkR10ERQuRMy6Kc7Tk0NrXTcT8ew8LRo0R7rIRL4kJ0GC+rJSPjxxf3AOTHqguGaF
	KPlybl32MAgO3f089J5pBpAwEaYgQgB8T3/vdVzaI+H8j91M6uwiCmxtqzQlJV25FKABjRYBhPNWt
	83qBLQlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx0rb-0000000CkSZ-0C4f;
	Mon, 02 Mar 2026 10:50:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx0rZ-0000000CkS6-2UUJ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 10:50:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A2E6960008;
	Mon,  2 Mar 2026 10:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63631C19423;
	Mon,  2 Mar 2026 10:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772448655;
	bh=ooCwVMtMeof9eUg55NNUtPSMrUI5IYvsBBfPpUNmiu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHKvAGlV1PYQM4oFzHWWPRF/Yv3lsn7pHbcI4wEPesGHyt//zusRP7n9wglL7LoOI
	 ZhCK58mOpx9cjjpITbEgzKyqV8Ml0pgYDx3WyVQrsAPALthSB4y74AGT934IURginD
	 S7LDUJ/n1/2o2lmF2Tg4568RN/JKwd+ULiEM0XODU4Xm0DNwN1w3/iQQlPMhM/XO8q
	 9KzuIHHM1A9UUjdjpOWQ/NtY8TfKfyVjVycIgth2dFNViaI0QB3GPKr1jibnDZHDbJ
	 uJuryc73Di6wnU+FHiy9nsYte5yb3BVgKohfue+dztdcVYxfNPAZlOKIrXGrEIlveJ
	 xGjmTzNbjr2FA==
Date: Mon, 2 Mar 2026 12:50:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
Message-ID: <20260302105051.GP12611@unreal>
References: <aZ_-cH8euZLySxdD@shinmob>
 <4c7aea9f-ae97-43c8-8b08-905696303978@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7aea9f-ae97-43c8-8b08-905696303978@nvidia.com>
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

On Thu, Feb 26, 2026 at 03:00:40PM +0000, Chaitanya Kulkarni wrote:
> On 2/26/26 12:09 AM, Shinichiro Kawasaki wrote:
> > Failure description
> > ===================
> >
> > #1: blktrace/002
> >
> >      The test case blktrace/002 failed due to "BUG: using __this_cpu_read() in
> >      preemptible" and a following WARN [2].
> 
> I saw this last night it was pretty late, just glad to see simple 
> testcase catching bugs.
> 
> I've a patch for this I'll send out shortly :-
> 
> 
> From 6a285db1bbdbb613a85ac55a395ed2043d4eb11d Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <kch@nvidia.com>
> Date: Wed, 25 Feb 2026 23:01:12 -0800
> Subject: [PATCH] blktrace: fix __this_cpu_read/write in preemptible context
> 
> 
> 
> blktrace/002 (blktrace ftrace corruption with sysfs trace)  [failed]
>      runtime  0.367s  ...  0.437s
>      something found in dmesg:
>      [   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
>      [   81.239580] null_blk: disk nullb1 created
>      [   81.357294] BUG: using __this_cpu_read() in preemptible 
> [00000000] code: dd/2516
>      [   81.362842] caller is tracing_record_cmdline+0x10/0x40
>      [   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G         
>         N  7.0.0-rc1lblk+ #84 PREEMPT(full)
>      [   81.362877] Tainted: [N]=TEST
>      [   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 
> 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>      [   81.362881] Call Trace:
>      [   81.362884]  <TASK>
>      [   81.362886]  dump_stack_lvl+0x8d/0xb0
>      ...
>      (See '/mnt/sda/blktests/results/nodev/blktrace/002.dmesg' for the 
> entire message)
> 
> [   81.211018] run blktests blktrace/002 at 2026-02-25 22:24:33
> [   81.239580] null_blk: disk nullb1 created
> [   81.357294] BUG: using __this_cpu_read() in preemptible [00000000] 
> code: dd/2516
> [   81.362842] caller is tracing_record_cmdline+0x10/0x40
> [   81.362872] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G           
>   N  7.0.0-rc1lblk+ #84 PREEMPT(full)
> [   81.362877] Tainted: [N]=TEST
> [   81.362878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   81.362881] Call Trace:
> [   81.362884]  <TASK>
> [   81.362886]  dump_stack_lvl+0x8d/0xb0
> [   81.362895]  check_preemption_disabled+0xce/0xe0
> [   81.362902]  tracing_record_cmdline+0x10/0x40
> [   81.362923]  __blk_add_trace+0x307/0x5d0
> [   81.362934]  ? lock_acquire+0xe0/0x300
> [   81.362940]  ? iov_iter_extract_pages+0x101/0xa30
> [   81.362959]  blk_add_trace_bio+0x106/0x1e0
> [   81.362968]  submit_bio_noacct_nocheck+0x24b/0x3a0
> [   81.362979]  ? lockdep_init_map_type+0x58/0x260
> [   81.362988]  submit_bio_wait+0x56/0x90
> [   81.363009]  __blkdev_direct_IO_simple+0x16c/0x250
> [   81.363026]  ? __pfx_submit_bio_wait_endio+0x10/0x10
> [   81.363038]  ? rcu_read_lock_any_held+0x73/0xa0
> [   81.363051]  blkdev_read_iter+0xc1/0x140
> [   81.363059]  vfs_read+0x20b/0x330
> [   81.363083]  ksys_read+0x67/0xe0
> [   81.363090]  do_syscall_64+0xbf/0xf00
> [   81.363102]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   81.363106] RIP: 0033:0x7f281906029d
> [   81.363111] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 63 0a 00 e8 59 
> ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 33 0e 00 00 74 17 31 c0 0f 
> 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> [   81.363113] RSP: 002b:00007ffca127dd48 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000000
> [   81.363120] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
> 00007f281906029d
> [   81.363122] RDX: 0000000000001000 RSI: 0000559f8bfae000 RDI: 
> 0000000000000000
> [   81.363123] RBP: 0000000000001000 R08: 0000002863a10a81 R09: 
> 00007f281915f000
> [   81.363124] R10: 00007f2818f77b60 R11: 0000000000000246 R12: 
> 0000559f8bfae000
> [   81.363126] R13: 0000000000000000 R14: 0000000000000000 R15: 
> 000000000000000a
> [   81.363142]  </TASK>
> [   81.363157] BUG: using __this_cpu_read() in preemptible [00000000] 
> code: dd/2516
> [   81.368486] caller is tracing_record_cmdline+0x10/0x40
> [   81.368496] CPU: 16 UID: 0 PID: 2516 Comm: dd Tainted: G           
>   N  7.0.0-rc1lblk+ #84 PREEMPT(full)
> [   81.368501] Tainted: [N]=TEST
> [   81.368502] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
> BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   81.368503] Call Trace:
> [   81.368505]  <TASK>
> [   81.368507]  dump_stack_lvl+0x8d/0xb0
> [   81.368513]  check_preemption_disabled+0xce/0xe0
> [   81.368518]  tracing_record_cmdline+0x10/0x40
> [   81.368523]  __blk_add_trace+0x307/0x5d0
> [   81.368528]  ? lock_acquire+0xe0/0x300
> [   81.368547]  blk_add_trace_bio+0x106/0x1e0
> [   81.368556]  blk_mq_submit_bio+0x63c/0xbb0
> [   81.368580]  __submit_bio+0xad/0x5c0
> [   81.368595]  ? submit_bio_noacct_nocheck+0x2b0/0x3a0
> [   81.368600]  submit_bio_noacct_nocheck+0x2b0/0x3a0
> [   81.368611]  submit_bio_wait+0x56/0x90
> [   81.368622]  __blkdev_direct_IO_simple+0x16c/0x250
> [   81.368635]  ? __pfx_submit_bio_wait_endio+0x10/0x10
> [   81.368656]  ? rcu_read_lock_any_held+0x73/0xa0
> [   81.368664]  blkdev_read_iter+0xc1/0x140
> [   81.368672]  vfs_read+0x20b/0x330
> [   81.368687]  ksys_read+0x67/0xe0
> [   81.368694]  do_syscall_64+0xbf/0xf00
> [   81.368702]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   81.368705] RIP: 0033:0x7f281906029d
> [   81.368708] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 63 0a 00 e8 59 
> ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 33 0e 00 00 74 17 31 c0 0f 
> 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
> [   81.368710] RSP: 002b:00007ffca127dd48 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000000
> [   81.368712] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
> 00007f281906029d
> [   81.368713] RDX: 0000000000001000 RSI: 0000559f8bfae000 RDI: 
> 0000000000000000
> [   81.368714] RBP: 0000000000001000 R08: 0000002863a10a81 R09: 
> 00007f281915f000
> [   81.368716] R10: 00007f2818f77b60 R11: 0000000000000246 R12: 
> 0000559f8bfae000
> [   81.368717] R13: 0000000000000000 R14: 0000000000000000 R15: 
> 000000000000000a
> [   81.368734]  </TASK>
> 
> The same BUG fires from blk_add_trace_plug(), blk_add_trace_unplug(),
> and blk_add_trace_rq() paths as well.
> 
> Fix by wrapping the tracing_record_cmdline() call with
> preempt_disable()/preempt_enable().  This is a best-effort "record
> the comm string for this PID" operation and briefly disabling
> preemption around it is both safe and correct.
> 
> With this patch now blktests for blktrace pass :-
> 
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing) [passed]
>      runtime  3.652s  ...  3.649s
> blktrace/002 (blktrace ftrace corruption with sysfs trace)  [passed]
>      runtime  0.437s  ...  0.389s
> blktests (master) #
> 
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   kernel/trace/blktrace.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 3b7c102a6eb3..488552036583 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -383,7 +383,9 @@ static void __blk_add_trace(struct blk_trace *bt, 
> sector_t sector, int bytes,
>       cpu = raw_smp_processor_id();
> 
>       if (blk_tracer) {
> +        preempt_disable_notrace();
>           tracing_record_cmdline(current);
> +        preempt_enable_notrace();

These lines likely belong in tracing_record_cmdline().

Thanks

> 
>           buffer = blk_tr->array_buffer.buffer;
>           trace_ctx = tracing_gen_ctx_flags(0);
> -- 
> 2.39.5
> 
> 

