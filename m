Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86606C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izS/IC0DmM7mAVkkRJhi5lj7qvWeAq5t5HTYJWiY8a8=; b=XkTCt/jplhnBmQdRxYh4khWrhh
	uJGXJGtCyGM+mwkI3va709/dRi57WV/Uy3lgC+HVRhp32ZJlTXdCqhA/wSq6PMrilwh01+6icec0i
	V5hH3csYUHKX0YBAOjKQ7aVD4aB82t9QCmWyjD2F+p5zye4EGrUkYWoQvdaY06Tv9UJP2o2ShYyNq
	8loX2U8dkcPhYlv7ODCtPAYe/VQ2Gr9Y2zdYHMDA2BH+spAycrhmyrEBVJZaEzO1acajS8hmPX4vU
	J2NO3X8BADue8bvAns5W8oqkxMHNKQlJnV+thNdvXOmES1utzaQrgpnS2N+PH3AfUJYOIdvt/+6sj
	fbpjmiSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFLF-00BAko-1e;
	Mon, 18 Dec 2023 15:15:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFLA-00BAhi-2V
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 15:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702912531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izS/IC0DmM7mAVkkRJhi5lj7qvWeAq5t5HTYJWiY8a8=;
	b=D5+3YC4rKmTL/Zuiux+puvj4Nj0P3y/sgruKcy11MQizppGBsnk+Xib56hXHRYWvAvap8E
	hrJ06y4YI0UbT3ry/uAAOWvAPLmxCXPQQuGECPbY0/4dH9Iz3b2ixMMrxivNUv+vKGhgY5
	sYp/3xNC/uPvMRffyXMpdZVCbEu9yy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-7vC1SDkKNxiRJCk_pwFISA-1; Mon, 18 Dec 2023 10:15:24 -0500
X-MC-Unique: 7vC1SDkKNxiRJCk_pwFISA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07FE487A380;
	Mon, 18 Dec 2023 15:15:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CED3C15968;
	Mon, 18 Dec 2023 15:15:23 +0000 (UTC)
Date: Mon, 18 Dec 2023 10:15:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/5] virtio_blk: remove the broken zone revalidation
 support
Message-ID: <20231218151522.GE12768@fedora>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4eVxO+z2jfATvVXq"
Content-Disposition: inline
In-Reply-To: <20231217165359.604246-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_071532_893347_C782C517 
X-CRM114-Status: GOOD (  22.79  )
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


--4eVxO+z2jfATvVXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 05:53:56PM +0100, Christoph Hellwig wrote:
> virtblk_revalidate_zones is called unconditionally from
> virtblk_config_changed_work from the virtio config_changed callback.
>=20
> virtblk_revalidate_zones is a bit odd in that it re-clears the zoned
> state for host aware or non-zoned devices, which isn't needed unless the
> zoned mode changed - but a zone mode change to a host managed model isn't
> handled at all, and virtio_blk also doesn't handle any other config
> change except for a capacity change is handled (and even if it was
> the upper layers above virtio_blk wouldn't handle it very well).
>=20
> But even the useful case of a size change that would add or remove
> zones isn't handled properly as blk_revalidate_disk_zones expects the
> device capacity to cover all zones, but the capacity is only updated
> after virtblk_revalidate_zones.
>=20
> As this code appears to be entirely untested and is getting in the way
> remove it for now, but it can be readded in a fixed version with
> proper test coverage if needed.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 26 --------------------------
>  1 file changed, 26 deletions(-)

Fair enough.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4eVxO+z2jfATvVXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWAYgoACgkQnKSrs4Gr
c8j5vwf6AvyDGx3q65J+QlDbrJwPqdAlJ2qDdjwPYSEIgUmM+viNseFP/3psEz2K
7bz3oZ0XXwQatvou0SAiQE8KeXitxdlYFTgJGCtnkyxzaBPZzdfSerjifJNpZhYY
5XC8qXs4ZnecdqeGnEkUS+E4DOlZWL/n4VXz3V0fJAgezdOWZe8u8kkQjy4rcFXl
+UqpzgXjuXfTykIPkc0Ij4JFG8uuPCkkQdzTG4o4FcTQbtgS8i41Mp/4Ty1ft3B8
PZTUAwJ8uEnRTwyLvTujtBinZOKg7EuosEoRjZJLIT0QwZFJGHJ4DxUyWwpy+Jso
E9s7jtYaaslUg+4xTvCIUaaGuRBVkg==
=W7fu
-----END PGP SIGNATURE-----

--4eVxO+z2jfATvVXq--


