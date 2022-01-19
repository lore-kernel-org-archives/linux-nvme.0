Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AFDC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 01:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cltIZlJGEJqHuywGvGn0zYmjorZsN58Zym7MQz3+dlQ=; b=izCCTGSDimWcB+1sqqzoWT6k6x
	kPeZmaUn/GVU7ifhHJc+/Ln5ZzEiU8RJZkj7ULohxvorLZPJ6rJ7aYCTBNaJFjjIpW06T3QvqiQfC
	dkEw1kugAtkEN0j+pLfql7X150Xb724z0zyzDJkAp9cWe+e4LqInALBTGBUnvqcFLzyV+IKqIhdNd
	RLWSEX6zZSuUS+CMrp4Iq3cdh6DEq3kRz+65ffd33ORWXgeUSf50J7Zqn/QQ443QS4G4aODHkc5fn
	a95CvNTwG/csHNe/RT4QWDS4Z3i1p3AR5icaOW/0jzP8eirp5+/gNVw8MdCmAdrVJ4i+VeG2swYHd
	9tvfZR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9zpR-003RPU-4U; Wed, 19 Jan 2022 01:32:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9zpN-003RO1-5S
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 01:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642555915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cltIZlJGEJqHuywGvGn0zYmjorZsN58Zym7MQz3+dlQ=;
 b=fWVAQKDa2PpLJszNRVxJdReZCRIdWNU0OA+LHaDoqjIRFA1IxpEMOADsAF/4fjAZNVhsBt
 94pvd10KWGTNMg2tIXD9WYB4iBIAtQGCCA8NjbRfOkGEfl8xBw0j5WGhUZaqp4HJA/VafU
 zL3TRQr2YR3T/ompeYwvHAGbf0+c+rg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-p87UJs1TOh6Vqv0ULcgoyQ-1; Tue, 18 Jan 2022 20:31:54 -0500
X-MC-Unique: p87UJs1TOh6Vqv0ULcgoyQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 bg32-20020a05600c3ca000b00349f2aca1beso718880wmb.9
 for <linux-nvme@lists.infradead.org>; Tue, 18 Jan 2022 17:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cltIZlJGEJqHuywGvGn0zYmjorZsN58Zym7MQz3+dlQ=;
 b=VIELPxcLsPAg45XkqjHgElW4BlIc0Fs/F8ftoyG+scIUVnDlttPbHN0X7XsKV3DOBD
 zkDssTCsms8fgLVeDKepyx70dVd1ZGJll/0EXjlS2ma4GgR+DckjkH9n8w/rtaVy0Pvw
 hm7frOHyop0HUJGLwj560Pqi94Iq/vie46luirUU20Rs4h9En7T6uPvVpIjKRM+kgVNU
 9nta3TX+3aJCXOAWBh3x70xW5IADf1KPiVKeFaT4FC0v8vgfjLYQ3C9U4HchAM5mwMMF
 uPILjONQ0VH+jhxzuDcaqtrLIMFnEvLUUE2GI5yAZmmNobibvOMMfBooX8lZmudB4stZ
 dXMw==
X-Gm-Message-State: AOAM5337kB85xHGpCUcGwOOns3xfseLMZJZpLCVCWp6PfTnkXpi6Qfeo
 04iOTvCKFlhYrGiRf55J6LrdXFQVKXIjB1p0UztWlsp3/pd2J/AFcs0Xp9Jts1U+arFq1zAlXtV
 28Wcyfo6+PYG9s/pRcunMLnVOoLDwfx4HpWFDnCQzuKo=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr1079424wmj.35.1642555912780; 
 Tue, 18 Jan 2022 17:31:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBuXRRc95SC8E45rNhMHFdp2BuhzBG6vA0lMN3STjytWOUSlFsX9Yr7Tixf1GEhyJmnJ0a26h+5ypEvFKfQYI=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr1079411wmj.35.1642555912517; 
 Tue, 18 Jan 2022 17:31:52 -0800 (PST)
MIME-Version: 1.0
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
 <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
In-Reply-To: <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
From: Chris Leech <cleech@redhat.com>
Date: Tue, 18 Jan 2022 17:31:40 -0800
Message-ID: <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_173157_315616_A0E79D07 
X-CRM114-Status: GOOD (  49.94  )
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

On Tue, Jan 18, 2022 at 3:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> > Hi,
>
> Hey Chris,
>
> > I'm looking at a reported NULL pointer fault with controller reset
> > testing under load
>
> Just to understand, is this upstream kernel?

This was a CentOS Stream 9 kernel, which should be largely in sync
with upstream currently.

> > and it appears that the nvme_tcp_stop_queue
> > sequence is racing against scheduled io_work.  The fault occurs when
> > kernel_sendpage is called from the workqueue context and hits a NULL
> > sock->ops pointer, which is cleared by kernel_sock_shutdown before the
> > call to cancel_work_sync.
>
> Hmm, can you point me to where kernel_sock_shutdown is clearing
> sock->ops? The assumption that nvme-tcp takes is that accessing
> the socket is not allowed only after sock_release() but
> still valid after kernel_sock_shutdown.

Looks like I need to apologize Sagi.  I'm not sure where I got turned
around looking at the socket code, but you're right and
kernel_sock_shutdown doesn't look to be the culprit here.

Thank you for the following detailed description. I'm going to go back
to my crash report and take another look at this one.

- Chris

