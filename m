Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A01C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbMMjTvHmdjPTLcQxT34dryRcfYCEIm7xtbbSnMTHp8=; b=Zcge159HlHFrLYUr1IfaYuI9i1
	xdKyMCjfvC5aDTE4Uuvuc+mM8oEHYl9qXzVe27TR62KpUdEP4RflITmu+RUqWziwfjT5/u8xtvCk1
	y+iv/mpBFjZzXu8+QVm8zUMHLSXipFzxxMu6f6nJB1b34sv8mUYLgUNK1ul9WAY+zEHCI6X9DBuOn
	7Ku0RyTtrwEJldpOOh3YmGoMtM+5MuAiwoKIlX7FSUjAiGLIudjM8mUCqeAqscjRTUjQd2WmaXbJz
	yK+0AkDgUgtzAAr88PQ0wLCXE4jEBad8sFj2IbUi1RiLLDijy2QthzCWQ1El4B3Dq+6JwG/g8W9pp
	7As1Zljw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDHtc-000B5Z-Je; Fri, 28 Jan 2022 03:25:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDHtY-000B4s-I2
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 03:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643340350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbMMjTvHmdjPTLcQxT34dryRcfYCEIm7xtbbSnMTHp8=;
 b=CS5tJwCZg4dO283/zhL6Ptzc3q1JyFuIHqwxSW2+imRGHHM21H2q+HK1lqRC/lI1dWpiE8
 z1t1AcHco0Tla7NYZZAmQ94tZd8XuGTSp93cp1wPZNzEkU0uFOGcjKxdpPuGlcrkph09SU
 ZhteIbpg/0geJAAsBcst4kjw0rk8cE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-yr3kpyyNOP2IpSV7UMdO7g-1; Thu, 27 Jan 2022 22:25:43 -0500
X-MC-Unique: yr3kpyyNOP2IpSV7UMdO7g-1
Received: by mail-wm1-f72.google.com with SMTP id
 bg16-20020a05600c3c9000b0034bea12c043so5207271wmb.7
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 19:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pbMMjTvHmdjPTLcQxT34dryRcfYCEIm7xtbbSnMTHp8=;
 b=RVKVZOjq17er75oK9ijV2VYnTHalcD6T7AH4fcjfVSokuEAH7ei1BYi6+3w5QRf1LQ
 MBfPV8Xorv8p2sJjIvPvZpI+TX9s/boUwmjrGRUz2hMrKEgG0o25hIWflzI21YHWK2xz
 xWJwSZYRK283mlzTczymzK5kavaXWlZ/mLfptRd9/qRxIhPp1sYdHnpxxup6JAfj/pO9
 mVCGjG6lKT7z79H+nL5HXnDp52otsAEnSTMCL2XGtUop3PTi+Ylmy2YyeF+oxG1icGYR
 s0/xjqnwg7/QX1Q6ciDM+msYobvACU67PXC2ydHb1/1UKVGf/7sIKwgKDinvdBB4a24B
 Anxg==
X-Gm-Message-State: AOAM530Da9UIZ5rhUDyUfsx+RsWPjjw8O5erev97fKsM5Rd+QceaAQZT
 LNYtOqDIWu59QTO+thixBhPRMedRFYXkRXI3UNOAgMcItMNCHp6+2k89NDtcFSO+BgRJ/uSA8Oi
 6bfpnOrsrr+kGFgF2Go7PTFS587mLsk6FvwwG1/n50eE=
X-Received: by 2002:adf:da4a:: with SMTP id r10mr5614940wrl.282.1643340342350; 
 Thu, 27 Jan 2022 19:25:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwd50oGp61Ub0ow+IRXggvq6b/DYgsKlP3GgN7X9T3F/szgTEcKSmeFDljECGlBkll4QUbqfKpLmGEzOR2Q2Z0=
X-Received: by 2002:adf:da4a:: with SMTP id r10mr5614929wrl.282.1643340342111; 
 Thu, 27 Jan 2022 19:25:42 -0800 (PST)
