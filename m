Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA55FF8868
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zlFAOFYiZOzC44pYWGL5TREI1CIhVmN1JWJKwtP01s=; b=a9fV2pJxfO2BZm0nKU8tg0ViDy
	uL2ArzEb7K+2TnFZCDRwN9WmwtWP4/YTk2pfsK71sv+yHhJwNM6jGVGkLbnmxykghN2FVnYTi+QPT
	/WXZbnZeoGtGsEu2XcimzVIGCxK4XBcDF8/GzTQ17DMZ25/5FNMnCTEmXVv0W5Fl/bhrev4mUc6I+
	Lf7kzDCcgYBw8lO3KawtiubM+jKD1hOr1fWSkPZnlBKK8HT7w4L9cvzKgfyIIlCEoN3digvdBiONW
	uGLP3GM8jdxK73NryRPzsaIXWpmqg+B+Lvq32ooxdLFyK7ZrJcQqwvKi5JCziwYuRDSeSSUMAmZP5
	VEAwdJWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHRB2-000000000eF-0H6j;
	Mon, 27 Apr 2026 18:59:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHRB0-000000000e9-48Jw
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 18:59:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A04060138;
	Mon, 27 Apr 2026 18:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2FEC19425;
	Mon, 27 Apr 2026 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777316365;
	bh=QZMJEGWHpiUV8DXG+f5+MQeXhOqVWOdAFotZCB/w/YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMpOtJyebplhqLg3INhnwzSYoUbul8qypAaLtXfK3T4lGdt+39VEx9+iMdFAj7+IW
	 NgcqfqoLaS3X1dN0pMWAyIxk1EsCLRTuAlU+AumP6GJo9ZYUgYCppDpL2W45xPy8um
	 ls58D/X+bwTkuZnTr3qf2L4Pfo5Sq+HTBABunK6myAJVwTW/QYDzerTQPbJ2Nze6T/
	 LNHaJu8Zk2miU+tugO8uYTGZghViAFxTVSgxryLR+zeGrCXEs9qhawIVVqbISdae9U
	 YyIxvg9gykwGNnbVvVyReLvcUQDqesii6rZ3WQ2GyMM+vZt1SnyIT0kXomK8N2HalN
	 BpGzQ4ojwezqw==
Date: Mon, 27 Apr 2026 20:59:19 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Message-ID: <xz5tuhi54qabvcyefv6hr5walm2cjls33tt76w6jhpf4xksc5e@5n3jqcum26fm>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
 <20260424130615.GW3611611@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fx6asz4eb2pbwyzp"
Content-Disposition: inline
In-Reply-To: <20260424130615.GW3611611@ziepe.ca>
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


--fx6asz4eb2pbwyzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 10:06:15AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 01:37:50PM +0200, Joel Granados wrote:
>=20
> > There is however, no clear consensus on how NVMe Live Migration should
> > land in the Linux kernel. The 2022 discussion [1] explored a VFIO-based
> > approach but reached no conclusion, likely because the specification was
> > not yet mature.
>=20
> Yes it was paused until the spec matures, then I expect it to go
> forward.
> =20
> > To move CDQ forward, I would like to understand where the LM logic belo=
ngs. I
> > currently see two options (of which I have no particular preference):
> >=20
> > 1. VFIO: Implement NVMe LM following the VFIO state machine, similar to=
 what
> >    was proposed in 2022.
> > 2. VM manager interface: Bypass VFIO and implement LM logic in the inte=
rface
> >    between the VM manager (e.g., QEMU) and the NVMe driver.
>=20
> I imagined it to be split between VFIO for the pci and volatile guest
> state and something else for the namespace setup and media migration.
That is an option. If we end up with an approach that supports namespace
migration, I'm happy :)

> Media migration is only needed for local drive so there use cases that
> don't need this component.
Indeed, And there should be an approach that supports those use cases as
well.

>=20
> We have many drivers fitting into the VFIO scheme now and good VMM
> coverage, I don't see a reason to throw it out.
And this is why I included it as one of the ways to implement it.

>=20
> > One aspect that has not received much attention in previous discussions
> > is namespace migration as prior work focused on migrating state and not
> > the actual data. Migrating potential terabytes is IMO a distinct use
> > case worth considering.=20
>=20
> Yes
>=20
> Though IDK if just plumbing the entire CDQ to userspace is the right
> choice for NVMe.. We don't know what future specs will add to CDQ, it
> may not be appropriate to treat it so insecurely.
Agreed, this RFC is just one of many ways of doing it. My original one is
fully contained inside the NVMe driver. One thing that is clear with the
tests that I have made, is that it is easy to move the CDQ logic in and
out of user space (depending on what is needed).

Best

--=20

Joel Granados

--fx6asz4eb2pbwyzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnvsgYACgkQupfNUreW
QU/3uQv+NPG6qzWp17pKJHYq2szzSv1KxtgC/fUhTquOPwPbjQyZD5HqxcymSEQl
PY2/8A1Yn3CkPQgpYU/VyjZkraZtGp056uol745oX/JpB+vGNZssBSPUlT/SyKM9
bDH0fSbqA54IaNC3ohgAr+f0Mhefm7C1nQcbkULUtneMP4GMmWYBeXXZQ14w+VyF
bKSwCNpH1ey1gQomM3V39ahwkcBLZxe9Fw+vakXoWphLN7KWFdZSlBut/sdDbaJU
VAKeJgSB7AYB0OKFj08Tb0+9xkh2yTd6Q5+6h9DLGWVVd7L8f8dwk/OodNu/Xqzp
m7k8UlDVwDuJji766N3cD8gzIVkih8SrO2zMPf6CQE9sJHZh7e7eHhygRStLdx20
sSzcY1eOrnMEuMK8Yf/iFn9f+rMik6K13/8HuZOeuPJvxhUJYB4x/h2Ic2f1nOW6
743R1NNygYl/GT2ZCQKWsgUR7sxxx4Ms31VeFNpsWPTXLughWXlQFgbuLkY/0lz7
/zdY7KVy
=gotq
-----END PGP SIGNATURE-----

--fx6asz4eb2pbwyzp--

