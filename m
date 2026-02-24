Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B65F3C9AC
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9elrl/yx+guJqdKqJuh7B15IGVGLF7zjlE6thsSxbeo=; b=EDJIwUEWknw2IZsodWj/G9DKyD
	NNnPoMDOCtNTdW514NfrFrEHNfiBeynIVbMZLMeVFflIj5dZH+yNRr4b4lNA441uDtuKbpq3+OBxX
	ITye1Ie1Rp2P/7gV2G+7Er0yYeh+9tUd/9MbayivNsbBV2rT2jUe/j8A2PQy9am8ISdPPmk8w36Bb
	l4BvNAp8LKC/gyyEHtosES8MCmn57LmgQIlNQuZrsG6IG7w2i/i30JQyqD/1xJ4DE4BOSBcjLhvgI
	Vz/fzUJKrui3yrYWcv6XatMnJ1bRS0/yuyfXHYUXIYA71JVX7wLgoyIDKtXxuKfu9eLVFWwe9TZsg
	4CQkIkNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuuv5-00000002NHy-3fY3;
	Tue, 24 Feb 2026 16:05:55 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuuv3-00000002NH5-1aGV
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 16:05:54 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b8f94bf6ef2so89453666b.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 08:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771949151; cv=none;
        d=google.com; s=arc-20240605;
        b=jwiFrysP7tOJZ77XNVg+cD4V+o1WTJrUSvEOV8U5Ov4v+WlNGYL3nIFUn4MLONu3lQ
         gH3kgmF9u2ecjovnreAVp7qhKNS+Oo2CpCN8jPRxD5Op3taCBayvBYGmEd5FLyWvfECn
         gONka6khBLyXM0pFOrjLIlRtTqbYAD6kqGl7v5bFeDVwK3Cd4oITGfG7YyblpcKB+D5A
         Ck4sROTiOxcTFWk94Os+X2SGrEA1CcLLgItm1eV5mQOj5bB4VZxfuUL7ZRGfEKLOCikE
         mlWZH17BIOaGO25JHsjxX2EEyZ9xXRYAwX3kPqX3DS97snJkGYp8V9/itN2koA5YTpBn
         nuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9elrl/yx+guJqdKqJuh7B15IGVGLF7zjlE6thsSxbeo=;
        fh=y7nqM+7O78CGXhfdLVm6obwXuJ2v1uHUsICi9vTB/2Y=;
        b=LshZcsa/Uda73kxXj59kXJmoPm0+F8nTT1DLqNXe4rSyURx6t9IMFpoFUDgS56d1qK
         TQolz+h55s0ksSi0DDAFxSmXLuv3x2MmsV/IPDEo/MtGGUWyBo5YEHLQpUF6G/NOhaUS
         exGxFVNWu0tCH8rzJ5ZPczMdVvzcF1Igo4aMmF3OFluEp+OOmSUOBqaABCOg2mDRQU3u
         b73vUlhFC1HYWZhRFvVURx9JtbDRqnkDITZefvV0t/fM3oN7PMXXYNnVkkk6hdSF8tHx
         h51WhYoJJyiDoSs6dST5LoVagXX5C/TTxl3C8tJEgxNne6+KHoBfm5rezphtwvXNn8UL
         BAQw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771949151; x=1772553951; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9elrl/yx+guJqdKqJuh7B15IGVGLF7zjlE6thsSxbeo=;
        b=gkDIIaEKVNpIj6qJy7HqEz2e1u5dQoIscO+0Jp0rzS79RAxKX5LD96gc5ClY5Y3D45
         yLM11NzEJYmwpMybmCqv4Pd8ndcLjg3MZ9Rkuup15PEzRDkzNkI2idmfgSTAxDfLDzaR
         ANiEr+486uw2uKag/esgXks7QPr+VZWzXwS/EkcQLXNZFULiDGpBC0lkk2nX+bFu27WJ
         BsQ5o3WKxpIHZpdhHasTylYbh7j1SGmNOrovSFDkz8JB08QHkFbsCBjLW6t+rd73Du5M
         d3dH7MjhOWL6g3kMBZl5lX4ysNjR1ffMa0FGQbuLNrxR59qoVq9kNiOYnIzaWmk8foBk
         rgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771949151; x=1772553951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9elrl/yx+guJqdKqJuh7B15IGVGLF7zjlE6thsSxbeo=;
        b=omPieo6XlyjRZpzk40WkpUK0aBIThiChjtWuHYj6bYIf2Vf3YkzyKs1O75XTgHr4I5
         FCQ2wryGR6o9RSAAzYINbIUaO8ruL/AhNnIUGN+I4xu6e99Zg+jFICS+ir4Amu1N9Mp2
         PccWtrmGYUfP0tRN0kypmZHc4J4BirNYmhy9NYEfF6gKEvVxsCZwO8jBcb6PHPTorYwS
         zpruXYZKCFkCtX+FnnDLIy18HteB1w9lfyqJLzZWzxMlRVW9rUVpc/N9bYe+YBwAmOco
         HhzAQeB1KdUFc2MxudhzTCKdsLvHv2oGZOs63SMC2zKGGKdN6VuXkCVWrQ+bDM7OM9zK
         yuCA==
