Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B1BD116F3
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=779X9C6h5K3skYhM8d7MYfpqdYLObiQFQ6B6MrIqbsI=; b=mEtkrJ5nodkD9KIN/7bdhjv8pr
	jO5366XMKxKRsBQ5m5J+X0vJRUXVlypJNPxNh9BYrQrIFeF7XImmIixp9EZ3BUdL21HAmDallU4hN
	9/UyuS+BH8KBE8BunLdjST7/aLXmPxMUoTnXYQPsCcb1wybwR3xCILnhrNSQAsAMeVebEj9vhBzo2
	qxpKl7JoEWrs7H/iAG502mwWxS/unzvA62rrC9BN/yhtLe86roOTuE7jIrPRLYcgTfExf8aC+4j4R
	jw5pW1/ddK+VfRnV2qDS17ArXwUZfJyXC2Y7jtsDFdJ5U4ldwzCHwxocnJh4ktg/xzp3g3WlQ3PZS
	M+nEMFXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5Wk-000000049ld-2CNf;
	Mon, 01 Dec 2025 15:09:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ5Wh-000000049kp-39cZ
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 15:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764601758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=779X9C6h5K3skYhM8d7MYfpqdYLObiQFQ6B6MrIqbsI=;
	b=c82HCEyriPXGdtM9IhWktff16SsYtxNiRvLOVo2LvuGmYVqeOz78ND9k+pPKitxCcAnJ+y
	UBOJx/mUA++jWinDte10Rw8EGtVi8ZlEwx92GoRaoCVQSB9gPmWZoQEkMly95y2/P3rXJQ
	wm5awwEbdg5wAKeBMEUoMV1zXqTHqfg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-Tj_YiY8EMgWuX_4BExsQwA-1; Mon,
 01 Dec 2025 10:09:14 -0500
X-MC-Unique: Tj_YiY8EMgWuX_4BExsQwA-1
X-Mimecast-MFC-AGG-ID: Tj_YiY8EMgWuX_4BExsQwA_1764601752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1753D195609D;
	Mon,  1 Dec 2025 15:09:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA01C180047F;
	Mon,  1 Dec 2025 15:09:10 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:09:09 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mike Christie <michael.christie@oracle.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 1/4] scsi: sd: reject invalid pr_read_keys() num_keys
 values
Message-ID: <20251201150909.GB866564@fedora>
References: <20251127155424.617569-1-stefanha@redhat.com>
 <20251127155424.617569-2-stefanha@redhat.com>
 <20251201063413.GA19461@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i8xxr+XJ1Xv3lF4c"
Content-Disposition: inline
In-Reply-To: <20251201063413.GA19461@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_070919_882519_82C69D5A 
X-CRM114-Status: GOOD (  17.02  )
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


--i8xxr+XJ1Xv3lF4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 07:34:13AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 27, 2025 at 10:54:21AM -0500, Stefan Hajnoczi wrote:
> > +	/*
> > +	 * Each reservation key takes 8 bytes and there is an 8-byte header
> > +	 * before the reservation key list. The total size must fit into the
> > +	 * 16-bit ALLOCATION LENGTH field.
> > +	 */
> > +	if (num_keys > (USHRT_MAX / 8) - 1)
> > +		return -EINVAL;
> > +
> > +	data_len =3D num_keys * 8 + 8;
>=20
> Having the same arithmerics express here in two different ways is a bit
> odd.
>=20
> I'd expected this to be something like:
>=20
> 	if (check_mul_overflow(num_keys, 8, &data_len) || data_len > USHRT_MAX)
> 		return -EINVAL;

Thanks, will fix.

Stefan

--i8xxr+XJ1Xv3lF4c
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmktr5UACgkQnKSrs4Gr
c8i6LggAuMKNzG5olHxh++csQmnmYxzq4kE3SpSVE1RXp1nBtNnhXXpkikKBmoNN
AHOh/pWQAQiCaQr0PQDAfOZl5BgfVWAr+GhgL2cSfxLjakmIcJmiC9XOcYXO/iKH
OA9Zz/QLeSpkyxEPXXxf0I6aoUUmc1kXRgWxWD380WSdqtU2YY+99aFagK25Q1rP
io6U352p85/2oolXwu6vJry1k479CbPL+eFFyxs11PUsO1HmF7x/wNLg1h1iMkl2
JplumT2Yb6kDNrvy+YhZUaWqCqQmHfiO1o05u+sso9JwbA2Q3eHNkzQ8mCvUV8ol
8jswyhnd25j+NX9B+7etYTi57cy5Bw==
=kHJb
-----END PGP SIGNATURE-----

--i8xxr+XJ1Xv3lF4c--


