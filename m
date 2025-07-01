Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598FCC83038
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y38AAXsAJd3bGos1ifagMLdar2TgEuC+xmcby9+v3Zs=; b=m1zlyB43IIj2b4mh+UwZ+V8QiT
	RNPtHE1elehYF7DfQwprJXIBBWdIARPJvT78ZKAuCuS+EriFE2AIw1UBPQfEa/apmGxOOucPmES/4
	RzKrRVw9a86v+bsmVRi/qewbcY7qzFWY+1RgYl7awDb6fBzmQORk6rvn4brFHvm75XYBhcOd9v5Wn
	aOfVrV4WTv9lVPmule4ygkMo9vs5C13WmU4O+hvK/wP5KS/VBXancD8y9MZBg4QNSz8ntouGrBegi
	rVOaZ+P/rgOQ/+LRv1VQ9igxro8Ger+dN6wBVywgQq0haj5hQxzr5sVBue8vsAvYaDLRei2VFXCC1
	4P6E0a2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVgV-00000004Igb-3wnj;
	Tue, 01 Jul 2025 07:45:43 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWV7k-00000004Ehk-1NYU
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 07:09:50 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso568158966b.0
        for <linux-nvme@lists.infradead.org>; Tue, 01 Jul 2025 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1751353786; x=1751958586; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y38AAXsAJd3bGos1ifagMLdar2TgEuC+xmcby9+v3Zs=;
        b=Bx2FBcOKLY0YWasAIjYH8Mbw+7OmGKsAFhZZI+aeYEflufNfyHXXaBtJn8IJFQKWoS
         +PYq/FyOjYKv4pZuo41Rwl8lXUME/q71omV0VgViE/xnSbsmG43sHQ3kM/0DTqchTqyi
         oschPqh4uhWf4YzLe0CF65IleUaMnxT/bHkh47BAkbvt8NuF5A4MeG10fjy0rNsCOlvn
         R5ZTyx3NiOHgkAaRvyL1CR67+qo2CcbARs8G9xm2PH919WNke72eFCa+PNO2WMN1bOEW
         RDBLx03jf5mCy47UhXuT+A25QIVAGXGkE+GV4VUHgPP0wHGIWM9CTgQt4lYaqa6K9Z+a
         kqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751353786; x=1751958586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y38AAXsAJd3bGos1ifagMLdar2TgEuC+xmcby9+v3Zs=;
        b=kj+JJ5Y878KGthraKaQkfO8AWkuRKHUyllcohxH5hcfXiGdt8AWF/4MF4tiyFwUsw3
         600KKqjPagIk4/XxbGonh+ttCmqq4vMkBrQ3YrrxaqqKKtbJ0gD8pFOd8VM7b36UDmq8
         uSkJwJXss5/3oMvqRL4uKXfMRbkV794uNGNxmgVT5MzjcCbGguYt/eQAqUcp0KlLtF1f
         8cpAg5d3m+YZmIVoTr535YXBGx2n7vj9c51CkUNe+4quzaq20K83ynCaV5W+rBBWunf0
         8HCQUzg3SJJv+t30zlQAHegzRlo0EW++haBWDHH6MM3vj7GmBzIzQMiEn1dJXHH3kT7+
         P4YA==
X-Forwarded-Encrypted: i=1; AJvYcCUyU/NAz+Ohz1n59vPxfRIu86S7CcBNaKNVxXg3QF/uDF4B091UAtk3b9N4GIiAX0O7RFaQrI8C4HD+@lists.infradead.org
X-Gm-Message-State: AOJu0YxBBQ24/nrNQrpWUSyhYw4lFulq0V0LiVz01gg6k5AJ9JEnAC/m
	zJK3iAX+Qpt23H9kCd6PPa2UmhrK6gK1lW6hXgs8JRgd7/v1B0P+bMDiBDBgmCwXsmM=
X-Gm-Gg: ASbGncutifyWZuRa4kK/+M11MCsiC855XTnhI3Gg7ArX6u3vKOgukTS2FWRi4yeWGy9
	p1xkljo3nWkkYRo/8keyJUg+MW8/L5kfqjyeLCTjVm2AOc+/6pFSFL2Cz0l1eQ66CCgZsOlu4+F
	AUHV6al63gSctBKzbr4HD7HpUnG8SWkDt3rysiKMW8qsp5WOwRQigyDRIdTjZ9trQLY0VjBGtZS
	gD+RFTqa33HoA7agokL3cYjbWmCN1rfOeMIZ53tGtncLNrhOTC+aRqNPGPaOhFg7EXGGjHugG8L
	BPsEYGOMxAVhzkQRNtMU5II4JNQRiw/NHUkszuTeCrsE/mm4lsdZXRkirP2JSMWA9MIKwnPlieB
	h45f9/iGMb+4QodqWoAn3sEht22U=
X-Google-Smtp-Source: AGHT+IG3RuoJ2BkEOIOPAMGl8XCV5kKpcDgg7D6y87yVO6s/fbOlmcqvDqhSos21KN8h1lSUZcnyJw==
X-Received: by 2002:a17:907:3d92:b0:ae0:c215:5be2 with SMTP id a640c23a62f3a-ae35010fd55mr1552179266b.30.1751353785354;
        Tue, 01 Jul 2025 00:09:45 -0700 (PDT)
