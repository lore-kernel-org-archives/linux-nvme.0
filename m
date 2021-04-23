Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C154C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 14:07:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6032F600CD
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 14:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6032F600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hNIhtx+PR1K//TV6MRVU4eRoTQWpKKtYhJTkRrGCmMk=; b=TazCkF38Va6jWC9oVjyTQZsvI
	9yhMjuqHUwCv0hgUuyXfg4swe8VYrju+mfe1LwFb+W5JpjkUSCG6YpIWYXzJEOTHIDQFk87P/DSOA
	xcPc5q+4OjWbekyUOA+FFcLQrJTSu/PdcNOlQNY8AJ8y0MiZUZu9vmO+exJZOWrvuPOi25HvxduTA
	zVMenqQY9gx5VkzI11j03MmFRCfy/P6yT/K08anzaMvzUzm5y46oQS0AuQVqbyhrHeALhU39UQ5g9
	IPR7dxQ4qaBiNkKhNGzOOotCnPjDgROCWFp+vJNhqlkMtZmX5blVMxQvH0EcPGzFGGVUf5SH7ICY/
	RCAfMX42g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZwSr-001f5K-Ag; Fri, 23 Apr 2021 14:07:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZwSp-001f57-9c
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 14:07:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Mime-Version:References:In-Reply-To:Date:To:From:Subject:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=HfIFnytc/94bvxef8Ed1hH5qMgE5P/qS17hGu8L0uZg=; b=u6/KmwhclsUXK5/94vPcJbtBe8
 pH3gObOX1q4xSV6b7ZXX32uFlI9fE4mGAvKHK5ZmuN9oT3s7S4V12p46ouDRKacfvKmvuyUUR8j78
 mb08v7XtQouo2bLh9UjilP7ZvLRXzPsllCJ44sbILX/AEn8956NDtejZ/N+UJ7WYGx4a7GqinGmu/
 AeS5Jv1C/LP1s8jGSDcaoOe5RJ/rYGwgfw19kN/DZVEG+JCdhVztbQrVFLo8izM/PNFPjMOcuixQK
 Fdn7wPMHxNdMJkNX37hUdV7OsAG1B32b1FIw78tRtujDT7TK+dy0Wy96cHnMj5WAr6ScSNeHnOTYE
 i+t3NddQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZwSm-00ESZF-D2
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 14:07:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619186836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfIFnytc/94bvxef8Ed1hH5qMgE5P/qS17hGu8L0uZg=;
 b=FYWVrhZ/V1NxrKo9q+hsCrq/TtKqotDH7y2Hils4lwLFkze5SjHMAkH0r2PMOpRali3V4O
 LfC1X/+D4OvIhnym02/+esCHi7UOSeqyycCKSg4Wzd1CEyWIwXYqFee2b5a1mpjDMAsU7X
 sky0Da9sSNSwSyhi+EZjIxGSsc5YPIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-CdRoMJZnN0qrA89HP3Y-Aw-1; Fri, 23 Apr 2021 10:07:14 -0400
X-MC-Unique: CdRoMJZnN0qrA89HP3Y-Aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C94BE8026AD
 for <linux-nvme@lists.infradead.org>; Fri, 23 Apr 2021 14:07:13 +0000 (UTC)
