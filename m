Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC1DC54E90
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 00:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kG+6aGCdgjc3eMqVLziW0Hb1LJdrswmRlFxe97FuFQE=; b=hmu70LC3jqWUDJ2R3PyQZ+f3ve
	lxZb6+DfyqZ/oCrc+NEb2ZDzycW6VJCz8bYiGa+oJTEtkm4KhdJOcalCk7KxohUE4hPdzrRbQ9AWp
	i5xspDWodKtm/02o++6Q33KxpW+r9ApuBolMZGX8JNuZTRptbgCJwo7VvzKnaJh18lQh4fNfl948P
	/ozuY4nPk3E1+a89O9yt8IZz03B0EZtj63kDOd7wAlM6vJGlimGzuBsZ3KxHUprpqp6E9EwJqVgVV
	A2I6gImoklfv0uIiplKr6hs66StYNwVE1hfekSqOMeNWys0ElQT7gHdFx2lrS7ApkhMJwJg42zElQ
	/dAWV7xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHu9W-0000000H97C-2xWc;
	Thu, 22 May 2025 00:51:18 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHu9T-0000000H969-2pfK
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 00:51:16 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-af5499ca131so734976a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 May 2025 17:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747875075; x=1748479875; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG+6aGCdgjc3eMqVLziW0Hb1LJdrswmRlFxe97FuFQE=;
        b=YJ3y42Nt4ImbXXlk5dQAwlL2fdWKFqig6Z8s8eMGdsUR8Eo4PcYpbz2NzFXvZXmxBE
         YnyAVlELNrYKTGqEgCh1ab/6vFZSvdG/tIETiFup0Jw32axZPf6CtosmAf++HyM52MTT
         MbMrmPI+nX+6QSgi6gjDx+TEK9Wz4s0SYxlKT4vcpMbNpZYwTIlVDaxt0rI8XM4ZyIEU
         nJ26fNaMqUifJQFuJwIf0rIkPaObxJuceTCU00OBSRmaf9gK0eZwLKhEFtRiDu1NAZLC
         93PdB4/eyEyIKs3/EqlvOrKCTP9XUkHFRwZbmGeDDiFexuKJ0iLzpWXrbQzKhnra2ZR4
         ScBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747875075; x=1748479875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG+6aGCdgjc3eMqVLziW0Hb1LJdrswmRlFxe97FuFQE=;
        b=B1xkQjcBc6Gqcm0sveTU2UwjNPbTzSr7nCqHWyyi51SSMClK9M/P4vsZD/BtjWwBPS
         yXKQt5tJD9CvKuutKYaXsKc6pAwZDsDkjp0rOXC5kORFM2bqX8rrlkhua7rSFMjWkSKE
         QtAp/w55ggqxVKhXuNc7vrc0Kgu/7wRfHQ4RFxBbaotlmwllphzSTvXwPAMJfYtF5cC/
         LQpOhmMiNH/2mUKSc5DcukjGZv/mkTWJ+Eb/3N0ABuYtZTR2Yohvq00toDbW32fUQIp0
         vdv/uGi3z6G95zUrtzXyPsi59tjHjwGMjlpy+ve6dvo3iKNUsePplx0f6FnoP2lpCjf5
         GF+g==
X-Forwarded-Encrypted: i=1; AJvYcCXss9Rghw5KMmY3CYyDA7Y2+uwRVqxvfWWMNj6IWKtzQeVRNi/OBKKJAeNNd8zqPrhF1cx3vn3BDnf6@lists.infradead.org
X-Gm-Message-State: AOJu0YzTpc2oMuGPMculBIZXZ0GWRcCTy73Mqb/X4bVLtIKOcqViC/FS
	Duj2BMknj60X0sYwUsB5onLTj5QJDxD1Yy3SS8SX/+mlr8G54pdH6p/IzlKo8bDTXfqsUEu689Y
	Jc3s2NqxtGFWJ76SHWnutxRDJtB2biPAt4i638CMWUg==
X-Gm-Gg: ASbGncsgso/LGmI/MIMBPMCvz5mVYMNliWrEVhDUuv0BuK+0e/w2Y7VLKyE9szmrZL5
	BGoLD5jnXtvSr/mucqxIsiwgiVCaIZQBa1AGGh+a5Du/o3W9xGL3rdjbvjNoveI5NiQzr/4FmCo
	R10Y07p9JuSECRJxXo//XUUNRY2p8gyr0=
