Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 23:14:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B68364FF9
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 23:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B68364FF9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y/kKDN3QA/EAu0NIbDb/4w9ZExSSWZIo1d/9eOy/ayU=; b=SvmNfBn/qMxiwLW93i/6kBv8u
	/7CZkPScb70C9Ys2duEuYToHiNrhFjLHREqaypgkZS2sIvL1GFpLJAWder0bbUG1ndX6gKy3t3KFi
	92KcV8Zkc95EpUtuuG3+TAJhKjXJx+vM4ZHM9BWPAZVSJ5g6Ul7WTU8B+qx0nSd2zeLmnKTDl8XNE
	HFEEp9RqytuEr0pzBmlDhhD0UsZ6Zlntw0YzuavSRwEleBbkXG5nRYVpyBQAdpSBfoAYQZ4g6Pqoc
	btR0xy09e2SuDd+fTVXg0U478CwRsJ0dh3f5PB1XnWwmw31kdiVZTjcpV/5AMDz7nz8lNOmZD7HNf
	c/PFkroCA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHxAh-00Ag2s-2v; Thu, 04 Mar 2021 23:14:19 +0000
Received: from mail110.syd.optusnet.com.au ([211.29.132.97])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lHxAU-00Ag1a-2B
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 23:14:09 +0000
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au
 [49.179.130.210])
 by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 3F09F105BD3;
 Fri,  5 Mar 2021 10:14:00 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1lHxAN-00FDz4-8o; Fri, 05 Mar 2021 10:13:59 +1100
Date: Fri, 5 Mar 2021 10:13:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Problem With XFS + KVM
Message-ID: <20210304231359.GT4662@dread.disaster.area>
References: <BYAPR04MB4965AAAB580D73E3B03E7E7886979@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965AAAB580D73E3B03E7E7886979@BYAPR04MB4965.namprd04.prod.outlook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
 a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
 a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=2J7IuT7wAAAA:8 a=ID6ng7r3AAAA:8
 a=7-415B0cAAAA:8 a=r7zCAvGXysCvWua5TsEA:9 a=CjuIK1q_8ugA:10
 a=RtgRkGnnZwJf8nmJIBi8:22 a=AkheI1RvQwOzcTXhi5f4:22
 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210304_231407_352081_CBAB88D0 
X-CRM114-Status: GOOD (  19.11  )
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

On Thu, Mar 04, 2021 at 10:34:29PM +0000, Chaitanya Kulkarni wrote:
> Hi,
> 
> I'm running fio verification job with XFS formatted file system on 5.12-rc1
> with NVMeOF file backend target inside QEMU test machine.
> 
> I'm getting a following message intermittently it is happening since
> yesterday.
> This can be easily reproduces with runing block tests nvme/011 :-
> 
> nvme/011 (run data verification fio job on NVMeOF file-backed ns) [failed]
>     runtime  270.553s  ...  268.552s
>     something found in dmesg:
>     [  340.781752] run blktests nvme/011 at 2021-03-04 14:22:34
>     [  340.857161] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>     [  340.890225] nvmet: creating controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:e4cfc949-8f19-4db2-a232-ab360b79204a.
>     [  340.892477] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for
> full support of multi-port devices.
>     [  340.892937] nvme nvme0: creating 64 I/O queues.
>     [  340.913759] nvme nvme0: new ctrl: "blktests-subsystem-1"
>     [  586.495375] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
>     [  587.766464] ------------[ cut here ]------------
>     [  587.766535] raw_local_irq_restore() called with IRQs enabled
>     [  587.766561] WARNING: CPU: 14 PID: 12543 at
> kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20
>     ...
>     (See '/root/blktests/results/nodev/nvme/011.dmesg' for the entire
> message)
> 
> Please let me know what kind of more details I can provide to resolve
> this issue.
> 
> Here is the dmesg outout :-
> 
>  ------------[ cut here ]------------
> [  587.766535] raw_local_irq_restore() called with IRQs enabled
.....
> [  587.766819] CPU: 14 PID: 12543 Comm: rm Not tainted 5.12.0-rc1nvme+ #165
> [  587.766823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [  587.766826] RIP: 0010:warn_bogus_irq_restore+0x1d/0x20
> [  587.766831] Code: 24 48 c7 c7 e0 f2 0f 82 e8 80 c3 fb ff 80 3d 15 1c
> 09 01 00 74 01 c3 48 c7 c7 70 6c 10 82 c6 05 04 1c 09 01 01 e8 cc c2 fb
> ff <0f> 0b c3 55 53 44 8b 05 63 b4 0c 01 65 48 8b 1c 25 40 7e 01 00 45
> [  587.766835] RSP: 0018:ffffc900086cf990 EFLAGS: 00010286
> [  587.766840] RAX: 0000000000000000 RBX: 0000000000000003 RCX:
> 0000000000000027
> [  587.766843] RDX: 0000000000000000 RSI: ffff8897d37e8a30 RDI:
> ffff8897d37e8a38
> [  587.766846] RBP: ffff888138764888 R08: 0000000000000001 R09:
> 0000000000000001
> [  587.766848] R10: 000000009f0f619c R11: 00000000b7972d21 R12:
> 0000000000000200
> [  587.766851] R13: 0000000000000001 R14: 0000000000000100 R15:
> 00000000003c0000
> [  587.766855] FS:  00007f6992aec740(0000) GS:ffff8897d3600000(0000)
> knlGS:0000000000000000
> [  587.766858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  587.766860] CR2: 0000000000bcf1c8 CR3: 00000017d29e8000 CR4:
> 00000000003506e0
> [  587.766864] Call Trace:
> [  587.766867]  kvm_wait+0x8c/0x90
> [  587.766876]  __pv_queued_spin_lock_slowpath+0x265/0x2a0
> [  587.766893]  do_raw_spin_lock+0xb1/0xc0
> [  587.766898]  _raw_spin_lock+0x61/0x70
> [  587.766904]  xfs_extent_busy_trim+0x2f/0x200 [xfs]

That looks like a KVM or local_irq_save()/local_irq_restore problem.
kvm_wait() does:

static void kvm_wait(u8 *ptr, u8 val)
{
        unsigned long flags;

        if (in_nmi())
                return;

        local_irq_save(flags);

        if (READ_ONCE(*ptr) != val)
                goto out;

        /*
         * halt until it's our turn and kicked. Note that we do safe halt
         * for irq enabled case to avoid hang when lock info is overwritten
         * in irq spinlock slowpath and no spurious interrupt occur to save us.
         */
        if (arch_irqs_disabled_flags(flags))
                halt();
        else
                safe_halt();

out:
        local_irq_restore(flags);
}

And the warning is coming from the local_irq_restore() call
indicating that interrupts are not disabled when they should be.
The interrupt state is being modified entirely within the kvm_wait()
code here, so none of the high level XFS code has any influence on
behaviour here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
