Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA58CF6BE4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 02:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQKylO5hhGGWP1igL13Od7cuF5VcgUr4nnyhlhBL60w=; b=FnMUSJ0m/1+HPEqdAZ09sPO1Il
	cnVBYkoBuMrR3IgTgeLOVZvuOW5BG3fehy6gO4VHDO33ea6E06V/hsGpXQZGRjRVDPqEz368tcbBQ
	L2GLJMS0c1AynJ6d2aPXZLprucY7x2QWbx/7yNh4vDTH3qAgJbY7CMghqKg1zBA0zosX3VXZpLJxK
	fkyBOItsqCa1DTwgzURcurECYUBzTbaZL2+QSV+NUqviKsg80ZRVX/bjAPvqiitjTi+5IVC7tuQFg
	V3gl4gWFlQ6av5fAMhm0TmqR7bs8crY73RvLuU7TbtnjUeos/2qd5mL0ZtJAP9Yu6pm2qgQXUqT8E
	csJTPRCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJkX-0000000E6Q2-3UcP;
	Wed, 07 Jan 2026 02:58:17 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJkT-0000000E6Pg-42lS
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 02:58:15 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-93f523bba52so322839241.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 18:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767754692; x=1768359492; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQKylO5hhGGWP1igL13Od7cuF5VcgUr4nnyhlhBL60w=;
        b=d/57Ctysw2ZPJADnd9j5Zm0JUHzcYvha/gBmOm181Ehx70fGk9r/XC7nTOzgkHvM4C
         GYKR+nWLA0IMbI/tf8VEpBemngn/ojhFzXPW56GW5BzpfXX3OEqn5XK6a1zvk1gTwFeJ
         P+Q55SRxpqsC5Z1F0SXbPfUDfaMX+9VxO9gmox0xF2Ts2GkjcFeSaMbnXbCuljdCrdiM
         x5etAtw06ZnbV08NVcQfveWAuWR0vTMXXbrFQlo3MxBI/d0Fnf+OXU+f7f7dYCf7aqse
         hUw0Qfhvt1dVJGaK89WOB8Kx/iGVeVh35F9OFHdDO203kyaQ4D79cH1JU89gwLuHKf37
         zeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767754692; x=1768359492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQKylO5hhGGWP1igL13Od7cuF5VcgUr4nnyhlhBL60w=;
        b=uW834r6n7g/DLIoWkWk88/CtLksym3bU5NXT1VPQTVz4Oag+p1ZliniOycLcj0Ht43
         IEcPBoRzUca9I4nnFyfAVDCbkk7rk/5/D8cxnddId+0CacsUsQb0fmnKQmC0yUrWSrza
         0aoU+nS2tq9//Z+ZJp//b1o545VhIKOOLBAb+as/QMykMxxBGQeoiiO7gQkO5b70L0Px
         Ug21JmT7VYu3jUwBXRFWb8DwuGb2lLPgT+wmk0tV9KJuszW8bLtrhGuNY1eotuSmdnRO
         t/HnaKNczGbw0Fxz/jA0xf6SZpgmeQAdSX9oTvFcrUYojf3DH4hDWdAOo3Qj54heQoE/
         oM7g==
X-Forwarded-Encrypted: i=1; AJvYcCWFDtAmmCSKZA4eAB4OJIg9fonyYTEkdppomxrHtsMRmPbhQt3Nrq0PckPcut4ejOOlIyxJu75K/taa@lists.infradead.org
X-Gm-Message-State: AOJu0YzP/RKZ3HHjNpOjQ3n4+gpNN2pOG0lOGoWOyGf1aZgXei9OBgey
	6WfBhitwPY3fR6TPlj9ydUYX627NAGTkRbUg1RbSzDLSdMjDVAHn/z9YIzwlIwLPJ+4ehX4KM+T
	+ztV32ki+06OX4Gdgwp2q/T4IxI3qyYb5iT1T3tH/7Q==
X-Gm-Gg: AY/fxX4rSBdYzeFBS0ClFO5Gm5zzeN36xyKNiK4fdPqGgQAkiOSZre+dcKs0ZjbcUkw
	ilmI3j49tA6dJuCRDSnDpD2cge8rqS6iRv1A6iRdnk9qencwGJcjNo1FmlA/y3C5UT9y0gC3Ex7
	vKn0gjlx6VooYNtwwFIOX9q1EhBFCHq/GVc+F1r+FYlkgE0JUt5+dR5NZc9eUYJgmwBY8+sWSzl
	TYBAJ9Mr0lcQKwKcdRVfPoU/OK8+r6Y/U00juGp2eZ/yqthhJB3qESM21FJNiH8TbSQBbs=