MIME-Version: 1.0
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
 <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
 <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
 <0ff519b9-9248-1f88-7117-ace764e18f64@grimberg.me>
 <d33f5615-0e40-2e6e-76a1-b9450fa9ec6c@grimberg.me>
In-Reply-To: <d33f5615-0e40-2e6e-76a1-b9450fa9ec6c@grimberg.me>
From: Chris Leech <cleech@redhat.com>
Date: Thu, 27 Jan 2022 19:25:30 -0800
Message-ID: <CAPnfmXJceXFDAUXND--8UiUJeyzL-8NUAdgYcws=CodEEOF6Zg@mail.gmail.com>
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_192552_833872_9418307A 
X-CRM114-Status: GOOD (  42.27  )
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

Thanks Sagi, this looks promising.

It also might fit with a new backtrace I was just looking at from the
same testing, where nvme_tcp_submit_async_event hit a null
ctrl->async_req.pdu which I can only see happening if it was racing
with nvme_tcp_error_recovery_work.

I'll get this into some testing here at Red Hat and let you know the results.

- Chris

On Thu, Jan 27, 2022 at 3:05 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Thank you for the following detailed description. I'm going to go back
> >> to my crash report and take another look at this one.
> >
> > No worries Chris, perhaps I can assist.
> >
> > Is the dmesg log prior to the BUG available? Does it tell us anything
> > to what was going on leading to this?
> >
> > Any more information about the test case? (load + controller reset)
> > Is the reset in a loop? Any more info about the load?
> > Any other 'interference' during the test?
> > How reproducible is this?
> > Is this Linux nvmet as the controller?
> > How many queues does the controller have? (it will help me understand
> > how easy it is to reproduce on a vm setup)
>
> I took another look at the code and I think I see how io_work maybe
> triggered after a socket was released. The issue might be
> .submit_async_event callback from the core.
>
> When we start a reset, the first thing we do is stop the pending
> work elements that may trigger io by calling nvme_stop_ctrl, and
> then we continue to teardown the I/O queues and then the admin
> queue (in nvme_tcp_teardown_ctrl).
>
> So the sequence is:
>          nvme_stop_ctrl(ctrl);
>          nvme_tcp_teardown_ctrl(ctrl, false);
>
> However, there is a possibility, after nvme_stop_ctrl but before
> we teardown the admin queue, that the controller sends a AEN
> and is processed by the host, which includes automatically
> submitting another AER which in turn is calling the driver with
> .submit_async_event (instead of the normal .queue_rq as AERs don't have
> timeouts).
>
> In nvme_tcp_submit_async_event we do not check the controller or
> queue state and see that it is ready to accept a new submission like
> we do in .queue_rq, so we blindly prepare the AER cmd queue it and
> schedules io_work, but at this point I don't see what guarantees that
> the queue (e.g. the socket) is not released.
>
> Unless I'm missing something, this flow will trigger a use-after-free
> when io_work will attempt to access the socket.
>
> I see we also don't flush the async_event_work in the error recovery
> flow which we probably should so we can avoid such a race.
>
> I think that the below patch should address the issue:
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 96725c3f1e77..bf380ca0e0d1 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2097,6 +2097,7 @@ static void nvme_tcp_error_recovery_work(struct
> work_struct *work)
>
>          nvme_auth_stop(ctrl);
>          nvme_stop_keep_alive(ctrl);
> +       flush_work(&ctrl->async_event_work);
>          nvme_tcp_teardown_io_queues(ctrl, false);
>          /* unquiesce to fail fast pending requests */
>          nvme_start_queues(ctrl);
> @@ -2212,6 +2213,10 @@ static void nvme_tcp_submit_async_event(struct
> nvme_ctrl *arg)
>          struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
>          struct nvme_command *cmd = &pdu->cmd;
>          u8 hdgst = nvme_tcp_hdgst_len(queue);
> +       bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> +
> +       if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)
> +               return;
>
>          memset(pdu, 0, sizeof(*pdu));
>          pdu->hdr.type = nvme_tcp_cmd;
> --
>
> Chris, can you take this for some testing?
>


