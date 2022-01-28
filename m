Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401AFC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWnJo4cmCTXb0OMeqY/u1XF8guzl9zI/sIiYPRyaJrA=; b=Ar6lWX9ltniyj0+T1ezLueMP+p
	YFMaFYshCxZh+nQn863QO6rtFKnhsH4Vy3PU8vnzIVFgKFggY5kcBA5qIhq1EuuFJqDhT6Fq/RToQ
	OmtWiErGwKq1/K65ZSvKQcZbQL8Y/1QBb9dikfzsQVTDZDbnYmLvY64MUTMj8ER/PaPGxPJuYIC8/
	ZdX5w8mxREpKAC7eHh92xTgN9/+BcSVOHHobzw7M07p2V1IEiQvc+LdUtkGi7XsaCFb48HqyJt3mc
	Ga2q/KVHSFN5Vrh6gMv8PGMOMiwemLLq0bP9hYElB9uwtxAgRudc7HyndyDjDUffx9ED6ek0LqGyQ
	T4C3D7aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDb5N-003oLD-D0; Fri, 28 Jan 2022 23:55:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDb5K-003oKn-0h
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 23:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643414115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UWnJo4cmCTXb0OMeqY/u1XF8guzl9zI/sIiYPRyaJrA=;
 b=dgFjs81RHvEOSuSk6hRwPUtcOGVVDV/2c2pc4hCAV7fwKS8J3QH7Q9KaywyWLXMIMauX9s
 l9cCdhfRDBy1JtptPwBhfDlQ5fG79lzns5QjFAm8iCw4z5PyM/9FZjLp9stoWqFwOYe03r
 4wsVCMRyVubhz/o/+Us4UwXkp3+DG78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-T130VgTaP_S8im7xZvmHYw-1; Fri, 28 Jan 2022 18:55:14 -0500
X-MC-Unique: T130VgTaP_S8im7xZvmHYw-1
Received: by mail-wm1-f71.google.com with SMTP id
 7-20020a1c1907000000b003471d9bbe8dso2820715wmz.0
 for <linux-nvme@lists.infradead.org>; Fri, 28 Jan 2022 15:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UWnJo4cmCTXb0OMeqY/u1XF8guzl9zI/sIiYPRyaJrA=;
 b=kP222gaBnAJ5uvyaqOGD7G2Y6fo85wJBdyPkm54ev5IS867eF23ektlCE2ttFb5x3Q
 YnavBjB8SKgD5zeyxOXKhnhfW8XQVT1NZBrJB8KV32E1YUfnoYLxQJ6/GDwLIr2xsyGX
 mFXQ4Zuc6wvfPKxJ0g3LavCKuBk3viHMmkPt+Cl5fK5dahy83wpyRwTGCR3ejuH++yT6
 dMwkAu+XS2IfHiSKhpd+XKQa6Zyz7euF+MJ3f53lMPhtILH844zQWTC7VoW6rbIuySD5
 Lzj55VYR0qVQk01Tqgxeoqg7Y2ohiAuIQg3lcWOPVDgR/LDhIyQh2fynn/AV+xoaaOUj
 oHbg==
X-Gm-Message-State: AOAM5329D8Gp56HWXt2CF3MCpPEMH2kKYq7i1Z/d6JfKvCLEAJd3QXLk
 Cv3O4W+SrG7gSMYfFEo076HKWOpp27RkfjfjylX23pADtyPJscvEBUa+2MfHut1qObxnrOHiPbg
 Y17UoAcRwt3Eu0F1+KU2i+uU9LXsVE+uwZWyKgvw1irY=
X-Received: by 2002:adf:da4a:: with SMTP id r10mr9250688wrl.282.1643414113323; 
 Fri, 28 Jan 2022 15:55:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGSIkVrmJxe2CuOVBPIy5bmaw4bapvFitxjajTbkn2+95ksTsSG7lRd6xe2BQtSwVOk0qumDIfWr7K2JQUi1M=
X-Received: by 2002:adf:da4a:: with SMTP id r10mr9250678wrl.282.1643414113085; 
 Fri, 28 Jan 2022 15:55:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
 <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
 <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
 <0ff519b9-9248-1f88-7117-ace764e18f64@grimberg.me>
 <d33f5615-0e40-2e6e-76a1-b9450fa9ec6c@grimberg.me>
 <CAPnfmXJceXFDAUXND--8UiUJeyzL-8NUAdgYcws=CodEEOF6Zg@mail.gmail.com>
