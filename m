Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB6CC44508
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1G5ncIGe+fb/Hn8cf/dLvLTLsXn/ZmK1FsivgSP9Ho=; b=UOQFEJHVxQb3R8YDapH1JoNj5t
	sPoXZUWiYLrN/pSMOnW8XLktxR//ebBejhzsl/L8NoO7m6Hok8SsxOIhWvebhmSFSl+R/UHWoFQpb
	wZ9Y1oh+Olam3MeEkXjoTnNRYEpBIZ1Kvhzb6RYfb4ui8yXF6wxoYeXCxcpDCbElGEBVg3otiZzyg
	kO0+yZYTT3pT+gsFnBcXsjjVEH/wX2YOVuP/fbnbdHrbzujqqdd7kn3V+B4MsHTv3fD/1+UBR0d8E
	41GXGUFRr6HOuiKchYKMeJXwWFg7MOEYEGTnDoE18qeItRQVaS6G9N134uq6Da8kvr4hGFTs3yuy9
	uWhTjQDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjffY-0000000CcyI-1R3Q;
	Tue, 14 Jul 2026 16:07:40 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjffT-0000000CcxH-0ion
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 16:07:38 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso6778077a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jul 2026 09:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045253; cv=none;
        d=google.com; s=arc-20260327;
        b=LGyGizDtA+fP+XwlBXP8xEtWAM2M6xTrn8NZWclJlHdWnZfiQK/AUvbBINQsxcCs1t
         Sg0dZQ/qUYe6+zjrDpG+7xVkyZocxwjlj7YT13tIKYqC+7IJvtfqY4SppqGxN+lxQoIY
         YeReSBw9ePuzFzf43WBre3aEGUY0UgmCg8KPeDFf92ob+FRXiMcaH8mG89p5OUCRkY/Y
         dhuc9tXKFMa8CtSHBpoNlQ9Qo+LvfxVet3SmE9/t+ZYfrGgSi6DcnmOQtWMmA/HRlsq4
         K6ZYIaDFZqgLoekxunGOKCNd8fsrRxJs+zXmmrDKgYEXGCwyK5nOKqudJlx2UdDWxmhd
         ChiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S1G5ncIGe+fb/Hn8cf/dLvLTLsXn/ZmK1FsivgSP9Ho=;
        fh=EJV5Z6mWqfJ7/ZhZdhKPNLKUtH9l2kvtOaSb5WRglzk=;
        b=G+qy4bBgXV5BnuSkHZTtlkzietEhlDSz4mPmTTiWhLvboSwYUE8RSuJxRsG7Y9OUz8
         slKf5iLAIR6/jA9cl26Oh5kjZaUDmD34Hn9L1ilC+PbLBTmo6dcD3woIyRIHj5WDsLA2
         BNz9q9+AnSN7/DmRVx8tOxnd43IAidBRIFijdCsFfBdY4ykcJGzawX5yT3wgc9FScXB4
         UQm0ZjGjE2JdiRJdxvEcVrJVxKW4i6dZ3EXysuiCvnu735En1KLhY7GkkC/dabvSARz1
         uvHr2QfaiW4WMl0IhY94P8C9ZU9oImEgY7luooGgQHcCTLpeXpqc+XizahXuExj/DjX2
         p+0A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784045253; x=1784650053; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1G5ncIGe+fb/Hn8cf/dLvLTLsXn/ZmK1FsivgSP9Ho=;
        b=gnVq+VLOq6loS8gEkmuGxppNXLb5einFWKT4Rt9W1QkfEgB1TXnVGZZLfegTzicQVs
         IjrYPAenQHYaSoN2Fj986+4ioPQqVcDcwbp8db+Jeu786Rl9uPW8nGTXwqDBq3Y9stvp
         RmLL2x8X2IO3zV/fhpyKSQSeQd5bB1/yVPyHphJ0pLWh2MQLh511cAYIuAk+UyIVmcNb
         0cFg95bV19CJTgwARDBlbqr4QvBdMLJNXG6Vu3WKSQ6zpz9miOaAYXs7x68CayWQCwid
         mC4pZU7e0C/Svk5H1BZRQuG7GbMvPZ5kRfef9SQEeo5pIEp6+JQXinbLHASr/poknnd4
         ANow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784045253; x=1784650053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1G5ncIGe+fb/Hn8cf/dLvLTLsXn/ZmK1FsivgSP9Ho=;
        b=DPsj6STkXqlwIA0WDmb2iW/WhPsV3UF5G4iosyyl8SUQpaq1EaDh6vNLlyiLZ3Sxy6
         v/fk/6q5Yg55oMD1XGoDQeZYWtEWihffJJZH2snL06antsUXJacFsYfIQ6Ycwe5CwiMK
         16CFGketcygtm6J7gCkwNPA0AlLAwMTy5NpdFFyWSqAKL7G5txh9T0CSL8QUlzdRZGNL
         NF0v4T0Fs4joojVMNIh5BMXDYUXdrmiIkU2KbFEqZEsp42a80Ivm8SZDAZlwmvL2JCFs
         TA889gQCZpkUhKBzS9pRKXM8eQSCwUaUJ7oPyFK8QxKKe2+ytcauDszAQlAD7yWQtcMJ
         hUig==