X-Google-Smtp-Source: AGHT+IE8KQ0pBaWIeM5RZZMuIPd3ZaANbtrHqYHKbNjtw97yc6uUPYF3UaMGKq2Xbzamen9e/r9yZwYNyIz8jOSGgaY=
X-Received: by 2002:a17:903:3316:b0:231:e331:b7d0 with SMTP id
 d9443c01a7336-231e331bb9cmr90635705ad.10.1747875074726; Wed, 21 May 2025
 17:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
In-Reply-To: <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 17:51:03 -0700
X-Gm-Features: AX0GCFudnwvn_Udgiur8069Jmsj9xowix4SDZDAHPqTd0gHgQT3ZpP6zXJP2fH8
Message-ID: <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_175115_717282_F12068C0 
X-CRM114-Status: GOOD (  24.05  )
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

On Wed, May 21, 2025 at 5:47=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Wed, May 21, 2025 at 3:31=E2=80=AFPM Keith Busch <kbusch@meta.com> wro=
te:
> >
> > From: Keith Busch <kbusch@kernel.org>
> >
> > Register the nvme namespace copy capablities with the request_queue
>
> nit: "capabilities"
>
> > limits and implement support for the REQ_OP_COPY operation.
> >
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/nvme.h     | 42 ++++++++++++++++++++++++++-
> >  2 files changed, 102 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index f69a232a000ac..3134fe85b1abc 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -888,6 +888,52 @@ static blk_status_t nvme_setup_discard(struct nvme=
_ns *ns, struct request *req,
> >         return BLK_STS_OK;
> >  }
> >
> > +static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
> > +               struct request *req, struct nvme_command *cmnd)
> > +{
> > +       struct nvme_copy_range *range;
> > +       struct req_iterator iter;
> > +       struct bio_vec bvec;
> > +       u16 control =3D 0;
> > +       int i =3D 0;
>
> Make this unsigned to avoid sign extension when used as an index?
>
> > +
> > +       static const size_t alloc_size =3D sizeof(*range) * NVME_COPY_M=
AX_RANGES;
> > +
> > +       if (WARN_ON_ONCE(blk_rq_nr_phys_segments(req) >=3D NVME_COPY_MA=
X_RANGES))
>
> Should be > instead of >=3D?
>
> > +               return BLK_STS_IOERR;
> > +
> > +       range =3D kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
> > +       if (!range)
> > +               return BLK_STS_RESOURCE;
> > +
> > +       if (req->cmd_flags & REQ_FUA)
> > +               control |=3D NVME_RW_FUA;
> > +       if (req->cmd_flags & REQ_FAILFAST_DEV)
> > +               control |=3D NVME_RW_LR;
> > +
> > +       rq_for_each_copy_bvec(bvec, req, iter) {
> > +               u64 slba =3D nvme_sect_to_lba(ns->head, bvec.bv_sector)=
;
> > +               u64 nlb =3D nvme_sect_to_lba(ns->head, bvec.bv_sectors)=
 - 1;
> > +
> > +               range[i].slba =3D cpu_to_le64(slba);
> > +               range[i].nlb =3D cpu_to_le16(nlb);
> > +               i++;
> > +       }
> > +
> > +       memset(cmnd, 0, sizeof(*cmnd));
> > +       cmnd->copy.opcode =3D nvme_cmd_copy;
> > +       cmnd->copy.nsid =3D cpu_to_le32(ns->head->ns_id);
> > +       cmnd->copy.nr_range =3D i - 1;
> > +       cmnd->copy.sdlba =3D cpu_to_le64(nvme_sect_to_lba(ns->head,
> > +                                               blk_rq_pos(req)));
> > +       cmnd->copy.control =3D cpu_to_le16(control);
> > +
> > +       bvec_set_virt(&req->special_vec, range, alloc_size);
>
> alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> amount of data used by the Copy command, which not all controllers
> support (see bit LLDTS of SGLS in the Identify Controller data
> structure). We have seen the same behavior with Dataset Management
> (always specifying 4 KB of data), which also passes the maximum size
> of the allocation to bvec_set_virt().

I see that was added in commit 530436c45ef2e ("nvme: Discard
workaround for non-conformant devices"). I would rather wait for
evidence of non-conformant devices supporting Copy before implementing
the same spec-noncompliant workaround. It could be a quirk if
necessary.

Best,
Caleb

