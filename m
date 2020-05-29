Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD7C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 03:40:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5826C20721
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 03:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cl8628aF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvOq9y+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5826C20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sbNIgaA+VWYwzVa/BGjREc2lNflfEM5JrPrprzldS+o=; b=cl8628aFuUT5ro
	DpEfFqi0cre51EYdpeMEd041JX8LV3j82epon6tgvGXVKKqjmeZMRQiH7cUjbmrHdUbkmXxL281zN
	c1ai4DGZFhoOQRX4LrH4jcBf9Pz4mgBeg1S8nvTc8ee/ldtH6SiYZoT1bApmbCmgL9T8Z7ML2Vx33
	/QtnRRXwPjaq3K4F/ss6oniSIMhG892mCBDSeWR4w2o22dOdElSsnp4AdEKD2h1SPOzys/SuimnjR
	7SGRpUIBlrM1MLqhrLejaD9tatEFO0s11jqtCDWPDoMJV6+/jyOneCuUERjLVrYd+5PX+El6DKxWW
	2O/RaB0JSUQhXLUoJSJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeVsK-0008AU-Uh; Fri, 29 May 2020 03:40:04 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeVsH-0007da-Rb
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 03:40:04 +0000
Received: by mail-wr1-x444.google.com with SMTP id y17so1713155wrn.11
 for <linux-nvme@lists.infradead.org>; Thu, 28 May 2020 20:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Hv8GT69E7LV6PIAHaRowkV9c7gHvtj7pugrFZzQZX4=;
 b=AvOq9y+hFRKSD89ea52JRYGflLcW4H/WlK3QsNpRbRF5h7zTqOa0uB5iTYqRTSWtrm
 0bvlwitno25lEwZmDHYBaFUbw4ZSp59+c5gvfwUeYTYFAMwkl0bERklNvkUWH20aY5Vj
 +DmdD1TuY7zygQigehPAcIte63bS4FGWKrJ9gKiczu0LO4tCxv9Vcz05ZE/ePCGlSkK6
 WrJG99ghBOx1BBzOQcTr59rEl/YwXsIngJe7PKEIOq92BvJcjZJN8gWTzbt68COSL2XN
 7hUl1qIYqgDcKTiHQl8VJH+n4bo4dg2ZoooNu2m0WqZrfQBVEE4FVkmFA+BkUkJ9wZ/m
 9Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Hv8GT69E7LV6PIAHaRowkV9c7gHvtj7pugrFZzQZX4=;
 b=P9huuwjx6MhKMoKWbQ2xi+nr+92GUCtV4RDo50dr8Xp4t7dhoJqYmiu/qZ42ogfePW
 E0KsvDsC1fzxwf2UnjDfStaqSleSwQ6eAftgRHVuDQR8eSEDvlvsUBe4XH+wgZJGmqBm
 jg23FWky22sccaAEzVpTDPODY4JDaUW8rVuCEnPNkihN5One0jipk07m0qH3Z5kJLjqk
 8+j1vnQNRF/DSxyWZNBZYfMzBxuoYdzmwzgOFjV0DS8qTUtTiFd7OjmwKlNe0zkx/98P
 gT0Qqwdt7iNfjZio7akG871NNNFjgKPOxWWc4mgW8LKeGbjNJM9byXRq20BS1rmQwgVB
 +obA==
X-Gm-Message-State: AOAM531ByDadMOtgx/K6UcUUo5HgVZObxOlLLFVM8ero7zEh98+ocv3h
 o8FTwA+m007Rr8zuH3KJ/oGy+uO+YHAGSSfg5xs=
X-Google-Smtp-Source: ABdhPJxgsGI1uSJbOl/m1xqxsGkurdEvLlXo81t0MOsagV98bq2u15vdwNNdr5IN1vRjK6XP/7dwTZDc9jX18nE4HXc=
X-Received: by 2002:a05:6000:100d:: with SMTP id
 a13mr6567389wrx.317.1590723598176; 
 Thu, 28 May 2020 20:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
 <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com>
