Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D067C48BC4
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Feb 2024 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UO6BHw1ihzgpeRBQ0bvNxub7e+paexcL1WHjA8wQRHk=; b=kSeGFMAg4igMrmtQ8P9YmiKmp/
	edpRk1wQfuHSOuRoSFQMRYVUxOHdXQb/wCWy6O0p1lpYYTtR8pg3zAwPaohjAxq2t+HeZk9rHY34A
	rAMVU6dWe6vyDkmxe3nM5NMMGIUfxjIUz40X8fy37mbT6ZptWGjcwKylwEkh/5qX3xKCHQTNKaGzb
	Bey7x5dB1swphejXjHdDGetMgWPifeBhiInKYJ9qoULm4NHolTQEAwF6XLTkT7ZGZ77NLYt5R26yb
	sEqZdqW9XTA+xqYRxKjXtZZyjb7OlRsTi9g7vbJY3erGkH4TZ5VsHio1TYQPONasFeeeGMUmhJnqC
	mOsst7BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbmXB-00000008HbP-00tK;
	Sun, 18 Feb 2024 19:09:05 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbmX7-00000008HaL-1wva
	for linux-nvme@lists.infradead.org;
	Sun, 18 Feb 2024 19:09:03 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E76781C006B; Sun, 18 Feb 2024 20:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708283331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UO6BHw1ihzgpeRBQ0bvNxub7e+paexcL1WHjA8wQRHk=;
	b=YpIsDUMiPL4NwLKKvg8ynwih9EeW2hmqUwxY3yApkx7HD5+0Ednpy2C4PYQUg4pQPNTkeO
	OrcaPIMchZzi/DHlWy3C4Wz88zm8nDqO3jaEllihLV2wCWv+obWxOY8k8SgD2p80dqZTkE
	o7aBdrMJ572NzHvOJ7P+mLKlDs1otD8=
Date: Sun, 18 Feb 2024 20:08:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	james.smart@broadcom.com, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 13/16] nvmet-fc: do not tack refs on
 tgtports from assoc
Message-ID: <ZdJVw8PbwTDngATQ@duo.ucw.cz>
References: <20240207212700.4287-1-sashal@kernel.org>
 <20240207212700.4287-13-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LfSJrMDKQ4jMO3dD"
Content-Disposition: inline
In-Reply-To: <20240207212700.4287-13-sashal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240218_110901_825909_56CE248D 
X-CRM114-Status: GOOD (  14.88  )
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


--LfSJrMDKQ4jMO3dD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Daniel Wagner <dwagner@suse.de>
>=20
> [ Upstream commit 1c110588dd95d21782397ff3cbaa55820b4e1fad ]
>=20
> The association life time is tied to the life time of the target port.
> That means we should not take extra a refcount when creating a
> association.

I don't see this one queued for 6.1 or 6.6. What went wrong here?

Best regards,
								Pavel

> +++ b/drivers/nvme/target/fc.c
> @@ -1110,12 +1110,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtpor=
t *tgtport, void *hosthandle)
>  	if (idx < 0)
>  		goto out_free_assoc;
> =20
> -	if (!nvmet_fc_tgtport_get(tgtport))
> -		goto out_ida;
> -
>  	assoc->hostport =3D nvmet_fc_alloc_hostport(tgtport, hosthandle);
>  	if (IS_ERR(assoc->hostport))
> -		goto out_put;
> +		goto out_ida;
> =20
>  	assoc->tgtport =3D tgtport;
>  	assoc->a_id =3D idx;
> @@ -1145,8 +1142,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport=
 *tgtport, void *hosthandle)
> =20
>  	return assoc;
> =20
> -out_put:
> -	nvmet_fc_tgtport_put(tgtport);
>  out_ida:
>  	ida_simple_remove(&tgtport->assoc_cnt, idx);
>  out_free_assoc:

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--LfSJrMDKQ4jMO3dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJVwwAKCRAw5/Bqldv6
8gWHAJ48kG4XWYE4gvOKhhrCrFwKENwUXwCfdMTyE10BLyKcPXjjH72pOsUk44U=
=ByLx
-----END PGP SIGNATURE-----

--LfSJrMDKQ4jMO3dD--

