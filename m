Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5C1C83F1A
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PV1oLssFLZkR7dFRmhoc+5BO5LGjEUlC8URX9DaoIeo=; b=3wgH2CHT8aSOCLiODvco52UCnU
	vtvJvaxV8gyR4pGWZWC+lkJiLsyhlPG3KbQiq5ImDA9qNcFk6ni6DdXxq+MH6NbaO5OL/E2F9Di2C
	oOGI1PvpEOf9OmbdzSeMs08jtsXfbDAT1oBbrcedx6ktTGTs38yH3QGqWVQFRlxbmrrJG1f0k7JnD
	r2VIu/Jo4ss1VAxb12MdmUWCGCpmUkOxgUxp9Svme4UgU6oSlXrf2diXsKfAuw8BqqFZbT2XWfCRe
	Y47YJQXQmZzcD5GzPICSS7vWXPtEw8MziRvsf2r+l2c0P+tdZ0dSqxsJDVWaMs/R0LiiDUb5owq2F
	rq2/f/4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uck6R-0000000CZKD-1dr6;
	Fri, 18 Jul 2025 12:22:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucjLd-0000000CTkA-1fvF
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 11:33:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 057A14369E;
	Fri, 18 Jul 2025 11:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E2AC4CEEB;
	Fri, 18 Jul 2025 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752838431;
	bh=ss4gbTsOaXhi72j0lyuVqUWKJ1y9ouYj/VwkNqG/yFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr5yb86BsBIJl0B7TbnBxNd+/lG2uDdwzKLGVWcSqLbrb+3t/G2itvDOIM5H0u0v/
	 fmbSJ/mowIj33aEKKlAf7xIhgBtmgOnDV1Iu6q577QxF7bQEy1VqwlMZKx5kstH/um
	 OqWdTNwkm1hMDsLVfVYJuv5SrVY26Y+Hvv9xzEg94BKQXPyWCifEfQMYDPtcfBwteD
	 6gWI476NY/87puMX2k3DTCF2IBK0LNk4XlMFMbyydsPPjrcYTPdJ4ElbMh5TXlKar7
	 jeTjpukFzkTs2HtnrRKwAoqUt/f196DVdVDCo5wmN6H40zM/APglsdBmHf6ER3dP+H
	 nMaLagxZ9oq8Q==
Date: Fri, 18 Jul 2025 13:33:34 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, Klaus Jensen <k.jensen@samsung.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme
 driver
Message-ID: <fjnpyvjn2kqlmlzagvuy43numc7u44ylls3nqxay4sh5qjayv5@xq2ty7wipbg5>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
 <20250714130230.GA7752@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bytbhyrsj7nnxlk3"
Content-Disposition: inline
In-Reply-To: <20250714130230.GA7752@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250718_043353_477523_94BACEE7 
X-CRM114-Status: GOOD (  22.82  )
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


--bytbhyrsj7nnxlk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 03:02:31PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 11:15:31AM +0200, Joel Granados wrote:
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The main motivation is to enable Controller Data Queues as described in
> > the 2.2 revision of the NVME base specification. This series places the
> > kernel as an intermediary between the NVME controller producing CDQ
> > entries and the user space process consuming them. It is general enough
> > to encompass different use cases that require controller initiated
> > communication delivered outside the regular I/O traffic streams (like
> > LBA tracking for example).

Thx for the feedback. Much appreciated.

>=20
> That's rather blurbish.  The only use case for CDQs in NVMe 2.2 is
> tracking of dirty LBAs for live migration, and the live migration
Yes, that is my understanding of nvme 2.2 as well.

> feature in 2.2 is completely broken because the hyperscalers wanted
> to win a point.  So for CDQs to be useful in Linux we'll need the
> proper live migration still under heavy development.  With that I'd
Do you mean in the specification body or patch series in the mailing
lists?

> very much expect the kernel to manage the CDQs just like any other
> queue, and not a random user ioctl.
This is a great segue to a question: If CDQ is like any other queue,
what is the best way of handling the lack of CDQ submission queues?
Something like snooping all submissions for these CDQs and triggering a
CDQ consume on every submission?

I went with the ioctl as the faster way to get it to work; I might
explore what having it as just another queue would look like.

> So what would be the use case for a user controlled CDQ?
Do you mean a hypothetical list besides LM in NVME 2.2?

Best

--=20

Joel Granados

--bytbhyrsj7nnxlk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmh6MP8ACgkQupfNUreW
QU8hMgwAgBytHdz5pT7HLF0dvl1/Vh/v44hch5bV2NWwqeQWLoEHhrQuP0UEViGv
S1BMHYMIske+GAtL+AKRdNL/2LpuzQP4YSftL+fGtNxlPfOq4ehoNMeSVWxHuJa+
XnyJomh527pzEK9RkwMKa1R/9OXjZo4aHluV0jUAeGwtD012iXG2cVa2ADac3u0b
G7r+MkrJ8iA92QGjae+YThqq8qau7AfKIYLfzDRCtdBtkJA7wKSXY+2fe8HqZmmk
ODmdSY8QhyXs7dltzHbSCzuGuU8PTNIs8Ko9V7u/Jqwj0MZ/2YWkcFpLQ0ZWQ503
/CQoS44IQw9WXPnGwmtTBeBUUHAar0QXCUQAquWIjDcHFeH9F+J6/9rAmwzJ9FeH
UkQ72DNt+ebsMmsGOdlNVYQOhnXeH6ZPPkX74bSxVrpb1fJx0OWJFgNSfWb8X47E
AOSONgnQWaHd+Pz7QOl18tqyscX/RnOK1ylei0mqbpenj4bCwi+x7LK/R0TrCM9p
DP4izM1j
=agQF
-----END PGP SIGNATURE-----

--bytbhyrsj7nnxlk3--