Received: from ovpn-112-203.phx2.redhat.com (ovpn-112-203.phx2.redhat.com
 [10.3.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B6ED608BA
 for <linux-nvme@lists.infradead.org>; Fri, 23 Apr 2021 14:07:13 +0000 (UTC)
Message-ID: <ebed842e4af1712f518026f1730eb797c019e41c.camel@redhat.com>
Subject: Re: [PATCH] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Date: Fri, 23 Apr 2021 10:07:13 -0400
In-Reply-To: <20210422152219.7067-1-mwilck@suse.com>
References: <20210422152219.7067-1-mwilck@suse.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=emilne@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_070720_583406_E1FCAB80 
X-CRM114-Status: GOOD (  26.77  )
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

On Thu, 2021-04-22 at 17:22 +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> We have observed a few crashes run_timer_softirq(), where a broken
> timer_list struct belonging to an anatt_timer was encountered. The
> broken
> structures look like this, and we see actually multiple ones attached
> to
> the same timer base:
> 
> crash> struct timer_list 0xffff92471bcfdc90
> struct timer_list {
>   entry = {
>     next = 0xdead000000000122,  // LIST_POISON2
>     pprev = 0x0
>   },
>   expires = 4296022933,
>   function = 0xffffffffc06de5e0 <nvme_anatt_timeout>,
>   flags = 20
> }
> 
> If such a timer is encountered in run_timer_softirq(), the kernel
> crashes. The test scenario was an I/O load test with lots of NVMe
> controllers, some of which were removed and re-added on the storage
> side.
> 
> I think this may happen if the rdma recovery_work starts, in this
> call
> chain:
> 
> nvme_rdma_error_recovery_work()
>   /* this stops all sorts of activity for the controller, but not
>      the multipath-related work queue and timer */
>   nvme_rdma_reconnect_or_remove(ctrl)
>     => kicks reconnect_work
> 
> work queue: reconnect_work
> 
> nvme_rdma_reconnect_ctrl_work()
>   nvme_rdma_setup_ctrl()
>     nvme_rdma_configure_admin_queue()
>        nvme_init_identify()
>           nvme_mpath_init()
> 	     # this sets some fields of the timer_list without taking a
> lock
>              timer_setup()
>              nvme_read_ana_log()
> 	         mod_timer() or del_timer_sync()
> 
> Similar for TCP. The idea for the patch is based on the observation
> that
> nvme_rdma_reset_ctrl_work() calls nvme_stop_ctrl()-
> >nvme_mpath_stop(),
> whereas nvme_rdma_error_recovery_work() stops only the keepalive
> timer, but
> not the anatt timer.
> 
> I admit that the root cause analysis isn't rock solid yet. In
> particular, I
> can't explain why we see LIST_POISON2 in the "next" pointer, which
> would
> indicate that the timer has been detached before; yet we find it
> linked to
> the timer base when the crash occurs.
> 
> OTOH, the anatt_timer is only touched in nvme_mpath_init() (see
> above) and
> nvme_mpath_stop(), so the hypothesis that modifying active timers may
> cause
> the issue isn't totally out of sight. I suspect that the LIST_POISON2
> may
> come to pass in multiple steps.
> 
> If anyone has better ideas, please advise. The issue occurs very
> sporadically; verifying this by testing will be difficult.
> 

We have a couple reports of this same crash, one when traversing the
timer list and one when removing the timer.  Note LIST_POISON2 in RAX.
I was also thinking that stopping would resolve it.

It's somewhat hard to reproduce so it may take a while to verify
but we'll test this patch out.

-Ewan

crash> bt
PID: 0      TASK: ffffffffbae12780  CPU: 0   COMMAND: "swapper/0"
 #0 [ffff922477a03cd8] machine_kexec at ffffffffb9c5bf3e
 #1 [ffff922477a03d30] __crash_kexec at ffffffffb9d6072d
 #2 [ffff922477a03df8] crash_kexec at ffffffffb9d6160d
 #3 [ffff922477a03e10] oops_end at ffffffffb9c22d4d
 #4 [ffff922477a03e30] general_protection at ffffffffba6011fe
    [exception RIP: run_timer_softirq+294]
    RIP: ffffffffb9d3ea36  RSP: ffff922477a03ee0  RFLAGS: 00010086
    RAX: dead000000000200  RBX: ffff922477a1aa80  RCX: 0000000000000100
    RDX: ffff922477a03ef0  RSI: 0000000000000002  RDI: ffff922477a1aa80
    RBP: 0000000000000001   R8: ffffffffbae12780   R9: 0000000000000000
    R10: 0000000000000310  R11: 000000000b5ad84c  R12: 000000011dd60000
    R13: ffff922477a03ef0  R14: ffff922472de0f80  R15: ffffffffbae05100
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffff922477a03f68] __softirqentry_text_start at ffffffffba8000e4
 #6 [ffff922477a03fc8] irq_exit at ffffffffb9cbc1d7
 #7 [ffff922477a03fd8] smp_apic_timer_interrupt at ffffffffba6027e4
 #8 [ffff922477a03ff0] apic_timer_interrupt at ffffffffba601d6f
--- <IRQ stack> ---
 #9 [ffffffffbae03dd8] apic_timer_interrupt at ffffffffba601d6f
    [exception RIP: native_safe_halt+14]
    RIP: ffffffffba4d667e  RSP: ffffffffbae03e80  RFLAGS: 00000246
    RAX: ffffffffba4d62d0  RBX: 0000000000000000  RCX: 00000000000f4240
    RDX: 0000000000000001  RSI: 0000000000000000  RDI: 0000000000000082
    RBP: 0000000000000000   R8: 000266f562c6c886   R9: 0000000000000001
    R10: 000000000000031f  R11: ffff9224722cb400  R12: ffffffffffffffff
    R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
    ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
#10 [ffffffffbae03e80] default_idle at ffffffffba4d62ec
#11 [ffffffffbae03ea8] do_idle at ffffffffb9cebbb7
#12 [ffffffffbae03ef0] cpu_startup_entry at ffffffffb9cebe0f
#13 [ffffffffbae03f10] start_kernel at ffffffffbb6b21e5
#14 [ffffffffbae03f50] secondary_startup_64 at ffffffffb9c000e7

(different crash)


PID: 69334  TASK: ffff8d02a652dd00  CPU: 0   COMMAND: "kworker/u2:2"
 #0 [ffffa658418cfb28] machine_kexec at ffffffffb565bf3e
 #1 [ffffa658418cfb80] __crash_kexec at ffffffffb576072d
 #2 [ffffa658418cfc48] crash_kexec at ffffffffb576160d
 #3 [ffffa658418cfc60] oops_end at ffffffffb5622d4d
 #4 [ffffa658418cfc80] general_protection at ffffffffb60011fe
    [exception RIP: detach_if_pending+58]
    RIP: ffffffffb573cdfa  RSP: ffffa658418cfd38  RFLAGS: 00010086
    RAX: dead000000000200  RBX: ffff8d02aac74f80  RCX: 0000000000000000
    RDX: ffffa65841d5bb68  RSI: ffff8d02afa1aa80  RDI: ffff8d02aac74f80
    RBP: ffff8d02aac74f80   R8: ffff8d02a652dd00   R9: 0000000000000000
    R10: 0000000002f41000  R11: 0000000000000000  R12: 0000000000000001
    R13: 0000000000000000  R14: ffff8d02a7621e80  R15: ffff8d02aac750a0
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffa658418cfd50] try_to_del_timer_sync at ffffffffb573cf4f
 #6 [ffffa658418cfd78] del_timer_sync at ffffffffb573cfb5
 #7 [ffffa658418cfd88] nvme_read_ana_log at ffffffffc01df657 [nvme_core]
 #8 [ffffa658418cfdb8] nvme_mpath_init at ffffffffc01e0642 [nvme_core]
 #9 [ffffa658418cfdd0] nvme_init_identify at ffffffffc01ddba8 [nvme_core]
#10 [ffffa658418cfe38] nvme_tcp_setup_ctrl at ffffffffc040e2e9 [nvme_tcp]
#11 [ffffa658418cfe80] nvme_tcp_reconnect_ctrl_work at ffffffffc040e4bf [nvme_tcp]
#12 [ffffa658418cfe98] process_one_work at ffffffffb56d3477
#13 [ffffa658418cfed8] worker_thread at ffffffffb56d3b40
#14 [ffffa658418cff10] kthread at ffffffffb56d9502
#15 [ffffa658418cff50] ret_from_fork at ffffffffb6000255


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
