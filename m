Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB14EB595E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 03:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lNXFAGoFwPPlMl2TNaoGWBMC72GA6Bq9CsHRRvHGD+M=; b=IC0GxaQ3fWNQiGx62hEtGd9JZo
	zt4cE5TOA0TBZW7p+OGiKlzf0f4Ya456qBZ8cvrMHwMTX1iYZrJi0iW+6KhGjueGOtmtIcIy/AXNG
	SjzPZOqH/iOHrySGxL6TMk5iftYB+f0hJwY8rQ/AnAQrG0WlCbgoU0FIH06UG3k6uxWMCKUWWhrsz
	wVBs06dQa8JXy0DTnDF67Ng47/I7wm+0aclg9pVqcICo/iwIkL8iZ3UeT+0hHRXN1/C/lZMSnOkxv
	hvbP5NfPqVmOTCbwE2xC0E/ZkXt2s46QPWTH/HQ0sECd0qD0w8+HvcL/RIWTCZUtJs57GRXQOK+T7
	xeIcBnyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0yr-000000009xz-2t6R;
	Wed, 11 Feb 2026 03:33:33 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0yo-000000009xN-3pdA
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 03:33:32 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso1933563241.2
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 19:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770780809; cv=none;
        d=google.com; s=arc-20240605;
        b=Kif/JJSYH0nfPTHDcyDm+aIerTt8sOMPIYLK3R9NbFlHiapSYkomJctzSqJkoNIDdg
         U9+mOAXYiBFLObSZ6eOZ8+cRiykmagHm+JpR+3e4DiGjEEf/iBGlcKrhos0QImb2f+7m
         YM038itfXG1JvhLTUDtiuZ+kFwI0rq1VP0HRtO4D6J8CUKaCnfQJkqRAJfv2rIuT+Vqz
         h/MDiL493Sptmj8d9kMqXTjOjrVsOMOeRcQb4BWgVvxH1Eph7m/rKx7dOZAjjBTGnvvC
         banyljVqQjhISTe69EPLlKc95tfSIhqFRojtEgX2CwYhQpfi3ceSe1qg6RWlY8QejS5B
         sfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNXFAGoFwPPlMl2TNaoGWBMC72GA6Bq9CsHRRvHGD+M=;
        fh=XyRWtcceCqs4vcXtqRhK9YqwNCdraD2t/WdEXnOL6x4=;
        b=VpCUkY8tSqQn01JX/+9PSNa/rzgRfi5dZSsrcYTabmKtpNVxxpTI8YYNGk+0rAYj2o
         90HcYOflqufTRGwduOu5xK/JavlzsUJ7XZcEwfZuKQDXdoRU9A3muFl8G7dIsxw4oqFB
         DOOfW6IEXWSZmDSa3G5hmOEUjbH34B485hJiyrjTV8d2C/q0RWH4qg4ENvrQTG2u8/hM
         KGjUBTQ6nlJoz2KybfRqUgr+5Ylpn1+3SIgdE18YF86uwL6Qum5jXjOqXNerEDqWqa4c
         Pp6aFU0YDymowMcgKNVfzrVWWbHpfI4GnGnEesdJskxnxeQdeUWMclzoXmPXfFmiMrkm
         ++Sg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770780809; x=1771385609; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNXFAGoFwPPlMl2TNaoGWBMC72GA6Bq9CsHRRvHGD+M=;
        b=Iz7YGVnvyAHJwWlJ7L/SX+FNvUGH7CgPGcmGTSkztzAN78GVPqm0gnB/1u2FX9r8yh
         krbKR3RtZkVQeuRmx+F5rGX97q03qv5t5qUye7w+W7hfGm1/OaBcTVZns/pKEKbmarA3
         wDHmLf4KZ9B4hdfxo57igdyxCeK9COTPmGrKH/jL0y21Xlw6qsLWt6VGs17er6fC/RkF
         Uyir4JkUIyj0uY/X5s3Vgtpi7Zta5+aLR3OpecKDIDFPCzrdEVvI0z0lBBL/OvRM+XlE
         iSe7rAoWqH/q4VVPCMqmGcfmNbISdKi3EOpg492ng3nU8H524VKDL6soWT/IKUS1MuzV
         FXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780809; x=1771385609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNXFAGoFwPPlMl2TNaoGWBMC72GA6Bq9CsHRRvHGD+M=;
        b=G4D1/ERDVYKOsEnT2KF0gGYT7kXTflOdruFpwAgo0OI/aVSQFln9ksNyjlDITQjhek
         U7d9gKQY2VrnxOWWpQRFZAvnKE952JRSNyGPevTzFpphIuro6RznQHxDb/fh3/EiVi4X
         MWqXtoGLnkx8Jq8fVBINqQKZ+wqtcNhrD90fhsWpZ4AvqwwIPrE3eBJLzc0CEJ4wRwmp
         DVYnZDItPJYNcFaZy0raE/nYPFJFACIhP8jb++163u2i6H/ZQLqmDt7qdrYTvwUmpsMo
         VeTEgO04YXLVDQD7UMXR5vRkRP1MH6UDcVKEnSpH2S0WrP1ohhFsoZdZN0xh/RiIUN93
         wARw==
