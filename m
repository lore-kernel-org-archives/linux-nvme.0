Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70317FB5E85
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pX3IZwbQWIREe0cd2yZ6WTCN0aV+1yG3Zml24cd+TQU=; b=S1yKxfnNwwXBezA6/22HcqjWES
	22B8Fwj7pPQU37xmYcdZcY0ZqYa24qOA+Wec9+D4b08Q9Zo9WZOAtUASng2Azp9gMvixp/5RVnPtM
	tgqJr8GtzLRgvWf7Gj1/NIVWatwqmiGjy4d7V1JjkG6Atdhl+zC+Q3Lht5UJ/SK7n/0MQCsZ6kugm
	lusg2pKX7dmmSyHHMw9Zr/YaGtPYV4fUy0/uSEoLjjpJLMZ7w2EyEfl8XeqCELfJL+we7+kh0bNMG
	/zs9NwHUkjTPQrSpeHEP53KoE2mnAtIDGReOWoJmQmYvJQbxc4nOmWTj+r9z9mP7pmAUOlsyV2DTj
	Bj2SiQCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HXA-000000055LU-41MF;
	Mon, 16 Mar 2026 23:39:40 +0000
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HX7-000000055K1-2G6X
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 23:39:39 +0000
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-41710377bf6so1696493fac.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Mar 2026 16:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773704376; cv=none;
        d=google.com; s=arc-20240605;
        b=HtYfvwp43trNk3WoWgC8e/25htv+oC6jAtoPtV/UHC5kONy9pt0iw0OIGs/7N9meBj
         BrcchLkIRZXX3hGy4VxpJfLMoVNQsu5YvZO+k+VE/CSDAHNJv9BhRV7R/ze5QL8giccO
         cfJoCpDmYNOYjwRukKduPOYQg+iObX7HAgD55UYLBBOADjE3bmMIDqto2dS1YrUm8XL1
         r2fHTttnmrrpfJJaQIr4CvyQ9kf0f2NxFtt0yhOyObexmiY4ggs+JpfpvsKRneE3BDJ/
         zSNJSdJk/sZhR/mmUxIFNzeDmg6izrzOXasDy8yGc13gZyVcNuVMpwaq65B4o4RQobyT
         J50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pX3IZwbQWIREe0cd2yZ6WTCN0aV+1yG3Zml24cd+TQU=;
        fh=o6vgLiCt95qKRxlTwt3lVVDU8rGP4Hj2AAlMkumpcL0=;
        b=BHqoTF/ufEFsEu+qtPu8z2hwFqfHgArkYI2y6G60z10r62rADgECKFD6wie1tKICRm
         FFSbo3ujAVuEFycFkPXbTSBOaG3SErR5937oPwPRrDUkLyxK8YOUi8Gp8IA8ibVmjUGn
         JaUyFhYUjbSdvYWiE7tNpDgHpLcw20bS7KSSIwrAo/o8stoe8hYKSOtIpcd11MkT5axB
         PCE6c/4QkniznHdBWHBzG93fmCoqGw3FoXoqN0/HEKVjrKXA++/MlvNhH9Lwt4nWak57
         x3XByrVKrfMoeBUcGrYd7XYI/LYJ+XqZZuAXu2T0HmbRlhvkO6CcfaRk5Rdm2Wi6z88B
         v9OQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773704376; x=1774309176; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX3IZwbQWIREe0cd2yZ6WTCN0aV+1yG3Zml24cd+TQU=;
        b=Mw79Yad+Xc6boR5OhgTtYLkBmEmZCjs7Jw3S9VsEtG16tKk1cJeyAj74AYU2yJsCP1
         MeOU8i9npP9xBMBeswgchwLo3Fg2gFwchs/1dn5PBaE5h9Kvct3HfOSv23JS5+U8IKPp
         9OwHhm4TfVQcXfwqi2/yqhP9Hj53/r50VGUPD12r5HvzjkG98Glb9rAKR89AsSUvDEez
         qs94E1MbLMGmN4fSsD/eS2o41zp3/GYkWkShUc/jVOmEU3J6ZkMA8Utc6m4Q4cwbSHHc
         BTB3splbu30hIvvZkQisHngrehkfTdt2eXgfxYnk16LfklDzLJNJm1LgUeXkogosxED3
         /wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773704376; x=1774309176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pX3IZwbQWIREe0cd2yZ6WTCN0aV+1yG3Zml24cd+TQU=;
        b=jEzG/HlHY6BpPo66hLgygs6P5q5P438zxWeAt+/wBst9GoBV5+FKcn1j7mzwG4pTXc
         gUny5QhrsBqjY5S/kJBKxERKDgKUPgq5+TVnhGZsKDPyTSDK50jPv/HvdAM1gkNXCW5J
         CV8ajYHEt67CpcbP1wG8mGC5LVLpXICuHvcKTX8nmxDY9lQwIlAjJm9RAKEcC6mdaRvp
         76Ii0OZN70E1LZIUE9aSdCWtQFP+JdhkhamBY30DYYQ0OdJA45wGqRtFWqLb1T241qo+
         471sn8TGFYdo6RstC7bU6qh/tCv8EVJTvWmypOKWVlgxrc3U8Me6AR8BeD3UGqU8WiYx
         WT/g==
