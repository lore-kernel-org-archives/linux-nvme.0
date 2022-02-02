Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA79C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNm5VWklaQo7vKQ+dCdXd27s1+gIsP6C+Dp7qaeAga8=; b=tewl3rqQ8YA1qreyX1cipybUd0
	5vfD7LqH9e56iY7o+ekYUmPrNQE6Ji8GH+AzNHKBRJ250yZw+62IT00/tk2ptH25EXoZnJu3eXZEQ
	17SsRlUqD2NtI+K6UjAmR7NvinZzOGwye6cxAqdYmvDSCdufXPED/O06cPvTyWQut9h7sFZDaltTe
	ka9IMr5b5raXmDKegYFX0Y878OF6aSrSsCJhB32g+Rm1FTWPgChnYl6cBqiVDx7CFPkYQpmh+EL1k
	opG5QDkZr8JAfInrLD3iRsC0TmuTbJWz5YXRMVb65DIzc/bNyfDvW3QNqRv8GLWQ7umulPkp2+Z5o
	7kBdbURg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nF9W8-00ELUb-HC; Wed, 02 Feb 2022 06:53:24 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nF9W5-00ELSx-6m
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 06:53:22 +0000
Received: by mail-pj1-x1030.google.com with SMTP id m7so2406438pjk.0
 for <linux-nvme@lists.infradead.org>; Tue, 01 Feb 2022 22:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JNm5VWklaQo7vKQ+dCdXd27s1+gIsP6C+Dp7qaeAga8=;
 b=MI8+HgC5pUET+Dv332isotarUX7FqSTNuq/OiHHe6rPNyn/aI+nfepqbhkzd8Puc9h
 y8cCcpRZ1G0sPxvsg7W8Y3g/se/ckpylPxse1FWB5i0z8uT51E7hxiZIyS7oTr1IBg12
 DtIDlAvL8pgdiaKMqDnigfR21mjM7FaiQhpqqL+u6g8PU/TgoJmZ8JWp4J9pfCiKqm9d
 2GJUQ7oyAZlFP4smrOeo9HJETEYdLazNzN6QZtn8q7CU0c05DrpMIUhECTb6QF5js0ci
 KSprmRnnDRVZhv4Hx7C2zq8+Pmh900CNxHchiATHGhocJGh3BB1fHzcza2VJamlPlL5h
 vRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JNm5VWklaQo7vKQ+dCdXd27s1+gIsP6C+Dp7qaeAga8=;
 b=aDtMgMADHYE1zH7vEEnRb2xnIYM825B3osqvmlHKoQUWxiv2uys1qUjPLjEG+o4o+S
 s6L3gfra//D2NSKAON0GVQH98o3L0qray3LNEVl9ydqt/ZqBn2AHCZIcYMIq9EoOQb8e
 JiGAGWz4PyysERyfZ3X1Y8coalntpwSOhqZ+X26wJeEHuzimNRoXZlYZr4RUPAkhGK0Q
 ebSUAK1/VOKWlzaFbeEabnqgbHR6FqOezVuiR+Vu7BK5llxLsAPGfW99ctsuD7Mb3uRU
 CKhpEDpq16kDfPsdFMqZvibQsyBaKMMgA2bGNN8ehPRbDsNxdA+htl5CguJF9fgAtr7G
 pVjA==
X-Gm-Message-State: AOAM531WR4PoTLOx5DwRzfKDWdIZIVjqOanZqlOz5B7mgx2Q9/mGDks1
 IwZgH8w2MNtUirG7UjQQWXP1+e3J1fwo4sqtFcY=
X-Google-Smtp-Source: ABdhPJwospAWl/NLR6oJyXbg6Z2oQkNl/Lt/4uI69c0wbbbQ+/ukk072N8uhJ2/hdfWHQR8YV46A7K7ZFew+y6QJ6oU=
X-Received: by 2002:a17:90b:4b01:: with SMTP id
 lx1mr6535773pjb.52.1643784799940; 
 Tue, 01 Feb 2022 22:53:19 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913@epcas5p3.samsung.com>
 <20220131141847.4791-1-joshi.k@samsung.com> <20220201080202.GA29518@lst.de>
In-Reply-To: <20220201080202.GA29518@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 2 Feb 2022 12:22:53 +0530
Message-ID: <CA+1E3r+4K5Merus3RF_DOe3XmoDMpPS4duTst=e56Jam=bXZZg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: add vectored-io support for user-passthru
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 kch@nvidia.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_225321_303014_315ED30A 
X-CRM114-Status: GOOD (  16.43  )
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

On Tue, Feb 1, 2022 at 1:32 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > +                     struct nvme_passthru_cmd64 __user *ucmd)
> > +{
> > +     return nvme_user_cmd64_common(ctrl, ns, ucmd, false);
> > +}
> > +
> > +static int nvme_user_cmd64_vec(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > +                     struct nvme_passthru_cmd64 __user *ucmd)
> > +{
> > +     return nvme_user_cmd64_common(ctrl, ns, ucmd, true);
> >  }
>
> I think we cn skip these tiny wrappers.

With the wrappers, the attempt was to retain nvme_user_cmd64
parameters so that we don't have to change all its invocations.
But sure, I can do away with that.

> >  static bool is_ctrl_ioctl(unsigned int cmd)
> > @@ -341,6 +369,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
> >               return nvme_submit_io(ns, argp);
> >       case NVME_IOCTL_IO64_CMD:
> >               return nvme_user_cmd64(ns->ctrl, ns, argp);
> > +     case NVME_IOCTL_IO64_CMD_VEC:
> > +             return nvme_user_cmd64_vec(ns->ctrl, ns, argp);
>
> Maybe add a rationale why we don't need a new ioctl for admin
> commands to the commit log.

Not many admin commands are buffer-heavy and likely to have lower
invocation frequency too, so I did not think of adding support.
If you foresee this to be useful for some (maybe log-page or
fw-download), I can fold that in.

Thanks,
-- 
Kanchan

