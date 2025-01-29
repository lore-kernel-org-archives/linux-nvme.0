Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2987C02194
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHWivDYWF4y7ba+zH92u1jVSetPKPOsiJHaqx7tsOwU=; b=vFtIzK1FSif6hO2SyKLWpb1UgJ
	G57eSr/EUg17DtwHEm2BLpcu4zD+dbFeKS+S0zOc47Veu6kPjJsKGjK8L47hFwjHod1avhi61qJAL
	hZGCXjakEmmDViMA9ul9llEh34OJ6AHLn90PnLi/XFKHIQn5suWCG57+J1K8JvSdoLBlIVPGkcm1Q
	USGpL1N9E/L7dDVXHWoT8vt5MjId9Ok0z2+hIQP5QsU0D8FYEL300UmNH8WrS55yZGWJEgIz42MA7
	m3Vxj6hXXq51c4JZU8ZY/9yAd82nvL4MA7DL7F/lPy5E4hFk/PhT6xKXccGC6WG8n/xsGilZHN/MH
	jJNDVsaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdC15-00000007VY3-3LTz;
	Wed, 29 Jan 2025 17:38:19 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td6FF-00000006q6h-3RAV;
	Wed, 29 Jan 2025 11:28:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 93864A4182F;
	Wed, 29 Jan 2025 11:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4990C4CED3;
	Wed, 29 Jan 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738150112;
	bh=0afCP9tpAob285d2+c3DFTpCZwuw1x7xRMd+0cAY7dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=keXqYgpBqSxQiFVgp6ssrhizY4Du1eWNsvvQf4/NWW+oCjoyMXSVpfZ5Bn1PdB/ED
	 9wv1wBuRchQxQ0CuW4u8FMVzwJ8rB0L5vRFiLUUNtPD9wj9Bn+/Va+Q9Z6mxgIymwQ
	 JLqQeOEbqULVQhG02Pj+7zzB2MlkL8R3oKJEeNxyMF67Vwg78zTFJsO4OZ7KbIbgaP
	 YP9spZdl67qiwH0u1r8P2FYAPgdnGwinuVWEYrFRtCSPzqRNfIEkTTNBeG18dRI+F6
	 TAaVqoYmML/+XRYt7G2+YbCO7gYobpmwRSUYyDEsvRA3IA3F3pdig8YUD/h8psjWYU
	 PeniPeunBQVTw==
Date: Wed, 29 Jan 2025 11:28:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 12/16] spi: spi-fsl-lpspi: convert timeouts to
 secs_to_jiffies()
Message-ID: <61d507a3-ca37-4eb9-b2cd-100298ffeeb6@sirena.org.uk>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxS6hvAU6Vp1PxGO"
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-12-9a6ecf0b2308@linux.microsoft.com>
X-Cookie: The world is not octal despite DEC.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_032833_986110_DDAD5F9E 
X-CRM114-Status: GOOD (  10.60  )
X-Mailman-Approved-At: Wed, 29 Jan 2025 09:38:17 -0800
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


--wxS6hvAU6Vp1PxGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 06:21:57PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

Acked-by: Mark Brown <broonie@kernel.org>

--wxS6hvAU6Vp1PxGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeaENIACgkQJNaLcl1U
h9Dwlwf/b75reI0uh7UpxNuw1Dgg2fl7hJn3m8DCJwfdhTb1pyNP6o2VB7PJ1FPR
zu8lccVGi/iZRranIOtvGjKtg5SrDhrF9CChAbwxk2f26lvF27Srdn7mHycwzkEm
h579H3K/1ri3X0oWXziH3KBnzKNBR3TB6h7Rp5na27mnWR9gKqZncog+7Qvr1aP1
3ufuZYWQ3RTFLp/IcPgBRYYjA/Ev1i7qKuqRS8qugS1d1vtZ7Js396WlV3r1KtgJ
qKDie5bMyU16q7C+SJERETYIrFvtYKXn3bERyeN2wpSjyOtEYM2awuQ3XRDFvz05
lMz/vFonoSs3p3TPlosZHyaOSE/Vdg==
=JJPM
-----END PGP SIGNATURE-----

--wxS6hvAU6Vp1PxGO--