In-Reply-To: <CAPnfmXJceXFDAUXND--8UiUJeyzL-8NUAdgYcws=CodEEOF6Zg@mail.gmail.com>
From: Chris Leech <cleech@redhat.com>
Date: Fri, 28 Jan 2022 15:55:01 -0800
Message-ID: <CAPnfmXJjaueZeHb0eANu_78n9dby82crquuxVWwiOD_P5gEY5w@mail.gmail.com>
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_155518_163577_83450A90 
X-CRM114-Status: GOOD (  47.25  )
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

This completed a day of automated testing without any failures.

Tested-by: Chris Leech <cleech@redhat.com>

On Thu, Jan 27, 2022 at 7:25 PM Chris Leech <cleech@redhat.com> wrote:
>
> Thanks Sagi, this looks promising.
>
> It also might fit with a new backtrace I was just looking at from the
> same testing, where nvme_tcp_submit_async_event hit a null
> ctrl->async_req.pdu which I can only see happening if it was racing
> with nvme_tcp_error_recovery_work.
>
> I'll get this into some testing here at Red Hat and let you know the results.
>
> - Chris
>
> On Thu, Jan 27, 2022 at 3:05 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > >> Thank you for the following detailed description. I'm going to go back
> > >> to my crash report and take another look at this one.
> > >
> > > No worries Chris, perhaps I can assist.
> > >
> > > Is the dmesg log prior to the BUG available? Does it tell us anything
> > > to what was going on leading to this?
> > >
> > > Any more information about the test case? (load + controller reset)
> > > Is the reset in a loop? Any more info about the load?
> > > Any other 'interference' during the test?
> > > How reproducible is this?
> > > Is this Linux nvmet as the controller?
> > > How many queues does the controller have? (it will help me understand
> > > how easy it is to reproduce on a vm setup)
> >
> > I took another look at the code and I think I see how io_work maybe
> > triggered after a socket was released. The issue might be
> > .submit_async_event callback from the core.
> >
> > When we start a reset, the first thing we do is stop the pending
> > work elements that may trigger io by calling nvme_stop_ctrl, and
> > then we continue to teardown the I/O queues and then the admin
> > queue (in nvme_tcp_teardown_ctrl).
> >
> > So the sequence is:
> >          nvme_stop_ctrl(ctrl);
> >          nvme_tcp_teardown_ctrl(ctrl, false);
> >
> > However, there is a possibility, after nvme_stop_ctrl but before
> > we teardown the admin queue, that the controller sends a AEN
> > and is processed by the host, which includes automatically
> > submitting another AER which in turn is calling the driver with
> > .submit_async_event (instead of the normal .queue_rq as AERs don't have
> > timeouts).
> >
> > In nvme_tcp_submit_async_event we do not check the controller or
> > queue state and see that it is ready to accept a new submission like
> > we do in .queue_rq, so we blindly prepare the AER cmd queue it and
> > schedules io_work, but at this point I don't see what guarantees that
> > the queue (e.g. the socket) is not released.
> >
> > Unless I'm missing something, this flow will trigger a use-after-free
> > when io_work will attempt to access the socket.
> >
> > I see we also don't flush the async_event_work in the error recovery
> > flow which we probably should so we can avoid such a race.
> >
> > I think that the below patch should address the issue:
> > --
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 96725c3f1e77..bf380ca0e0d1 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -2097,6 +2097,7 @@ static void nvme_tcp_error_recovery_work(struct
> > work_struct *work)
> >
> >          nvme_auth_stop(ctrl);
> >          nvme_stop_keep_alive(ctrl);
> > +       flush_work(&ctrl->async_event_work);
> >          nvme_tcp_teardown_io_queues(ctrl, false);
> >          /* unquiesce to fail fast pending requests */
> >          nvme_start_queues(ctrl);
> > @@ -2212,6 +2213,10 @@ static void nvme_tcp_submit_async_event(struct
> > nvme_ctrl *arg)
> >          struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
> >          struct nvme_command *cmd = &pdu->cmd;
> >          u8 hdgst = nvme_tcp_hdgst_len(queue);
> > +       bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> > +
> > +       if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)
> > +               return;
> >
> >          memset(pdu, 0, sizeof(*pdu));
> >          pdu->hdr.type = nvme_tcp_cmd;
> > --
> >
> > Chris, can you take this for some testing?
> >


