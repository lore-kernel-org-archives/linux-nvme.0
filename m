Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F91C04FFE
	for <linux-nvme@archiver.kernel.org>; Fri, 17 May 2024 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsBcgs+i07u2l3W88V5z3GmB5lAU185KFxQwtWbkIR0=; b=ZUtatz5p/tIVkSKKeSVo0oYbPa
	GwG9CWdf34fgUVDT0FfoeSXGTTVeHYKu51C3SVNIM1L89VtoQBqIs5lMO9AJxZW8AaohpMXdbQ1tD
	X63ihTxV20WN2BFb0LTCkwMMEJws3t708JJ8pZBtrP9ZjRJrbJw/fTmutLdmJAs5n17Fju6tp0ooZ
	qeJkLD2DyNIi53geShpit8BxtARaJSVeXd5etWLC9pFlXPH2Z+WwsecryJp2gMbKHAom4lDRqwln+
	lzIjf7aveYoz7GPRrcIjlX1aFFXVvQhdjBo3YAdehEj+9cr3bcbn9o5KuQ9PbX4PdiAEtc4kndG6M
	y2lNigcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s80Qx-00000008Nqp-0e0q;
	Fri, 17 May 2024 16:27:51 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s80Qk-00000008Nni-3zGo
	for linux-nvme@lists.infradead.org;
	Fri, 17 May 2024 16:27:40 +0000
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3c74b27179dso1101082b6e.1
        for <linux-nvme@lists.infradead.org>; Fri, 17 May 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963247; x=1716568047; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsBcgs+i07u2l3W88V5z3GmB5lAU185KFxQwtWbkIR0=;
        b=HWUarYCmMjiMPhf00uQVtcyk76UA9Mbw5SYYqD9M0f3MudocnjTYYx8AhBfTxmLkOx
         kDXNZLq8VDGVF1Xv9xTkTc3AQkx/Y5bxLQIkGG5qcUMC/zOr9YP6pknwoIwipk4ImctQ
         kyeUHpri7WORabeLZ/qmx4GSyuJj7p/iluEeYmPuVyafIjBGoAJ57ANcy2QSKnKxBYkb
         kp51OjP/vB3Y1dRk8MoyHMD1m7X2w7bTWNGVWsYPuPiR+oG33AZwWa9SDIYeMPffmBB2
         ++xcYufEqoiGrOgLQ9JQ3uc9YL4JYSfEoC0mKFfrVcSsKs/KGkA/KOCh6JV62GbYYJMp
         OKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963247; x=1716568047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsBcgs+i07u2l3W88V5z3GmB5lAU185KFxQwtWbkIR0=;
        b=E6yQFabFWCVxUHC3b9ymlFbpXdvb16U9srhgxafs5pslxg3fvPJYMT/hwN1BVDlg8y
         Vo+mHQy+5UFshy+N/5dCNNNABlLsHf0nKUmZ3Y9kAK5i1Thbgtjf9USlCT01YZvd4g3q
         H/7xVRRc9k8i1a+OoUaoDNwmF8xSJmbaBWNbZtGofVARya3wIgcw3xdSOTHsUJad0Rmp
         BimDFmKgiuKgsLNEEE2n00+BTTIVdX83vTectVeDhpvxD1ZbtgDzd+stxNJGaHBW+HUD
         Cm3KBn686/YczUe2ppf/+raOvLMEqqPAhdtcHuRmmHh1c4t653ws6nebGUL4fuL3Fs8k
         i6yA==
X-Forwarded-Encrypted: i=1; AJvYcCWABu2q36XKX30Rj0IS7K3uNl+74rG8lDbqPBiJr00RAkgagTd/I8YoLxNGBho/Wpz7GeyjcS2UozbKAR8sbAmfSZR/ZZok7urMdI+34ww=
X-Gm-Message-State: AOJu0YxGzfSQ+TiBpTBsdOW1wXv3AG5p/X1lBCMRPQdr1TMExdfcQZwj
	xVEvJGIx2Sdz8KcAhhaLYA/n4ZUmZ82q2qFy06IIyEnjYNIqprrab7p0Xjfs2xHC/LbnCb9tHU2
	y3vXUkq6a8gRNR7/2M1tHcGvMI6w=
X-Google-Smtp-Source: AGHT+IEog8f0lXH81lGhHBFVqjJdyaUhli4ZdwxANkP6pers4WIujvbAuERD6Y1ltN16MdEUhdCFPSnFoomxYWnGZqg=
X-Received: by 2002:a05:6808:18a0:b0:3c9:c7a0:94f7 with SMTP id
 5614622812f47-3c9c7a0964fmr4945200b6e.1.1715963246922; Fri, 17 May 2024
 09:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com> <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
 <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com> <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
 <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
In-Reply-To: <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 17 May 2024 09:27:00 -0700
Message-ID: <CA+1E3r+hgO=-K=oojP8xMBDOkVtma60FK-RTxQhbvg2yUc+Abg@mail.gmail.com>
Subject: Re: [PATCH] nvme: enable FDP support
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, david@fromorbit.com, gost.dev@samsung.com, 
	Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240517_092739_015468_D8E5C40D 
X-CRM114-Status: GOOD (  30.04  )
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

On Tue, May 14, 2024 at 2:40=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
>
>
> > On May 15, 2024, at 6:30 AM, Kanchan Joshi <joshiiitr@gmail.com> wrote:
> >
> > On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko <slava@dubey=
ko.com> wrote:
> >>> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> wrot=
e:
> >>>
> >>> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko <slava@dub=
eyko.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wr=
ote:
> >>>>>
> >>>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the =
host
> >>>>> to control the placement of logical blocks so as to reduce the SSD =
WAF.
> >>>>>
> >>>>> Userspace can send the data lifetime information using the write hi=
nts.
> >>>>> The SCSI driver (sd) can already pass this information to the SCSI
> >>>>> devices. This patch does the same for NVMe.
> >>>>>
> >>>>> Fetches the placement-identifiers (plids) if the device supports FD=
P.
> >>>>> And map the incoming write-hints to plids.
> >>>>>
> >>>>
> >>>>
> >>>> Great! Thanks for sharing  the patch.
> >>>>
> >>>> Do  we have documentation that explains how, for example, kernel-spa=
ce
> >>>> file system can work with block layer to employ FDP?
> >>>
> >>> This is primarily for user driven/exposed hints. For file system
> >>> driven hints, the scheme is really file system specific and therefore=
,
> >>> will vary from one to another.
> >>> F2FS is one (and only at the moment) example. Its 'fs-based' policy
> >>> can act as a reference for one way to go about it.
> >>
> >> Yes, I completely see the point. I would like to employ the FDP in my
> >> kernel-space file system (SSDFS). And I have a vision how I can do it.
> >> But I simply would like to see some documentation with the explanation=
 of
> >> API and limitations of FDP for the case of kernel-space file systems.
> >
> > Nothing complicated for early experimentation.
> > Once FS has determined the hint value, it can put that into
> > bio->bi_write_hint and send bio down.
> >
> > If SSDFS cares about user-exposed hints too, it can choose different
> > hint values than what is exposed to user-space.
> > Or it can do what F2FS does - use the mount option as a toggle to
> > reuse the same values either for user-hints or fs-defined hints.
>
> How many hint values file system can use? Any limitations here?

As many as already defined (in rw_hint.h). Possible to go higher too.
No hard limitation per se. Write is not going to fail even if it sends
a hint that does not exist.

> And how file system can detect that it=E2=80=99s FDP-based device?

It does not need to detect. File system sees write-hints; FDP is a
lower-level detail.

