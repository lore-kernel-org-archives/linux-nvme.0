Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B11C021BF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVc9XhtGM1TLJ0eb+li7svXM1XPnWKs8qetqaDL3kIY=; b=KesiU4ycAco4TSzveAoo+kg126
	ORUXcKF9Qne/51BxMdTXaF1ouKo7/x01t0AgZHAstlcIojtMtjywopQip9X5N8VNSJO65lm8phnou
	G+ptOYkaESCJgZG+nG13ae+5gGKp3VjuTYyRPHOS9pPczHzFEKlE/nfVtpmgU+NYUSwMA7VJIUltS
	0uraO8URCA+7mFisUyG/doM3lss4T8MPkTttAvekiOXMlHBrQjY8pIJXAz5pHlq4hei8WBNaOFZAd
	/jN6XdoNvPzelhqT1XrLWn1d6nDbUGt0b6bQoeH1c3HlW/v47AP5wjIaqeZrRXG7h810aAC7UbsB3
	Idpv/5jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn5jd-00000001vTQ-0QV2;
	Wed, 26 Feb 2025 00:57:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1XN-00000001MiA-3k5L
	for linux-nvme@bombadil.infradead.org;
	Tue, 25 Feb 2025 20:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TVc9XhtGM1TLJ0eb+li7svXM1XPnWKs8qetqaDL3kIY=; b=RRz/DDCJXry95qZD6grGe+hF32
	UyF/OFe7OCEsIWGRgbpkkqKm/cudjU7jomcsCJZJQ74LQ9SJb7X+l94vif27bk609x5EBILn8Vs1S
	ycMZ0trLitz/5YQ8NPAU2bFxNP13tEOJqAZAcUNfQCgwHcfcyAQ7vFVl+MNGyoeJNT5rBjWIVs5lu
	5fr/Mwn+3tTReoVzUrmpt1mmvZnawvL54zazcWLZsm0Du18szW56DGRZU4FUI7vSoD6y2tCH5/qRe
	jhYb+2UMBbahJ4yliwgCdsQDj3hmX2xlg7g47eUXUGVCGUD6rWLHhfApaF5BUVYUYq04O9zUsO84W
	vOSmgIaA==;
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn1XK-00000003QKt-3SC6
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 20:28:16 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn1Wc-00041b-Jz; Tue, 25 Feb 2025 21:27:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tn1WS-002pgM-2j;
	Tue, 25 Feb 2025 21:27:20 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 461863CBC72;
	Tue, 25 Feb 2025 20:27:20 +0000 (UTC)
Date: Tue, 25 Feb 2025 21:27:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, 
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-xfs@vger.kernel.org, linux-nvme@lists.infradead.org, 
	cocci@inria.fr, linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-spi@vger.kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-sound@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, imx@lists.linux.dev, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
Message-ID: <20250225-cuddly-cobalt-hoatzin-e51fa3-mkl@pengutronix.de>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-13-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u45zipechepd67vw"
Content-Disposition: inline
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-13-a43967e36c88@linux.microsoft.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_202814_972366_265E57EB 
X-CRM114-Status: GOOD (  16.08  )
X-Mailman-Approved-At: Tue, 25 Feb 2025 16:56:55 -0800
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


--u45zipechepd67vw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 13/16] spi: spi-imx: convert timeouts to
 secs_to_jiffies()
MIME-Version: 1.0

On 25.02.2025 20:17:27, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplicati=
on
>=20
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
>=20
> @depends on patch@
> expression E;
> @@
>=20
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
>=20
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--u45zipechepd67vw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme+J6EACgkQDHRl3/mQ
kZxJmwgAjTBuQGjYsvjY3usfUGQlEX04CIIY/fXUbuNzg4k+rDZYBJVygyeWMSjH
P09FwLbjh/3LifMz41UC89WtofRA/pYz/koXNfKNHmOgy3F49mc9hZdB5bWYREeh
pt/7hAditNxNFMWvhHfZTFosdWI0f8QzpbcRF1N2bpFG+XIbVNCkzo7FD1IWzvtR
GOEwRfExkjtczf6yPcr0Lt5Fvh/Z2kD8uSH227AVm5XLZ9mTp9IzOmS6B2LTYfDi
YMDx5tD4fzYZ5KakPtBlEogWj3yg2pX6DpQETIHYrH7G5Or7uM9m8vWp9e29TGNH
hi/ia9fePGWAvvBB/1tngbAZUlNvSA==
=n4uD
-----END PGP SIGNATURE-----

--u45zipechepd67vw--

