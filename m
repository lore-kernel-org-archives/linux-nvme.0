Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9246C55179
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2026 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NyskaGzxXiUJSY1RAI56QOEC/h9sww2umeZqQML0Hvg=; b=KP9o1qF5jLGMce32mKJTg2qhj4
	mIJO+kKLLNBXHZf882Pce0pbuXitmdzCtL+2ofM5+1+8pQvJ9MQJeDgTcSrjHHzZhVJju++Ui7Fby
	Ty7jQftxawMrx1bkG9aq79sc+0nfZZJB9NgleFAEfEqQAWtxFv+67XlKWxBR6EacufrIBO3N9vKHU
	hWEYHyj6XNCdZ60sJviMuPfZH3x7pF/sBCPmRz0o/YQTUIH+73iQieUnfqV0gIehDCBGY8w956vKP
	96ig+ICK57vZiYbL8gZxQv7S6CqDYKrXFjRfWlYFQcckwD+c08rkp3kIZevwhAd6iwB+7XAeZUxx8
	diBZuyNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqrw6-0000000H2l4-1EiI;
	Mon, 03 Aug 2026 12:38:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqrw1-0000000H2kw-303a
	for linux-nvme@lists.infradead.org;
	Mon, 03 Aug 2026 12:38:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D32D760A82;
	Mon,  3 Aug 2026 12:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36011F000E9;
	Mon,  3 Aug 2026 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785760704;
	bh=NyskaGzxXiUJSY1RAI56QOEC/h9sww2umeZqQML0Hvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C0Dew/QP3f8SId4nu9ELxi+WxV60Z5tfG7G3Qo913du84rz0oJzQpnFuHsEZALeJ+
	 ohEOFkDjdRvUc8njRvhVZ9vkTP0r4tbu52tr3tK4tbzz5LW5dg35v91LdmqSukCl59
	 YqjR/UQ16yF4vWd1wMeUO34Ms6BkoBOPgc5lb+RQE9WrQGKnFwbR2rhCKtJfr7eqs6
	 uzalCroCr2ItWNP6RCe4ogV77Jxbvm9/CWPwTpqgnPHe4ghTmUUVHhOOAgzSsYnSqs
	 cdq/mmIzoceP9j6sFz2AWhfeoMfhglQMrtvYzorRDuMtLoFsqLe6CoO97sWN109IK2
	 IK6RvPFk8auoQ==
Date: Mon, 3 Aug 2026 14:38:18 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 00/14] nvme: Controller Data Queue (CDQ) support
Message-ID: <77w6thdnghziwylsrzy2f37mltfsh54lyyumcafhanu6xt5jev@ffpbhy4yx2kk>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
 <64867060-4219-4188-9f9c-c38d5ea4b71c@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mvfg2fhode7n55sr"
Content-Disposition: inline
In-Reply-To: <64867060-4219-4188-9f9c-c38d5ea4b71c@nvidia.com>
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


--mvfg2fhode7n55sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 11:48:43PM +0000, Chaitanya Kulkarni wrote:

> On 7/24/26 4:10 AM, Joel Granados wrote:
> > NVMe LM SW WG
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The NVMe Live Migration SoftWare Working Group (mentioned in [6]) was
> > one of the main feedback points in my previous RFC. My main goal in this
> > respect is to keep exploring different approaches in the hope that when
> > it materializes we can "hit the ground running".
>=20
>=20
> What does this mean ? -Chaitanya

With this I meant that the pre-discussions that are possible before the
Working Group materializes might serve as information that feeds the
Working Group itself.

Best

--=20

Joel Granados

--mvfg2fhode7n55sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmpwi7EACgkQupfNUreW
QU/2ygwAh7JDOaPvyjUJiglvHbnfvXOBzgbvvwSwni9jSanQQt76s8Wk2DqGgGD/
z9pJbhKR0qlyKJFemRW67oD/Hpa3gGu6udmUZpv+jRgNdj1x0BE611ir4vm2t+sT
9Bq+1EJ9ozDYwzzuHxnQOGPcP01jfWfxQLUh4atct9Hkxm2bhZg6yl8EhpGnSnmw
2vI7XgT9YvQkR4vIRKbgdSNtPa8AZRrivkPdboWC+l0cucdaFhEye8TG/OMkfVIj
lwP5Mjg9un0z6Lj9lA1gEHXnNj1LStM6KxHWXPK4np/Q7PkzRrm5wkXu0HK9pmYA
QhvezUTzKe7e3Od5pxnhFyxIdF2HlMK92s5yB+O8oI0wGVzonue5ansj/Yr0ZADY
jiDQWC4CB/bxI7MRLPyvZO2ZhMiYUQljqlw25ROnnUWJz6+bGEvTo2KrwpB3AOHt
GdvdifAjuhYkZ2o0JQpLvMfUhR8UpcW3eSLIkTLR96Rh6+aGTkE7+/HPvf+aRyXe
1PeORbUi
=BX/p
-----END PGP SIGNATURE-----

--mvfg2fhode7n55sr--

