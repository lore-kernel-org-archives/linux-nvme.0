Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854EC7EE25
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60WZl3oZ6fBs/Ceeo8bIk6EIYy4B+YbGCr8o/YA86ok=; b=0KxAcpxiACwFvFwmvE+jqSKNY7
	7FQpH+ZLG6ROs8qhByVYIocMBreTuuxfHJukzNKJog5fAZB7lPx4I1aD25rY6ET1+upb/00jmaPri
	p7WLO+XQGfIP89Qhz6qyUyZTRTqOTl4c6chCAcSzXRJBIElgGfl08AR2BdF53gFISbAxP6+aY2n1y
	qxViy7OSkVD3O7SjviMXul1x0wb2aCgjxpi2P63OE4iUB+WiK7AikSFmSmoatsEtUUHIUC/h6ZlJw
	onsVi126YMe1KNDnnq0BhNun3nQlGTiAlu94Qo1YCncKoN/nNYzaqWGx3LbglInfAjpD1Z1Xqc4e6
	k/1TPwfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8cqu-00365t-1L;
	Mon, 12 Jun 2023 08:24:40 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8cqp-00364V-0W
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 08:24:36 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so4400367e87.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686558272; x=1689150272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60WZl3oZ6fBs/Ceeo8bIk6EIYy4B+YbGCr8o/YA86ok=;
        b=ZAZk5udz3/I69mJI4du0tzVMDiEgIsYyMoCvR0k04ygDEwkRYCChMo27W5frEIIYjI
         ci6bRt8IUBIgONURrdqaChEFdvzcGgZdeMjRb2K2ES6KJ40J4LW2dSRqoDqCu/Z6onUw
         OC0Zr9HSxV+NisOUSoKKjITFfzY15hURsDAdg4vZ6YyG9+GoCGghaJJ3hynQPBiL0Jcp
         AzyNSV2Hu1ok/xk4+mYKkqJ0+SW+qUDce9tLUBkVhFYtpbnm5lTcYcDSAXua1rmoVSWJ
         qbnM4641hQNVsewMvlUl/X6GxdCQEKhR2o7F3T23gTyjJ5idTOSfpq9JaysVxZarytSQ
         9mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558272; x=1689150272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60WZl3oZ6fBs/Ceeo8bIk6EIYy4B+YbGCr8o/YA86ok=;
        b=W4FygKc871uQwF4U2J5P0lytyGLxmgpGnFyR1ZQ5KJU0k6zCsnq/ABevP0a5N+JcD5
         2x71sE8GQYe7R8FXEM0Jf8EpEEk9uSVxS6+7KaOg2Z/fluwm3GL1v/4EUYw9BHGI8MMX
         00YnL9N/RlyuAticcp0ALwG3KLqJfkhayiNOq0MBysmgjPVzJja3pKWBDnXsPAtsY23h
         Y6X6WhrLH0w8bmsnjg18DO6wB/lWSHFy/aXOe6nLyuyZyD24lyq7hbMwHvxdlopEg1Tp
         OdyHIXHAPWgJkKd+IjuqbjlMt1oKxqVhl8ctw8TZDe3V26bsW1fLBKyrHvByqYaMFa9S
         VfyQ==
X-Gm-Message-State: AC+VfDzTKdQHdmcpTXa6quVl2kKP606DkSdiZBOBR5hyJgN2Y50OSnRW
	RZVb1vBcVLcpUld0spqj1YKX8ZHWlQ76pWcAq1c=
X-Google-Smtp-Source: ACHHUZ4CdBnTB+Vhy4XJXj9InjjeF/dLWBaEWexLgZIQJN0wifT9hvDMXtyNxyE0zfy2pXLu1iCHUf+Dso9sL/dqMCg=
X-Received: by 2002:a19:5619:0:b0:4f3:83d6:f22c with SMTP id
 k25-20020a195619000000b004f383d6f22cmr3403785lfb.66.1686558271608; Mon, 12
 Jun 2023 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com> <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
 <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
In-Reply-To: <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 12 Jun 2023 16:24:20 +0800
Message-ID: <CADtkEef69h+Asg+J_EeOkZhmPBtnTnV2EaytfCifxjo41TW-=w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_012435_199170_D9DFB8F2 
X-CRM114-Status: GOOD (  41.62  )
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

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=B8=80 09:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jun 11, 2023 at 11:11:06AM +0300, Sagi Grimberg wrote:
> >
> > > > Hi Ming:
> > > >
> > > > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:15=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hello Chunguang,
> > > > >
> > > > > On Mon, May 29, 2023 at 06:59:22PM +0800, brookxu.cn wrote:
> > > > > > From: Chunguang Xu <chunguang.xu@shopee.com>
> > > > > >
> > > > > > We found that nvme_remove_namespaces() may hang in flush_work(&=
ctrl->scan_work)
> > > > > > while removing ctrl. The root cause may due to the state of ctr=
l changed to
> > > > > > NVME_CTRL_DELETING while removing ctrl , which intterupt nvme_t=
cp_error_recovery_work()/
> > > > > > nvme_reset_ctrl_work()/nvme_tcp_reconnect_or_remove().  At this=
 time, ctrl is