X-Forwarded-Encrypted: i=1; AJvYcCVUa8xLdbml0crjvCDRyKNfxP5CRpA4H0sP3ylVVNdDOQPtnetqSdFX7odCpjGFgfsmSizrbOuf1HxU@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/Xpjgk0U4U9LjWLxBIMxypYwbUShBjTia538JtB/19VxVddsf
	jMx6X2hmzSnooF3iNqOJ/cgPYqc0xAU4OllXHfUtdk50cXmnsqcifx4QxLQSBlG3BN0uULiH7zH
	lMGB3AbBDEr1km7awcHc0xhOOKvAP4sZ+AtQCdCD4lQ==
X-Gm-Gg: ATEYQzzawEsBuFbMqvujM/QoFLK3cxKhseHnVs/gTXgT5MoH705uTrAXTGmYfmVIIJ7
	UBHqQ6t5l/aHIAbwjmgH1IV6IM/uL/OqlDBlgf0DSN/r0nFcmsmxiJ1Md+pDFuh6SSNKi27D10s
	GEYOBs56XnfI8WkjjpOKG+S6lfqcya7BonR00q8Eq7V1DaQdV0VW5TkhZPlR3MvkowlAf1CQdce
	v88QgTGLcU8Y1s3nlC/12BNrbuowCHepZNoJr4b/oApTTCTAwaizB8mz7vHJnXtA7G+RkdhmHuR
	x3HS3v1dozhlBO9u3LM=
X-Received: by 2002:a17:907:944d:b0:b87:2780:1b2b with SMTP id
 a640c23a62f3a-b9081b42deemr418739366b.4.1771949150553; Tue, 24 Feb 2026
 08:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20260221033302.1451669-1-csander@purestorage.com>
 <20260221033302.1451669-6-csander@purestorage.com> <aZ3Aib5gQlIiIaEp@kbusch-mbp>
In-Reply-To: <aZ3Aib5gQlIiIaEp@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 24 Feb 2026 08:05:38 -0800
X-Gm-Features: AaiRm529SReJJacBJBeqpsD0vSQd0hbecA02l4HpaODihodeqyEBKLbliz0xMiE
Message-ID: <CADUfDZrYmfikCe1HB7G-5JqXWwVeAgiJduDrj+qX1Ca9VdhgAg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] nvme: set discard_granularity from NPDG/NPDA
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_080553_433249_8770B9AF 
X-CRM114-Status: GOOD (  12.97  )
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

On Tue, Feb 24, 2026 at 7:15=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Feb 20, 2026 at 08:33:00PM -0700, Caleb Sander Mateos wrote:
> > @@ -2113,11 +2114,27 @@ static bool nvme_update_disk_info(struct nvme_n=
s *ns, struct nvme_id_ns *id,
> >       else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
> >               lim->max_hw_discard_sectors =3D UINT_MAX;
> >       else
> >               lim->max_hw_discard_sectors =3D 0;
> >
> > -     lim->discard_granularity =3D lim->logical_block_size;
> > +     if (ctrl->dmrsl && ctrl->dmrsl <=3D nvme_sect_to_lba(ns->head, UI=
NT_MAX))
> > +             lim->max_hw_discard_sectors =3D
> > +                     nvme_lba_to_sect(ns->head, ctrl->dmrsl);
> > +     else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
> > +             lim->max_hw_discard_sectors =3D UINT_MAX;
> > +     else
> > +             lim->max_hw_discard_sectors =3D 0;
>
> Something seems off about this patch: these last four new lines added
> here are the same as the unmodified lines preceding it.

Good catch, looks like I bungled the conflict resolution when rebasing
these patches. Will remove the duplicated lines.

Thanks,
Caleb

