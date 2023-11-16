Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED52C47071
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPxNHo3ULcsNHonG1S3dXxZBWwtHJpSMfZE5XqJO15g=; b=jSCrBYChMEkKogyHfXEsQy2NuT
	l3dhl7yORssF0mt3Tgq8Uk5uaWAJLYcVmpwLxYKwdVbATmOrJ2pa9vDpxrMABisQmyxnGl8bPya/e
	SudCZwIChAcIKyiyjDSuYEHG96rhdQuV1m71vq77xPQhm3a67/SzNHZuZYqW93N6x0C9NcwJYTzNJ
	uuXuxd/VN8+odSt25ey+sXbPZ8HV34wQI8hH8zR/NezBi8o4JlAZG3OiIj3F/mMgUmZpziPaMTW3M
	w1wHKjdqZtO0/cYx/Y2rPGGL2dHerpvK8kxWikoVSILCB23gOUonJL4e0STrTZvLkbBxjRVf8mcn/
	drW04uFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3hnf-004Ry2-26;
	Thu, 16 Nov 2023 19:13:15 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3hnc-004Rwh-2k
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 19:13:14 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41b7fd8f458so6612131cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 16 Nov 2023 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700161990; x=1700766790; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPxNHo3ULcsNHonG1S3dXxZBWwtHJpSMfZE5XqJO15g=;
        b=OcUVhVKsITpT5k3/WLe1VPCB1XfT4ZQzClWC8q8Z9L46LhXHQELXdrXYuVrtpbQ3cv
         dEiPM4nVpZ+IufDDV4eABcUoELbWGx5tAPYfkiqVvJi4aT4XqIQtkdoLKOLv25w3Eb/W
         7CSy1AM3zsK/iSWsmNWIFAdb0Z7fAR++BE81CmL7jvp4q8ww/jyEv2XUqDtdV4rDH7RQ
         JLRCQj70j+ERzqQCXijBgJ8lOZg9NUd8bKvIcyu8mSMsvFmlPyKkRXBb0tDVshNWRMrn
         sOruMZBuqM+SSZriWXoJ2HuqKj8qova1/krpiFlcftuGqCW2q24FKBTr5zUAVF0Oma9Z
         3ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700161990; x=1700766790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPxNHo3ULcsNHonG1S3dXxZBWwtHJpSMfZE5XqJO15g=;
        b=mv835iIhICdWDRfjvrzqfyQDuMYFZKlmGazYcDMHqgxqiHvztuYtpVM7h34Y1Ff1Ju
         jQQgJJ3sI0/x2J6bnypeh5KUHpf2jMruxlsgYBE5DsvJ5Cvx/mj+qg4S0cYEzgVKn7HY
         9ekM07rRvPz65/OV3H35txR3lhd7K9hyP3r2i5sPEOxb9BBMAcIDrJdWY5kA9vZayOER
         Or7wzWpMN+4Two4sy37K+qiC0Xccm5b270LaYwySx6trUiM1OzI3diSIvCJ5ubXmhB6p
         Rf25WNgnR6ZtAfQXEhHqnJFy+yqqpuzMYLRCCFS2WQxLxnJEnrRZeK9Q7EjJ2Y78utal
         Ofmw==
X-Gm-Message-State: AOJu0Yw3J+a9mx2Wj1xuu/u6gXtmz99rpVPMOMhZQO5UaD2y1SjpgolK
	YYDc2RES0ojv26OcPT4vXpx6tH8NDLx8eg7hDOqSH1/Jvebn0bbIjDD/Xw==
X-Google-Smtp-Source: AGHT+IHTcTjmLc+6xfRRk7irgDlKVNzX6sIipRK12iEvdBnagtqRWf+9rxO6g4dKAB73yESltnrs0a7UlctfM0jH7yU=
X-Received: by 2002:a05:622a:56:b0:418:1f52:1421 with SMTP id
 y22-20020a05622a005600b004181f521421mr11326596qtw.9.1700161990608; Thu, 16
 Nov 2023 11:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Thu, 16 Nov 2023 11:12:58 -0800
Message-ID: <CA+AMecGH_yugc7YQX2tqMSKzsA-aJYJSVBOVjiyYcw994-_Zng@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	randyj@purestorage.com, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_111312_987719_3E52634B 
X-CRM114-Status: GOOD (  23.22  )
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

On Wed, Nov 15, 2023 at 7:52=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Nov 15, 2023 at 02:44:04PM -0800, Yuanyuan Zhong wrote:
> > On Wed, Nov 15, 2023 at 11:55=E2=80=AFAM Keith Busch <kbusch@kernel.org=
> wrote:
> > >
> > > On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> > > > On Wed, Nov 15, 2023 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.d=
k> wrote:
> > > >
> > > > Do you mean something like this? If not, can you please elaborate
> > > > "when we need"?
> > > > -               struct nvme_effects_log *cel =3D xa_load(&ctrl->cel=
s, ns->head->ids.csi);
> > > > +               struct nvme_effects_log *cel =3D (ns->head->ids.csi=
 =3D=3D NVME_CSI_NVM) ?
> > > > +                       ctrl->effects : xa_load(&ctrl->cels, ns->he=
ad->ids.csi);
> > > > Will it be good to change ctrl->effects to ctrl->effects[3] for
> > > > already defined CSI?
> > >
> > > I suggest either re-assign the cached head->effects to one from a sti=
ll
> > > live controller when current path is removed, or move the saved effec=
ts
> > > to the subsystem instead of the controller. All controllers in the
> > > subsystem should be reporting the same effects log anyway, so
> > Is it specified in spec that all controllers in the subsystem
> > should be reporting the same effects log?
>
> Yes, in section 5.16.1.6, "Commands Supported and Effects":
>
>   This log page is used to describe the commands that the controller
>   supports and the effects of those commands on the state of the NVM
>   subsystem.
>
> Oddly enough, Figure 202 says the scope of the log page is "Controller"
> rather than "Subsystem". Sounds like ECN potential. You can memcmp the
> effects log from each controller for a sanity check if you think some
> subsystem controllers messed that up.

Yeah, it says scope is controller.
I think it=E2=80=99s valid to start upgrading one controller in the subsyst=
em
to report different
effects log, e.g. adding or revoking CSUPP for some opcode.
If the saved effects log is kept in the subsystem, how to refresh it
for the subsystem?

