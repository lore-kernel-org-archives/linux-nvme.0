Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0551AC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 01:37:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF1F207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 01:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UBPVbh2x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqerqJMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF1F207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lf/6sAg4iZPGKGm0sp/9SYari8nP8vaOSx1ba9+01OM=; b=UBPVbh2xVKbz2Q
	jWCMYVTifdvPmHHpLsDBye0z5354kXFGyFjlAekZwz8Em3hVV5HG4S3mnbvbHYAenHLAO3UNO5vTI
	xq6MJPkBZYkDvuheXU9FqdS14d+NBL8Abwi6jqbAKogQv4X7uWiXtMbIakPcARUBea93uZyp/9D4n
	TGomKF1XGp3CImjf/0ruNZSU45Ptm/8L4JTupLSLTMdAZrH1CAC29xj92YbtDcTbgqVvwSvjCueh2
	jzilhYjVnwP92ecrGoa/dbV+u0drjxCeUaPt00HskAOJbTdDcVljous/zopR+tj2dquEH7TaYesVd
	/BTWKvJikTIaVZS4NKvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je7U7-0000in-Lx; Thu, 28 May 2020 01:37:27 +0000
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je7TH-0008Jt-Vf
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 01:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590629792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CrRDMSyUueCP0CeAxgEqbi+UPByZat1mVSXlLI0YYgI=;
 b=TqerqJMdImM2Z3mXrFNEL+Z+6ycmSBdE8g17FjTY7AJFnQFB46F7oSjvw7DzX8S6CwzQ9q
 llDQZMA7jACkKHKxt4hXBaf3MAdsmK6/dw3cYKM1rgTSDHLyFnr1OJjOckKhCQOceW0obK
 61ADobNFtIAz4B0QGxn53fjXV/0LT5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-UaYLpAKAOOeHoG6UjxjQXA-1; Wed, 27 May 2020 21:36:23 -0400
X-MC-Unique: UaYLpAKAOOeHoG6UjxjQXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCE7F835B46;
 Thu, 28 May 2020 01:36:21 +0000 (UTC)
