Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4CCC369CF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKwnVUZzWyLWE8JyyGAoHutnjyrjVjeY7Q2Qvd5+NgI=; b=cuXWxf3BS+po5jQnNm4RB4c+sK
	ZIgDKcGKsopPtMM0hEDJXMFy0bTOark/SHGpWQ271HQK/yHKE3i4haiEmYi6laUF5h3UBqlEsCCQk
	Ze2bMVFvEB+uuwUzt3WQzlQRcwdBhTS4mTcHkLSWWZ1TRWk4hc1DO0gcl21E2iWDspotZZ5KjqN1A
	1SAoX+i2HuPbb8hQeYRer/augAfj1fnqTEaWYCYx73rDqUQlvjgga141zVQ4A7w8MXYeYGftONVR4
	Jv/mmN4PhbqrLgmRv9NgrxSnFQe6qaX++ttilSEE8NMP9lc3gdFmefojm3SFYcd9yaOSiyTpl8U04
	e2tpS/+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5isK-0000000Fqz5-0KDQ;
	Fri, 18 Apr 2025 10:23:12 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5irz-0000000Fqv2-1dST
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 10:22:52 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-ac29fd22163so269888566b.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1744971769; x=1745576569; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKwnVUZzWyLWE8JyyGAoHutnjyrjVjeY7Q2Qvd5+NgI=;
        b=o+xTM+cx3QZcU0a7nTSmSAFisoxBb7lx+L13OHdXZkgrOtuID6UJN3pg2vwuyG9ht6
         mA4S2mBI2nnnGf9bkNUbx59U8EGBoHnQruS7OT1rv/m31PswGgs5zVRuAuaxK4ZHFAXm
         IcBZf1iyanbe3cLyWIJXUWUODhlPLqIYbyJLF/ggOxty784HVxSTdP1/7fI35wh0Th6V
         QsXo5myL6llH/p3rN3dsoA0c0RqGqoqRSqclPb8CZLXgjNM8hnBqX4on60aAcX6RMKLR
         5WWChz1foC3izQAnyKHadjUycNWjhni3MyjWyM0hD0Egi6+X5nRz4E7RGX1AOs2KQ2lM
         Zo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971769; x=1745576569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKwnVUZzWyLWE8JyyGAoHutnjyrjVjeY7Q2Qvd5+NgI=;
        b=UYn2hz9LMYDBkIFQ14HKUxZTiFjpBa01qqal5GfentnBnVCBe5l8hUHfIi62p6adG3
         kDzPtfZ+vAqjtg49WP6KoZvsPd1EKtmC3oKi3Fi9ftkMvY3ycoYOK5zISGlgg+d45yvM
         RnfMUsonsT8D1B3K1Iubv/5vcK1272m2xIRoFMMhORZGErJGXUKUqmAKtszf34H1b47N
         gwmjfeoV2/HtnyOt37in54inAdbCy48jZRFnLDVm1/vLFv4Nfx2rNL2WSPW9hSxMLrH1
         pq8J5K4zrpxEZ2PxUHmLBoT2rzr3dgDFTRKHQpqWpSma2nIRFTF7ZyynNH4ZBVzOgcYh
         N0rQ==
X-Gm-Message-State: AOJu0YyPKcKYjblWdWPUYZimNMhsX7ESyUEnizMXouNnb7Tl3+PaLROe
	XTAdUj1lQTh09MoABQzR+d6t219VgGFJUvzA/Ze2XzOJPt1arYBN1v/YCYsPhScqgq7RxJrWnYV
	9
X-Gm-Gg: ASbGncsUTjWHGCkkCPa4tkA0J4GPM9dua7RtuoGH+7hpu4I/pIMLvEPoju2+lEpnNWl
	LafPlROQjDl/wUo6PzW/MportRVTtBKqkfuZeKGf6WcfAJhjUphuDGX6XCI/rgm4sIrT558ip9C
	zL9Okl85maHJqw7cVMjVWbubFVeCfBKgKPyAEvjB/NmjSrD6cIrEFpOrYbF81K3kU8hARCoZw5H
	bCL9KQ+GKwdn1h1D3d3paQNFgsE3pskVQJVqaIozZtux8PbmLII1nPRYBjEDceGDV6GIKjZHd/9
	p0ueERvoSHQnwJA/mTmFhdTsTfQ3acG19zXu4lanCkdcSW8WaXcQ9Q1nPoSTCPkyiAgtxU+3C3m
	qDN2sji/x
X-Google-Smtp-Source: AGHT+IG9b1OB3VsBXUNUUdwj0UHGJGJRVzsWYf3XpNWMufy6eEpIMx2UZrm1XP7AbfDFr7UroQvA0A==
X-Received: by 2002:a5d:6d88:0:b0:39c:2669:d7f4 with SMTP id ffacd0b85a97d-39efbad7d40mr1549867f8f.43.1744970192344;
        Fri, 18 Apr 2025 02:56:32 -0700 (PDT)
Received: from somecomputer (84-115-238-41.cable.dynamic.surfer.at. [84.115.238.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493124sm2269912f8f.68.2025.04.18.02.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:56:32 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH] nvmet: Make blksize_shift configurable
Date: Fri, 18 Apr 2025 11:56:30 +0200
Message-ID: <8418057.aG60p0z9Xu@anvil>
In-Reply-To: <0e61c6e9-10bc-4272-b446-31e0d67547ce@kernel.org>
References: <20250418090834.2755289-1-richard@nod.at>
 <0e61c6e9-10bc-4272-b446-31e0d67547ce@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_032251_424144_C29CDA7B 
X-CRM114-Status: GOOD (  15.95  )
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

On Freitag, 18. April 2025 11:37 'Damien Le Moal' via upstream wrote:
> > +	if (!ns->blksize_shift)
> > +		ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev)=
);
>=20
> If the user set logical block size is smaller than the block dev logical =
block
> size, this is not going to work... No ? Am I missing something ?

Likely, yes.
TBH, I'm not sure whether it makes actually sense for the bdev case to make
blksize_shift configurable.
The case I see most benefit is the backing file case.

> > +	if (!ns->blksize_shift) {
> > +		/*
> > +		 * i_blkbits can be greater than the universally accepted
> > +		 * upper bound, so make sure we export a sane namespace
> > +		 * lba_shift.
> > +		 */
> > +		ns->blksize_shift =3D min_t(u8,
> > +				file_inode(ns->file)->i_blkbits, 12);
>=20
> This will work for any block size, regardless of the FS block size, but o=
nly if
> ns->buffered_io is true. Doesn't this require some more checks with regar=
ds to
> O_DIRECT (!ns->buffered_io case) ?

Good catch. I'll add a check.

It's also worth discussing whether we should limit blksize_shift to a speci=
fic
range. Right now, any shift is accepted, and it is up to the user to
use a sane value.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