X-Forwarded-Encrypted: i=1; AJvYcCVxLd/UKCZGyFu5txIbtUDZV09MPlp+tkrH+UynvELx+Llj9qnUXkkHKLhX7JZr0hXQstM2T1yiApP9@lists.infradead.org
X-Gm-Message-State: AOJu0YxFZIddgcB9RpsrbpwQdZtM4CrU7gfMnrjkkhGwZZ6l/u8lvr8h
	SG6gPn9e8YeV8SqWoUHyj1UltCXaSKqZAiw/Rtjl0H3hXLpqtOwjtJvQtESYRzcGLOLjYe76FJr
	NQC2SUm31qwyPIEL9QcMU23W8S+4F8eMYqXxf9RBDEg==
X-Gm-Gg: ATEYQzxbMMb8MPf6T0iaHFdt96Y82M69yYeEwwXFWKWzbZjUmYldlmxJof9JhD1LWL7
	u5TYntimf0ECzmbYYqrX5evJAin24jbXPB8u0Ij730w1mblkJMkVZwI5xTBEP6J6AOBEs0eYHLh
	HkUoa55soFQzna5ecWai59YQI+B3i5xuhM1th5yJpJfc/moqVw27ZV9/tzTR7EULlyBW/Y//Phm
	/BbLWVn+Z1z/ImNmfe647lbOgScqk+2MP9C7gm/gHy871Z5UzIjpgv3F8RIt+cJWmerCQfgEpQ5
	El3c1SNl
X-Received: by 2002:a05:6808:1809:b0:467:17f3:68b6 with SMTP id
 5614622812f47-46757672b91mr6527707b6e.8.1773704376036; Mon, 16 Mar 2026
 16:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260302172914.2488599-1-csander@purestorage.com>
 <20260302172914.2488599-4-csander@purestorage.com> <aagKTanM5Az9UDsJ@fedora>
 <CADUfDZozycFBPX0kH=22Gda7njM3xVmL=Cy=zCq6cfXY8JH_dw@mail.gmail.com>
 <a6591d03-3707-4f1c-b1fa-49f010f98d53@kernel.dk> <CADUfDZp0shyZ5FqfEcwbi0tHXOFqwqZKRvwQW=heR-yvaOaw0Q@mail.gmail.com>
 <aauO72ocnZRhJkiA@fedora> <7dfb5a9b-9af2-4463-b9a1-0eb680fd6c47@kernel.dk>
