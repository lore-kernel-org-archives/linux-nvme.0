Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F489C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:13:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F25B239EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 06:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F25B239EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nN4/pdf7+Ad/7lc8YavuYr9MxWnQK2wHlDpmKBnpxbU=; b=NL0rGj2QJrqNLttPaSVFONKst
	PauW1cPYqCQst1EaITquaOns8nEjXgg3GUtVC3ddNI9vJTCvS+DXXtDtx2iArTcBEhafehlfPHRhX
	Spu0/Rc55oF/xjP56N8zgWQ6KvN78EDiv0QgV1ValK6P4L3zmsKo1sm8O5SEBkf9cPb889p40usc3
	209CVbR3YbgYShK9UwVzmyUWOZXoCPBjM1kTFsuq0xFfcxrz7qBhKPzehtYVqbOVEyms+rg2YrdV4
	ekW3X5drT88FclsWYiUYpyFL0VKVI6Wnm47LunOnLOiZ6uTn8wanGYpAfoiF3mssVlXNDegWHgXwK
	meFyYqS2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0IMH-0004zm-HU; Fri, 15 Jan 2021 06:13:17 +0000
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0IME-0004zN-IC
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 06:13:15 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id F171A5C017E;
 Fri, 15 Jan 2021 01:13:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 15 Jan 2021 01:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=VC8jbXEAdVFxpTojZ5qcCezm0Xt
 s5RX5v9FAQ1lo7rU=; b=nYM52kzXIwg6c/HCkf47HkhToUVg4L08V8UENVKcGtA
 LG4hJZNwALUaZX5xG+DQp5hXpwLRvpeTjTwwp8rH4GZeUYgexVCW/jHeY61lLDbX
 4jyMknkiMn3jsj4X/K4lY9tO9j7zpiFmlMu42gwOrd0bDaNNmnqXaKxEImnunpd6
 emsLVbiAMNWpsG4MyjoXgzR8DN6QBbUjEo461ij76WkipmqR4RY/fmQparFjtJve
 shr0ZlRgZcoSvuXq1lAJGDMZ4YUPqlcft9gNNUGTw/LxxiLWzwT8j7k1k6BAM2wT
 BxyhEy5mqBddzbfjcyjoUrjlgyLUXNnQnBEK78Znyzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VC8jbX
 EAdVFxpTojZ5qcCezm0Xts5RX5v9FAQ1lo7rU=; b=QJos0+dSuIR2CdCXJzJeDa
 14GaandXbMgvhn/oC75OXoDFAIJHB8SRSdDPOERiydnINJSg4yUBwCy410jmJqv+
 uE7RCiscPkHMb91LrredLfIaKoNEl7wlb/lTntDrHSg/ToyYF9JCL5Q6HA3tzRbz
 /IY80RRz4TJWubWF8SL1YA0QMTS4CXlS8tYl5E+nAvBS+y1wb7esQjvNzH57Caet
 xIqOysm92fbN/D2/wWJlHyJFE1XRbCLvxI0Gvwx3/EXtxW5zZJigaHnwEBDRS8J9
 GvITpmXxH8ydUGDW8PrrCLddTnRjBcm2pWoO3ypAs7D5hg2iunpFatJ6nARfpEJQ
 ==
X-ME-Sender: <xms:eTIBYGQPDd3031MuLmTEH7OVzOZKmfO6v_WhnkvuTPPkG8kv4kChVg>
 <xme:eTIBYLyBiQqw7Nvre_F93RWguM_1Xx02Wh4mhAh5mMS-TRFi6VbtjEzjJf3l4wQGx
 eFdf1RHPypcFLCoIHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:eTIBYD19y5-tv0uOrLZcA1aTH_Gcs3igG2Ln_mwuc-vNcE9YxaI2YQ>
 <xmx:eTIBYCCNSHu_cvK37ibl-F5ycB3gwYALq63YfnVyglnNGzaOkZU1Jg>
 <xmx:eTIBYPiacsJT8FQHnO14ai9ybKeH7j_iGwZfxLQrKWq8WtRNcgo9Lg>
 <xmx:eTIBYPf3DoGnlyqwLlw7nc8lA2nXB91Afo92Yn_Xfm8FYk5zasGLKw>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D980924005B;
 Fri, 15 Jan 2021 01:13:12 -0500 (EST)