> The sequence follows this logic:
> 1. kernel_sock_shutdown(SHUT_RDWR) - guarantee we do not send or
> receive anything to/from the wire when any of the driver contexts
> access the socket from this point on.
> 2. nvme_tcp_restore_sock_calls() - guarantee that we are not wake up
> from any socket event, incoming data, or buffer space becoming
> available to send from this point on.
> 3. cancel_work_sync(io_work) - cancel and fence io_work, and make sure
> that it is not self-requeued. So in essence guarantee that io_work is
> not triggered again (not by self-requeue, nor by socket callbacks).
>
> Here we should be able to safely continue to release the socket
> in nvme_tcp_free_queue as there should be no way anything can access
> the socket concurrently.
>
> The only places where io_work is triggered from the code are:
> 1. .queue_work
> 2. socket_event (data_ready/write_space)
> 3. from io_work itself (quota exhausted, or r2t was received)
>
> So (2)+(3) should be prevented by nvme_tcp_stop_queue as outlined
> above, and (1) is prevented by quiescing the request_queue which is
> happening earlier in the reset sequence (nvme_tcp_teardown_io_queues
> calls nvme_stop_queues before nvme_tcp_stop_io_queues).
>
> So this is the logic that nvme-tcp follows to safely reset the
> controller during traffic/load.
>
> I have to say that if kernel_sock_shutdown() is clearing sock->ops
> then we clearly have a wrong assumption, but I'm surprised that it
> even works at all...
>
> However I did not find evidence to kernel_sock_shutdown() clearing
> sock->ops and in which conditions.
>
> >
> > [ 4353.145377] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> > [ 4353.151921] RIP: 0010:kernel_sendpage+0x11/0xc0
> > [ 4353.157005] Code: ff ff ff 31 db e9 70 ff ff ff be ff ff ff ff e9
> > 49 ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 18 48
> > 8b 47 20 <4c> 8b 88 a0 00 00 00 4d 85 c9 74 3b 48 8b 7e 08 48 8d 47 ff
> > 83 e7
> > [ 4353.177985] RSP: 0000:ffffb5870a7b7d68 EFLAGS: 00010292
> > [ 4353.189185] RAX: 0000000000000000 RBX: 0000000080000000 RCX: 0000000000000048
> > [ 4353.189196] RDX: 0000000000000000 RSI: ffffdffa25000000 RDI: ffff981b45de3400
> > [ 4353.189199] RBP: ffff981b45de3400 R08: 00000000000000c0 R09: ffff98182073b0ec
> > [ 4353.189202] R10: 000000000000000c R11: 000000000000000c R12: ffff9817c4885e38
> > [ 4353.226418] R13: 0000000000000048 R14: ffff9817d0018000 R15: 0000000000000000
> > [ 4353.234393] FS:  0000000000000000(0000) GS:ffff981b2fa00000(0000)
> > knlGS:0000000000000000
> > [ 4353.243442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4353.249871] CR2: 00000000000000a0 CR3: 00000001307ce004 CR4: 00000000003706f0
> > [ 4353.257850] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 4353.265824] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 4353.273798] Call Trace:
> > [ 4353.276554]  nvme_tcp_try_send_cmd_pdu+0xf4/0x250 [nvme_tcp]
> > [ 4353.282901]  ? tcp_rcv_space_adjust+0x1d/0x1c0
> > [ 4353.287888]  nvme_tcp_try_send+0x15a/0x330 [nvme_tcp]
> > [ 4353.293553]  ? release_sock+0x43/0x90
> > [ 4353.297666]  ? nvme_tcp_try_recv+0x73/0xa0 [nvme_tcp]
> > [ 4353.303334]  nvme_tcp_io_work+0x37/0x90 [nvme_tcp]
> > [ 4353.308723]  process_one_work+0x1e3/0x3b0
> > [ 4353.313237]  worker_thread+0x50/0x3b0
> > [ 4353.317335]  ? rescuer_thread+0x370/0x370
> > [ 4353.321813]  kthread+0x149/0x170
> > [ 4353.325440]  ? set_kthread_struct+0x40/0x40
> > [ 4353.330128]  ret_from_fork+0x22/0x30
> >
> > It would seem easy enough to cancel the io_work before
> > kernel_sock_shutdown, but I think that still leaves an opportunity for
> > it to be rescheduled.
>
> How would it be rescheduled? By who?
>
> >  The TCP callbacks do all appear to be protected
> > by the sk_callback_lock and checks against sk_user_data, so it may be
> > possible to restore those first?  I'm not sure on the best way to
> > safely shut down the socket in this case.
> >
> > I'll try and get some testing on this change, but wanted to get this
> > on the list and see what other suggestions you might have.
> >
> > Thanks!
> > Chris Leech
> >
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 4ceb28675fdf..d9e1f875f80d 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1567,9 +1567,9 @@ static void nvme_tcp_restore_sock_calls(struct
> > nvme_tcp_queue *queue)
> >
> >   static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
> >   {
> > -       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> >          nvme_tcp_restore_sock_calls(queue);
> >          cancel_work_sync(&queue->io_work);
> > +       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> >   }
>
> On the surface, this seems harmless (other than redundantly
> sending/receiving data to/from the wire while we are terminating
> the queue). But it is unclear to me why would this fix anything...
>
> Obviously from the bug report, it seems that there is something
> that is not taken into account, but I don't yet see what it is
> and how that is fixed by this patch.
>


