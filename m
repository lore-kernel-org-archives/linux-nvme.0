Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7DEC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chicRdpt/RHl6Og52i4WwN8FqyTqPtr7pyE/vQ8o7sU=; b=OhVzsmoKLJTEo3SoDkgQiLWydX
	4JWFy2kJ7woFlOjhjKry2nzJsBM46D5y4PQt5IuS2KX0Cv/X0O/rFivZRcg5uj69Es2+nS735YcOl
	tcgAnJ/XrEINV6MDqUvLVzgWGBmaJ8K7lhAjJlDmweSPXBWbKQkqRy4Uwlz2dtKcZXVT9A5TCCFK8
	FGlJqTfC4QV1dsKPhuSUo9FgZUCnfs9v/4diHm3c7r9M0R/oxWTbp3Z2tjCu4PVcC+T62C0O/2Spk
	RORjtT6S6kcPitkwnjmAgnzafQ/SbTvSb4CijRcjeeeRvOqiOSnOtIBMeYNcX5uU7+3NEKmBuroM4
	dQxhT1fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jLj-0000000Furu-3XFW;
	Fri, 18 Apr 2025 10:53:35 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jLg-0000000FurL-40IU
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 10:53:34 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso13931395e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 03:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744973611; x=1745578411; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chicRdpt/RHl6Og52i4WwN8FqyTqPtr7pyE/vQ8o7sU=;
        b=butyKoHMsjrWRqPVj3mwwgGwHqiX8Vtxxxi4B1iv2y3tT6ENUN1yFx+GIx87pv8JBC
         L3tRx/43dNWDEXo6Vbv2QWWnox5OlN+mtFfFmb0Zh95GVkdzn0hmHulJzKwXS1kPURYM
         2UXJl+LX9ixXSxzt5cNPkv88qQbMl4wDnB77tmT6R+3V+evYNOTWqpyeVngtPvmgLMaE
         J8ZTiRMHtG+tJfHVOHyjdpPOlcv96omhVXa3rwxSr6zLp64Vd5mJ6U7x+8Cx9stKPN9n
         Kgl889GTFls9RmgcuwD6RR2xskjC7MwSqZGfC0PW5q6qCb4VywzNK3ZQkSPq6MhrTB4m
         Oprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973611; x=1745578411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chicRdpt/RHl6Og52i4WwN8FqyTqPtr7pyE/vQ8o7sU=;
        b=fgIEO4+L2VYsIqIg0Qx/wEQ1/freLb7Q7kMChFIgXMKE7F59j3tHBPVDaVp7Zn7kT5
         HvYtLwjToPpwc3gko3St0FqJO8wWxnv0RRx1zhiPG89X+MT5Aig6o4muWIc+2bi7cGvY
         QOpBlniskfpeRVD/hNmlS4w/7yqXlBTwLfOu2oZdCADep8YZ8xQsgAfu7zpiYKVuhhP7
         L0ZvgbNljN7UNNiVB2u7nl9ekd7mtpZRwLvyA0vCy7vrpSMr5E97OS9cf9IakfHduh01
         4ln1k6GfDa9YF3h+3ti+Cmpm6I9nOPfh1nnHN9uu17t0hESe9zYoQczBDal9QJRQeT5X
         3/+g==
X-Gm-Message-State: AOJu0YwqxljpJfWVXE5B56nTPK2uFPju8f5+IhrN5rN/PVUwXGSyocIy
	4una/gyr6F4ErSOJIxBlQ+iVzxpEUdOE8D8Z5/6cVTmCd7CLrxyNT8IJT2j9MhV+3MHgHDw2dWd
	B
