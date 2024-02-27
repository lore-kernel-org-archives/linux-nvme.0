Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC59CC5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54xFP8dR0olqcvPpYDpoBncHaRX0m6k6KfoTX+mHPYU=; b=WNHjYOfgw2e8L9iJjUwMEYDF9I
	gN1uRDdXQwoxgfdFHoTrTD/aTtyBmWXvz/kp1PpmMrpfurw3AMJQV8bRniVDs9/R9AhutvsYVSr7n
	guGzJYr6K3ClIRRumTBucwkF/l5Df8LQBnA8oasEPP8npVIU9Dwx64Cuwi6/AJvBp5jqeI7QYMZ2c
	+pPzLW12U2Yu6LrIS0YkFV+pg/Lb3xl3eSQD3187b2xGyOkYSqVmgTRBCRK9ANXFryT/KdjlCdb5U
	8bOSo6CkjIWMo1sKR7DvlVSRCyRnDFnT4/MTw/JhHFvqZL33r5LSche4SZLT5vS4SJWYSzQQDm03e
	25HIQ/ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revFm-00000004s3z-3xHi;
	Tue, 27 Feb 2024 11:04:06 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1revFj-00000004s3F-44eA
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 11:04:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75F541F454;
	Tue, 27 Feb 2024 11:04:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 630F813A58;
	Tue, 27 Feb 2024 11:04:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tRm3F6HB3WWvCgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 27 Feb 2024 11:04:01 +0000
Message-ID: <19dcfd6e-e5b3-4227-9f6f-312327699c22@suse.de>
Date: Tue, 27 Feb 2024 12:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: authentication error are always non-retryable
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240226143013.39119-1-hare@kernel.org>
 <qdv47uxmz4n5vvsxyzh56iexjlznnvovilp2tvhwiqfvqcblqw@43x77wt3yxgq>
 <c5513762-1759-4cd3-8933-7d77fdf4d2ba@suse.de>
 <pk2oeie4d5blevrkljm6fro5fvuiqtlwvm4ldingh2bmgutxoh@5dshhbsxoy7i>
 <pcuy5bumakpkx6277pg2kkr7xamqfarhtexwiuyjcaovlzbpyu@gwizbsksfs6s>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <pcuy5bumakpkx6277pg2kkr7xamqfarhtexwiuyjcaovlzbpyu@gwizbsksfs6s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 75F541F454
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_030404_341495_C21DEFD2 
X-CRM114-Status: GOOD (  15.09  )
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