X-Forwarded-Encrypted: i=1; AJvYcCXFAvZ7NSx8a1Ps9BR3EJ2e6pit47QNS8wLiv6w2G8p8kJ1bWLXJG3tssYhzRscc23hm1KVMWUQQE7y@lists.infradead.org
X-Gm-Message-State: AOJu0Yxq98FYYyTFLWFd6n4bU6yGJ3uVqdoy1MrWB6FXRPjmV24jqWrJ
	WS5IWoF0LfSCFoIM3ecVX1wltZvXURrSE38BWJL/K0jr/T7G7K+Vy4bbUiNXB1UykMI50nv7dX2
	TuvWDcwEWPIYnFSZZFQq47IgY4MBwZ9TmY6nrCiE/VODPqt3wU+bqB+Y=
X-Gm-Gg: AZuq6aJTG8p0TfJ/mlY7XWJcTInwJfgtm3nthe3JsH99nKDzg1dSnjsCzc2/aOIkIl2
	cyEtnbtbevOC0hd3aa75fweaIZT4Gi2Q+jTX5TfKDuMBWX1UpQbsw5jsvKqEKfLblPTwcXjjCx9
	P00pSMxd8XLXDFFDyBz6AUsXfHP/3syqNSkW8KbJ39QdSBY3XT5MCiAfCsnHjaZfQ873JxqrZZc
	RS3zNd20lpl8KZpDxFdZ/x2S9eRvQ9xXeS1bvy1SNKSQrRgW5VAMwuyG2GQ3FfFsoP05p1l7G/v
	UIJ2D5E=
X-Received: by 2002:a05:6102:2ad5:b0:5ef:8ad:a3bb with SMTP id
 ada2fe7eead31-5fde4125509mr379575137.9.1770780809432; Tue, 10 Feb 2026
 19:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com> <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
 <20260210222732.GQ3729-mkhalfella@purestorage.com> <5f3c9cf0-7fee-432a-b6c5-44fb2acb0b1d@gmail.com>
 <20260210232553.GR3729-mkhalfella@purestorage.com> <20260211001243.GS3729-mkhalfella@purestorage.com>
In-Reply-To: <20260211001243.GS3729-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 19:33:18 -0800
X-Gm-Features: AZwV_QhRwZF-ai4n-PTcrQUreIfxI2ZtrNCZvYn76hbyxxqIk84VbTOcu-v8mlA
Message-ID: <CAPpK+O37eh5tKFcos61DKH8pYsFtw-mcWLw+ZVQRJKdNtJCp-g@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: James Smart <jsmart833426@gmail.com>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_193330_995182_815C9ADB 
X-CRM114-Status: GOOD (  43.32  )
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