Received: from somecomputer (85-127-104-84.dsl.dynamic.surfer.at. [85.127.104.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b347sm817941266b.35.2025.07.01.00.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:09:43 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org,
 upstream@sigma-star.at
Cc: linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] nvmet: Make blksize_shift configurable
Date: Tue, 01 Jul 2025 09:09:42 +0200
Message-ID: <2920993.eCsiYhmirv@nailgun>
In-Reply-To: <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
References: <20250630191341.1263000-1-richard@nod.at>
 <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_000948_680622_42D2FCF0 
X-CRM114-Status: GOOD (  47.02  )
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

On Dienstag, 1. Juli 2025 02:34 'Damien Le Moal' via upstream wrote:
> On 7/1/25 4:13 AM, Richard Weinberger wrote:
> > Currently, the block size is automatically configured, and for
> > file-backed namespaces it is likely to be 4K.
> > While this is a reasonable default for modern storage, it can
> > cause confusion if someone wants to export a pre-created disk image
> > that uses a 512-byte block size.
> > As a result, partition parsing will fail.
> >=20
> > So, just like we already do for the loop block device, let the user
> > configure the block size if they know better.
>=20
> Hmm... That fine with me but this explanation does not match what the pat=
ch
> does: you allow configuring the block size bit shift, not the size. That =
is not
> super user friendly :)
>=20
> Even if internally you use the block size bit shift, I think it would be =
better
> if the user facing interface is the block size as that is much easier to
> manipulate without having to remember the exponent for powers of 2 values=
 :)

The initial intention of this patch was exposing the blksize_shift property.
If we want to expose this as more user friendly, I'm fine with it.
Maybe "minimum_io_size"?