X-Forwarded-Encrypted: i=1; AHgh+RrZ+PMF0sWCrVJhFy/01Rup7ETP08n6Ynmc1TJWWEC767WNwMIqOTFzX+IuNZg/IioS4gGPURAGZYEp@lists.infradead.org
X-Gm-Message-State: AOJu0YwdeoBKwS2XOVBhHUW3bPS/ya3wx586MvVZwKUwVgyigfATISYI
	dxRe5T4kC6RtphH/Gqf6q1YQzyEnZGG1QMu8uaewxi9UUJL2Y069ZyQa/s/MplyPEyn9aLCt1b5
	uW6B/cfrI/g5WZ/s+XtXY1PxnyWc4pjQ=
X-Gm-Gg: AfdE7cmjuffjwqIlidrQflhmFGN5PMu0zBb0HKdTLQTj5fexGNu/29PdblKvrA41mU4
	3Srz6m9R1kcpJeY21qpjFmjtcN/bPmBc9KdpvSQrNqhfBLwj1kCZ4w7Xs8Bhy7WKzwYskpU3J+J
	vCEaLXpn8WLJ2tYfiq/WoH+W9jWi7liw6ypMrqzJ0LxKMTcpM0+ofQUjk7I9Z/LfDqOxby5ciUy
	lBMJ79scfaFNoFYHmWTwTGDDhhSKQymxeMTrvndS4Oq10aRxXQ9ouYGRR/J4iFMpWA3uNhB9rrj
	kHDS+gJnZzBBJGBCW4nCRGpeneTVTQ==
X-Received: by 2002:a05:6402:518c:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-69cd6c5e4b0mr1616839a12.5.1784045253021; Tue, 14 Jul 2026
 09:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260515185853.2761456-1-coshi036@gmail.com> <0938b6f8-8001-4fcf-95a4-327fa9077163@oracle.com>
 <ah7znSpPM-H-ACaV@kbusch-mbp> <ah752_DIQdr_LHaB@kbusch-mbp>
 <c6046eb2-9594-4355-9f4c-21a6f3bd8131@oracle.com> <539bb4aa-30a3-457c-8c77-c0d660376c3a@oracle.com>
 <CACd_6n1h6NW3DS1MDKkcr=r-uxGQ=HspMLN6TWtLc26Vct8sYQ@mail.gmail.com>
 <e4650024-1706-46b5-91f8-57f2c358fcd3@oracle.com> <CACd_6n2AZvgi1B8Vn8S6NwytDkqHmS=4z-1sxjmk+FPfWv_JMQ@mail.gmail.com>
 <1be7cde9-e065-4980-ade9-6efc9278c12d@oracle.com>
In-Reply-To: <1be7cde9-e065-4980-ade9-6efc9278c12d@oracle.com>
From: Chao S <coshi036@gmail.com>
Date: Tue, 14 Jul 2026 12:07:21 -0400
X-Gm-Features: AUfX_mzNeWM1y9pvn0DxxBWguFIC_NFd4sOomDPRoqzPG_HJHYVGrbFHkK5m-yM
Message-ID: <CACd_6n2pY0vHr9Lge9patRgNkBO-d8-nKV1fi3CYBu9ajmg3-w@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: core: reject invalid LBA data size from Identify Namespace
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>, Maurizio Lombardi <mlombard@arkamax.eu>, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_090736_110596_2FCFE0B5 
X-CRM114-Status: GOOD (  33.17  )
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

Hi John,

I apologize for the delayed response. I may have missed the notifications,
since at the same time, we have some crashes and bug patches working
in parallel. So the response process is a little slower. Thanks for
letting me know
the newest fixup. Apologize again!

Best,
Chao

