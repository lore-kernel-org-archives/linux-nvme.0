Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EB5D116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FEWq6IeBh011o08f/hWEQ+gTUdIM+S4jmcV1ap/FeSI=; b=EvT29CbxlMUhx1A8eSFQYn1QgZ
	BdBsn4sY8SO5YE766FBgm8nxa9B1t9fjFGOnyFf+UHXzifnp3Vi74fUouLSerAhdPxPB88yvUDf/k
	+2LQS2msdXWrhwjfPY+04V6noV+azrYmbYd4Zgoi6/6bjnIvcEMi7dT9FnDJIJgA2lELKGpjrEnPe
	/Mkf0U0Qfz8Z5iMvhJw7xVB9TkoT/W0yYCjYH2ugDrC1V1aLfcDZHBV+fUBD+9wkZnJqp1pC9UxgN
	OgOc9fK1ryleNopT6C6N2X7KK5I6wySjouCIzRjspFixIf726u51qCWGeue89eFRBGoXxS4O/qNOe
	fCiIhcbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ6pz-00000004GyX-1C8z;
	Mon, 01 Dec 2025 16:33:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ6pw-00000004Gwp-2xfv
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 16:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764606795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEWq6IeBh011o08f/hWEQ+gTUdIM+S4jmcV1ap/FeSI=;
	b=G+nFWSTsfOnY80DqFHoInXjZdVkt7uBpak87Pa4+zqqhLNCn/Qwhqfz0fw0XKrSpq6Bpa0
	9bQjMgpDYo1yCe7jHanBxT+lQAsO9BPQybhhz4hnyOLrxPNKmYgAavVk2llWYH1+YRwzrC
	SFGtrqxgpzAZ1KGgW2aMqJ4gqb/2cPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-14JTXgA9Obixynv9YqxJNg-1; Mon,
 01 Dec 2025 11:33:11 -0500
X-MC-Unique: 14JTXgA9Obixynv9YqxJNg-1
X-Mimecast-MFC-AGG-ID: 14JTXgA9Obixynv9YqxJNg_1764606789
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08E44195606F;
	Mon,  1 Dec 2025 16:33:09 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73C931800451;
	Mon,  1 Dec 2025 16:33:07 +0000 (UTC)
Date: Mon, 1 Dec 2025 11:33:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/4] block: add IOC_PR_READ_KEYS ioctl
Message-ID: <20251201163306.GF866564@fedora>
References: <20251127155424.617569-1-stefanha@redhat.com>
 <20251127155424.617569-4-stefanha@redhat.com>
 <20251201064016.GC19461@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Wld60ZO5GhULH6y"
Content-Disposition: inline
In-Reply-To: <20251201064016.GC19461@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_083316_815177_698135A1 
X-CRM114-Status: GOOD (  22.53  )
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


--5Wld60ZO5GhULH6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 07:40:16AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 27, 2025 at 10:54:23AM -0500, Stefan Hajnoczi wrote:
> > +static int blkdev_pr_read_keys(struct block_device *bdev, blk_mode_t m=
ode,
> > +		struct pr_read_keys __user *arg)
> > +{
> > +	const struct pr_ops *ops =3D bdev->bd_disk->fops->pr_ops;
> > +	struct pr_keys *keys_info __free(kfree) =3D NULL;
>=20
> Please avoid the use of the __free mess and write readable and maintainab=
le
> code instead.

Okay.

> > +	struct pr_read_keys inout;
>=20
> Inout is not a very good variable name, as it doesn't really have much
> of meaning. =20

It's the ioctl argument. I will change it to read_keys in the next
revision. I'm not sure if that's any better, but it reminds us which
struct this is.

> > +	if (copy_from_user(&inout, arg, sizeof(inout)))
> > +		return -EFAULT;
> > +
> > +	/*
> > +	 * 64-bit hosts could handle more keys than 32-bit hosts, but this
> > +	 * limit is more than enough in practice.
> > +	 */
> > +	if (inout.num_keys > (U32_MAX - sizeof(*keys_info)) /
> > +	                     sizeof(keys_info->keys[0]))
> > +		return -EINVAL;
> > +
> > +	keys_info_len =3D struct_size(keys_info, keys, inout.num_keys);
>=20
> Do the size check on the calculate len here?

Yes, that's better. Checking SIZE_MAX also gets rid of the 32-bit vs
64-bit host comment.

> > +		return ret;
> > +
> > +	/* Copy out individual keys */
> > +	keys_ptr =3D u64_to_user_ptr(inout.keys_ptr);
> > +	num_copy_keys =3D min(inout.num_keys, keys_info->num_keys);
> > +	keys_copy_len =3D num_copy_keys * sizeof(keys_info->keys[0]);
>=20
> num_copy_keys is only used once, so maybe drop it?

Will fix.

Stefan

--5Wld60ZO5GhULH6y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmktw0IACgkQnKSrs4Gr
c8jbjwf4l8yKwuv+JSACDgyBSmml66HpfH23XvTBZ1amFOCIGNjC/b5FuNNlKmxx
uiZ+J2cmoLSe9XZLD2WheyZj3IsyRI7zXdxW7sRKmlkOScwiMAjCfYN/E6RAkD8l
q8i7i307XyhMALjleqLDDI/8zM7GpKrPCAmRgHmnzAxEW0k2dfrKX9soWlZkUwdU
VP+/JgXktggIfajUjGKHh6CBT2ez2Ju4xHEWcX/8pRGFY1BwIff5vFDuEGt5yr7g
mVp8wS3xjZWbuK1mhGHe3Mn2HVFwU27XMZ4onHUp13Xexiyek6kSpilE9dp0DDdd
y+3x2ZZ4+tTHHRYqaEgEvbM+5vpE
=D7ST
-----END PGP SIGNATURE-----

--5Wld60ZO5GhULH6y--