In-Reply-To: <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 29 May 2020 11:39:46 +0800
Message-ID: <CACVXFVOTQ7HLV5DCP1XezPqha13LfUrj-fZE8++_BAoTvtPWMA@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To: Alan Adamson <alan.adamson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_204001_968924_4DA44CFA 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 29, 2020 at 4:19 AM Alan Adamson <alan.adamson@oracle.com> wrote:
>
> It did come back.  Just took a little longer.
>
> Alan
>
> [  394.319378] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [  394.334228] nvme nvme0: new error during reset
> [  394.340125] nvme nvme0: Shutdown timeout set to 10 seconds
> [  394.343452] nvme nvme0: 56/0/0 default/read/poll queues
> [  394.343557] FAULT_INJECTION: forcing a failure.
>                 name fail_io_timeout, interval 1, probability 100, space
> 0, times 995
> [  394.343559] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [  394.343559] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [  394.343560] Call Trace:
> [  394.343561]  <IRQ>
> [  394.343563]  dump_stack+0x6d/0x9a
> [  394.343564]  should_fail.cold.5+0x32/0x42
> [  394.343566]  blk_should_fake_timeout+0x26/0x30
> [  394.343566]  blk_mq_complete_request+0x15/0x30
> [  394.343569]  nvme_irq+0xd9/0x1f0 [nvme]
> [  394.343571]  __handle_irq_event_percpu+0x44/0x190
> [  394.343573]  handle_irq_event_percpu+0x32/0x80
> [  394.343574]  handle_irq_event+0x3b/0x5a
> [  394.343575]  handle_edge_irq+0x87/0x190
> [  394.343577]  do_IRQ+0x54/0xe0
> [  394.343578]  common_interrupt+0xf/0xf
> [  394.343579]  </IRQ>
> [  394.343581] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [  394.343582] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44
> 00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00
> 00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [  394.343583] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [  394.343584] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [  394.343585] RDX: 0000005bd0b51f04 RSI: 0000000031573862 RDI:
> 0000000000000000
> [  394.343585] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [  394.343586] R10: 011c65ca3dee2b0c R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [  394.343586] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [  394.343588]  cpuidle_enter+0x2e/0x40
> [  394.343590]  call_cpuidle+0x23/0x40
> [  394.343591]  do_idle+0x230/0x270
> [  394.343592]  cpu_startup_entry+0x1d/0x20
> [  394.343594]  start_secondary+0x170/0x1c0
> [  394.343596]  secondary_startup_64+0xb6/0xc0
> [  424.524341] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [  424.524389] nvme nvme0: Abort status: 0x0
> [  454.729622] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [  454.740442] nvme nvme0: new error during reset
> [  454.750403] nvme nvme0: Shutdown timeout set to 10 seconds
> [  454.753508] nvme nvme0: 56/0/0 default/read/poll queues
> [  454.753596] FAULT_INJECTION: forcing a failure.
>                 name fail_io_timeout, interval 1, probability 100, space
> 0, times 994
> [  454.753598] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [  454.753599] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [  454.753599] Call Trace:
> [  454.753600]  <IRQ>
> [  454.753603]  dump_stack+0x6d/0x9a
> [  454.753604]  should_fail.cold.5+0x32/0x42
> [  454.753605]  blk_should_fake_timeout+0x26/0x30
> [  454.753606]  blk_mq_complete_request+0x15/0x30
> [  454.753609]  nvme_irq+0xd9/0x1f0 [nvme]
> [  454.753612]  __handle_irq_event_percpu+0x44/0x190
> [  454.753613]  handle_irq_event_percpu+0x32/0x80
> [  454.753615]  handle_irq_event+0x3b/0x5a
> [  454.753616]  handle_edge_irq+0x87/0x190
> [  454.753617]  do_IRQ+0x54/0xe0
> [  454.753619]  common_interrupt+0xf/0xf
> [  454.753620]  </IRQ>
> [  454.753622] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [  454.753623] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44
> 00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00
> 00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [  454.753624] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [  454.753625] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [  454.753626] RDX: 00000069e16d295b RSI: 0000000031573862 RDI:
> 0000000000000000
> [  454.753626] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [  454.753627] R10: 011c65eebaf0c79e R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [  454.753627] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [  454.753630]  cpuidle_enter+0x2e/0x40
> [  454.753632]  call_cpuidle+0x23/0x40
> [  454.753633]  do_idle+0x230/0x270
> [  454.753634]  cpu_startup_entry+0x1d/0x20
> [  454.753636]  start_secondary+0x170/0x1c0
> [  454.753637]  secondary_startup_64+0xb6/0xc0
> [  484.934587] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [  484.934641] nvme nvme0: Abort status: 0x0
> [  492.613861] INFO: task kworker/u114:2:1182 blocked for more than 245
> seconds.
> [  492.613884]       Not tainted 5.7.0-rc7+ #2
> [  492.613912] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  492.613948] kworker/u114:2  D    0  1182      2 0x80004000
> [  492.613953] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [  492.613954] Call Trace:
> [  492.613956]  __schedule+0x2dc/0x710
> [  492.613958]  ? __kfifo_to_user_r+0x90/0x90
> [  492.613960]  schedule+0x44/0xb0
> [  492.613961]  blk_mq_freeze_queue_wait+0x4b/0xb0
> [  492.613962]  ? finish_wait+0x80/0x80
> [  492.613963]  blk_mq_freeze_queue+0x1a/0x20
> [  492.613966]  nvme_update_disk_info+0x62/0x3b0 [nvme_core]
> [  492.613968]  __nvme_revalidate_disk+0x8d/0x140 [nvme_core]
> [  492.613970]  nvme_revalidate_disk+0xa4/0x140 [nvme_core]
> [  492.613971]  ? blk_mq_run_hw_queue+0xba/0x100
> [  492.613973]  revalidate_disk+0x2b/0xa0
> [  492.613975]  nvme_validate_ns+0x46/0x5b0 [nvme_core]
> [  492.613978]  ? __nvme_submit_sync_cmd+0xe0/0x1b0 [nvme_core]
> [  492.613980]  nvme_scan_work+0x25a/0x310 [nvme_core]
> [  492.613983]  process_one_work+0x1ab/0x380
> [  492.613984]  worker_thread+0x37/0x3b0
> [  492.613985]  kthread+0x120/0x140
> [  492.613990]  ? create_worker+0x1b0/0x1b0
> [  492.613992]  ? kthread_park+0x90/0x90
> [  492.614011]  ret_from_fork+0x35/0x40
> [  515.139879] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [  515.150634] nvme nvme0: new error during reset

Looks your kernel has applied patchset of '[PATCH 0/3] blk-mq/nvme:
improve nvme-pci reset handler',
and seems it works well.

> [  515.158310] blk_update_request: I/O error, dev nvme0n1, sector 0 op
> 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [  515.158346] Buffer I/O error on dev nvme0n1, logical block 0, async
> page read
> [  515.160800] nvme nvme0: Shutdown timeout set to 10 seconds
> [  515.163954] nvme nvme0: 56/0/0 default/read/poll queues

The controller is reset to normal state even though timeout is
triggered during reset.

The hang from scan work context just means that blk_mq_freeze_queue() waits for
too long(245sec) becuase IO request times out and is retried for 5
times, and that may
not be avoided if you fail all IO requets for 1000 times.

As I suggested to you in another thread, if you stop to fail IO
requests after injecting failure
for some time, the scan work will run to end and everything will be
fine. That said NVMe's
error handling becomes better after applying the patchs of '[PATCH
0/3] blk-mq/nvme: improve
nvme-pci reset handler'.

Thanks,
Ming Lei

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
