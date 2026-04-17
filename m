Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01050F8E499
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KsO1NaX9EqdvAZLJ/Ig7h5Lud7184o3UpmgRp/VzKQ=; b=Bvdu4Hz6Ph3zN+tdw93tBfuGvg
	oLOxOAsCLnBL9tIpK+Nfve2ZexztTANCCcgfDOcI2eeH6r7Z6QGvu3vYbTMWwabFUFRefqCawzM+m
	y8V8v5/cF9gJfSjG7wSmTkCLByTKnOmZaRbpvNKPJ/Jqb+z9qtJvQEFsjthZEai5qzjgR4NT3ZS2+
	J2tvsuNGQLWqOFBEtKDtvBkzHiL8NZpc9n3C2EHXBYS2Vc4EVCsIkpgBSIcK9Li8gRyOt0D5lPnMn
	CoSRCccN6nVnmQ8SQ8zvneWCVup6DHOaqrcT20phzQXMqXXo+SCkU7veMCoeH+ixS4gVGUTtoXB9d
	j7CRQAfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYOZ-00000003HyI-1Jrx;
	Fri, 17 Apr 2026 01:53:23 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYOV-00000003Hxn-0lr0
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:53:21 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7dbb38eaf49so34382a34.2
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776390797; cv=none;
        d=google.com; s=arc-20240605;
        b=XPeVwFHwODuuDbi8fI8PvNir+Iz+woIiQmnTf796wBcyJ0Y5pZCduKJZ3oKUx3tPdR
         qPKFIcWFwSjhKTL0H6L9EoWbzgegWUGsVR5jVdeyHGcIZzeY+AUxgGs6comYaNATK1+R
         kX/ryE6YTZbifZJJkMzw1G+MzokGc+Mh+TVkVt+vcFGWVAFo22BMJQBDyX6LuXFQut2Z
         sMVSKRvv0GUdZwe+okbJPwdZnFEYyCeLyAlhp1/UmQbrbCGMf7VUjhNdfEJfvyNI0kfT
         aTXISw4UyWl7L8g/5QMuWCcPpoDbEyUCKaxGWXHCkG+PkKCUuy+ItrMUXYRQTFSevdLV
         EHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KsO1NaX9EqdvAZLJ/Ig7h5Lud7184o3UpmgRp/VzKQ=;
        fh=gNeI9zRP2PkTUUqVVZVmfo0WSgMJG0pXaKPKw1ewRgA=;
        b=kXTYVrWn+MK/sCIpPKbil3dl0c2UAIAjx8Z9bYi09AT/RsNmL/xDMbKpqqi8POkUPy
         CMIIPfE98ai44Cfkl+OplA6/o2Mb7OgCSc9q5zGTIBuB09yIiENLhroFjkF9amQv9d78
         JCVYZydT3VVH4bmpzMybWrY3p70YCUOY6uMAyTmo7kMvfixM+ARPOOAptKjl0iuyRAzk
         QvU0OLLK68rg3RlUmZcsqWhQB9etx0rPQEkK09RaWvPQ9htafc0VbGehKQcAkHu/nlsj
         rqS2Mhxje1QCCrKcg4/yZwm8cWnvaAYFLLT2K1JZczEIpWRhN7OJSPq3N1tDTyvA6S7W
         bJQw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776390797; x=1776995597; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KsO1NaX9EqdvAZLJ/Ig7h5Lud7184o3UpmgRp/VzKQ=;
        b=Nd5hHQFvC8z8aADStzXpNzJlWDGntCwHkHSXZy+bvpIAEuJ5OkssPULuvryc4+kTBE
         XPr9udECRyDZ4hMD3ivwFPpxf6Th15N5KxPzIhuSGN5EOnmtDXDtn2MmxEhmvX+u7uk2
         63TAoOSeiWsCNmCJFHKHChWXX21bj7DysCbhuTXzJeKbfeBmVUeRw3RhiiV+iuYwmQrg
         ffVWl4fWkGL9yrMKutjPJB6qLZacdzz/6iq+r4/ObD7KOHUkOWRHxp9aYP/g8qeqZ8Rn
         mCZfKJG3jKvDQpQl0D4qPmxuzs/YP1W4DNE7sf9ks4VkR3VF8x0Innrph9E7dTFv44GD
         OtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776390797; x=1776995597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KsO1NaX9EqdvAZLJ/Ig7h5Lud7184o3UpmgRp/VzKQ=;
        b=GdRx/yJbVs/1DPqfKJxJjgneiXZLOIacoaPMvpIkKNiVOxlJ3aTmDUtTettYX91pgM
         APAaJDqTvpClCYWcYh+WAAtpY36UfwU62UAdqFKIndckQHQhyIyu3lB0DxN1W+3od4rh
         gnfIY7RiO1r1BZxbdYd5NDsuOcKMSxPix8udzTIdO190Hym7JAPbbBLgd4jlvUZkmLKD
         CasBClyifP+o+lnU0zRbhviGfIN59WrOL4y6ZCXIVHfZS59UJqCvVcNba3AHG6z5Adk+
         NxaxaTEbkWx4XQGojrEkiPR4h/gWXIvcJ+9ir3UFUPHmyzUAh/UGeEV5wCVqZg0nMOqM
         PXfA==
