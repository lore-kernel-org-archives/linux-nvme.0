Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B0C1B0FF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxcvzVHb6QGpX5vTNhZx0AQWnfqeFMf8w/1AJrtRJqA=; b=rIJ86ry7k4BCPQfJWpbiLi6HRk
	v+JUddaIb/yjDNnBh9JH09o0GZ3PURG1PRvzfHGJH3b5OYr0qvsWrOOmie5/IWsL3jTjZcV9nXSAP
	HbQoVA6o3TBEk2FwX/wWVclMPw/zxeuLZ928HrAGtB52IPyZmp+a+7yVDB1uguVzwliWgShOOYHXW
	cFY+S5c1G0nAiPy5L6ofqE2X8m4WmZjFkB6hYVxgGxMZ8eiP8yUJGoSyQnrpEcHIb+qmcjX22KLKP
	n5IE7m2oWptmNPYgjq+OILHPPYB4nkztswYNkOMkohujrNrWQepChI2caNYN5ZC/It3EkRsmW48lY
	UDV1dbNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJEr-00000004FM8-2wKW;
	Wed, 26 Feb 2025 15:22:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnFc8-00000003TpG-0d0w;
	Wed, 26 Feb 2025 11:30:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 975A25C273B;
	Wed, 26 Feb 2025 11:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC63AC4CED6;
	Wed, 26 Feb 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740569407;
	bh=9WiEqRQ0WC4TcHNEk0++D2oF9/1toQwtlnkrdN1ISFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIUlTfK2pXqaUDMpw5RIIHnVeByfDlzQfBY3+0E8d5BdAX+TUTVNIwrKJgP/FaBgf
	 IjKKuUXeG5l9Ew8YeRaCGxVo6aYi0aUIrGzgwgY4+2DWcarIPntGz/9GLbyfVSNYfO
	 SW67yeYI3cR0fo8n3xv0/29uJIe3dVQR5PiV8qSEWeCXl+fwqnxdcjjE7DRmUVfiOS
	 9ThhnWpo2ZcFcSSUl0fMoM6tREGrNbzEDH/ikx2VuLf8tYWdUKO61yIk6vUlP6vZME
	 uzwqRVd6q4FA9sQCc3I/OUPF+zTBTE5BD6JsPh7tFiinI8MhEHoSIxhQ9UdEv6t4h/
	 T5prmsk09BN7w==
Date: Wed, 26 Feb 2025 11:29:53 +0000
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
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v3 00/16] Converge on using secs_to_jiffies() part two
Message-ID: <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZCSMnIMPvhXPgIqW"
Content-Disposition: inline
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
X-Cookie: I've been there.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_033008_303779_8CEBDC20 
X-CRM114-Status: GOOD (  14.37  )
X-Mailman-Approved-At: Wed, 26 Feb 2025 06:39:23 -0800
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


--ZCSMnIMPvhXPgIqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffi=
es() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
>=20
> where N is a constant or an expression, to avoid the multiplication.

Please don't combine patches for multiple subsystems into a single
series if there's no dependencies between them, it just creates
confusion about how things get merged, problems for tooling and makes
everything more noisy.  It's best to split things up per subsystem in
that case.

--ZCSMnIMPvhXPgIqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme++zEACgkQJNaLcl1U
h9BKXgf/Ybq0e4qGEIKGWBa7OUYTknbVxMBC/99e3FVQ0Dwf4IPl8bDlEvGCxai/
A2UYH2niNzqAGOIs0IYUzaMIbok+phK2ifRcVyNdM2KciC1B2jGROzQplIYaq0bH
aEBWCAEyWMlRAMVwWL66KhB7d9asaNrv9v4WCNfcV9F4pThna3PAti9AF+sX6sQh
kvQleuahMD/hHAdTIrgBuJGgtox61kBDTFMibaWt2Moq01Wsp8YDQS3JtnnLyiE0
Rc67if2Uvg1ZMAyO3Fvm80flyFkMHhuiaq0uTFCLt1YiqCLfzk2w+QExnv0DRECR
mx63KFPW0WMILQcbYwjzaGgaLuTDWg==
=UO5r
-----END PGP SIGNATURE-----

--ZCSMnIMPvhXPgIqW--