>=20
> >=20
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> > Changes since v1 (RFC)[0]:
> >=20
> > - Make sure blksize_shift is in general within reason
> > - In the bdev case and when using direct IO, blksize_shift has to be
> >   smaller than the logical block it the device
> > - In the file case and when using direct IO try to use STATX_DIOALIGN,
> >   just like the loop device does
> >=20
> > [0] https://lore.kernel.org/linux-nvme/20250418090834.2755289-1-richard=
@nod.at/
> >=20
> > Thanks,
> > //richard
> > ---
> >  drivers/nvme/target/configfs.c    | 37 +++++++++++++++++++++++++++++++
> >  drivers/nvme/target/io-cmd-bdev.c | 13 ++++++++++-
> >  drivers/nvme/target/io-cmd-file.c | 28 ++++++++++++++++++-----
> >  3 files changed, 71 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/confi=
gfs.c
> > index e44ef69dffc24..26175c37374ab 100644
> > --- a/drivers/nvme/target/configfs.c
> > +++ b/drivers/nvme/target/configfs.c
> > @@ -797,6 +797,42 @@ static ssize_t nvmet_ns_resv_enable_store(struct c=
onfig_item *item,
> >  }
> >  CONFIGFS_ATTR(nvmet_ns_, resv_enable);
> > =20
> > +static ssize_t nvmet_ns_blksize_shift_show(struct config_item *item, c=
har *page)
>=20
> As mentioned above, I think this should be nvmet_ns_blksize_show().
>=20
> > +{
> > +	return sysfs_emit(page, "%u\n", to_nvmet_ns(item)->blksize_shift);
>=20
> And you can do:
>=20
> 	return sysfs_emit(page, "%u\n",
> 			  1U << to_nvmet_ns(item)->blksize_shift);
>=20
> > +}
> > +
> > +static ssize_t nvmet_ns_blksize_shift_store(struct config_item *item,
> > +		const char *page, size_t count)
>=20
> Similar here: nvmet_ns_blksize_store()
>=20
> > +{
> > +	struct nvmet_ns *ns =3D to_nvmet_ns(item);
> > +	u32 shift;
> > +	int ret;
> > +
> > +	ret =3D kstrtou32(page, 0, &shift);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Make sure block size is within reason, something between 512 and
> > +	 * BLK_MAX_BLOCK_SIZE.
> > +	 */
> > +	if (shift < 9 || shift > 16)
> > +		return -EINVAL;
>=20
> And this would be simpler:
>=20
> 	if (blksz < SECTOR_SIZE || blksz > BLK_MAX_BLOCK_SIZE ||
> 	    !is_power_of_2(blksz))
> 		return -EINVAL;
>=20
> > +
> > +	mutex_lock(&ns->subsys->lock);
> > +	if (ns->enabled) {
> > +		pr_err("the ns:%d is already enabled.\n", ns->nsid);
> > +		mutex_unlock(&ns->subsys->lock);
> > +		return -EINVAL;
> > +	}
> > +	ns->blksize_shift =3D shift;
>=20
> and here:
>=20
> 	ns->blksize_shift =3D ilog2(blksz);
>=20
> > +	mutex_unlock(&ns->subsys->lock);
> > +
> > +	return count;
> > +}
> > +CONFIGFS_ATTR(nvmet_ns_, blksize_shift);
> > +
> >  static struct configfs_attribute *nvmet_ns_attrs[] =3D {
> >  	&nvmet_ns_attr_device_path,
> >  	&nvmet_ns_attr_device_nguid,
> > @@ -806,6 +842,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] =
=3D {
> >  	&nvmet_ns_attr_buffered_io,
> >  	&nvmet_ns_attr_revalidate_size,
> >  	&nvmet_ns_attr_resv_enable,
> > +	&nvmet_ns_attr_blksize_shift,
> >  #ifdef CONFIG_PCI_P2PDMA
> >  	&nvmet_ns_attr_p2pmem,
> >  #endif
> > diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io=
=2Dcmd-bdev.c
> > index eba42df2f8215..be39837d4d792 100644
> > --- a/drivers/nvme/target/io-cmd-bdev.c
> > +++ b/drivers/nvme/target/io-cmd-bdev.c
> > @@ -77,6 +77,7 @@ static void nvmet_bdev_ns_enable_integrity(struct nvm=
et_ns *ns)
> > =20
> >  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
> >  {
> > +	int bdev_blksize_shift;
> >  	int ret;
> > =20
> >  	/*
> > @@ -100,7 +101,17 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
> >  	}
> >  	ns->bdev =3D file_bdev(ns->bdev_file);
> >  	ns->size =3D bdev_nr_bytes(ns->bdev);
> > -	ns->blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev));
> > +	bdev_blksize_shift =3D blksize_bits(bdev_logical_block_size(ns->bdev)=
);
> > +
> > +	if (ns->blksize_shift) {
> > +		if (ns->blksize_shift < bdev_blksize_shift) {
> > +			pr_err("Configured blksize_shift needs to be at least %d for device=
 %s\n",
> > +				bdev_blksize_shift, ns->device_path);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		ns->blksize_shift =3D bdev_blksize_shift;
> > +	}
>=20
> Nit: to avoid the indented if, may be write this like this: ?
>=20
> 	if (!ns->blksize_shift)
> 		ns->blksize_shift =3D bdev_blksize_shift;
>=20
> 	if (ns->blksize_shift < bdev_blksize_shift) {
> 		pr_err("Configured blksize needs to be at least %u for device %s\n",
> 			bdev_logical_block_size(ns->bdev),
> 			ns->device_path);
> 		return -EINVAL;
> 	}

It's a matter of taste, but yes...

> Also, if the backend is an HDD, do we want to allow the user to configure=
 a
> block size that is less than the *physical* block size ? Performance will
> suffer on regular HDDs and writes may fail with SMR HDDs.

I'm not sure whether it's worth putting more smartness into this logic.
=20
> > =20
> >  	ns->pi_type =3D 0;
> >  	ns->metadata_size =3D 0;
> > diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io=
=2Dcmd-file.c
> > index 2d068439b129c..a4066b5a1dc97 100644
> > --- a/drivers/nvme/target/io-cmd-file.c
> > +++ b/drivers/nvme/target/io-cmd-file.c
> > @@ -49,12 +49,28 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> > =20
> >  	nvmet_file_ns_revalidate(ns);
> > =20
> > -	/*
> > -	 * i_blkbits can be greater than the universally accepted upper bound,
> > -	 * so make sure we export a sane namespace lba_shift.
> > -	 */
> > -	ns->blksize_shift =3D min_t(u8,
> > -			file_inode(ns->file)->i_blkbits, 12);
> > +	if (ns->blksize_shift) {
> > +		if (!ns->buffered_io) {
> > +			struct block_device *sb_bdev =3D ns->file->f_mapping->host->i_sb->s=
_bdev;
> > +			struct kstat st;
> > +
> > +			if (!vfs_getattr(&ns->file->f_path, &st, STATX_DIOALIGN, 0) &&
> > +			    (st.result_mask & STATX_DIOALIGN) &&
> > +			    (1 << ns->blksize_shift) < st.dio_offset_align)
> > +				return -EINVAL;
> > +
> > +			if (sb_bdev && (1 << ns->blksize_shift < bdev_logical_block_size(sb=
_bdev)))
> > +				return -EINVAL;
>=20
> I am confused... This is going to check both... But if you got STATX_DIOA=
LIGN
> and it is OK, you do not need (and probably should not) do the second if,=
 no ?

I was not sure about that.
Is it guaranteed that STATX_DIOALIGN returns something sane?

>=20
> Also, the second condition of the second if is essentially the same check=
 as
> for the block dev case. So maybe reuse that by creating a small helper fu=
nction ?

Ok.
=20
> > +		}
> > +	} else {
> > +		/*
> > +		 * i_blkbits can be greater than the universally accepted
> > +		 * upper bound, so make sure we export a sane namespace
> > +		 * lba_shift.
> > +		 */
> > +		ns->blksize_shift =3D min_t(u8,
> > +				file_inode(ns->file)->i_blkbits, 12);
> > +	}
>=20
> It feels like this entire hunk should be a helper function as that would =
allow
> making it a lot more readable with early returns. This code here whould be
> something like:

Ok.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



