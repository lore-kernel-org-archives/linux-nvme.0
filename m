Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57EDC5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fVQl6eVjqWOQckPl4rm3y5OktooK3CT9hSogUpnaOfA=; b=nnWn4JPLqdErXKIEu2lbDsKIDh
	Ai1HH62+0fvuwm+Gjw12hYxBqzTygjofctqkPcQWB5HUURQOpJuD60P0aCtBJSY+y+Vvb8w4VonrF
	RCjWPYodhqNjiWos0Qc4J34GKt7T/HvKV4PQ9XXbLoJRr3ufaAX2S/gOlai0QJFzHrDmyYj67cAm1
	5QpNvwZANCI3KLj9y1U1ex200N2AkBOXOu639bySnwur5hz/BiMaZdKBLCQXLqRfq3vE4wBhS3E87
	ZmmDw0xkVF2HfSyGXO00/NlUicK8oBdonGVbdo8MEtxCjPCdoGzcmdIQROLyQgoGrWDgnoDWHms4g
	aZWAdZwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reuOq-00000004ewq-0OQM;
	Tue, 27 Feb 2024 10:09:24 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reuOm-00000004evP-0MZz
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 10:09:22 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86601210F7;
	Tue, 27 Feb 2024 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709028558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVQl6eVjqWOQckPl4rm3y5OktooK3CT9hSogUpnaOfA=;
	b=N0X4Re/9ExWPsv6jXcYeG8vFuOjpi2CkId9/Yw94c8jtlxE2zVBGpm/3Fqo3iU9YN3ucOA
	GKg811grbwU7Ao7OKD8n4rxhM+joEEHlMqjVyJ8ebpAokJtW86K6Fb+TkXWAFnCZfO8BfL
	kuMLjn9AL7VufDQFTmgYgM8V0h8FJKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709028558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVQl6eVjqWOQckPl4rm3y5OktooK3CT9hSogUpnaOfA=;
	b=TzU0huypl2jgQyqCin/SIYIC0PWDAke+no/Y49R8zqtIbIU6sUn9njzX/bjmrkfOJIXgdN
	X19vKOR4ugn3jzDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709028558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVQl6eVjqWOQckPl4rm3y5OktooK3CT9hSogUpnaOfA=;
	b=N0X4Re/9ExWPsv6jXcYeG8vFuOjpi2CkId9/Yw94c8jtlxE2zVBGpm/3Fqo3iU9YN3ucOA
	GKg811grbwU7Ao7OKD8n4rxhM+joEEHlMqjVyJ8ebpAokJtW86K6Fb+TkXWAFnCZfO8BfL
	kuMLjn9AL7VufDQFTmgYgM8V0h8FJKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709028558;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVQl6eVjqWOQckPl4rm3y5OktooK3CT9hSogUpnaOfA=;
	b=TzU0huypl2jgQyqCin/SIYIC0PWDAke+no/Y49R8zqtIbIU6sUn9njzX/bjmrkfOJIXgdN
	X19vKOR4ugn3jzDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E5E913216;
	Tue, 27 Feb 2024 10:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qqnkGc603WWeOwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 27 Feb 2024 10:09:18 +0000
Date: Tue, 27 Feb 2024 11:09:17 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3] nvme: authentication error are always non-retryable
Message-ID: <pcuy5bumakpkx6277pg2kkr7xamqfarhtexwiuyjcaovlzbpyu@gwizbsksfs6s>
References: <20240226143013.39119-1-hare@kernel.org>
 <qdv47uxmz4n5vvsxyzh56iexjlznnvovilp2tvhwiqfvqcblqw@43x77wt3yxgq>
 <c5513762-1759-4cd3-8933-7d77fdf4d2ba@suse.de>
 <pk2oeie4d5blevrkljm6fro5fvuiqtlwvm4ldingh2bmgutxoh@5dshhbsxoy7i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pk2oeie4d5blevrkljm6fro5fvuiqtlwvm4ldingh2bmgutxoh@5dshhbsxoy7i>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_020920_309826_90F235A5 
X-CRM114-Status: GOOD (  16.12  )
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

On Tue, Feb 27, 2024 at 09:51:17AM +0100, Daniel Wagner wrote:
> On Tue, Feb 27, 2024 at 08:54:32AM +0100, Hannes Reinecke wrote:
> > Ouch.
> > 
> > Does this help?
> 
> Yes, this helps. I am running the whole test suite for all transport a
> few times just a few times now. Just to make sure.

- rmda nvme/031

[ 2454.989813] kworker/0:35/22379 is trying to acquire lock:
[ 2454.989813] ffff88810a68dd48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: __flush_work+0x72/0x7d0
[ 2454.989813]
               but task is already holding lock:
