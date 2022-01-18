Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C7DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jan 2022 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K9VQ3JuxtyJJfzhTlyEFDWqvEF/247ZlIcAyZt77Q+Y=; b=tWbdNxHWLFmPLfDgGagiZQJ4zX
	oEEatgR1vE4I/4lfg4XdGv7ZqYHScFOfHnWcip7I6bpqr6rxKdVykb90v/XztACwr8JYIhurAI2tM
	vZUaaTw+dlP6rSAayI5ERG8pDjaud+WE9uDD6P/rKlCy0x5Y/3SlvtPlqVvu0kZjffMqyFtZ9kmXv
	qzPLm3UjA75lxkhYpxNvOfvzm/9NmdckgtQB9I9lmn8PFKo+ILO0Mkn6b/afYRBFjuwFnkLEenpyf
	VdXEaRuT836hO460iOyT5oyafHGDyf1uU/tuThZWfzpP6+O9kFeLv02JpAXyXoMFrxIV217HqDRdK
	7QecB/qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9xxh-003Fzq-Ot; Tue, 18 Jan 2022 23:32:25 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9xxe-003FzF-Ia
 for linux-nvme@lists.infradead.org; Tue, 18 Jan 2022 23:32:24 +0000
Received: by mail-wm1-f52.google.com with SMTP id c2so1471868wml.1
 for <linux-nvme@lists.infradead.org>; Tue, 18 Jan 2022 15:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K9VQ3JuxtyJJfzhTlyEFDWqvEF/247ZlIcAyZt77Q+Y=;
 b=xytWbynklBdv+HsQaf5GDIQIRkLTo8vWsGJl+VlEDTVu2oIlDJAYwYhLZ7+l1pR9E1
 qfujxMxRANCvaFfJpDG7qJwqTqyHAIXVORx4WPb805KAPgoLW/kzpmpPVAzG75C13QWh
 oGHLAJMCV6AAJgEpVwILrpQR+TvodsRMwRSP7hFTWnSe2btwMAqjUjyKhAG4WoW9NhNJ
 F39uvRPb71TT53i9imROdwiCLeDuXIHKUTHJFZwbIq5PV+xEP80HJskRf5365IMFu6Aa
 ziaP694cKxrPxt5nSmeCRWPLR2IcOaicjQcXHeJckdfuwnC8veomgSjQppGgktNGlgku
 5jAA==
X-Gm-Message-State: AOAM530RdEsVVNym6MKqrwgATdltseGmfGodYd9A+9OZM3ZtVdduyvlK
 hVnHkjZEc5L+bhNsrr2507lPygjtuPs=
X-Google-Smtp-Source: ABdhPJwLUuxXMIhQwSze4ZITdqqOqCE84ZsngyOE7uWmVfBo90+wk4avflnYElj0C0l6OX3ok2PAtQ==
X-Received: by 2002:adf:d4cd:: with SMTP id w13mr25655977wrk.506.1642548740254; 
 Tue, 18 Jan 2022 15:32:20 -0800 (PST)
Received: from [10.100.102.14] (85.65.248.190.dynamic.barak-online.net.
 [85.65.248.190])
 by smtp.gmail.com with ESMTPSA id l13sm3914714wmq.22.2022.01.18.15.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 15:32:19 -0800 (PST)
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
Date: Wed, 19 Jan 2022 01:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_153222_662026_F7DE05F3 
X-CRM114-Status: GOOD (  37.51  )
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


> Hi,

Hey Chris,

> I'm looking at a reported NULL pointer fault with controller reset
> testing under load

Just to understand, is this upstream kernel?

> and it appears that the nvme_tcp_stop_queue
> sequence is racing against scheduled io_work.  The fault occurs when
> kernel_sendpage is called from the workqueue context and hits a NULL
> sock->ops pointer, which is cleared by kernel_sock_shutdown before the
> call to cancel_work_sync.

Hmm, can you point me to where kernel_sock_shutdown is clearing
sock->ops? The assumption that nvme-tcp takes is that accessing
the socket is not allowed only after sock_release() but
still valid after kernel_sock_shutdown.

The sequence follows this logic:
1. kernel_sock_shutdown(SHUT_RDWR) - guarantee we do not send or
receive anything to/from the wire when any of the driver contexts
access the socket from this point on.
2. nvme_tcp_restore_sock_calls() - guarantee that we are not wake up
from any socket event, incoming data, or buffer space becoming
available to send from this point on.
3. cancel_work_sync(io_work) - cancel and fence io_work, and make sure
that it is not self-requeued. So in essence guarantee that io_work is
not triggered again (not by self-requeue, nor by socket callbacks).

