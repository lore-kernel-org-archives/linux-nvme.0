Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB57CD98E4
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z0l6+g1rDCrPE1xY+T101+BXsaDlbCV1J0qUbRh4BtA=; b=LIddjAreEC3QB6mKJMT3nBVlnp
	JVIGjZL9l8V78PSLUWIjGQBaoNV11eju6V0LHtupI/zWQ2GZ1C/bdfSw9PBrzb8OwwN1rATbREo+0
	HFB79JxfvNbimbxNVl6kksC1Cw+nw/rsmtDnPC1ewp7rjn+gwkWuTPxY6vvW/hgcKKAinlR0S2/JL
	KGMhtliXYOM6MhNof+ajc8p76Jkr0WNCDnPpReagi0VsUN4IzBrcoJJOlQjDUbUALKsiAeewJMCAy
	tVPMEZrVBaAuOGntDVjjPGU2n41xEjaYSHtZGcB/BX6HB9bnA565u/ILMFzQFBgLfEgD0+PbI9hgq
	8GM1yRZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqxx-0000000HSu1-079M;
	Wed, 17 Jun 2026 14:10:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqxw-0000000HStt-0XtN
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 14:10:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BCBC41B4B;
	Wed, 17 Jun 2026 14:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99A31F000E9;
	Wed, 17 Jun 2026 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705403;
	bh=z0l6+g1rDCrPE1xY+T101+BXsaDlbCV1J0qUbRh4BtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XkffQyVTrijgcT1OtIhuP8LwfY4+eWzSQNdJD+7diK0080wPNBCQwmsbi6Dasl9zK
	 z5wwTQQ8w7ph0r7QMrUxYYDn5yKEkUUgF+3a5T4v+BF1igPus3C5lcxo7gbRnYbcXQ
	 t7YyEl65spNyYtSKM5hDUnvps2gc0fC7hDu4udnUYKqYCgbLT1xNYWKHvuKY0hQSPw
	 69feGXidr9kRGBFoiebFsKuiKpzU40hFvOoi9t694XFHmI4P8MhjuWhbI6pepqk6jJ
	 tPsYYdCwFltzsM8BN1O/xMvkYPCrX8FkkumPIWJn3yn0JdgiPZO5PmPoSOipMvVE2Q
	 oZaT2+0/N+QlA==
Date: Wed, 17 Jun 2026 16:09:57 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: unmap the data buffer when metadata mapping fails
Message-ID: <ucuw6j7fkmxjk5hktf4l2y6svnmduuax5dslifsthwpvcxmrht@s6gygbw6it2m>
References: <20260612-jag-fixes-v1-1-24423dc8afdb@kernel.org>
 <DJ6Z3EVG32PV.1CXC6PRBH1CIY@arkamax.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lrk4q3nqgm75u6b"
Content-Disposition: inline
In-Reply-To: <DJ6Z3EVG32PV.1CXC6PRBH1CIY@arkamax.eu>
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


--4lrk4q3nqgm75u6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 11:45:26AM +0200, Maurizio Lombardi wrote:
> On Fri Jun 12, 2026 at 11:40 AM CEST, Joel Granados wrote:
> > Commit d0d1d522316e ("blk-map: provide the bdev to bio if one exists")
> > dropped the "bio =3D req->bio" assignment in nvme_map_user_request(), b=
ut
> > left the local bio variable initialized to NULL and still used it in the
> > out_unmap error path.  The "if (bio)" test is therefore always false, so
> > a failure of blk_rq_integrity_map_user() no longer unmaps the already
> > mapped data buffer.  The callers only call blk_mq_free_request(), which
> > does not unmap user pages, leaking the bio and its pinned user pages.
> >
> > Use req->bio directly to unmap the data buffer on the error path, and
> > drop the now unused local variable.
> >
> > Fixes: d0d1d522316e ("blk-map: provide the bdev to bio if one exists")
> >
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > Did we forget to unmap?
> > ---
>=20
> Isn't this already fixed in mainline tree?
That is indeed the case. I must have been looking at an outdated state.

Sorry for the noise.

Best
>=20
> 2279cd9c61a330e5 ("nvme: fix bio leak on mapping failure")
>=20
> Maurizio
>=20

--=20

Joel Granados

--4lrk4q3nqgm75u6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmoyqqwACgkQupfNUreW
QU9zEAwAj1Gkw7Vzehe3MzFmWZzDc3Hy+yN7BrhtGjPaKIjv4IWDjzsV1bbgjW7q
6k6TLNlSaGMrIqpbKw/i05dwP6m8t4mtqlWgiyqDdkxDc65kNb4lEVFgGUbVeKvk
kcnLRHO18Rum/s9GomdacW2NuY06cbLWxDbeGpWyjtb+suJFMZ2nPZo7roG/Ammi
rYHcgIm1B6dVtygPZs61DqIR6yjLS/VZAZBhac2befesX6hqQPpkRIY/vwg/2PUj
bwp3vo3ASaRv6/YBqOgX1ewfNquHfM1dWxnMVjNhs5gHN5losnAF1HcdC54ieofW
Cd4OypctajZchZ8pCrEeuzftt8AlbseTY7bC+m+yANgW/6vAmS/3XI3yIGR9ezfz
KOd6UkMAHYioPtTPViDURngbQeGEj5ePP40dSsxp6PlwMvh8SrIyJiNZHAWxb84g
kXPizGRGWawUeWuhAQ/P9WfJF2YAjvkGn1VzD6D+5RR2M/rBmstLyr1Vf9Vv5P3L
MQ9jeEz1
=eio8
-----END PGP SIGNATURE-----

--4lrk4q3nqgm75u6b--

