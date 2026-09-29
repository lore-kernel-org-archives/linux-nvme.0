Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CD7CA5FA7
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/WMI8lfF/OSrttALYjpfUBi10UnOZ9MwedFyUxvaAbA=; b=aCu4gl1fsIHtxD7M2tBoew7Uxs
	CqfTEIKJVHDxzVeerXx+Q+0mNKTdngszCUZbMfGCkETpJ+PvVxFywsWsXCdsBehcnIuqkcWnD4p7x
	joW7e3UqQuZwBS5PE/xyEVub4BjtF35QvgD7NbJr+Uc+ivmyR1RkEGT8WIUfw+YN99NweVQGWCod6
	/41jq84hCPtwsZQ+GRz5c1qL4g7JpQvvNB0MxwJH09PSadurhbKuqMpRJbmePJpMTyiJZFQJvVcn8
	kZNRv4tl81K/Xk9p9NVss9ZCq5yNF99g09lhpka5sOu2w+MjM+UOmeSgRo7wOjk2zHhUYFj0aDT12
	Bg9NdKeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBcvR-00000004Jk7-0xyg;
	Tue, 29 Sep 2026 18:51:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBcvG-00000004Je6-0fAH;
	Tue, 29 Sep 2026 18:51:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B987602CA;
	Tue, 29 Sep 2026 18:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4811F000FF;
	Tue, 29 Sep 2026 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707885;
	bh=/WMI8lfF/OSrttALYjpfUBi10UnOZ9MwedFyUxvaAbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EeCb5904S2ffg/WWZNEkHiFLiIst0KEkW7s7e/DKqtHosRZFbvSUM528WQUBfCrER
	 /gIWP17U+z4/iDSTPjMDbhbRLzFydlWXFVQiwhn5mqjRYZ9aQMbpe5bsKFMbCy6GwT
	 hwOnNd8mP9cQLkDS1lAn8hZVxnhCvd+gZi0C2G/vxbe/iD34iNOihiS/+03dSntIpk
	 v5QFsCi2cEyLW3vfm3zsM/zS247R4LMtHB78ox9HfqkRNUr3J5HjR8ZsMJainxKnjT
	 fs47ndSB3X8JQ49wOvTbYf1YdnxDKQ0zAoqx1R4db0bA6UiZx4H1HSbhBK5UoDgxg/
	 /gVJJMuFXzbFw==
Date: Tue, 29 Sep 2026 19:51:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
Message-ID: <20260929-wrongful-shirt-2920bcdab205@spud>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
 <20260929-debonair-busy-hamster-be2fda@quoll>
 <CADo9pHg2JyGyOA=_6orXdhDwj7NaKRBciyQMG2w7fQcPm0MNwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="94Nbq7tBACJ51b1N"
Content-Disposition: inline
In-Reply-To: <CADo9pHg2JyGyOA=_6orXdhDwj7NaKRBciyQMG2w7fQcPm0MNwg@mail.gmail.com>
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

--94Nbq7tBACJ51b1N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 03:22:09PM +0200, Luna Jernberg wrote:
> https://youtu.be/TPwe53kCJuM

Why are you linking this here? Is there something relevant to this
series in that stream?

Confused,
Conor.

>=20
> Den tis 29 sep. 2026 kl 10:21 skrev Krzysztof Kozlowski <krzk@kernel.org>:
> >
> > On Fri, Sep 25, 2026 at 10:22:49AM +0200, Janne Grunau wrote:
> > > The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
> > > the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
> > > compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
> > > "apple,t6031-asc-mailbox" to its dt-bindings.
> > >
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > ---
> > >  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >
> > Best regards,
> > Krzysztof
> >
> >

--94Nbq7tBACJ51b1N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwIpgAKCRB4tDGHoIJi
0mYQAP9UIJeKqv9AhxyIQM+FA4DJ02DszB2mvYOx9cyyt0PHiwD/TTKncTdmGbHf
cbaZwKF3EvrrClbOBuC2WjwU1nMvGwE=
=hd1e
-----END PGP SIGNATURE-----

--94Nbq7tBACJ51b1N--

