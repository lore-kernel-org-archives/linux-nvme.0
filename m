Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD99C5DF63
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 21:29:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF762166E
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 21:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HeCgQ7B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF762166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1vptuN/ILiNCkWK0LIr4m/085hCsiMf4NalDegQZKKQ=; b=HeCgQ7B9UrX+u72dx3kXIl7BA
	vQsl9R90XvPUUBcVkvebcQXYjkdwppUfnJi/UXst9p04qc7k8QdnVLqA0WJ4PFVQ1KtLd5gaXOKm6
	DBCt+8bTkplFra5ofZOPN41ZDBuOOmQPROk/5Utdv05OklX3qj4Mvrwzceislsf9RkuwlPWo1yEwv
	/I7CmBp+UWrIf+XMjE3u+AjQtko10bIrgklfpPnwVovKvr5NXsqz+BvETtLg3ov1B402aemPdO3NH
	HI03rAEh/4B3lWteX12vIErnycT4mcoJnfRJ8iAOEkVv7jb0Pw3bEYy+jEoXd5hidSkQBCXJf9K1A
	yITG86c5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSSs5-0006Iw-KG; Wed, 06 Nov 2019 21:29:45 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSSs2-0006Hm-P3
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 21:29:44 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 9B5A81C09B6; Wed,  6 Nov 2019 22:29:36 +0100 (CET)
Date: Wed, 6 Nov 2019 22:29:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191106212921.GA7020@amd>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191106_132942_966774_8EC85A9C 
X-CRM114-Status: GOOD (  17.88  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Chris Healy <cphealy@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Content-Type: multipart/mixed; boundary="===============7151700858154747447=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============7151700858154747447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > nvme devices report temperature information in the controller informati=
on
> > (for limits) and in the smart log. Currently, the only means to retrieve
> > this information is the nvme command line interface, which requires
> > super-user privileges.
> >=20
> > At the same time, it would be desirable to use NVME temperature informa=
tion
> > for thermal control.
> >=20
> > This patch adds support to read NVME temperatures from the kernel using=
 the
> > hwmon API and adds temperature zones for NVME drives. The thermal subsy=
stem
> > can use this information to set thermal policies, and userspace can acc=
ess
> > it using libsensors and/or the "sensors" command.
> >=20
> > Example output from the "sensors" command:
> >=20
> > nvme0-pci-0100
> > Adapter: PCI adapter
> > Composite:    +39.0=B0C  (high =3D +85.0=B0C, crit =3D +85.0=B0C)
> > Sensor 1:     +39.0=B0C
> > Sensor 2:     +41.0=B0C
> >=20
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>=20
> This looks fine to me, but I'll wait a few more days to see if there are
> any additional comments..

User wants to know temperature of /dev/sda... and we already have an
userspace tools knowing about smart, etc...

pavel@amd:/data/film$ sudo hddtemp /dev/sda
/dev/sda: ST1000LM014-1EJ164: 48=B0C

I see we also have sensors framework but it does _not_ handle
harddrive temperatures.

Does it need some kind of unification? Should NVMe devices expose
"SMART" information in the same way other SSDs do?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3DOzEACgkQMOfwapXb+vIMvACfQ4av1AszPWgW7jbyZuTg6fmz
a2EAoIkF7v4EygABLAACFFwF9dxY14dS
=o7Jq
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--


--===============7151700858154747447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============7151700858154747447==--

