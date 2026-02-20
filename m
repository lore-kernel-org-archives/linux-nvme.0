Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF38C531F8
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1MENmG+bEvSD0SFxF0bGDPSMmGPUDfTcgs9gxNo5RiQ=; b=ZIePUuIZMaXN8NarwH2nDjbnSg
	GNxpcEjZoYke31mapX8GPSy1pbSsN5wW+eyBn/VeGJDZkbvuyzqHdQNl+Bfj1f9g7il9l0CfiStHk
	xOOQ1Y9d0sgXoYtQhjNd+tfJOt0TGcGutC4AmrLCvHwq+oDEfjdBbbjt+/IseyO6tGWyhPLHDAuaw
	D9p7u8+/+XbxK0ETQUpFMrx4h3lYTViSTfcOzzUotNtnM7v7n5TUKK96mBWgxtzWipdHCN+QpIyOW
	+ZLRtoaHjdHtJOUAssuA8TqBeLCiRKPcziI/m1oQua3WURPnIGvtdKn8bpyD7Q/QXDhsGLiB7JvZT
	pt7rBCLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtFzC-0000000D22f-2BKT;
	Fri, 20 Feb 2026 02:11:18 +0000
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtFzA-0000000D21q-1Qph
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 02:11:17 +0000
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-948bf40406bso586157241.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 18:11:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771553475; cv=none;
        d=google.com; s=arc-20240605;
        b=IMypXdPXUWmb+TBLHT9dew/98lAx2ntW/HEdIM6uhMfRvZZYqP8WxhL8TT0RLzFaHx
         LYIH9cjTabFnf0ul6iPxxpW1992EoHidvU4gpI/Wt8x8B4MungaF2wRrN0xeFV3rNr0A
         o0Ui1GqOSOLViKYures9fQd6WcCVMFaheIX+b3hZmfZePyq/y7pAo25qFaAlap2F2n2a
         6BjJV5et5qOM99HQr2uuveSrLfX3z6JB4lT2mA3+iap0cc3eK0ee+IGcROUd1oWHwAbR
         g3JxwFFr6ERzy4k07GsvEab1BCBZ9UND9zefey2lT0R/fEp3hwk5yCAapzNAWBm2x++N
         8xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MENmG+bEvSD0SFxF0bGDPSMmGPUDfTcgs9gxNo5RiQ=;
        fh=dlyxtKBybaMvMx0XC5QbIQA6+JPyGvfxHmUpKO9ZEAw=;
        b=DOKyNw7SKQYU6DH9V+sgPlmRKyC35jbBeuw0i2f51Ed3g1XXpBQKb854Q9eAD6BTjQ
         Baoi+yoyzEBgMUfal0LSpnRXZLw18Pe4gf2YuB/Fn2OWxUjnd9C+jSPVWPnKxf2Ede/y
         35d3/FipkaE7ZFcW4sAtJRDfjMRQpEjN18iZaGi0G6hjObObK/6veruIK7LoW4meiy3F
         RN1vW1z15+9cV4rFtK0VVtv9gEhuv8aTHoiI0Lck3NWTRHa58FgPQD4GPHZRndkhJEFs
         GbSsTbvUaaWPKe5ri2LJh6H96nWQPC1P3FlPi3V0ykmGiCTFt+BZZsy8IlcDZF3dKd8C
         keyQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771553475; x=1772158275; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MENmG+bEvSD0SFxF0bGDPSMmGPUDfTcgs9gxNo5RiQ=;
        b=eC7Is0qzn3gaiVwdtsl2JDO0N3yTlEUUV4g7QzjjzBuGGHsXbSId+9kPbOz1g6DQyZ
         ROhOpBlvbp7TP0cTvwSYk3TxSwl1F5jfL5SaQePhltXvx9aSAAMMq0qAsnwG63D+YgnO
         SF+GRy+dfulk/sRMpDybQ917ykWDunccGFRDvYFjzEkH1832E0SQCKHOkeskoyg3xQgn
         rkCkngLOrVip0NTD913E/C+H57FU6iQNyUsBh/uMtsAZLCae37Ctu4kSb4fMZkyUFlz+
         lHvJZiFiQbMTn+N3zcZmC4IH0kie7HpJPTB9KjXk3uUfai+PCtVrBkZi9W/pR+nFgw+s
         A5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771553475; x=1772158275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MENmG+bEvSD0SFxF0bGDPSMmGPUDfTcgs9gxNo5RiQ=;
        b=aelv5hh7xF3c/gUQwOMvFRbca17YayU0JqVY7mb2EEIIA9gj/OTYZOMCemgV1amrwB
         GxeHJRhPkIiaUVn2hhGFTXeZRyhLFmDxNGMo2jBQCf0a0rwqcUDDIC5K+K6G8rQi8K2b
         8A97qKmqxEwdsJ1l4D4tcAghjiLNidFBQbNM8f3xcGjrUITHZGLDanr4Nj5kY4uajina
         fYgEBRJeLvfVIp1HNAN9FH7MzWub2vgNc5vVoWgRuGFIimDJz24QDDNjgffgpDUREi/R
         kPA6X0K6KlZUjmLpVeKDEDM9LZbXLsdbXGtqPpTrlSijOdYZ/BVArIAWkYmhIuwdo3aJ
         ZN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUbYWCAzjcGs45gLWCOsqJ914lfcoFnYz7EKEaUcT6XUAmKkkKAIil3Bzq8FMejdX9CuDi22356KTN@lists.infradead.org