On 2/27/24 11:09, Daniel Wagner wrote:
> On Tue, Feb 27, 2024 at 09:51:17AM +0100, Daniel Wagner wrote:
>> On Tue, Feb 27, 2024 at 08:54:32AM +0100, Hannes Reinecke wrote:
>>> Ouch.
>>>
>>> Does this help?
>>
>> Yes, this helps. I am running the whole test suite for all transport a
>> few times just a few times now. Just to make sure.
> 
> - rmda nvme/031
> 
> [ 2454.989813] kworker/0:35/22379 is trying to acquire lock:
> [ 2454.989813] ffff88810a68dd48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: __flush_work+0x72/0x7d0
> [ 2454.989813]
>                 but task is already holding lock:
> [ 2454.989813] ffff88810a68dd48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_scheduled_works+0x6d4/0xf80
> [ 2455.001905]
>                 other info that might help us debug this:
> [ 2455.001905]  Possible unsafe locking scenario:
> 
> [ 2455.005799]        CPU0
> [ 2455.005799]        ----
> [ 2455.005799]   lock((wq_completion)nvmet-wq);
> [ 2455.005799]   lock((wq_completion)nvmet-wq);
> [ 2455.005799]
>                  *** DEADLOCK ***
> 
> [ 2455.005799]  May be due to missing lock nesting notation
> 
> [ 2455.005799] 3 locks held by kworker/0:35/22379:
> [ 2455.005799]  #0: ffff88810a68dd48 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_scheduled_works+0x6d4/0xf80
> [ 2455.005799]  #1: ffff88812e997d68 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_scheduled_works+0x6d4/0xf80
> [ 2455.021848]  #2: ffffffff920c60c0 (rcu_read_lock){....}-{1:2}, at: __flush_work+0x72/0x7d0
> [ 2455.021848]
>                 stack backtrace:
> [ 2455.021848] CPU: 0 PID: 22379 Comm: kworker/0:35 Tainted: G        W          6.8.0-rc3+ #39 3d0b6128d1ea3c6026a2c1de70ba6c7dc10623c3
> [ 2455.021848] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> [ 2455.021848] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
> [ 2455.021848] Call Trace:
> [ 2455.021848]  <TASK>
> [ 2455.021848]  dump_stack_lvl+0x5b/0x80
> [ 2455.021848]  __lock_acquire+0x65f2/0x7b00
> [ 2455.021848]  ? lock_release+0x25c/0xcd0
> [ 2455.021848]  lock_acquire+0x11c/0x3d0
> [ 2455.021848]  ? __flush_work+0x72/0x7d0
> [ 2455.021848]  ? lockdep_hardirqs_on_prepare+0x2b0/0x5f0
> [ 2455.021848]  ? __flush_work+0x72/0x7d0
> [ 2455.021848]  __flush_work+0x648/0x7d0
> [ 2455.021848]  ? __flush_work+0x72/0x7d0
> [ 2455.021848]  ? __flush_work+0x72/0x7d0
> [ 2455.021848]  ? __cfi_wq_barrier_func+0x10/0x10
> [ 2455.021848]  nvmet_ctrl_put+0x3b2/0x640 [nvmet 06f982ecc8920c7359ba51cc41092b5d91a725d5]
> [ 2455.021848]  nvmet_sq_destroy+0x2e7/0x350 [nvmet 06f982ecc8920c7359ba51cc41092b5d91a725d5]
> [ 2455.021848]  nvmet_rdma_free_queue+0x35/0x590 [nvmet_rdma d9fba27fd955e2c2575b3e184853a6daafaffc5c]
> [ 2455.021848]  ? do_raw_spin_unlock+0x116/0x890
> [ 2455.021848]  ? process_scheduled_works+0x6d4/0xf80
> [ 2455.021848]  nvmet_rdma_release_queue_work+0x43/0xa0 [nvmet_rdma d9fba27fd955e2c2575b3e184853a6daafaffc5c]
> [ 2455.021848]  process_scheduled_works+0x774/0xf80
> [ 2455.060121]  worker_thread+0x8c4/0xfc0
> [ 2455.061903]  ? __kthread_parkme+0x84/0x120
> [ 2455.063471]  kthread+0x25d/0x2e0
> [ 2455.065681]  ? __cfi_worker_thread+0x10/0x10
> [ 2455.065681]  ? __cfi_kthread+0x10/0x10
> [ 2455.065681]  ret_from_fork+0x41/0x70
> [ 2455.065681]  ? __cfi_kthread+0x10/0x10
> [ 2455.065681]  ret_from_fork_asm+0x1b/0x30
> [ 2455.065681]  </TASK>
> [ 2455.096534] nvmet: adding nsid 1 to subsystem blktests-subsystem-5
> 
> This looks familiar. I thought we have addressed it. Maybe I missing the
> fix since this is on 6.8-rc3
> 
No, looks like a different one.
Problem seems to be the 'flush_workqueue(nvmet_wq)' in
nvmet_rdma_remove_one().
When calling that we end up with this call chain:

flush_workqueue(nvmet_wq)
   rdma_release_queue_work()
     rdma_free_queue()
       sq_destroy()
         ctrl_put()
           ctrl_free()
             flush_work(async_event_work)

which deadlocks as we're already flushing the workqueue.
What would happen if we do _not_ call flush_workqueue() in
nvmet_rdma_remove_one(), but rather move it into nvmet_rdma_exit()?

Cheers,

Hannes


