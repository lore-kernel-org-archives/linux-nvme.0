Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FC1FF8860
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WtwvpKuwYC3jedsAk3iYvV1vHtuA59WzQBH+AqA1Olc=; b=gtQ2CeSoTaEAVwKPl1jg9XJqWa
	eg/ql75gqEolLSnsSEoqVhsjk9xhgn9dBfJfyXniUzxjtEMJTJYERp+1pXS2NuM2f9k7rcMpr06Di
	SY+5jJI+vqafXbeGvleVaapkrIU6NpzU7smvd7xRhNMgUGL1I4bhcbIBITiYq0c9iFCqEnPQ0Ygu/
	fqtabr6zKiaHawWneSRMtGrxMj0WqE/gLkXGJKEAp+5noaItLWAhS4uUhDKHYl5rBEX+VzDsFX5wF
	Me00OICa6/hFY6i+7sEhrGNPbQyRUx6zy90cwGUa4FAnd1AeW4hl2rII/k6diFKKWEEs/hwyF3MuF
	v6F7SNvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHQdN-0000000HZdO-2O9g;
	Mon, 27 Apr 2026 18:24:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHQdM-0000000HZdH-0hLI
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 18:24:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 401AB60154;
	Mon, 27 Apr 2026 18:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C02AC19425;
	Mon, 27 Apr 2026 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777314249;
	bh=CQH8neZ6y3uTsffxBYxmU5E8eykLbOelntlH3cEzbFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyLYnb8+gzyju+qCyhcPHH4sDBV0r7TOgrM7dhUQQJTJg28A+GCZNZxc5zRpZTllE
	 i6e5cP6WtWgBPLjCF1uLaaKMOXaODqYvrO25mOAmHlbJWxMJTp3ckWtZoD00Xb1Jrp
	 68aoLYlq5dz/uK57/3C9/E2qKmYKcK6I5B6gCXOw/dLI++kA9MnqucSTzcSwJ+mMV5
	 7dDy8mRNP4NB/QFop2kEYl+lUTXus0NAR1FQad6NEypi+3bDtmNQMtCvIb32E6tfPK
	 9N9BxjpD9ZgmRIv6JoksWmHlRr8rKjwcvW89hqM9oSnjpIi9SN6GfLAYGg5Ynjx/jW
	 p4HcY5boc69sw==
Date: Mon, 27 Apr 2026 20:24:02 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Message-ID: <ieeora3jekprb2h2lhs5xcm3wnchgmd3z7f3c3hf3wl4x6npoa@5uqwtljasa3s>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
 <20260424130615.GW3611611@ziepe.ca>
 <20260424132423.GA15833@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pirpm2ayv24zbu7t"
Content-Disposition: inline
In-Reply-To: <20260424132423.GA15833@lst.de>
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


--pirpm2ayv24zbu7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 03:24:23PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 24, 2026 at 10:06:15AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 24, 2026 at 01:37:50PM +0200, Joel Granados wrote:
> >=20
> > > There is however, no clear consensus on how NVMe Live Migration should
> > > land in the Linux kernel. The 2022 discussion [1] explored a VFIO-bas=
ed
> > > approach but reached no conclusion, likely because the specification =
was
> > > not yet mature.
> >=20
> > Yes it was paused until the spec matures, then I expect it to go
> > forward.
>=20
> And it will happen in the nvme software working group.  Which should be
> up an running if Samsung hadn't done everything in the power to torpedo
There is nothing that indicates to me that Samsung "torpedoed" the
creation of the nvme SW working group.

> it.  Because of that I do not exact Samsung to have any major impact in
> how this will be implemented in Linux.
>=20
> Note that we also can't discuss any of this at LSF/MM in public, so
I see no reason not to have the discussion at LSF/MM. It is the perfect
venue to unpack the (potential) interaction between the vfio and nvme
drivers. Regardless of what is currently brewing in NVMe, there is no
reason why the fundamental architecture cannot be discussed. Of course,
we need to be careful of what is mentioned in public, but I see that as
a detail that does not prevent from having the conversation.

Best

--=20

Joel Granados

--pirpm2ayv24zbu7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnvqbgACgkQupfNUreW
QU9jygv/bhwSzKSRdPP35niigKc6dLtr7i0fh5nKhROdqW16zVlgqkbUEEnFsJUJ
yYGfi8zoevD8HTOyXC2ZSSV6cWWLYhLqFX2Ko6p3AfTwOeAuk9vyqv29j2F5xZpo
PCCtv2ckY0+Pa6WzfdnzJvQETxUulKQjkRnIuJlV+96PKaeh40dFVRK4dcCbSlyc
EISV+NL5CaXRjTJkRN7ZIDvrn80kc5deiRUwxnyWZRmLFlcs+53jiOQMZglHUf3u
uE9FOqxauoCesSH/mqUYo+ydI4Bwl0vwTKoIfKG+DEOO0jgOBMTe4fRMAB190BhH
131/hTES5SmXS1jkRG40yWL6uC6+aeuxmtYeYDDQD5eX+G44x4GC0o3yDG/kJDJc
y4s2RIl8oxjOS+F5Q/oqUuZC4zfIbxZIofdyKnMmAyIoJVQ+gwTYChBPBwMH9BIj
Qf6OoAXbePhc/yLnQABeZxyomg7XkpIm43GT6T32PcCj5EgP4F9sj8o7IFamA5GF
PDtmmOD5
=XNi+
-----END PGP SIGNATURE-----

--pirpm2ayv24zbu7t--