X-Google-Smtp-Source: AGHT+IHfOZRLy7DMEgvpSNSop/KUxbXsgwlpE2Vc3o1pPZnsLjGuYseYTCmMrx3GfcFuH9UqxL4a0Chw7M6Fn5CKhIA=
X-Received: by 2002:a05:6102:3ed0:b0:5dd:c53b:75cc with SMTP id
 ada2fe7eead31-5ec8cc64799mr581001137.13.1767754691876; Tue, 06 Jan 2026
 18:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-6-mkhalfella@purestorage.com> <13c2bf9c-6eac-4c48-b12c-f76e86c8ef32@grimberg.me>
 <20251225181313.GC8129-mkhalfella@purestorage.com> <eaf73b5a-a438-4afe-a76e-148a7d9744ef@grimberg.me>
 <20251231220020.GK3864520-mkhalfella@purestorage.com> <06f365d8-9861-4c22-a226-06c8c3b2cc5e@grimberg.me>
In-Reply-To: <06f365d8-9861-4c22-a226-06c8c3b2cc5e@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 6 Jan 2026 18:58:00 -0800
X-Gm-Features: AQt7F2rcDV0gLPkZ_iWRgpkqTre9tZeMc9cWHUcCTjTlsoZr_pMwPIzn-_WARp0
Message-ID: <CAPpK+O228GtTb_6QOovLkY=5-yxFdJmVfvq4P3S8+M-B6UYZZA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_185814_186388_BA48C59E 
X-CRM114-Status: GOOD (  53.90  )
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