On Tue, Feb 10, 2026 at 4:12=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Tue 2026-02-10 15:25:55 -0800, Mohamed Khalfella wrote:
> > On Tue 2026-02-10 14:49:15 -0800, James Smart wrote:
> > > On 2/10/2026 2:27 PM, Mohamed Khalfella wrote:
> > > > On Tue 2026-02-10 14:09:27 -0800, James Smart wrote:
> > > >> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> > > >> ...
> > > >>> +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > > >>> +{
> > > >>> +       unsigned long deadline, now, timeout;
> > > >>> +       struct nvme_ctrl *sctrl;
> > > >>> +       u32 min_cntlid =3D 0;
> > > >>> +       int ret;
> > > >>> +
> > > >>> +       timeout =3D nvme_fence_timeout_ms(ictrl);
> > > >>> +       dev_info(ictrl->device, "attempting CCR, timeout %lums\n"=
, timeout);
> > > >>> +
> > > >>> +       now =3D jiffies;
> > > >>> +       deadline =3D now + msecs_to_jiffies(timeout);
> > > >>> +       while (time_before(now, deadline)) {
> > > >>
> > > >> Q: don't we have something to identify the controller's subsystem
> > > >> supports CCR before we starting selecting controllers and sending =
CCR ?
> > > >>
> > > >> I would think on older devices that don't support it we should be
> > > >> skipping this loop.   The loop could delay the Time-Based delay wi=
thout
> > > >> any CCR.
> > > >
> > > > I do not think we have something that identifies CCR support at
> > > > subsystem level. The spec defines CCRL at the controller level. The=
 loop
> > > > should not that bad. nvme_find_ctrl_ccr() should return NULL if CCR=
 is
> > > > not supported and nvme_fence_ctrl() will return immediately.
> > > >
> > > >>
> > > >> -- james
> > > >>
> > >
> > > I would think CCRL on the failed controller would be enough to assume
> > > the subsystem supports it.
> >
> > ictrl->ccr_limit is a good indication that subsystem supports CCR. I do
> > not think it is enough though. I say that for two reasons:
> >
> > - May be this controller does not support CCR but others do on the same
> >   subsystem. There is nothing prevents subsystem from putting a cap of
> >   CCR at subsytem level.
This is not a concern.  Controllers should support CCR uniformly in
a subsystem, and it would be unusual for them not to.

> > - May be this controller supports CCR command but not now because all
> >   CCR slots are used now. This can happen in the case of cascading
> >   failure.
This is the concern.  Because the code modifies ccrl as it has ccr cmds
outstanding, checking ictrl may not give an accurate picture if ccr is
supported.


> >
> > >
> > > I'm not worried about the coding on the host is so bad. It's more the
> > > multiple paths that must have cmds sent to them and getting error
> > > responses for unknown cmds (should be responded to ok, but you never
> > > know) as well as creating conditions for other errors where there wil=
l
> > > be no return for it - e.g. other paths losing connectivity while the =
ccr
> > > outstanding, etc. yes, they all have to work, but why bother adding
> > > these flows to an old controller that would never do CCR ?
> >
> > If nvme_find_ctrl_ccr() returns a source controller to use then we know
> > the controller supports CCR and does have an available slot to process
> > this CCR request. I do not see how this code will send CCR request to a=
n
> > old controller that does not know about CCR command.
> >
> > I am not fully opposed against using ictrl->ccr_limit to return early. =
I
> > do not see the need for it. If you feel strongly about it I can update
> > nvme_fence_ctrl() to do so.
> >
>
> I forgot to mention that ctrl->ccr_limit is initialized from id->ccrl in
> nvme_init_identify(). If this value is greater than zero then we know
> the controller does support CCR. nvme_find_ctrl_ccr() checks for that
> and the returned source controller must support CCR and has a slot
> available for it.