X-Forwarded-Encrypted: i=1; AFNElJ9zuEtXzczNnrnlKVk5ZonY+kJ+d2OioUj9h3+DMpDdDpRRTsPI20NnB76gdWSgk6MvGyMTPQsmF6am@lists.infradead.org
X-Gm-Message-State: AOJu0YylUsfaWcEplVwQm1hLoz9qZQmdTo+h/xwIt1k1ekEJAPOl4eD6
	omRE+aj811tDHQRdnk3FiXgGQB2TY+zvhi8li7ZW6i82llZkge26YKhK7RqIvSfOKJ4T2W7zfA9
	FNBAorLPuOlaeV+8JT7IbbfJTyczPj4t4YTjXYiHOvg==
X-Gm-Gg: AeBDievQ3vZ3Rz/GQoxscxOyK94o+mwGA8O/2ZCGskThIXEzKs4Y7V2rsaUf+AsbeDd
	9Ot/y0hgvkcB3usm22/NcsMQP/8gXGLuFyQmOXz2OTzs92t4gkNDzM2EXAl3qeGCN+pISmBPrPG
	GlbCVjzpb7ghdgEmySsE7Rq+HZn5Xt9DHeIC0if9De1VQ8N0d+VE4/+om2iSHj7jP+L/d0l3MBE
	CjA2YL9I8h974cPCYzFIs4XoLtdwMkQTLcLVDe1jV/7+3S1oKEiF+z8KkjsEyyfqhh4SkQVpjgw
	zOuOWz0txxLDl48Z2Tc=
X-Received: by 2002:a05:6871:ea06:b0:423:e2d:bcd5 with SMTP id
 586e51a60fabf-42abee7a63fmr242473fac.0.1776390796946; Thu, 16 Apr 2026
 18:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260416002214.2048150-1-csander@purestorage.com>
 <20260416002214.2048150-7-csander@purestorage.com> <20260416052325.GE14950@lst.de>
In-Reply-To: <20260416052325.GE14950@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 16 Apr 2026 18:53:05 -0700
X-Gm-Features: AQROBzCPGHONvWMncmYhZ1NMXp33B6ERld-DgLK_KyRg3_SVXkVvrIxlwuDEnA0
Message-ID: <CADUfDZpbOhO9BUW_mFZYh9-UZU26_o3rFGBffNTpepk0ogJhZw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] blk-integrity: avoid sector_t in bip_{get,set}_seed()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185319_407506_27BA886A 
X-CRM114-Status: GOOD (  29.66  )
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

