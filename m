Return-Path: <SRS0=3azT=MH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961EC07E96
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:19:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD5B613C0
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jul 2021 14:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD5B613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9JIfbDos1wFCzpLtrK7rGH9u0BS2se3lkgqLmKnihl0=; b=jiSJ9gU2DAOCMQ
	NpDDIzIHuT4mIyPanJrTBjJbl/v7YDzrb9v+5t/+E64R9ngw0Pg88PBOS1R1WlWlx86o/YIFwmr17
	0A/Q4iaN6/AHTUmH27DfgeP7kXTxYXFSPI0gczYNcH9vYJKk+nTBnXqG7X8DzXpMn/a4e14CCX9Z2
	QxymgSLANuKnPhg1DdyGI9NetIjzOKVP3HOBkmDeY07WEHm9JmKfImNTDcbwmXOlapqf7mSy+S0OF
	QNGBA5zm+TmT/0vIhVLQdYChvuJU4gNvHT8iv6cY6OYJwYr+E/IUp56ft44lD9LKZTtHIsYlz8H7P
	ogKPeQTfQZ3Bk9zXfCYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m42DB-0014IT-Nj; Thu, 15 Jul 2021 14:19:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m42D7-0014HL-UE
 for linux-nvme@lists.infradead.org; Thu, 15 Jul 2021 14:19:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BA4D61370;
 Thu, 15 Jul 2021 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626358773;
 bh=a0J70/HOHFNk5XJ2Dy4ddWW6m0q4N6CyahH7sxelevQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RbwEEVyKryiEi3vTI0ccnLutqb8YCL+OujCrqLy/NLZ0RRQc7llKSfu747Ypv7T6S
 8oEaryVElgloK/zvkN1wc7v8Boupb9M9Sop5SatbcZY+04XOGOanNim09jB5gXA/U+
 gtISrX9mruG99ZOkSKPTeco/zgLCnQTcV0GtFivQ=
Date: Thu, 15 Jul 2021 16:19:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YPBD8z+yqC0ShjrZ@kroah.com>
References: <4729812.CpyZKHjjVO@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4729812.CpyZKHjjVO@natalenko.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_071934_052402_97F01922 
X-CRM114-Status: GOOD (  18.12  )
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

On Thu, Jul 15, 2021 at 03:56:38PM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> After a v5.13.2 massive update I encountered this:
> 
> ```
> [19231.556665] ------------[ cut here ]------------
> [19231.556674] WARNING: CPU: 20 PID: 502 at drivers/nvme/host/core.c:850 
> nvme_setup_discard+0x188/0x1f0
> ...
> [19231.556776] CPU: 20 PID: 502 Comm: kworker/20:1H Not tainted 5.13.2 #1
> [19231.556780] Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 
> 3601 05/26/2021
> [19231.556784] Workqueue: kblockd blk_mq_run_work_fn
> [19231.556789] RIP: 0010:nvme_setup_discard+0x188/0x1f0
> [19231.556794] Code: 49 8b 44 24 10 4c 8b 90 40 0b 00 00 4c 2b 15 8f 09 d8 00 
> 49 c1 fa 06 49 c1 e2 0c 4c 03 15 90 09 d8 00 4d 89 d0 e9 b9 fe ff ff <0f> 0b b8 
> 00 00 00 80 49 01 c2 72 52 48 c7 c0 00 00 00 80 48 2b 05
> [19231.556798] RSP: 0018:ffffaed2416efc00 EFLAGS: 00010287
> [19231.556802] RAX: ffff8e67fb580000 RBX: ffff8e640bbe5240 RCX: 0000000000000020
> [19231.556805] RDX: ffff8e67fb580000 RSI: 000000000000001f RDI: 0000000000000000
> [19231.556808] RBP: ffff8e640bbe5388 R08: ffff8e677b580000 R09: 0000000008abb800
> [19231.556811] R10: ffff8e677b580000 R11: 0000000000000400 R12: ffff8e6405999c00
> [19231.556814] R13: 000000000000001f R14: ffff8e6405693000 R15: ffff8e640bbaf800
> [19231.556816] FS:  0000000000000000(0000) GS:ffff8e6b0ef00000(0000) knlGS:
> 0000000000000000
> [19231.556819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19231.556822] CR2: ffff888c76ece000 CR3: 000000047a184000 CR4: 0000000000350ee0
> [19231.556825] Call Trace:
> [19231.556830]  nvme_setup_cmd+0x2d0/0x670
> [19231.556834]  nvme_queue_rq+0x79/0xc90
> [19231.556837]  ? __sbitmap_get_word+0x30/0x80
> [19231.556842]  ? sbitmap_get+0x85/0x180
> [19231.556846]  blk_mq_dispatch_rq_list+0x15c/0x810
> [19231.556851]  ? list_sort+0x21d/0x2f0
> [19231.556856]  __blk_mq_do_dispatch_sched+0x196/0x320
> [19231.556860]  __blk_mq_sched_dispatch_requests+0x14d/0x190
> [19231.556864]  blk_mq_sched_dispatch_requests+0x2f/0x60
> [19231.556867]  blk_mq_run_work_fn+0x43/0xc0
> [19231.556871]  process_one_work+0x24e/0x430
> [19231.556876]  worker_thread+0x54/0x4d0
> [19231.556880]  ? process_one_work+0x430/0x430
> [19231.556883]  kthread+0x1b3/0x1e0
> [19231.556886]  ? __kthread_init_worker+0x50/0x50
> [19231.556889]  ret_from_fork+0x22/0x30
> [19231.556895] ---[ end trace d9abdf019a56b4c7 ]---
> [19231.556906] blk_update_request: I/O error, dev nvme1n1, sector 632935424 op 
> 0x3:(DISCARD) flags 0x0 phys_seg 31 prio class 0
> ```
> 
> or, in code:
> 
> ```
>  850     if (WARN_ON_ONCE(n != segments)) {
>  851         if (virt_to_page(range) == ns->ctrl->discard_page)
>  852             clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
>  853         else
>  854             kfree(range);
>  855         return BLK_STS_IOERR;
>  856     }
> ```
> 
> BFQ scheduler is in use.
> 
> Something similar was already fixed by a958937ff166fc60d1c3a721036f6ff41bfa2821, 
> but I do not have a multipath device here, it's just 2 NVMe SSDs in a soft 
> RAID10 with LUKS and LVM.
> 
> Any idea what this might mean? v5.13.2 brought some commit into a stable tree 
> that are, as I still suspect, causing unreproducible panics [1] [2]. 
> Previously, I dropped that extra stuff from my kernel build and had no issues. 
> This time I also do not have any extra commits in the block layer, only those 
> that are in v5.13.2.
> 
> Thanks.
> 
> [1] https://lore.kernel.org/linux-block/3533087.dJKXTdksHR@spock/
> [2] https://lore.kernel.org/linux-block/2957867.CS06ZTPI5V@spock/

Can you run 'git bisect' to find the offending patch?

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