Received: from T590 (ovpn-12-189.pek2.redhat.com [10.72.12.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F245C1B0;
 Thu, 28 May 2020 01:36:15 +0000 (UTC)
Date: Thu, 28 May 2020 09:36:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
Message-ID: <20200528013611.GA933147@T590>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <22083f76-43f5-38a1-0e2d-84b626a6fd50@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22083f76-43f5-38a1-0e2d-84b626a6fd50@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_183636_228994_A29FF97B 
X-CRM114-Status: GOOD (  23.67  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Alan,

On Wed, May 27, 2020 at 11:09:53AM -0700, Alan Adamson wrote:
> I tested this patch against a timeout test I've been working with and I'm
> getting a hang.
> =

> # cat block-err.sh
> set -x
> echo 100 > /sys/kernel/debug/fail_io_timeout/probability
> echo 1000 > /sys/kernel/debug/fail_io_timeout/times
> echo 1 > /sys/block/nvme0n1/io-timeout-fail
> dd if=3D/dev/nvme0n1 of=3D/dev/null bs=3D512 count=3D1
> =

> =

> # sh=A0 block-err.sh
> + echo 100
> + echo 1000
> + echo 1
> + dd if=3D/dev/nvme0n1 of=3D/dev/null bs=3D512 count=3D1
> =

> **** Hang ****
> =

> # dmesg
> .
> .
> .
> [=A0=A0 79.403253] FAULT_INJECTION: forcing a failure.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name fail_io_timeout, interval=
 1, probability 100, space 0,
> times 1000
> [=A0=A0 79.403255] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0-rc7+ #1
> [=A0=A0 79.403256] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [=A0=A0 79.403257] Call Trace:
> [=A0=A0 79.403259]=A0 <IRQ>
> [=A0=A0 79.403267]=A0 dump_stack+0x6d/0x9a
> [=A0=A0 79.403270]=A0 should_fail.cold.5+0x32/0x42
> [=A0=A0 79.403273]=A0 blk_should_fake_timeout+0x26/0x30
> [=A0=A0 79.403275]=A0 blk_mq_complete_request+0x1b/0x120
> [=A0=A0 79.403280]=A0 nvme_irq+0xd9/0x1f0 [nvme]
> [=A0=A0 79.403287]=A0 __handle_irq_event_percpu+0x44/0x190
> [=A0=A0 79.403288]=A0 handle_irq_event_percpu+0x32/0x80
> [=A0=A0 79.403290]=A0 handle_irq_event+0x3b/0x5a
> [=A0=A0 79.403291]=A0 handle_edge_irq+0x87/0x190
> [=A0=A0 79.403296]=A0 do_IRQ+0x54/0xe0
> [=A0=A0 79.403299]=A0 common_interrupt+0xf/0xf
> [=A0=A0 79.403300]=A0 </IRQ>
> [=A0=A0 79.403305] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [=A0=A0 79.403307] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f =
44 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <=
45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [=A0=A0 79.403308] RSP: 0018:ffffb97e8c54be40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [=A0=A0 79.403309] RAX: ffff9781bf76cc40 RBX: ffffd95e7f743200 RCX:
> 000000000000001f
> [=A0=A0 79.403310] RDX: 000000127ccd6e6c RSI: 0000000031573862 RDI:
> 0000000000000000
> [=A0=A0 79.403310] RBP: ffffb97e8c54be80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [=A0=A0 79.403311] R10: 011b921e580bc454 R11: ffff9781bf76bb44 R12:
> 0000000000000002
> [=A0=A0 79.403311] R13: ffffffffbd14c120 R14: ffffffffbd14c208 R15:
> ffffffffbd14c1f0
> [=A0=A0 79.403314]=A0 cpuidle_enter+0x2e/0x40
> [=A0=A0 79.403318]=A0 call_cpuidle+0x23/0x40
> [=A0=A0 79.403319]=A0 do_idle+0x230/0x270
> [=A0=A0 79.403320]=A0 cpu_startup_entry+0x1d/0x20
> [=A0=A0 79.403325]=A0 start_secondary+0x170/0x1c0
> [=A0=A0 79.403329]=A0 secondary_startup_64+0xb6/0xc0
> [=A0 109.674334] nvme nvme0: I/O 754 QID 34 timeout, aborting
> [=A0 109.674395] nvme nvme0: Abort status: 0x0
> [=A0 139.879453] nvme nvme0: I/O 754 QID 34 timeout, reset controller
> [=A0 139.895263] FAULT_INJECTION: forcing a failure.
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name fail_io_timeout, interval=
 1, probability 100, space 0,
> times 999
> [=A0 139.895265] CPU: 5 PID: 2470 Comm: kworker/5:1H Not tainted 5.7.0-rc=
7+ #1
> [=A0 139.895266] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [=A0 139.895271] Workqueue: kblockd blk_mq_timeout_work
> [=A0 139.895272] Call Trace:
> [=A0 139.895279]=A0 dump_stack+0x6d/0x9a
> [=A0 139.895281]=A0 should_fail.cold.5+0x32/0x42
> [=A0 139.895282]=A0 blk_should_fake_timeout+0x26/0x30
> [=A0 139.895283]=A0 blk_mq_complete_request+0x1b/0x120
> [=A0 139.895292]=A0 nvme_cancel_request+0x33/0x80 [nvme_core]
> [=A0 139.895296]=A0 bt_tags_iter+0x48/0x50
> [=A0 139.895297]=A0 blk_mq_tagset_busy_iter+0x1eb/0x270
> [=A0 139.895299]=A0 ? nvme_try_sched_reset+0x40/0x40 [nvme_core]
> [=A0 139.895301]=A0 ? nvme_try_sched_reset+0x40/0x40 [nvme_core]
> [=A0 139.895305]=A0 nvme_dev_disable+0x2be/0x460 [nvme]
> [=A0 139.895307]=A0 nvme_timeout.cold.80+0x9c/0x182 [nvme]
> [=A0 139.895311]=A0 ? sched_clock+0x9/0x10
> [=A0 139.895315]=A0 ? sched_clock_cpu+0x11/0xc0
> [=A0 139.895320]=A0 ? __switch_to_asm+0x40/0x70
> [=A0 139.895321]=A0 blk_mq_check_expired+0x192/0x1b0
> [=A0 139.895322]=A0 bt_iter+0x52/0x60
> [=A0 139.895323]=A0 blk_mq_queue_tag_busy_iter+0x1a0/0x2e0
> [=A0 139.895325]=A0 ? __switch_to_asm+0x40/0x70
> [=A0 139.895326]=A0 ? __blk_mq_requeue_request+0xf0/0xf0
> [=A0 139.895326]=A0 ? __blk_mq_requeue_request+0xf0/0xf0
> [=A0 139.895329]=A0 ? compat_start_thread+0x20/0x40
> [=A0 139.895330]=A0 blk_mq_timeout_work+0x5a/0x130
> [=A0 139.895333]=A0 process_one_work+0x1ab/0x380
> [=A0 139.895334]=A0 worker_thread+0x37/0x3b0
> [=A0 139.895335]=A0 kthread+0x120/0x140
> [=A0 139.895337]=A0 ? create_worker+0x1b0/0x1b0
> [=A0 139.895337]=A0 ? kthread_park+0x90/0x90
> [=A0 139.895339]=A0 ret_from_fork+0x35/0x40
> [=A0 139.897859] nvme nvme0: Shutdown timeout set to 10 seconds
> [=A0 139.901186] nvme nvme0: 56/0/0 default/read/poll queues

The above just shows the stack trace which fakes the timeout failure.
Not see any hang stack trace.

The reason is that you set 100% failure, then no any request can move
on. And each request is tried 100 times, which may take too long
to complete given the default timeout is 30sec.

 echo 100 > /sys/kernel/debug/fail_io_timeout/probability
 echo 1000 > /sys/kernel/debug/fail_io_timeout/times

If you stop the injection via below command after some time, such as 5min
since starting the script, you will see the test done with this patchset.

	echo 0 > /sys/block/nvme0n1/io-timeout-fail

Without this patches, the controller can be removed very soon.

Thanks,
Ming

> =

> On 5/20/20 4:56 AM, Ming Lei wrote:
> > Hi,
> > =

> > For nvme-pci, after controller is recovered, in-flight IOs are waited
> > before updating nr hw queues. If new controller error happens during
> > this period, nvme-pci driver deletes the controller and fails in-flight
> > IO. This way is too violent, and not friendly from user viewpoint.
> > =

> > Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
> > in nvme-pci reset handler with checking if all ns queues are frozen &
> > controller disabled. Then a fresh new reset can be scheduled for
> > handling new controller error during waiting for in-flight IO completio=
n.
> > =

> > So deleting controller & failing IOs can be avoided in this situation.
> > =

> > Without this patches, when fail io timeout injection is run, the
> > controller can be removed very quickly. With this patch, no controller
> > removing can be observed, and controller can recover to normal state
> > after stopping to inject io timeout failure.
> > =

> > Ming Lei (3):
> >    blk-mq: add API of blk_mq_queue_frozen
> >    nvme: add nvme_frozen
> >    nvme-pci: make nvme reset more reliable
> > =

> >   block/blk-mq.c           |  6 ++++++
> >   drivers/nvme/host/core.c | 14 ++++++++++++++
> >   drivers/nvme/host/nvme.h |  1 +
> >   drivers/nvme/host/pci.c  | 37 ++++++++++++++++++++++++++++++-------
> >   include/linux/blk-mq.h   |  1 +
> >   5 files changed, 52 insertions(+), 7 deletions(-)
> > =

> =

> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- =

Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
