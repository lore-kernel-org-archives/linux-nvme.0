Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775DFC61DB3
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T2+jeNTi2tAEJP0ezy+QLAeMKjlI4HTH6qEscg7aEgQ=; b=K0WZYdrjl69OsUJ3zTNBPtfZS1
	M48Gm8oF4g9/nVp4olBTVJ1CjVzzUsIM5ZJCWfWjXyr48gohX9x8korMXAbvZRPpQGNwDG2k7dRg2
	usZqu4yDa+OUKFuUUjlr4G2Vc6f7LqdWaAJC7C8h2wnn9I6EV08ySn+KRhzs1h5VVvV0jvXTsu5NK
	h7j/W07iKaLID86dJrAS6iEHdAxaA63KAkwxHXB/vZGNBde+4LbQkM5K1nx0ZcNOXYiFBV0tlf4QQ
	aEyNIPNeeZL5NdqAmEmY89Tl1v2EdICg9SoZpQup8yaJzygp6R5pPXD00IRsAl1obl+Eui4k7WKHq
	L3jNYMOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGJS7-002cAe-A4; Fri, 13 Jan 2023 12:46:35 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGJS5-002c9T-1A
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 12:46:34 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 35AA65C0078;
	Fri, 13 Jan 2023 07:46:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 13 Jan 2023 07:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1673613992; x=1673700392; bh=T2
	+jeNTi2tAEJP0ezy+QLAeMKjlI4HTH6qEscg7aEgQ=; b=s42IgY6JfW+WhP0xx4
	eAL1G5Wc12hE601mzEYcGmcMZLblfv/OsvLNqJSHA2rnTU07DSIS5r5gjLvlKl6D
	sV5X6bBNa9irHTvGQvKMolIo4zaSYAhM+vl1Ah/YxlgMNUYCAkNv0JJx54+J4gns
	aK6+c/I+kYn+KxyVNaZaFBlBZXlB5v5I4idpQIy8PLuMuYnk/knSNDsZraNlFmto
	G4smkATVwgQaipDRBdCjPQD/8XHA8lCEWkyKeoA7c4/degJxEMWUEV61ud7vWfDF
	0AXgoPPTCsGjISLPsJzS5RsbGZfsolLPpOPRIFCc58NM9V9vQUh+qcJl4hJGAVFe
	/vEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1673613992; x=1673700392; bh=T2+jeNTi2tAEJP0ezy+QLAeMKjlI
	4HTH6qEscg7aEgQ=; b=Oqm1WcB7G3XFjDu4k4YsTvJslMH1tcxMjPAGl+ELxoBO
	EBELRDcQQ81oRJ+yX9lMIuVQtJpsz6OcvVnkgMJYUJ2himZPfcmmH0xaduxNeotP
	I8N6J7/5m2K+bV3ZAST1df1i3NTk+zZ6hVrFQ7fuz0+mBdNWNRplXdOKgPPdXOiA
	7rQ9+8d7zIL+Bz4SJPcWOY6wq98pcvkrc/ENJiJR+MBcnFsaWXFHK9p85cUNQaiC
	ZgIPzol2Nmff5uUqDPRqG6fSMVkYAvVS9gHgpZUVIeH20G7M9L6fSxn2BbMxmQYS
	oic/9U/IFSmpdNAeiaEm0jovQsB4iHlEuj5mPXFubw==
X-ME-Sender: <xms:plLBYzDFd9u1p9I1_bjN5ylzDxff1dv9u4w7VCGd0EUHy4Ly8weOzA>
    <xme:plLBY5gxXr1nEqLpoTInZ3e1leUOmKXyGg4QLqLBQ63l0RAYxTVr8hYpWaWMYbmNr
    WxRhGoFCEBulH90WqI>
X-ME-Received: <xmr:plLBY-kFKsH8tUY6cVZU8zGAlofURpivpfEhPooeRNU5bRdJAkcVRIac2ltzsgovcCm53mN1Jmsec2BGVB7r_1TgBGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleekgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
    hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:plLBY1xG48X6O35ozinZ6QGYEZ9ZhVxjb4a7ItlCR-Qh237hKdlD4w>
    <xmx:plLBY4RhD1RUUe-MMRCybMe06T3K-yeczEx32zhukLb9umBmTp6_ZQ>
    <xmx:plLBY4a5v3rlszjRuw-394xaOi6b1UF0aU4llDkKXUmEpk79g4Vx6g>
    <xmx:qFLBY9Jc4bbH5u6VKiHMjKNRT2g_a9Bl8TZ7VqQIdV4qQfe-D69zeQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jan 2023 07:46:28 -0500 (EST)
Date: Fri, 13 Jan 2023 13:46:26 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8FSoppe0d6w9waL@cormorant.local>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8EcOFE52X5KbzO7@cormorant.local>
 <CAFEAcA9y0E=EZwmetyvymvt64BpQxAnKMHs0E=BBH9_3OfMwFA@mail.gmail.com>
 <Y8FQnsxSwcTUYqYm@cormorant.local>
 <CAFEAcA9H4bYfqmt2w_xSXS_uX9z-6NCRqdsn3tDz6h-v39cGKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gTT12bfSOS/S2v76"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9H4bYfqmt2w_xSXS_uX9z-6NCRqdsn3tDz6h-v39cGKw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_044633_186609_BCAC9304 
X-CRM114-Status: GOOD (  10.73  )
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


--gTT12bfSOS/S2v76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 13 12:42, Peter Maydell wrote:
> On Fri, 13 Jan 2023 at 12:37, Klaus Jensen <its@irrelevant.dk> wrote:
> > There are a fair amount of uses of pci_irq_pulse() still left in the
> > tree.
>=20
> Are there? I feel like I'm missing something here:
> $ git grep pci_irq_pulse
> include/hw/pci/pci.h:static inline void pci_irq_pulse(PCIDevice *pci_dev)
> $
>=20
> ...looks at first sight like an unused function we could delete.
>=20

Oh! My mistake! I grepped for irq_pulse which matched qemu_irq_pulse(),
doh.

--gTT12bfSOS/S2v76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmPBUqIACgkQTeGvMW1P
DemLRAf8CLgdAVSE5g3v6JPkz8a/gQiA+0JeuV28TN9fGWHMWFBZ2NDz34UoydU0
hzEStv4+jP+JHuCR0arwI8KUtKM+aatO14udXLBgae8EWg9J/cnAG5jrzXYnef6x
Fv27SGSqkN8iw0YMQoEFfu+BMzHjJ9pfvQIxjbnAToZXWDjGt6hR4KoyorH3G3hU
PEKZcwBCSb012o3jBPi6hyeS1znZWkvQWkEPloIUppL2du901lo/hAqKfPAi2wt0
VW3b/JAtHoP+zgs1mk2I2b28wGHJMPEsPu95QZ89xMn7jgHYGWCBE1o01BwGxkRL
uSs/pqWli1dNRH4SS1RpwthybVBVwQ==
=B73A
-----END PGP SIGNATURE-----

--gTT12bfSOS/S2v76--