On Sun, Jan 4, 2026 at 1:09=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wro=
te:
> On 01/01/2026 0:00, Mohamed Khalfella wrote:
> > On Sat 2025-12-27 11:48:49 +0200, Sagi Grimberg wrote:
> >> On 25/12/2025 20:13, Mohamed Khalfella wrote:
> >>> On Thu 2025-12-25 15:23:51 +0200, Sagi Grimberg wrote:
> >>>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> >>>>> Send an AEN to initiator when impacted controller exists. The
> >>>>> notification points to CCR log page that initiator can read to chec=
k
> >>>>> which CCR operation completed.
> >>>>>
> >>>>> Signed-off-by: Mohamed Khalfella<mkhalfella@purestorage.com>
> >>>>> ---
> >>>>>     drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
> >>>>>     drivers/nvme/target/nvmet.h |  3 ++-
> >>>>>     include/linux/nvme.h        |  3 +++
> >>>>>     3 files changed, 28 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.=
c
> >>>>> index 7dbe9255ff42..60173833c3eb 100644
> >>>>> --- a/drivers/nvme/target/core.c
> >>>>> +++ b/drivers/nvme/target/core.c
> >>>>> @@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_=
struct *work)
> >>>>>           nvmet_async_events_process(ctrl);
> >>>>>     }
> >>>>>
> >>>>> -void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>>> +static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, =
u8 event_type,
> >>>>>                   u8 event_info, u8 log_page)
> >>>>>     {
> >>>>>           struct nvmet_async_event *aen;
> >>>>> @@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl =
*ctrl, u8 event_type,
> >>>>>           aen->event_info =3D event_info;
> >>>>>           aen->log_page =3D log_page;
> >>>>>
> >>>>> - mutex_lock(&ctrl->lock);
> >>>>>           list_add_tail(&aen->entry, &ctrl->async_events);
> >>>>> - mutex_unlock(&ctrl->lock);
> >>>>>
> >>>>>           queue_work(nvmet_wq, &ctrl->async_event_work);
> >>>>>     }
> >>>>> +void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
> >>>>> +         u8 event_info, u8 log_page)
> >>>>> +{
> >>>>> + mutex_lock(&ctrl->lock);
> >>>>> + nvmet_add_async_event_locked(ctrl, event_type, event_info, log_pa=
ge);
> >>>>> + mutex_unlock(&ctrl->lock);
> >>>>> +}
> >>>>>
> >>>>>     static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl=
, __le32 nsid)
> >>>>>     {
> >>>>> @@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct n=
vmet_alloc_ctrl_args *args)
> >>>>>     }
> >>>>>     EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> >>>>>
> >>>>> +static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
> >>>>> +{
> >>>>> + lockdep_assert_held(&ctrl->lock);
> >>>>> +
> >>>>> + if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
> >>>>> +         return;
> >>>>> +
> >>>>> + nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
> >>>>> +                              NVME_AER_NOTICE_CCR_COMPLETED,
> >>>>> +                              NVME_LOG_CCR);
> >>>>> +}
> >>>>> +
> >>>>>     static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *=
ctrl)
> >>>>>     {
> >>>>>           struct nvmet_subsys *subsys =3D ctrl->subsys;
> >>>>> @@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(=
struct nvmet_ctrl *ctrl)
> >>>>>           list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) =
{
> >>>>>                   mutex_lock(&sctrl->lock);
> >>>>>                   list_for_each_entry(ccr, &sctrl->ccrs, entry) {
> >>>>> -                 if (ccr->ctrl =3D=3D ctrl)
> >>>>> +                 if (ccr->ctrl =3D=3D ctrl) {
> >>>>> +                         nvmet_ctrl_notify_ccr(sctrl);
> >>>>>                                   ccr->ctrl =3D NULL;
> >>>>> +                 }
> >>>> Is this double loop necessary? Would you have more than one controll=
er
> >>>> cross resetting the same
> >>> As it is implemented now CCRs are linked to sctrl. This decision can =
be
> >>> revisited if found suboptimal. At some point I had CCRs linked to
> >>> ctrl->subsys but that led to lock ordering issues. Double loop is
> >>> necessary to find all CCRs in all controllers and mark them done.
> >>> Yes, it is possible to have more than one sctrl resetting the same
> >>> ictrl.
> >> I'm more interested in simplifying.
> >>
> >>>> controller? Won't it be better to install a callback+opaque that the
> >>>> controller removal will call?
> >>> Can you elaborate more on that? Better in what terms?
> >>>
> >>> nvmet_ctrl_complete_pending_ccr() is called from nvmet_ctrl_free() wh=
en
> >>> we know that ctrl->ref is zero and no new CCRs will be added to this
> >>> controller because nvmet_ctrl_find_get_ccr() will not be able to get =
it.
> >> In nvmet, the controller is serving a single host. Hence I am not sure=
 I
> >> understand how multiple source controllers will try to reset the impac=
ted
> >> controller. So, if there is a 1-1 relationship between source and impa=
cted
> >> controller, I'd perhaps suggest to simplify and install on the impacte=
d
> >> controller
> >> callback+opaque (e.g. void *data) instead of having it iterate and the=
n
> >> actually send
> >> the AEN from the impacted controller.
> > A controller is serving a single path for a given host. A host that is
> > connected to nvme subsystem via multiple paths will have more than one
> > controller. I can think of two reasons why we need to support resetting
> > an impacted controller from multiple source controllers.
> >
> > - It is possible for multiple paths to go down at the same time. The
> >    first source controller we use for CCR, even though we check to see =
if
> >    LIVE, might have lost connection to subsystem. It is a matter of tim=
e
> >    for it to see keepalive timeout and fail too. If CCR fails using thi=
s
> >    controller we should not give up. We need to try other paths.
>
> But the host is doing the cross-reset synchronously... it waits for
> kato for a completion of the reset, and then gives up, its not like it
> is sitting there waiting for the AEN...
The Linux host as Mohamed has implemented it is doing the CCR
synchronously.  I expect most hosts will also, until they time out one
controller because the connection might be dying, and that timeout
might come sooner than the target.  Controllers publish how many
outstanding CCRs they may be the source of, not how many
controllers they may be impacted controllers for.  However, it is my
understanding (correct me if I am wrong) that the Linux nvmet
implementation is primarily for testing the Linux nvme host
implementation.  Whatever limitations keep the nvmet code
simple can make sense, even if they do not in a production
system.

>
> Generally the fact that the spec states a capability/flexibility, it is
> still Linux's
> choice to choose weather to implement it. I'm trying to understand if we =
can
> simplify Linux host and controller in this non-trivial error recovery flo=
w.
>
> What is your expectation to happen in general? what are your expected
> kato/cqt
> values? how many attempts do we want the host to do?
For CQT, I see 30-60 seconds.  For KATO, I see 5-60 seconds.  I see
KATO skewing lower than it should because of the cost to reliably avoid
data corruption.

In general, I expect an HA-pair storage array to benefit most from
implementing this feature.  Often, a host would establish an association
over 4 paths, 2 to each HA-pair.  It is common for non-disruptive operation
for a member of the pair to go down for software upgrades or hardware
modifications while the other member stays up.  In this configuration,
2 paths go down when the member goes down.  The host has a 2 in 3
chance of picking a controller to which the host still has a connection.
Given the tremendous reduction in failover time (even with a timeout
on the CCR) and my perception of the complexity cost of a retry, I would
much rather make the host have a 100% chance of using CCR
successfully after a retry.

> > - Some nvme subsystems might support resetting impacted controller from
> >    a subset of controllers connected to the host. An array that has
> >    multiple frontend engines might not support resetting controllers
> >    across engines. In fact, TP8028 allows for subsystem to suggest to
> >    host to use another source controller in Alternate Controller ID
> >    (ACID) fied on CCR logpage (not implemente in this patchset).
>
> It is not a case though where the impacted controller will be reset from
> multiple
> source controller at the same time...
>
> I'd also say that if indeed there are subsystems that require specific
> controllers to do
> cross recovery, they won't be able to use this at all... Are there any
> such arrays?

There are certainly systems out there (striping, Ceph-like, or stretched to
support non-dispersed hosts) that have many more nodes than an HA-pair
and may have communication barriers that prevent nvme controllers from
being able to handle an CCR for another nvme controller. I still think they
would benefit from retrying a CCR to find a path that can succeed.

Sincerely,
Randy Jennings

