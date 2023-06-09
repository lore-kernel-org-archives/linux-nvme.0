Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932F8C7EE25
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 03:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lR4PdEBpm66GXLyK91fb9Hkr7it6RDc+Xu6p+y1I6mA=; b=U7XejxBxTj3vY4sTq+ARcrAC4i
	djiBeqo56+9BkryIo1crs/zu9UEY/XjQ9DIiF0NHmN/mWrSnHx18xFfzeUYeVx6pmNZLgjXCoKw3r
	SrjXVclXyQfrYevjfLvcVW6iK9qGleWA+kg4jlkB/ZmCJ+JIqAhiFE5u0EgvN4UxJzzCdAbd32tmj
	sBQrBs6rKZeHz0nvyuK3e+vKYLvZbKKse+UjUbQXwAujBASTT/pokS+UHdP2bbqwKei4gP2IXID1S
	biYqnYUxUIbScsCusrJd6nC9HWXR1wcOvCa36TXiiHAQEvZSnsNxUq1DRkvOsNlIW1/QA07bnGbyk
	GnyWw1wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Sii-00BRfJ-0o;
	Fri, 09 Jun 2023 03:23:24 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Sie-00BReL-0D
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 03:23:21 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977d0288fd2so222599366b.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Jun 2023 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686280994; x=1688872994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR4PdEBpm66GXLyK91fb9Hkr7it6RDc+Xu6p+y1I6mA=;
        b=VzeHWQsOxDrTjhpiRanRhdeNOgoG4H6Sms7xBt7h6K+PhiZqeM9Sbtn3y4WhxHf1bP
         i3aItjTP1Pr10Yf1PKa8A9H5oF35tpQlxjA2+E/c/TIaXimqKz2OOOFBWGXv+i4/tz+b
         fk+iQ3kZvi/IF3kQnCvxhSoyx0w02i311P7G69QLNnaWxEs/5nQmbKgB5oNbyk47wTBX
         Lvm59LwhBu0pG9dGvV5F94iJCzjuFHvJckQeRSAQLPNiKh1kaTgSnN/YQAEq2Au2vtf4
         EhdiGqPkKCn9xuLoxz/jyDAz7Gb8tXe6Hqq8JqXxaFBMN8H2MJi0pMcmpVT17ez4snyH
         8jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280994; x=1688872994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR4PdEBpm66GXLyK91fb9Hkr7it6RDc+Xu6p+y1I6mA=;
        b=Ix5BrCSElYbJJi4/yAuzl1XL58cgELvoAHdojU0MhzhMFIYyQgRxFKHgj3K1o3i4Og
         mUSW/rQUV+paraJgNlfQkE5cLoQvChaAaX/XDcT6/QMpyBOeEBHqZs6HJmaILn0YTtuG
         LOx7zgBVjbtRv8keH/cbTa9hfaaJ8Pr54zDbXVO1S0spZ0W2mvCR2ns3YdWIynlu58vk
         5iqA4aMmezZRxGwVR3jWTcOP/3oRLqAqB9lrLUKil7hvUf4GH8GbS9X8V1VJBPh0aifZ
         9SjcG5z3u9Y26h1XJ4GfEekjO4zulH2sQm9yaSWdRf6JQihRgMvGk7FgWlUpEc95cJrk
         J8ZA==
X-Gm-Message-State: AC+VfDy1lY7WyPMck+aM0fDXBqlyrWH4gpjtYWw0Hy9uiTj7PyJt5cNX
	A6zsCkyINq72qDVNwHSPv2GmHTFVQS/+wgJNGTs=
X-Google-Smtp-Source: ACHHUZ5iaY5FcNQkiNbHXTUnK1hbAWFUyTbX/nFz3LcECW969VHszYuaH25MaHZyd2y5TbEk3PMBj3bJvn/TRm4iHzg=
X-Received: by 2002:a17:907:a4e:b0:969:fc68:fa9a with SMTP id
 be14-20020a1709070a4e00b00969fc68fa9amr452656ejc.40.1686280994039; Thu, 08
 Jun 2023 20:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685350577.git.chunguang.xu@shopee.com> <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com> <CADtkEeds0jCug7F9MymVOdEVBrkSdX6mnLz4kZGCJ7og9JCc7A@mail.gmail.com>
 <ZIHcyBePwLQahkYI@ovpn-8-23.pek2.redhat.com>
In-Reply-To: <ZIHcyBePwLQahkYI@ovpn-8-23.pek2.redhat.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Fri, 9 Jun 2023 11:23:02 +0800
Message-ID: <CADtkEefZ7OKNxDvs_nk3Vr9X=P3Pv1joqesV3piBR8Dfr=SFqg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
To: Ming Lei <ming.lei@redhat.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_202320_128648_49D5CE41 
X-CRM114-Status: GOOD (  35.39  )
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

Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=888=E6=97=A5=
=E5=91=A8=E5=9B=9B 21:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 08, 2023 at 10:48:50AM +0800, =E8=AE=B8=E6=98=A5=E5=85=89 wro=
te:
> > Ming Lei <ming.lei@redhat.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=9B=9B 08:56=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Wed, Jun 07, 2023 at 12:09:17PM +0800, =E8=AE=B8=E6=98=A5=E5=85=89=
 wrote:
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
> > > >         ...
> > > >         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> > > >                 /* state change failure is ok if we started ctrl de=
lete */
> > > >                 WARN_ON_ONCE(ctrl->state !=3D NVME_CTRL_DELETING &&
> > > >                              ctrl->state !=3D NVME_CTRL_DELETING_NO=
IO);
> > > >                 return;
> > > >         }
> > > >
> > > >         nvme_tcp_reconnect_or_remove(ctrl);
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
> > > >         /* If we are resetting/deleting then do nothing */
> > > >         if (ctrl->state !=3D NVME_CTRL_CONNECTING) {
> > > >                 WARN_ON_ONCE(ctrl->state =3D=3D NVME_CTRL_NEW ||
> > > >                         ctrl->state =3D=3D NVME_CTRL_LIVE);
> > > >                 return;
> > > >         }
> > > >         ...
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
> > > > > >    new IO to load partition table.
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
> >
> > I think if we donot freeze ctrl, as the IO already submit (just queue
> > to hctx->dispatch) and may
> > pending for a long time,  it may trigger new hang task issue, but
> > freeze ctrl may can avoid these
> > hang task.
>
> How can the freeze make the difference? If driver/device can't move on,
> any request is stuck, so the IO path waits in either submit_bio() or
> upper layer after returning from submit_bio().
>

Now error_recovery and reset ctrl are handled somewhat differently:
1. error_recovery will freeze the controller, but it will unquiescing
queue to fast fail pending IO later,
otherwise this part of IO may cause task hang during the reconnection,
so while error_recovery work
interrupted, just leave ctrl freeze, queue is unquiescing.

Think carefully, the new IO will still hang in enter_queue, it seems
that this solution still not work fine, if we try to remove freeze from
nvme_tcp_teardown_io_queues(), I think we may also need to
refactor error_recovery.

2. Reset ctrl will freeze the controller and quiescing queue at the
same time, while reset interrupted,
ctrl is freeze and the queue is quiescing.

I may got the point of you, what
https://lore.kernel.org/linux-block/CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOG=
FiisCzM49_dg@mail.gmail.com/T/#ma0d6bbfaa0c8c1be79738ff86a2fdcf7582e06b0
proposal seems better.

> Thanks,
> Ming
>