On Tue, Jul 14, 2026 at 4:18=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> This response took almost 3 weeks. The previous response took again
> almost 3 weeks. kernel development may be relatively slow moving, but
> it's not that slow. You need to respond much more promptly to keep up
> with current development.
>
> >
> > Here is the concrete change (drivers/nvme/host/core.c,
> > nvme_update_ns_info_block()):
> >
> >    unsigned int memflags;
> >    sector_t capacity;
> >    unsigned lbaf;
> > + u64 nsze;
> >    int ret;
> > ...
> > - if (id->lbaf[lbaf].ds < SECTOR_SHIFT ||
> > -    check_shl_overflow(le64_to_cpu(id->nsze),
> > -       id->lbaf[lbaf].ds - SECTOR_SHIFT,
> > -       &capacity)) {
> > + /*
> > + * check_shl_overflow() also rejects a data size below SECTOR_SHIFT,
> > + * as that makes the shift count negative, so no separate lower-bound
> > + * test is needed.  Feed nsze through a plain u64 so sparse does not
> > + * trip over the __le64 provenance of le64_to_cpu().
> > + */
> > + nsze =3D le64_to_cpu(id->nsze);
> > + if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
> > +       &capacity)) {
> >    dev_warn_once(ns->ctrl->device,
> >    "invalid LBA data size %u, skipping namespace\n",
> >    id->lbaf[lbaf].ds);
> >    ret =3D -ENODEV;
> >    goto out;
> >    }
> >
> > Two things:
> >
> > 1. Drops the explicit ds < SECTOR_SHIFT test as redundant --
> >     check_shl_overflow() already returns true for the resulting negativ=
e
> >     shift. I confirmed ds=3D0 and ds=3D8 are still rejected without it.
> >
> > 2. Routes le64_to_cpu(id->nsze) through a plain u64 local, which is wha=
t
> >     silences the C=3D1 warning (sparse loses the __le64 provenance when=
 the
> >     value is passed straight into check_shl_overflow()).
> >
> > Behavior is otherwise unchanged. Since the original is already in
> > v7.2-rc1, I'll send this as a standalone patch on top of mainline
> > (Reported-by: you) unless you'd prefer a different form.
>
> My fix is now in mainline
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv7.2-rc3&id=3D92f58587a04c94985fd4a9e3575720b054c432bf,
> so any change which you want to make must be on top of that.
>
> >
> > Thanks,
> > Chao
> >
> > On Wed, Jun 24, 2026 at 9:15=E2=80=AFAM John Garry <john.g.garry@oracle=
.com> wrote:
> >>
> >> On 23/06/2026 21:37, Chao S wrote:
> >>>> BTW, I have thought that check_shl_overflow would catch
> >>>> id->lbaf[lbaf].ds < SECTOR_SHIFT (so that we don't need the extra ch=
eck).
> >>> Confirmed -- check_shl_overflow() returns true for the negative shift
> >>> that ds < SECTOR_SHIFT produces (_to_shift collapses to 0 and the
> >>> _to_shift !=3D _s test fires). I checked ds=3D0 and ds=3D8: both are =
still
> >>> rejected with the explicit lower-bound test removed, so it is redunda=
nt.
> >>>
> >>> For the C=3D1 warning, the minimal fix is to drop that redundant chec=
k and
> >>> feed nsze through a plain u64 local -- as Keith found, laundering the
> >>> le64_to_cpu() result through a non-__le64 type makes the warning go a=
way:
> >>>
> >>> u64 nsze;
> >>> ...
> >>> nsze =3D le64_to_cpu(id->nsze);
> >>> if (check_shl_overflow(nsze, id->lbaf[lbaf].ds - SECTOR_SHIFT,
> >>>         &capacity)) {
> >>> dev_warn_once(...);
> >>> ret =3D -ENODEV;
> >>> goto out;
> >>> }
> >>>
> >>> This keeps check_shl_overflow() in one tested helper and avoids a
> >>> wrapper. John's nvme_valid_ds() works too; if we prefer that, I'd nam=
e it
> >>> for its actual sense (it returns true on overflow, i.e. invalid), e.g=
.
> >>> nvme_ds_overflows().
> >>>
> >>> One note: I'd lean toward keeping check_shl_overflow() rather than
> >>> open-coding the bound. It folds the lower-bound (negative shift) and =
the
> >>> overflow case into one tested helper, so we don't have to re-derive t=
he
> >>> boundary by hand -- e.g. the lower bound is on ds itself, not on the
> >>> post-subtract (ds - SECTOR_SHIFT) shift, which I found easy to get
> >>> subtly wrong.
> >>
> >> What exactly is your proposed change (to what is in the tree)?
> >>
> >>>
> >>> Keith, since v3 is already in your tree: do you want an incremental f=
ixup
> >>> on top, or a v4 to replace the applied commit? I have both ready.
> >>>
> >>
> >>
> >>
>