[ 2454.989813] ffff88810a68dd48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_scheduled_works+0x6d4/0xf80
[ 2455.001905]
               other info that might help us debug this:
[ 2455.001905]  Possible unsafe locking scenario:

[ 2455.005799]        CPU0
[ 2455.005799]        ----
[ 2455.005799]   lock((wq_completion)nvmet-wq);
[ 2455.005799]   lock((wq_completion)nvmet-wq);
[ 2455.005799]
                *** DEADLOCK ***

[ 2455.005799]  May be due to missing lock nesting notation

[ 2455.005799] 3 locks held by kworker/0:35/22379:
[ 2455.005799]  #0: ffff88810a68dd48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_scheduled_works+0x6d4/0xf80
[ 2455.005799]  #1: ffff88812e997d68 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_scheduled_works+0x6d4/0xf80
[ 2455.021848]  #2: ffffffff920c60c0 (rcu_read_lock){....}-{1:2}, at: __flush_work+0x72/0x7d0
[ 2455.021848]
               stack backtrace:
[ 2455.021848] CPU: 0 PID: 22379 Comm: kworker/0:35 Tainted: G        W          6.8.0-rc3+ #39 3d0b6128d1ea3c6026a2c1de70ba6c7dc10623c3
[ 2455.021848] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[ 2455.021848] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
[ 2455.021848] Call Trace:
[ 2455.021848]  <TASK>
[ 2455.021848]  dump_stack_lvl+0x5b/0x80
[ 2455.021848]  __lock_acquire+0x65f2/0x7b00
[ 2455.021848]  ? lock_release+0x25c/0xcd0
[ 2455.021848]  lock_acquire+0x11c/0x3d0
[ 2455.021848]  ? __flush_work+0x72/0x7d0
[ 2455.021848]  ? lockdep_hardirqs_on_prepare+0x2b0/0x5f0
[ 2455.021848]  ? __flush_work+0x72/0x7d0
[ 2455.021848]  __flush_work+0x648/0x7d0
[ 2455.021848]  ? __flush_work+0x72/0x7d0
[ 2455.021848]  ? __flush_work+0x72/0x7d0
[ 2455.021848]  ? __cfi_wq_barrier_func+0x10/0x10
[ 2455.021848]  nvmet_ctrl_put+0x3b2/0x640 [nvmet 06f982ecc8920c7359ba51cc41092b5d91a725d5]
[ 2455.021848]  nvmet_sq_destroy+0x2e7/0x350 [nvmet 06f982ecc8920c7359ba51cc41092b5d91a725d5]
[ 2455.021848]  nvmet_rdma_free_queue+0x35/0x590 [nvmet_rdma d9fba27fd955e2c2575b3e184853a6daafaffc5c]
[ 2455.021848]  ? do_raw_spin_unlock+0x116/0x890
[ 2455.021848]  ? process_scheduled_works+0x6d4/0xf80
[ 2455.021848]  nvmet_rdma_release_queue_work+0x43/0xa0 [nvmet_rdma d9fba27fd955e2c2575b3e184853a6daafaffc5c]
[ 2455.021848]  process_scheduled_works+0x774/0xf80
[ 2455.060121]  worker_thread+0x8c4/0xfc0
[ 2455.061903]  ? __kthread_parkme+0x84/0x120
[ 2455.063471]  kthread+0x25d/0x2e0
[ 2455.065681]  ? __cfi_worker_thread+0x10/0x10
[ 2455.065681]  ? __cfi_kthread+0x10/0x10
[ 2455.065681]  ret_from_fork+0x41/0x70
[ 2455.065681]  ? __cfi_kthread+0x10/0x10
[ 2455.065681]  ret_from_fork_asm+0x1b/0x30
[ 2455.065681]  </TASK>
[ 2455.096534] nvmet: adding nsid 1 to subsystem blktests-subsystem-5

This looks familiar. I thought we have addressed it. Maybe I missing the
fix since this is on 6.8-rc3


- loop nvme/045

nvme/045 (Test re-authentication)                            [failed]
    runtime  3.187s  ...  1.344s
    --- tests/nvme/045.out      2023-11-28 12:59:52.711505550 +0100
    +++ /home/wagi/work/blktests/results/nodev/nvme/045.out.bad 2024-02-27 10:20:02.792666798 +0100
    @@ -8,5 +8,5 @@
     Re-authenticate with changed DH group
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
    -disconnected 1 controller(s)
    +disconnected 0 controller(s)

This is not easy to trigger by itself. That means just executing
nvme/045 in a loop does not trigger it, instead it only appears when
running the whole test suite. Anyway, this could just be another
instance of userspace racing with the cleanup code in the kernel.