Here we should be able to safely continue to release the socket
in nvme_tcp_free_queue as there should be no way anything can access
the socket concurrently.

The only places where io_work is triggered from the code are:
1. .queue_work
2. socket_event (data_ready/write_space)
3. from io_work itself (quota exhausted, or r2t was received)

So (2)+(3) should be prevented by nvme_tcp_stop_queue as outlined
above, and (1) is prevented by quiescing the request_queue which is
happening earlier in the reset sequence (nvme_tcp_teardown_io_queues
calls nvme_stop_queues before nvme_tcp_stop_io_queues).

So this is the logic that nvme-tcp follows to safely reset the
controller during traffic/load.

I have to say that if kernel_sock_shutdown() is clearing sock->ops
then we clearly have a wrong assumption, but I'm surprised that it
even works at all...

However I did not find evidence to kernel_sock_shutdown() clearing
sock->ops and in which conditions.

> 
> [ 4353.145377] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [ 4353.151921] RIP: 0010:kernel_sendpage+0x11/0xc0
> [ 4353.157005] Code: ff ff ff 31 db e9 70 ff ff ff be ff ff ff ff e9
> 49 ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 18 48
> 8b 47 20 <4c> 8b 88 a0 00 00 00 4d 85 c9 74 3b 48 8b 7e 08 48 8d 47 ff
> 83 e7
> [ 4353.177985] RSP: 0000:ffffb5870a7b7d68 EFLAGS: 00010292
> [ 4353.189185] RAX: 0000000000000000 RBX: 0000000080000000 RCX: 0000000000000048
> [ 4353.189196] RDX: 0000000000000000 RSI: ffffdffa25000000 RDI: ffff981b45de3400
> [ 4353.189199] RBP: ffff981b45de3400 R08: 00000000000000c0 R09: ffff98182073b0ec
> [ 4353.189202] R10: 000000000000000c R11: 000000000000000c R12: ffff9817c4885e38
> [ 4353.226418] R13: 0000000000000048 R14: ffff9817d0018000 R15: 0000000000000000
> [ 4353.234393] FS:  0000000000000000(0000) GS:ffff981b2fa00000(0000)
> knlGS:0000000000000000
> [ 4353.243442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4353.249871] CR2: 00000000000000a0 CR3: 00000001307ce004 CR4: 00000000003706f0
> [ 4353.257850] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4353.265824] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4353.273798] Call Trace:
> [ 4353.276554]  nvme_tcp_try_send_cmd_pdu+0xf4/0x250 [nvme_tcp]
> [ 4353.282901]  ? tcp_rcv_space_adjust+0x1d/0x1c0
> [ 4353.287888]  nvme_tcp_try_send+0x15a/0x330 [nvme_tcp]
> [ 4353.293553]  ? release_sock+0x43/0x90
> [ 4353.297666]  ? nvme_tcp_try_recv+0x73/0xa0 [nvme_tcp]
> [ 4353.303334]  nvme_tcp_io_work+0x37/0x90 [nvme_tcp]
> [ 4353.308723]  process_one_work+0x1e3/0x3b0
> [ 4353.313237]  worker_thread+0x50/0x3b0
> [ 4353.317335]  ? rescuer_thread+0x370/0x370
> [ 4353.321813]  kthread+0x149/0x170
> [ 4353.325440]  ? set_kthread_struct+0x40/0x40
> [ 4353.330128]  ret_from_fork+0x22/0x30
> 
> It would seem easy enough to cancel the io_work before
> kernel_sock_shutdown, but I think that still leaves an opportunity for
> it to be rescheduled.

How would it be rescheduled? By who?

>  The TCP callbacks do all appear to be protected
> by the sk_callback_lock and checks against sk_user_data, so it may be
> possible to restore those first?  I'm not sure on the best way to
> safely shut down the socket in this case.
> 
> I'll try and get some testing on this change, but wanted to get this
> on the list and see what other suggestions you might have.
> 
> Thanks!
> Chris Leech
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4ceb28675fdf..d9e1f875f80d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1567,9 +1567,9 @@ static void nvme_tcp_restore_sock_calls(struct
> nvme_tcp_queue *queue)
> 
>   static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   {
> -       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>          nvme_tcp_restore_sock_calls(queue);
>          cancel_work_sync(&queue->io_work);
> +       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   }

On the surface, this seems harmless (other than redundantly
sending/receiving data to/from the wire while we are terminating
the queue). But it is unclear to me why would this fix anything...

Obviously from the bug report, it seems that there is something
that is not taken into account, but I don't yet see what it is
and how that is fixed by this patch.