> > > > >
> > > > > I didn't dig into ctrl state check in these error handler yet, bu=
t error
> > > > > handling is supposed to provide forward progress for any controll=
er state.
> > > > >
> > > > > Can you explain a bit how switching to DELETING interrupts the ab=
ove
> > > > > error handling and breaks the forward progress guarantee?
> > > >
> > > > Here we freezed ctrl, if ctrl state has changed to DELETING or
> > > > DELETING_NIO(by nvme disconnect),  we will break up and lease ctrl
> > > > freeze, so nvme_remove_namespaces() hang.
> > > >
> > > > static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > > > {
> > > >          ...
> > > >          if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> > > >                  /* state change failure is ok if we started ctrl d=
elete */
> > > >                  WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &=
&
> > > >                               ctrl->state !=3D NVME_CTRL_DELETING_N=
OIO);
> > > >                  return;
> > > >          }
> > > >
> > > >          nvme_tcp_reconnect_or_remove(ctrl);
> > > > }
> > > >
> > > >
> > > > Another path, we will check ctrl state while reconnecting, if it ch=
anges to
> > > > DELETING or DELETING_NIO, we will break up and lease ctrl freeze an=
d
> > > > queue quiescing (through reset path), as a result Hang occurs.
> > > >
> > > > static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> > > > {
> > > >          /* If we are resetting/deleting then do nothing */
> > > >          if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> > > >                  WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> > > >                          ctrl->state =3D=3D NVME_CTRL_LIVE);
> > > >                  return;
> > > >          }
> > > >          ...
> > > > }
> > > >
> > > > > > freezed and queue is quiescing . Since scan_work may continue t=
o issue IOs to
> > > > > > load partition table, make it blocked, and lead to nvme_tcp_err=
or_recovery_work()
> > > > > > hang in flush_work(&ctrl->scan_work).
> > > > > >
> > > > > > After analyzation, we found that there are mainly two case:
> > > > > > 1. Since ctrl is freeze, scan_work hang in __bio_queue_enter() =
while it issue
> > > > > >     new IO to load partition table.
> > > > >
> > > > > Yeah, nvme freeze usage is fragile, and I suggested to move
> > > > > nvme_start_freeze() from nvme_tcp_teardown_io_queues to
> > > > > nvme_tcp_configure_io_queues(), such as the posted change on rdma=
:
> > > > >
> > > > > https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAc=
b6nLV61uOGFiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf75=
82e06b0
> > > >
> > > > While drive reconnecting, I think we should freeze ctrl or quiescin=
g queue,
> > > > otherwise nvme_fail_nonready_command()may return BLK_STS_RESOURCE,
> > > > and the IOs may retry frequently. So I think we may better freeze c=
trl
> > > > while entering
> > > > error_recovery/reconnect, but need to unfreeze it while exit.
> > >
> > > quiescing is always done in error handling, and freeze is actually
> > > not a must, and it is easier to cause race by calling freeze & unfree=
ze
> > > from different contexts.
> > >
> > > But yes, unquiesce should have been done after exiting error handling=
, or
> > > simply do it in nvme_unquiesce_io_queues().
> > >
> > > And the following patch should cover all these hangs:
> > >
> >
> > Ming, are you sending a formal patchset for this?
>
> Not yet, will do it.

Hi Ming:

Please cc me, thx.

> >
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 3ec38e2b9173..83d3818fc60b 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -4692,6 +4692,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *c=
trl)
> > >      */
> > >     nvme_mpath_clear_ctrl_paths(ctrl);
> > > +   /* unquiesce io queues so scan work won't hang */
> > > +   nvme_unquiesce_io_queues(ctrl);
> >
> > What guarantees that the queues won't be quiesced right after this
> > by the transport?
>
> Please see nvme_change_ctrl_state(), if controller state is in
> DELETING, new NVME_CTRL_RESETTING/NVME_CTRL_CONNECTING can be entered
> any more.
>
> >
> > I'm still unclear why this affects the scan_work?
>
> As Chunguang mentioned, if error recover is terminated by nvme deletion,
> the controller can be kept in quiesced state, then in-queue IOs can'tu
> move on, meantime new error recovery can't be started successfully becaus=
e
> controller state is NVME_CTRL_DELETING, so any pending IOs(include those
> from scan context) can't be completed.
>
>
>
>
> Thanks,
> Ming
>