X-Gm-Gg: ASbGncssUnTjzuYBFZ6JbHMk2dqE+LPqvedYDbKrZAnhL8MSGIy2M9j+1m/dVox+k+v
	Zjkj5Wg6gdjbtTfNHOfuI3hYzpIOquQvQI+Bvu6wNw/LOW01nN9NGxRxJDWPQ/rXy/cAnqYGffh
	b0QW7/B8zL/4eeTTcYhcXZgXPJj3aPvxsfWpbQE0GlpuIDCXI72KiymnHP1MfoNBvTvCoqOnSWR
	jELGV+bQfClc8DSc4sU652NxoYBnsTJPAcHPUzKqCRR95rD6rQxiDNhWFkrB5NNGn/VGxXgFHNI
	6/MemKDOmhGsfHchsjyY7WVSM1Qw+8Q7bjUBSCQMei9jm2y/2drEgntn/T15gvHMdj873uf1k3T
	UelkzO+dV
X-Google-Smtp-Source: AGHT+IFRGae/w+LSe2Wb9xwhXf4HEpT8dkNYJ3tTEo4SBBzlp0BYf8M0aTZt7D6qMJek4Sctywyk2g==
X-Received: by 2002:a05:600c:1c81:b0:43d:2313:7b49 with SMTP id 5b1f17b1804b1-4406ab970bfmr16426115e9.12.1744973611145;
        Fri, 18 Apr 2025 03:53:31 -0700 (PDT)
Received: from somecomputer (84-115-238-41.cable.dynamic.surfer.at. [84.115.238.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d712esm17389405e9.36.2025.04.18.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:53:30 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
Date: Fri, 18 Apr 2025 12:53:28 +0200
Message-ID: <6281253.5x4bddO4Km@anvil>
In-Reply-To: <9f8fdcc0-53ae-4255-b221-b4e787320c44@kernel.org>
References: <20250418090834.2755289-1-richard@nod.at> <8418057.aG60p0z9Xu@anvil>
 <9f8fdcc0-53ae-4255-b221-b4e787320c44@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_035332_993765_9F213281 
X-CRM114-Status: GOOD (  21.59  )
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

On Freitag, 18. April 2025 12:23 Damien Le Moal wrote:
> On 4/18/25 18:56, Richard Weinberger wrote:
> > On Freitag, 18. April 2025 11:37 'Damien Le Moal' via upstream wrote:
> >>> +	if (!ns->blksize_shift)
> >>> +		ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bde=
v));
> >>
> >> If the user set logical block size is smaller than the block dev logic=
al block
> >> size, this is not going to work... No ? Am I missing something ?
> >=20
> > Likely, yes.
> > TBH, I'm not sure whether it makes actually sense for the bdev case to =
make
> > blksize_shift configurable.
>=20
> Probably not... I do understand the value for the file case though.

The use case is exposing ready-to-use cloud images like:
https://cloud.debian.org/images/cloud/bookworm/20250416-2084/debian-12-gene=
ric-amd64-20250416-2084.raw

via NVme-of TCP.
Yesterday I did so and figured that no GPT partitions got detected because =
of different block sizes.
Setting the block size in nvmet to 512 made it work.

If there are better ways to achieve the same, I'm open for suggestions.

>=20
> > The case I see most benefit is the backing file case.
> >=20
> >>> +	if (!ns->blksize_shift) {
> >>> +		/*
> >>> +		 * i_blkbits can be greater than the universally accepted
> >>> +		 * upper bound, so make sure we export a sane namespace
> >>> +		 * lba_shift.
> >>> +		 */
> >>> +		ns->blksize_shift =3D min_t(u8,
> >>> +				file_inode(ns->file)->i_blkbits, 12);
> >>
> >> This will work for any block size, regardless of the FS block size, bu=
t only if
> >> ns->buffered_io is true. Doesn't this require some more checks with re=
gards to
> >> O_DIRECT (!ns->buffered_io case) ?
> >=20
> > Good catch. I'll add a check.
>=20
> And by the way, you need to check for STATX_DIOALIGN since some FS (e.g. =
xfs)
> can handle direct IOs that are not aligned to the FS block size. See the =
recent
> changes in drivers/block/loop.c to improve direct IO handling, specifical=
ly, the
> function loop_query_min_dio_size().

Ok!

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