X-Gm-Message-State: AOJu0Yy32ltqkJcjirYqYBQ9X46FbQJzGAsh7TWYeW49+h929rMkcaWt
	hCtMozrZZXDslqfGeQYIsiN5SwQi9x2oltZYDx3ZQfwoXq9sOPqDwdxOBBxts/UPMRGcHWPPLSQ
	fUen7okF8t2Y9jRFwi5QENFcz7PVubrzz0aekbZ1Hzg==
X-Gm-Gg: AZuq6aKUqOB4kyTfAH3JOkqCmhgZg6E21I/SKCCt7EID5Ob4JCwZO3nL16nSYjTpJOc
	miIV+W1qAr7zziUyEE6+Lw2obcJ/NymR1viwRlLq4dyLcMdeIKGgcMSk1gxVo6vL30RLiCv0JG1
	5U9u4b6n4gS8tLpvfn1a7ljLIf9verk19Kp/Oy2xJnwVBgmyFS3DvetEcElGW1UOlMndgh3oZPz
	kI2/yNTdysJCHZ+iHeCNtbuj1Q33Oa0cPpIUnTI51W+MO1YZdUDiw/K9nXY/UurASMpdlwlrydM
	mgyw/505YRVBjFThG4wRghx/j3cPLRDpCM5O7Pa+sgzS3exNoZRq+RZ6G6eUCQFNMuzb
X-Received: by 2002:a05:6102:38d3:b0:5f5:773d:88bb with SMTP id
 ada2fe7eead31-5fe2af25116mr8094274137.28.1771553474611; Thu, 19 Feb 2026
 18:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-19-mkhalfella@purestorage.com> <9d6cf4f9-37d8-4704-bcc1-0b849ad28955@suse.de>
 <20260216184515.GH2392949-mkhalfella@purestorage.com> <3bad149e-a0fa-4377-9701-7b35ef6b5b88@suse.de>
 <20260217153530.GI2392949-mkhalfella@purestorage.com> <96ea8e82-ead3-498f-bb87-5b2809089950@gmail.com>
In-Reply-To: <96ea8e82-ead3-498f-bb87-5b2809089950@gmail.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 19 Feb 2026 18:11:03 -0800
X-Gm-Features: AaiRm50uF_ZFRb16GFpksJeZQ3mWNEQzGpDPUHhFovgKAEwhvDk6FW90kGB_QrU
Message-ID: <CAPpK+O1w7G7XwNAwvAn9pp_U7itwodYSFe=u87xhdpNWV2CxtA@mail.gmail.com>
Subject: Re: [PATCH v3 18/21] nvme: Update CCR completion wait timeout to
 consider CQT
To: James Smart <jsmart833426@gmail.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Hannes Reinecke <hare@suse.de>, 
	Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_181116_402468_5D359A83 
X-CRM114-Status: GOOD (  47.18  )
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

On Thu, Feb 19, 2026 at 5:22=E2=80=AFPM James Smart <jsmart833426@gmail.com=
> wrote:
>
> On 2/17/2026 7:35 AM, Mohamed Khalfella wrote:
> > On Tue 2026-02-17 08:09:33 +0100, Hannes Reinecke wrote:
> >> On 2/16/26 19:45, Mohamed Khalfella wrote:
> >>> On Mon 2026-02-16 13:54:18 +0100, Hannes Reinecke wrote:
> >>>> On 2/14/26 05:25, Mohamed Khalfella wrote:
> >>>>> TP8028 Rapid Path Failure Recovery does not define how much time th=
e
> >>>>> host should wait for CCR operation to complete. It is reasonable to
> >>>>> assume that CCR operation can take up to ctrl->cqt. Update wait tim=
e for
> >>>>> CCR operation to be max(ctrl->cqt, ctrl->kato).
> >>>>>
> >>>>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> >>>>> ---
> >>>>>     drivers/nvme/host/core.c | 2 +-
> >>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>>>> index 0680d05900c1..ff479c0263ab 100644
> >>>>> --- a/drivers/nvme/host/core.c
> >>>>> +++ b/drivers/nvme/host/core.c
> >>>>> @@ -631,7 +631,7 @@ static int nvme_issue_wait_ccr(struct nvme_ctrl=
 *sctrl, struct nvme_ctrl *ictrl)