In-Reply-To: <7dfb5a9b-9af2-4463-b9a1-0eb680fd6c47@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 16 Mar 2026 16:39:25 -0700
X-Gm-Features: AaiRm50nhenZoBbLC8Sk9TzZIBg4dRriB4JHlfVxfFsnUKJQpFv4BSA4wVnHWLg
Message-ID: <CADUfDZpJjncxh1URmNkAsuhBjapFY3-MRfDas8rfBiyh8Hi3GQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] io_uring: count CQEs in io_iopoll_check()
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_163937_638279_77EAD5E3 
X-CRM114-Status: GOOD (  40.18  )
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

On Mon, Mar 16, 2026 at 3:11=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/6/26 7:35 PM, Ming Lei wrote:
> > On Fri, Mar 06, 2026 at 05:38:15PM -0800, Caleb Sander Mateos wrote:
> >> On Wed, Mar 4, 2026 at 8:29?AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>> On 3/4/26 8:46 AM, Caleb Sander Mateos wrote:
> >>>> On Wed, Mar 4, 2026 at 2:33?AM Ming Lei <ming.lei@redhat.com> wrote:
> >>>>>
> >>>>> On Mon, Mar 02, 2026 at 10:29:12AM -0700, Caleb Sander Mateos wrote=
:
> >>>>>> A subsequent commit will allow uring_cmds that don't use iopoll on
> >>>>>> IORING_SETUP_IOPOLL io_urings. As a result, CQEs can be posted wit=
hout
> >>>>>> setting the iopoll_completed flag for a request in iopoll_list or =
going
> >>>>>> through task work. For example, a UBLK_U_IO_FETCH_IO_CMDS command =
could
> >>>>>> call io_uring_mshot_cmd_post_cqe() to directly post a CQE. The
> >>>>>> io_iopoll_check() loop currently only counts completions posted in
> >>>>>> io_do_iopoll() when determining whether the min_events threshold h=
as
> >>>>>> been met. It also exits early if there are any existing CQEs befor=
e
> >>>>>> polling, or if any CQEs are posted while running task work. CQEs p=
osted
> >>>>>> via io_uring_mshot_cmd_post_cqe() or other mechanisms won't be cou=
nted
> >>>>>> against min_events.
> >>>>>>
> >>>>>> Explicitly check the available CQEs in each io_iopoll_check() loop
> >>>>>> iteration to account for CQEs posted in any fashion.
> >>>>>>
> >>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >>>>>> ---
> >>>>>>  io_uring/io_uring.c | 9 ++-------
> >>>>>>  1 file changed, 2 insertions(+), 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> >>>>>> index 46f39831d27c..b4625695bb3a 100644
> >>>>>> --- a/io_uring/io_uring.c
> >>>>>> +++ b/io_uring/io_uring.c
> >>>>>> @@ -1184,11 +1184,10 @@ __cold void io_iopoll_try_reap_events(stru=
ct io_ring_ctx *ctx)
> >>>>>>               io_move_task_work_from_local(ctx);
> >>>>>>  }
> >>>>>>
> >>>>>>  static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned int =
min_events)
> >>>>>>  {
> >>>>>> -     unsigned int nr_events =3D 0;
> >>>>>>       unsigned long check_cq;
> >>>>>>
> >>>>>>       min_events =3D min(min_events, ctx->cq_entries);
> >>>>>>
> >>>>>>       lockdep_assert_held(&ctx->uring_lock);
> >>>>>> @@ -1227,34 +1226,30 @@ static int io_iopoll_check(struct io_ring_=
ctx *ctx, unsigned int min_events)
> >>>>>>                * the poll to the issued list. Otherwise we can spi=
n here
> >>>>>>                * forever, while the workqueue is stuck trying to a=
cquire the
> >>>>>>                * very same mutex.
> >>>>>>                */
> >>>>>>               if (list_empty(&ctx->iopoll_list) || io_task_work_pe=
nding(ctx)) {
> >>>>>> -                     u32 tail =3D ctx->cached_cq_tail;
> >>>>>> -
> >>>>>>                       (void) io_run_local_work_locked(ctx, min_eve=
nts);
> >>>>>>
> >>>>>>                       if (task_work_pending(current) || list_empty=
(&ctx->iopoll_list)) {
> >>>>>>                               mutex_unlock(&ctx->uring_lock);
> >>>>>>                               io_run_task_work();
> >>>>>>                               mutex_lock(&ctx->uring_lock);
> >>>>>>                       }
> >>>>>>                       /* some requests don't go through iopoll_lis=
t */
> >>>>>> -                     if (tail !=3D ctx->cached_cq_tail || list_em=
pty(&ctx->iopoll_list))
> >>>>>> +                     if (list_empty(&ctx->iopoll_list))
> >>>>>>                               break;
> >>>>>>               }
> >>>>>>               ret =3D io_do_iopoll(ctx, !min_events);
> >>>>>>               if (unlikely(ret < 0))
> >>>>>>                       return ret;
> >>>>>>
> >>>>>>               if (task_sigpending(current))
> >>>>>>                       return -EINTR;
> >>>>>>               if (need_resched())
> >>>>>>                       break;
> >>>>>> -
> >>>>>> -             nr_events +=3D ret;
> >>>>>> -     } while (nr_events < min_events);
> >>>>>> +     } while (io_cqring_events(ctx) < min_events);
> >>>>>
> >>>>> Before entering the loop, if io_cqring_events() finds any queued CQ=
E,
> >>>>> io_iopoll_check() returns immediately without polling.
> >>>>>
> >>>>> If the queued CQE is originated from non-iopoll uring_cmd, iopoll r=
equest
> >>>>> will not be polled, may this be one issue?
> >>>>
> >>>> I also noticed that logic and thought it seemed odd. I would think
> >>>> we'd always want to wait for min_events CQEs (and iopoll once even i=
f
> >>>> min_events is 0). Looks like Jens added the early return in commit
> >>>> a3a0e43fd770 ("io_uring: don't enter poll loop if we have CQEs
> >>>> pending"), perhaps he can shed some light on it?
> >>>
> >>> I don't  recall the bug in question, it's been a while... But it alwa=
ys
> >>> makes sense to return events that are ready, and skip polling. It sho=
uld
> >>> only be done if there are no ready events to reap.
> >>
> >> Ming, are you okay with preserving that behavior in this patch then? I
> >> guess there's a potential fairness concern where REQ_F_IOPOLL requests
> >> may not be polled for some time if non-REQ_F_IOPOLL requests continue
> >> to frequently post CQEs.
> >
> > IMO, the fairness may not a big deal given userspace should keep pollin=
g
> > if the iopoll IO isn't done.
>
> I think so.
>
> > But forget to mention, if non-iopoll CQE is posted and ->cq_flush becom=
es
> > true, io_submit_flush_completions() may not get chance to run in case o=
f
> > the early return.
> >
> > Maybe something like below is needed:
> >
> > @@ -1556,8 +1556,10 @@ static int io_iopoll_check(struct io_ring_ctx *c=
tx, unsigned int min_events)
> >          * If we do, we can potentially be spinning for commands that
> >          * already triggered a CQE (eg in error).
> >          */
> > -       if (io_cqring_events(ctx))
> > +       if (io_cqring_events(ctx)) {
> > +               io_submit_flush_completions(ctx);
> >                 return 0;
> > +       }
>
> We should probably experiment with this a bit, I don't think it's a
> showstopper for merging this.

I don't think it's an issue currently. Any path that posts CQEs
(synchronously during submit, from task work, or iopoll) already calls
io_submit_flush_completions()/__io_submit_flush_completions(). In
other words, there's no way to reach this io_cqring_events() branch
without the CQEs having already been flushed. If a new path were added
in the future that could post CQEs outside of those contexts, it would
of course need to ensure io_submit_flush_completions() is called after
posting the CQEs.

>
> Caleb, I think we can stage this for 7.1 and see how it goes.

Sounds good, thank you.

--Caleb

