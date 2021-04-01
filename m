Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0707FC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 15:45:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801C961357
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 15:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801C961357
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oHWW0VYkOFO/QCfR8Yx+8xy0sEdjpt/AI1KRTcysfpc=; b=XboHYPjFRH6ITKuwnX7f3or0O
	N85tNK8R/ZCp5fP31lM6FLZ6I14Oi6MHzq/xN9OVtZ1ww48Om9S9A2YRQ8Ub8tCniwkfaGBRdnMgf
	5Kry+MoonYwt4kRJiTQGtMoyU5eezf8UsM+NO122EMQNc5fjX6ABRYo57CYyKwOFL4/GhQthJDtrk
	XtGFfkweh/7o55b2138F9PjJL+VcVvyNwQzdrkASy3iqt2V5mYyuVPViVmyvM2XOR5q1M4sismiwY
	ZEJCoze6EGDvCqZkOnMGWMu0BSQhNHiZQ++lP5wydyku0oN4mtM4Gnz8aVpGcutr4R9ZlfkOMIVdd
	q+VfJpufQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRzVm-00A4CU-JR; Thu, 01 Apr 2021 15:45:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzNx-00A2aM-V7
 for linux-nvme@desiato.infradead.org; Thu, 01 Apr 2021 15:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dixihDL6ibe+7m8OfDvLwmvcjHuMaT2gR6fH6rC17jA=; b=q4kWrv1pgW/bzW0Yj8XW8QOKCa
 LRKdU2DYj250qP6NJYAbx33HMF4ueDOpG/2vvzunmELifWmjnrmywpthUWACkXTJdSZLBooEhOqik
 bt9tTc/Xqjw/EjXx4azzuJs3Ws08+yCvWqls4hugWqgfMnMA3g+txCdd3MHYtBkYkyGA0h5GhIVKd
 G329hQe7JMxzCR/a1w0X162SqCMRYOFdh1aXwn82SDc3JMOnDpyOMK+CBVdIQOSE+c3YJDSq8IRTU
 Hjp7Cu+vokSIdSz954O7VyJ5nm8JOXqP1A7NMeKpKRfai9XQm8ESEmTPU4LbdipDh67ilpWcaJrI0
 DcPMIgzA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lRzNq-006InR-7e; Thu, 01 Apr 2021 15:37:23 +0000
Date: Thu, 1 Apr 2021 16:37:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Recursive locking complaint with nvme-5.13 branch
Message-ID: <20210401153722.GA1501960@infradead.org>
References: <f8288fe3-d8d2-5cfe-6aef-410bcd6e6231@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8288fe3-d8d2-5cfe-6aef-410bcd6e6231@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Wed, Mar 31, 2021 at 09:03:36PM -0700, Bart Van Assche wrote:
> Hi,
> 
> If I boot a VM with the nvme-5.13 branch (commit 24e238c92186
> ("nvme: warn of unhandled effects only once")) then the complaint
> shown below is reported. Is this a known issue?

This looks like someone is trying to open a nvme device as the backing
device for pktcdvd?  In that case this is a different bd_mutex.  But
I'm really curious why systemd would do that.

> 
> Thanks,
> 
> Bart.
> 
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.12.0-rc3-dbg+ #6 Not tainted
> --------------------------------------------
> systemd-udevd/299 is trying to acquire lock:
> ffff88811b1e80a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x85/0x350
> 
> but task is already holding lock:
> ffff8881134100a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x1a9/0x350
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&bdev->bd_mutex);
>   lock(&bdev->bd_mutex);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by systemd-udevd/299:
>  #0: ffff8881134100a0 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0x1a9/0x350
>  #1: ffffffffa10269c8 (pktcdvd_mutex){+.+.}-{3:3}, at: pkt_open+0x22/0x15a [pktcdvd]
>  #2: ffffffffa1025788 (&ctl_mutex#2){+.+.}-{3:3}, at: pkt_open+0x30/0x15a [pktcdvd]
> 
> stack backtrace:
> CPU: 6 PID: 299 Comm: systemd-udevd Not tainted 5.12.0-rc3-dbg+ #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack+0x9d/0xcf
>  print_deadlock_bug.cold+0x131/0x136
>  validate_chain+0x6d3/0xc70
>  ? check_prev_add+0x11d0/0x11d0
>  __lock_acquire+0x500/0x920
>  ? start_flush_work+0x375/0x510
>  ? __this_cpu_preempt_check+0x13/0x20
>  lock_acquire.part.0+0x117/0x210
>  ? blkdev_get_by_dev+0x85/0x350
>  ? rcu_read_unlock+0x50/0x50
>  ? __this_cpu_preempt_check+0x13/0x20
>  ? lock_is_held_type+0xdb/0x130
>  lock_acquire+0x9b/0x1a0
>  ? blkdev_get_by_dev+0x85/0x350
>  __mutex_lock+0x117/0xb60
>  ? blkdev_get_by_dev+0x85/0x350
>  ? blkdev_get_by_dev+0x85/0x350
>  ? mutex_lock_io_nested+0xa70/0xa70
>  ? __kasan_check_write+0x14/0x20
>  ? __mutex_unlock_slowpath+0xa7/0x290
>  ? __ww_mutex_check_kill+0x160/0x160
>  ? trace_hardirqs_on+0x2b/0x130
>  ? mutex_unlock+0x12/0x20
>  ? disk_block_events+0x92/0xc0
>  mutex_lock_nested+0x1b/0x20
>  blkdev_get_by_dev+0x85/0x350
>  ? __mutex_lock+0x49c/0xb60
>  pkt_open_dev+0x7f/0x370 [pktcdvd]
>  ? pkt_open_write+0x120/0x120 [pktcdvd]
>  ? __ww_mutex_check_kill+0x160/0x160
>  pkt_open+0xfd/0x15a [pktcdvd]
>  __blkdev_get+0xa3/0x450
>  blkdev_get_by_dev+0x1b4/0x350
>  ? __kasan_check_read+0x11/0x20
>  blkdev_open+0xa4/0x120
>  do_dentry_open+0x27d/0x690
>  ? blkdev_get_by_dev+0x350/0x350
>  vfs_open+0x58/0x60
>  do_open+0x316/0x4a0
>  path_openat+0x1b8/0x260
>  ? do_tmpfile+0x160/0x160
>  ? __this_cpu_preempt_check+0x13/0x20
>  do_filp_open+0x12d/0x240
>  ? may_open_dev+0x60/0x60
>  ? __kasan_check_read+0x11/0x20
>  ? do_raw_spin_unlock+0x98/0xf0
>  ? preempt_count_sub+0x18/0xc0
>  ? _raw_spin_unlock+0x2d/0x50
>  do_sys_openat2+0xe9/0x260
>  ? build_open_flags+0x2a0/0x2a0
>  __x64_sys_openat+0xd3/0x130
>  ? __ia32_sys_open+0x110/0x110
>  ? __secure_computing+0x74/0x140
>  ? syscall_trace_enter.constprop.0+0x71/0x230
>  do_syscall_64+0x32/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
