Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB73C2BB3F
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LXrgWyvWAa7mpo5Hy0ExAVZUfBAE64Xn9mUeqoQEoh4=; b=a6AAMcGmM0ip2F755kak5Who93
	xGtorlN1AKWhQu0a2mb3A9MCmtSbFwTNquejiat/owATqRMLMQLqyi6yV7nEJWaC1md7p5BIMMr8F
	mImiSf6rRtGx/IdmC8Bm/GruHhyjTSZ6ZoPJVuSyiYPUZs0oR1yBztShv0qm3r+iKa0DomW+wFSR8
	cnIIztje8sSH3+xaHLloPQxMJ3AC9ifavAxwfTo8VPPC93yIPAh6/Fqx4KxGwkN4yWP8DPGBcTbED
	DqB2om2IabxGqENpp36oVS8t0ZnS3dEw/sKsPRdvYBcn3GwUbA0NjiA7QTpgP4YxINhpdvat+A8K7
	vjZ9fHtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3OcO-001tOA-1h;
	Wed, 15 Nov 2023 22:44:20 +0000
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3OcL-001tMq-2Q
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 22:44:19 +0000
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-586ae6edf77so101102eaf.1
        for <linux-nvme@lists.infradead.org>; Wed, 15 Nov 2023 14:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700088256; x=1700693056; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXrgWyvWAa7mpo5Hy0ExAVZUfBAE64Xn9mUeqoQEoh4=;
        b=WlRxMHG5dUl7jUgOy7WPqVGtn00yzEG4xyOmip9Flim1hOT4o3kTt2Ti4FBs40YHjE
         5hvfT7b9Vp9XZmzBfs/hHnl5M4E4I/h9fQ8rQbA+hAMwatYU7pW3G7cGoFeXYCsMx5Xm
         jpIhLliIHvIfCMgqHPKqR9RikHxyAteOn5p3SsRanPhjZshPllHPvIHR5AKLySSCpWc0
         RWMR8NSqDT7tEz1CtSebBKpIZ+/+t3nyeFovVsLAxad7cPheEB7pgIL25RAAUfh5kggY
         LAF+Iwa0TP8QmZshAsPRW2unWZqa7AxzgnLFBrttFzn+wxdlBjnGXlZNC4EGG+FEA0z3
         RjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700088256; x=1700693056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXrgWyvWAa7mpo5Hy0ExAVZUfBAE64Xn9mUeqoQEoh4=;
        b=abm7LAdRMfT/biMWf2j7tsrrWvzzLA1OJhSZ6/hgqKMNFN/A2VgDsRJTlljz3e63/u
         onOTvKAmbwYUIS3R4jge1GDEmwOAZqsGzdBMV5H1YNkuY0QrM/T3VoOg5CrUxQZyM9to
         8pL9e94JDdiuIoqb4V7x0mDH3QwdtJugMj4D3EceUqMGeO2CPeR27AgmYBZQ+xXPAPit
         zk65IS1Q7p6Sel3KeYq5n22kR/hc5uRQPrPtHKp5hlWyp1fUWcuuoNFFgK/RX3G4GhJV
         TSERz+1ZkHie0NmjuDNO+gKaPzAtDVVJlBqInB3OU4CiHtA4YgeL/6CcvbC0YXccQauD
         dkkA==
X-Gm-Message-State: AOJu0YyLS6A3W/l4W28Lel3PUF6fzS6b0VmAc9pYySK5Yw7SgUqPWyuZ
	0SZqJ+vQKuaO5KfUa7gkCnX8xqUB1BXbhJ3zrCSU/A==
X-Google-Smtp-Source: AGHT+IGrycqa+3tW5XHyxAo6jk4d3g94Kstx3L4T6j5UriD6ILVj1s4cuFgwmiT04zhqz0EokZUAdXeiJ2vS6qbrCkw=
X-Received: by 2002:a05:6358:88f:b0:168:e55a:853e with SMTP id
 m15-20020a056358088f00b00168e55a853emr6625450rwj.4.1700088256000; Wed, 15 Nov
 2023 14:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Wed, 15 Nov 2023 14:44:04 -0800
Message-ID: <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	randyj@purestorage.com, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_144417_951123_86230F04 
X-CRM114-Status: GOOD (  15.61  )
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

On Wed, Nov 15, 2023 at 11:55=E2=80=AFAM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> On Wed, Nov 15, 2023 at 11:21:53AM -0800, Yuanyuan Zhong wrote:
> > On Wed, Nov 15, 2023 at 11:02=E2=80=AFAM Jens Axboe <axboe@kernel.dk> w=
rote:
> >
> > Do you mean something like this? If not, can you please elaborate
> > "when we need"?
> > -               struct nvme_effects_log *cel =3D xa_load(&ctrl->cels, n=
s->head->ids.csi);
> > +               struct nvme_effects_log *cel =3D (ns->head->ids.csi =3D=
=3D NVME_CSI_NVM) ?
> > +                       ctrl->effects : xa_load(&ctrl->cels, ns->head->=
ids.csi);
> > Will it be good to change ctrl->effects to ctrl->effects[3] for
> > already defined CSI?
>
> I suggest either re-assign the cached head->effects to one from a still
> live controller when current path is removed, or move the saved effects
> to the subsystem instead of the controller. All controllers in the
> subsystem should be reporting the same effects log anyway, so
Is it specified in spec that all controllers in the subsystem
should be reporting the same effects log?
> duplicating all that per-controller is kind of wasteful.