Date: Fri, 15 Jan 2021 07:13:11 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: allow use of cmb on v1.4 controllers
Message-ID: <YAEyd5fNOa1/3gN2@apples.localdomain>
References: <20210114132441.193782-1-its@irrelevant.dk>
 <20210114180600.GA1511435@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
In-Reply-To: <20210114180600.GA1511435@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210115_011314_649382_A8AC000E 
X-CRM114-Status: GOOD (  18.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Klaus Jensen <k.jensen@samsung.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: multipart/mixed; boundary="===============0189148279283176536=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============0189148279283176536==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QGogBnsieQdqwW2s"
Content-Disposition: inline


--QGogBnsieQdqwW2s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 14 10:06, Keith Busch wrote:
> On Thu, Jan 14, 2021 at 02:24:41PM +0100, Klaus Jensen wrote:
> > @@ -1795,6 +1796,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
> >  	if (dev->cmb_size)
> >  		return;
> > =20
> > +	vs =3D readl(dev->bar + NVME_REG_VS);
> > +
> > +	if (vs >=3D NVME_VS(1, 4, 0)) {
> > +		if (!NVME_CAP_CMBS(dev->ctrl.cap))
> > +			return;
> > +
> > +		writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
> > +	}
> > +
> >  	dev->cmbsz =3D readl(dev->bar + NVME_REG_CMBSZ);
> >  	if (!dev->cmbsz)
> >  		return;
> > @@ -1805,6 +1815,19 @@ static void nvme_map_cmb(struct nvme_dev *dev)
> >  	bar =3D NVME_CMB_BIR(dev->cmbloc);
> >  	bar_size =3D pci_resource_len(pdev, bar);
> > =20
> > +	if (vs >=3D NVME_VS(1, 4, 0)) {
> > +		cmbmsc =3D pci_resource_start(pdev, bar);
>=20
> Shouldn't this have a '+ offset' in case the CMB doesn't start at the
> beginning of the bar?
>=20


Of course, good catch!

> > +		cmbmsc |=3D (NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE);
> > +
> > +		/*
> > +		 * Writing the low bits may cause the controller to check the
> > +		 * validity of the 52 bit controller base address in the CMBMSC
> > +		 * register, so write the high bits first.
> > +		 */
> > +		writel(cmbmsc >> 32, dev->bar + NVME_REG_CMBMSC + 4);
> > +		writel(cmbmsc, dev->bar + NVME_REG_CMBMSC);
>=20
> hi_lo_writeq()?
>=20

Ah, was looking for that...

> This should probably come after we've verified the '(offset > bar_size)'
> check below so that we're not enabling these capabilities before we know
> if they're within the BAR.
>=20

Right.

> > +	}
> > +
> >  	if (offset > bar_size)
> >  		return;


--QGogBnsieQdqwW2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmABMnUACgkQTeGvMW1P
Denm5wf/ZXRZbJtkXnCV5NpLdCVVnlGDBo7EN1Ktwyy/tkxM9aJ35+wLoyG6qNyu
v1xOpxpMyOQSwNrI5KBSgExRfMJ4ubdFnEA12zzfYdqFs0RGlLzil/7AroO1zjs3
PyCj8YqljZpCybDV9O1Xidogb4O1zDDPaTfLi1QcPOAQ6YU1/X/t0Yu9lyVIzMLZ
nfu06QKUGhOqV5R+YzbRNzaXoaN7gnRx6Yw/YHUkTqCSwhEzZBPHXSG/JFHLzXqs
If0gwtXZD4nsQaV7p4Y1t9n+Fpknal7ZN8sqoNXpNLLxsQvXUzVNptOHphQbLZK1
uM+cXrzQVXzKqavfFO4uhVCN1955dw==
=VFE8
-----END PGP SIGNATURE-----

--QGogBnsieQdqwW2s--


--===============0189148279283176536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0189148279283176536==--

