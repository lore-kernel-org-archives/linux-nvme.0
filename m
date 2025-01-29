Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300AC3DA4A
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+LlRpnDAicJ8OxCQD89sCWT8NZ3A3z4q2lUUi96t0Os=; b=36xRDf3hSWB/sT+ijS3JeS6JmP
	v4N+a0+RiKdcNj8uwfvRD1rOwR+F7J7B8QCSVW367zW5pa1Q3Ua5K9g0qRbfsgrKzaOu6xvvuZ+Gj
	VW9DUbSGf/WmkDEbsFaVJmJXESAn1gIARKqU8hBIcpIJwcYVrPhIKnp+wHN6G5PXRKiO6J99zlJe7
	rLEdFo4sFHzhWbXyDahcpbZDKope0Ebcs8CXx5Sk0uCBVyeEpRv9DTkJPev6/wLT23AqblARKaBiR
	wyk8KNotzdp/YTs/URswGmWcvGqoGoNQbn40wEPojBRTd+5OuON5qz4FmwPeBTSohpgsaXt8EIce3
	gPpgwwww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdC16-00000007VYA-1Zyo;
	Wed, 29 Jan 2025 17:38:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td6HF-00000006qQM-0JI4;
	Wed, 29 Jan 2025 11:30:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 548DD5C48E9;
	Wed, 29 Jan 2025 11:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08219C4CED3;
	Wed, 29 Jan 2025 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738150236;
	bh=PGzhPhIGvedo1hUSZOhnBkmZDQESU8tumG/s6DUxvXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtI67GZDUwmVObMXVDnkn0JrT90mq1FWzZPJfX54LEnSuCkHcZegr9yD+nONZRlzB
	 NdTLLdl6vn6f8UrE+u4ErdIRAJ08ob0Xby74NcltekuNw+jlEhZ/ccP0QNf7C6JcXf
	 SwqH2i3Gs/sVoWSH1fgadm8LkE8QOh8sim2YzKEDtprzZ8ObXHa24pw/dQvs2U98RF
	 Tr6DWrDeNAfZAaOGR1I0I3HG51Uw66JRtlaZH0NKwMSzMvf3IVfb4NrYOydkdw8khx
	 9vzabwvkyLvROFag7yIgVq22runc6+02aDA3ULJ93boFRdvIIutHM5yGGI5/dCwLO/
	 rGjfk6o1HfewA==
Date: Wed, 29 Jan 2025 11:30:21 +0000
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
Subject: Re: [PATCH 13/16] spi: spi-imx: convert timeouts to secs_to_jiffies()
Message-ID: <003cc629-1969-432b-9d9a-e17a315a0407@sirena.org.uk>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
 <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqw+F9EZKY3y+n+J"
Content-Disposition: inline
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-13-9a6ecf0b2308@linux.microsoft.com>
X-Cookie: The world is not octal despite DEC.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_033037_213976_E313989B 
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


--nqw+F9EZKY3y+n+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2025 at 06:21:58PM +0000, Easwar Hariharan wrote:
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

Acked-by: Mark Brown <broonie@kernel.org>

--nqw+F9EZKY3y+n+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeaEU0ACgkQJNaLcl1U
h9DZyQf/T/OK8ZWxSzh3dJWsLr99J2XEq+bjv9e7IU0AU/eyO6YeJOJ5PzHFHkPr
Zk1IUnGI0OF8pcUXyBzuUL5L6xn4D2+l7+ChMN1V94Q0KWuPSEf7bJL7lo+UBq4k
BDHHE1Qs7qag4DrPoQb4K+6qXX46HvTIJKamPKtm4VAw0BAVoK/N6pSPKtK+yRC8
TmfWRcS+046vsaFWuQF1aS3hy1eiY0eFjv3+XLhta71PFbIfQ8sBZtX+gzPu8/t8
w8BgXrldeDtBpKhtizRNkmlu9WoicVeENDpjYOAf3CeC08eHyRT/GrS4iYwRP26k
HKKCEB2NvAkAB5bvQXqsqFPC+Nzgmg==
=CTWt
-----END PGP SIGNATURE-----

--nqw+F9EZKY3y+n+J--