> >>>>>           if (result & 0x01) /* Immediate Reset Successful */
> >>>>>                   goto out;
> >>>>>
> >>>>> - tmo =3D secs_to_jiffies(ictrl->kato);
> >>>>> + tmo =3D msecs_to_jiffies(max(ictrl->cqt, ictrl->kato * 1000));
> >>>>>           if (!wait_for_completion_timeout(&ccr.complete, tmo)) {
> >>>>>                   ret =3D -ETIMEDOUT;
> >>>>>                   goto out;
> >>>>
> >>>> That is not my understanding. I was under the impression that CQT is=
 the
> >>>> _additional_ time a controller requires to clear out outstanding
> >>>> commands once it detected a loss of communication (ie _after_ KATO).
> >>>> Which would mean we have to wait for up to
> >>>> (ctrl->kato * 1000) + ctrl->cqt.
> >>>
> >>> At this point the source controller knows about communication loss. W=
e
> >>> do not need kato wait. In theory we should just wait for CQT.
> >>> max(cqt, kato) is a conservative guess I made.
> >>>
> >> Not quite. The source controller (on the host!) knows about the
> >> communication loss. But the target might not, as the keep-alive
> >> command might have arrived at the target _just_ before KATO
> >> triggered on the host. So the target is still good, and will
> >> be waiting for _another_ KATO interval before declaring
> >> a loss of communication.
> >> And only then will the CQT period start at the target.
> >>
> >> Randy, please correct me if I'm wrong ...
> >>
> >
> > wait_for_completion_timeout(&ccr.complete, tmo)) waits for CCR operatio=
n
> > to complete. The wait starts after CCR command completed successfully.
> > IOW, it starts after the host received a CQE from source controller on
> > the target telling us all is good. If the source controller on the targ=
et
> > already know about loss of communication then there is no need to wait
> > for KATO. We just need to wait for CCR operation to finish because we
> > know it has been started successfully.
> >
> > The specs does not tell us how much time to wait for CCR operation to
> > complete. max(cqt, kato) is an estimate I think reasonable to make.
>
> So, we've sent CCR, received a CQE for the CCR within KATO (timeout in
> nvme_issue_wait_ccr()), then are waiting another max(KATO, CQT) for the
> io to die.
>
> As CQT is the time to wait once the ctrl is killing the io, and as the
> response indicated it certainly passed that point, a minimum of CQT
> should be all that is needed. Why are we bringing KATO into the picture?
Good point.

>
> -- this takes me over to patch 8 and the timeout on CCR response being KA=
TO:
> Why is KATO being used ? nothing about getting the response says it is
> related to the keep alive. Keepalive can move along happily while CCR
> hangs out and really has nothing to do with KATO.
>
> If using the rationale of a keepalive cmd processing - has roundtrip
> time and minimal and prioritized processing, as CCR needs to do more and
> as the spec allows holding on to always return 1, it should be
> KATO+<something>, where <something> is no more than CQT.
Well, CCR was supposed to decide to fail at some time less than CQT
on the controller.  But I see your reasoning.  Using the normal admin
timeout time would probably also work.

> But given that KATO can be really long as its trying to catch
> communication failures, and as our ccr controller should not have comm
> issues, it should be fairly quick. So rather than a 2min KATO, why not
> 10-15s ?
Ugh.  2 minute KATO?  Have you seen that in the field?  I've
seen 5-30 seconds.

> This gets a little crazy as it takes me down paths of why not
> fire off multiple CCRs (via different ctlrs) to the subsystem at short
> intervals (the timeout) to finally find one that completes quickly and
> then start CQT.
This is an interesting idea.  That said, there was concern in the
group that controllers would have a low CCRL (like, 4).  And I would
expect some paths down to be correlated (when connected to
an HA pair subsystem).

I was not sure why the expected limit would be low; the
implementation I am considering should have a rather large limit,
so I like your idea.

> And if nothing completes quickly bound the whole thing
> to fencing start+KATO+CQT ?
Well, 2x or 3x KATO.

Sincerely,
Randy Jennings