On Wed, Apr 15, 2026 at 10:23=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Wed, Apr 15, 2026 at 06:22:14PM -0600, Caleb Sander Mateos wrote:
> > bip_set_seed() and big_get_seed() take/return a sector_t value that's
> > actually an integrity interval number. This is confusing, so pass
> > struct blk_integrity and struct bio instead to bip_set_seed() and
> > convert the bio's device address to integrity intervals.
> >
> > Open-code the access to bip->bip_iter.bi_sector in the one caller of
> > bip_set_seed() that doesn't use the bio device address for the seed.
> > Open-code bip_get_seed() in its one caller.
> >
> > Add a comment to struct bvec_iter's bi_sector field explaining its
> > alternate use for bip_iter.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > ---
> >  block/bio-integrity.c               |  5 ++---
> >  block/t10-pi.c                      |  2 +-
> >  drivers/nvme/target/io-cmd-bdev.c   |  3 +--
> >  drivers/target/target_core_iblock.c |  3 +--
> >  include/linux/bio-integrity.h       | 11 -----------
> >  include/linux/blk-integrity.h       | 14 ++++++++++++++
> >  include/linux/bvec.h                |  1 +
> >  7 files changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> > index 3ad6a6799f17..e9ae5db99f64 100644
> > --- a/block/bio-integrity.c
> > +++ b/block/bio-integrity.c
> > @@ -103,13 +103,12 @@ void bio_integrity_free_buf(struct bio_integrity_=
payload *bip)
> >
> >  void bio_integrity_setup_default(struct bio *bio)
> >  {
> >       struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
> >       struct bio_integrity_payload *bip =3D bio_integrity(bio);
> > -     u64 seed =3D bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR=
_SHIFT);
> >
> > -     bip_set_seed(bip, seed);
> > +     bip_set_seed(bip, bi, bio);
> >
> >       if (bi->csum_type) {
> >               bip->bip_flags |=3D BIP_CHECK_GUARD;
> >               if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
> >                       bip->bip_flags |=3D BIP_IP_CHECKSUM;
> > @@ -472,11 +471,11 @@ int bio_integrity_map_iter(struct bio *bio, struc=
t uio_meta *meta)
> >
> >       it.count =3D integrity_bytes;
> >       ret =3D bio_integrity_map_user(bio, &it);
> >       if (!ret) {
> >               bio_uio_meta_to_bip(bio, meta);
> > -             bip_set_seed(bio_integrity(bio), meta->seed);
> > +             bio_integrity(bio)->bip_iter.bi_sector =3D meta->seed;
> >               iov_iter_advance(&meta->iter, integrity_bytes);
> >               meta->seed +=3D bio_integrity_intervals(bi, bio_sectors(b=
io));
> >       }
> >       return ret;
> >  }
> > diff --git a/block/t10-pi.c b/block/t10-pi.c
> > index 787950dec50a..71367fd082bd 100644
> > --- a/block/t10-pi.c
> > +++ b/block/t10-pi.c
> > @@ -510,11 +510,11 @@ static void blk_reftag_remap_prepare(struct blk_i=
ntegrity *bi,
> >  static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *=
bi,
> >                              unsigned *intervals, u64 *ref, bool prep)
> >  {
> >       struct bio_integrity_payload *bip =3D bio_integrity(bio);
> >       struct bvec_iter iter =3D bip->bip_iter;
> > -     u64 virt =3D bip_get_seed(bip);
> > +     u64 virt =3D bip->bip_iter.bi_sector;
> >       union pi_tuple *ptuple;
> >       union pi_tuple tuple;
> >
> >       if (prep && bip->bip_flags & BIP_MAPPED_INTEGRITY) {
> >               *ref +=3D bio->bi_iter.bi_size >> bi->interval_exp;
> > diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io=
-cmd-bdev.c
> > index f2d9e8901df4..2c4b312f2f55 100644
> > --- a/drivers/nvme/target/io-cmd-bdev.c
> > +++ b/drivers/nvme/target/io-cmd-bdev.c
> > @@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req =
*req, struct bio *bio,
> >               pr_err("Unable to allocate bio_integrity_payload\n");
> >               return PTR_ERR(bip);
> >       }
> >
> >       /* virtual start sector must be in integrity interval units */
> > -     bip_set_seed(bip, bio->bi_iter.bi_sector >>
> > -                  (bi->interval_exp - SECTOR_SHIFT));
> > +     bip_set_seed(bip, bi, bio);
> >
> >       resid =3D bio_integrity_bytes(bi, bio_sectors(bio));
> >       while (resid > 0 && sg_miter_next(miter)) {
> >               len =3D min_t(size_t, miter->length, resid);
> >               rc =3D bio_integrity_add_page(bio, miter->page, len,
> > diff --git a/drivers/target/target_core_iblock.c b/drivers/target/targe=
t_core_iblock.c
> > index 1087d1d17c36..4e0fa91a08fd 100644
> > --- a/drivers/target/target_core_iblock.c
> > +++ b/drivers/target/target_core_iblock.c
> > @@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *=
bio,
> >               pr_err("Unable to allocate bio_integrity_payload\n");
> >               return PTR_ERR(bip);
> >       }
> >
> >       /* virtual start sector must be in integrity interval units */
> > -     bip_set_seed(bip, bio->bi_iter.bi_sector >>
> > -                               (bi->interval_exp - SECTOR_SHIFT));
> > +     bip_set_seed(bip, bi, bio);
> >
> >       pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_s=
ize,
> >                (unsigned long long)bip->bip_iter.bi_sector);
> >
> >       resid =3D bio_integrity_bytes(bi, bio_sectors(bio));
> > diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrit=
y.h
> > index af5178434ec6..edcd0855abba 100644
> > --- a/include/linux/bio-integrity.h
> > +++ b/include/linux/bio-integrity.h
> > @@ -56,21 +56,10 @@ static inline bool bio_integrity_flagged(struct bio=
 *bio, enum bip_flags flag)
> >               return bip->bip_flags & flag;
> >
> >       return false;
> >  }
> >
> > -static inline sector_t bip_get_seed(struct bio_integrity_payload *bip)
> > -{
> > -     return bip->bip_iter.bi_sector;
> > -}
> > -
> > -static inline void bip_set_seed(struct bio_integrity_payload *bip,
> > -                             sector_t seed)
> > -{
> > -     bip->bip_iter.bi_sector =3D seed;
> > -}
> > -
> >  void bio_integrity_init(struct bio *bio, struct bio_integrity_payload =
*bip,
> >               struct bio_vec *bvecs, unsigned int nr_vecs);
> >  struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp=
_t gfp,
> >               unsigned int nr);
> >  int bio_integrity_add_page(struct bio *bio, struct page *page, unsigne=
d int len,
> > diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrit=
y.h
> > index 825d777c078b..3a2e55e809c5 100644
> > --- a/include/linux/blk-integrity.h
> > +++ b/include/linux/blk-integrity.h
> > @@ -85,10 +85,24 @@ static inline unsigned int bio_integrity_bytes(stru=
ct blk_integrity *bi,
> >                                              unsigned int sectors)
> >  {
> >       return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
> >  }
> >
> > +/**
> > + * bip_set_seed - Set bip reference tag seed from bio device address
> > + * @bip:     struct bio_integrity_payload whose ref tag seed to set
> > + * @bi:              struct blk_integrity profile for device
> > + * @bio:     struct bio whose device address to use for the ref tag se=
ed
> > + */
> > +static inline void bip_set_seed(struct bio_integrity_payload *bip,
> > +                             const struct blk_integrity *bi,
> > +                             const struct bio *bio)
> > +{
> > +     bip->bip_iter.bi_sector =3D
> > +             bio_integrity_intervals(bi, bio->bi_iter.bi_sector);
>
> The bip is pointed to by the bio, so we don't need to pass it separately.
> Same for struct blk_integrity.

I did consider that, but all callers already have bip and bi in
variables that they also use elsewhere. Seemed like it might be
slightly more efficient to just pass the precomputed values instead of
looking them up again. Not a big deal either way. I'll go ahead and
implement your suggestion.

Thanks,
Caleb

