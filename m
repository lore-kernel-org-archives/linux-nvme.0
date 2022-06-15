Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA54C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KvWaIlvfZ59vjvil/zNalhRTIs8O2ytwvv4X2MgE2AE=; b=zHBv9OHiAFym05kbA0aK5autwz
	e8iIFHC0b5b8TPwSUGTVuY5FC/whKN+Z/EQ2caHBFuysi7wCE9aI3dRPHNyd4mClIh/Hv6qgGymYR
	ZS9tYRxYm06vdeZy57Yt/s5tIhFiSsevEM1Vb4OS1Ty3dMYVjk35QZxhje+V7fsUCx9FgJGxfWYU5
	TxhYl0AU6U9hkHXQPlD37oT3OkN0N2YItuqOPcZP0AQZFsw5qz+lIKR+tbfRkknhUnUE7s00SLikS
	B4ogNRm1kXGKioMzoaFxZb7hQltnTQdnoK1zH8sccr9FcUnvDqZr5Wyn8T4KuzRaqAHOm76prBygd
	dMsi+jzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1R4Y-00E8oX-PO; Wed, 15 Jun 2022 11:20:30 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1R4U-00E8mO-Uo
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 11:20:28 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615112022euoutp0205060e9d1ad726ab59f88be44ba40102~4x1Lud3av3082830828euoutp02j;
	Wed, 15 Jun 2022 11:20:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615112022euoutp0205060e9d1ad726ab59f88be44ba40102~4x1Lud3av3082830828euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655292022;
	bh=KvWaIlvfZ59vjvil/zNalhRTIs8O2ytwvv4X2MgE2AE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=T4Acx15OLwp6KfdLQ13AGxoDG+aj1xM880wzHhefSmZUEmdocxOLXxXT6cg8DfnFZ
	 Iz5mg9M1rBaRpShJH1qbZB2BNfuySVh9xrCgBoEBZqcC+4Uwqsypk1TE7Co1BYZyvX
	 KLSmRMZpugmw3coHJB/JOi0l5I6E27IIVReWG9Lw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220615112021eucas1p230546fc3787c978a8ce9ed47c2a829cd~4x1Ld6DsZ3006630066eucas1p2Y;
	Wed, 15 Jun 2022 11:20:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.06.09664.570C9A26; Wed, 15
	Jun 2022 12:20:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220615112021eucas1p1ede659836f0c274e07832c6bcb584670~4x1LA6Q1H1978519785eucas1p1c;
	Wed, 15 Jun 2022 11:20:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220615112021eusmtrp1412b9ebe4a5c6d83f4217f0ec3b1bf8c~4x1LAR81F2047120471eusmtrp1R;
	Wed, 15 Jun 2022 11:20:21 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-42-62a9c075e5f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.9E.09095.570C9A26; Wed, 15
	Jun 2022 12:20:21 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220615112021eusmtip20faacd3770108a906a1182d022d0f254~4x1K4gCLy0966209662eusmtip25;
	Wed, 15 Jun 2022 11:20:21 +0000 (GMT)
Received: from localhost (106.210.248.101) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 15 Jun 2022 12:20:20 +0100
Date: Wed, 15 Jun 2022 13:20:19 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>
Subject: Re: [PATCH v2 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220615112019.ywxmzkiujezgiu24@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="7g7nbb2c2kgv3766"
Content-Disposition: inline
In-Reply-To: <20220613182439.GA16349@lst.de>
X-Originating-IP: [106.210.248.101]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87qlB1YmGWy5rmGxcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjuKySUnNySxLLdK3S+DKOPbkH3PBE7GKt79MGxj/
	CXUxcnJICJhI9M1cw9LFyMUhJLCCUWLrsfuMEM4XRokHj25COZ8ZJR7fW8wK0/Li52GoxHJG
	iRtPd7GBJMCqls8LgEhsZZRY/XwdO0iCRUBV4t2M2ywgNpuAjsT5N3eYQWwRASWJp6/Ogk1i
	FmhhlLhweh5YkbBAksT5Ce8YQWxeAQeJ5ofLmSFsQYmTM5+A1TALVEh8XjgBaAEHkC0tsfwf
	B0iYE2j+3K4uRohLlSVmnTrHDGHXSqw9doYdZJeEwAsOia6FB9ggEi4SU/5sgmoQlnh1fAs7
	hC0jcXpyDwuEnS2xc8ouqEEFErNOTmUD2SshYC3RdyYHwnSUWLC3FsLkk7jxVhDiSD6JSdum
	M0OEeSU62qChriaxo2kr4wRG5VlI3pqF5K1ZCG9BhHUkFuz+xIYhrC2xbOFrZgjbVmLduvcs
	CxjZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQmotP/jn/awTj31Ue9Q4xMHIyHGFWA
	mh9tWH2BUYolLz8vVUmE1yx4ZZIQb0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZ
	qakFqUUwWSYOTqkGpoqdl17nl7gm3YwXlMxNnqXJwZHw46powMHQhW9PF597eNT4/8W7on6n
	imz+On80+rkv88j0L6d2rHwiLvauK53pDP/TXctZFC79MV4454yhxxWmg/7lN2adzHilGGjb
	mNRud/KF7u0V60rKC4L7Gyqe5zXGlv44+I+T5aLdhYn7qhrWWh1s7r/tuHel2fPXOzOdT2Xy
	XfThdNkToDyL84fQ0pkBZq9/rQoQWun6SXb7k0+lLeeWe7wJU04R5Dxg5SvF/yw55UpuRri6
	p+XLq1KbMyelzSjzzVJZfOu4sSq7RUVNla5S48sdR25wPxWLevXrx73PX2xzO12KMoN38GpE
	NMQ7WS3b7sFW/uutkRJLcUaioRZzUXEiADVcU0e/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7qlB1YmGdy4zmexcvVRJotJh64x
	Wsxf9pTdgdlj06pONo/NS+o9dt9sYAtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
	No+1MjJV0rezSUnNySxLLdK3S9DL+Pj0DnvBI7GKxbcbWRsY/wh1MXJySAiYSLz4eZgRxBYS
	WMoosbgxHCIuI/Hpykd2CFtY4s+1LrYuRi6gmo+MEs8eXIZytjJKrJrczgJSxSKgKvFuxm0w
	m01AR+L8mzvMILaIgJLE01dnGUEamAVaGCUunJ4HViQskCRxfsI7sNW8Ag4SzQ+XM0NMfc4o
	MePaDFaIhKDEyZlPgBo4gLrLJP60ikKY0hLL/3GAVHAC7Zrb1cUIcamyxKxT55gh7FqJV/d3
	M05gFJ6FZNAshEGzEAaBVDALaEnc+PeSCUNYW2LZwtfMELatxLp171kWMLKvYhRJLS3OTc8t
	NtQrTswtLs1L10vOz93ECIzJbcd+bt7BOO/VR71DjEwcjIcYVYA6H21YfYFRiiUvPy9VSYTX
	LHhlkhBvSmJlVWpRfnxRaU5q8SFGU2AgTmSWEk3OByaLvJJ4QzMDU0MTM0sDU0szYyVxXs+C
	jkQhgfTEktTs1NSC1CKYPiYOTqkGJu1HG9t8zuwxynxusiIzXf1BSc4p7lSrELHYnpsNE17q
	XqtlOWJTvzj1PWvhx5bKaTZTpn13fh46bdGUeVY9l/r9vVPnbvKb08O2K1m2f0/Dqc9asxvN
	b+QHWyoU717oy3uUPXHLmk0mc7ONy+Kmvgo7On/1ZL2Zb9ZOCriupao2fTLrp3vPmn0bvDbN
	6J65WXXivr3ugeVHf/ce9TL7u+y+/d2yrdl7X8q2vTOUy7Dpf/pEQJlZz8FQbc7KC3MapByO
	GKUubnT6z73y0ErTDZ33TFIS3+qe4LM0uqb4ovtIxSOniA9tTCEBf5pXe079kKFksTDj16ot
	UssT2tgPf5m3Q9GqQTV21VfBh1ori5VYijMSDbWYi4oTAX10E+NeAwAA
X-CMS-MailID: 20220615112021eucas1p1ede659836f0c274e07832c6bcb584670
X-Msg-Generator: CA
X-RootMTR: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
References: <20220607134055.1742162-1-j.granados@samsung.com>
	<CGME20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7@eucas1p1.samsung.com>
	<20220607134055.1742162-3-j.granados@samsung.com>
	<20220613182439.GA16349@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_042027_302402_5076370D 
X-CRM114-Status: GOOD (  23.87  )
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

--7g7nbb2c2kgv3766
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 08:24:39PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 07, 2022 at 03:40:55PM +0200, Joel Granados wrote:
>=20
> >  static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> >  		struct nvme_ns_ids *ids)
> >  {
> > +	int ret =3D 0;
> >  	struct nvme_ns *ns;
> >  	struct gendisk *disk;
> >  	struct nvme_id_ns *id;
> > +	struct nvme_id_ns_cs_indep *indep_id;
> >  	int node =3D ctrl->numa_node;
> > +	bool cs_indep =3D nvme_ns_indep(ids);
> > =20
> > -	if (nvme_identify_ns(ctrl, nsid, ids, &id))
> > +	if (cs_indep)
> > +		ret =3D nvme_identify_ns_cs_indep(ctrl, nsid, &indep_id);
> > +	else
> > +		ret =3D nvme_identify_ns(ctrl, nsid, ids, &id);
>=20
> nvme_validate_or_alloc_ns already does the nvme_identify_ns_cs_indep, so
> we should be able to reuse it or move it here.
One way we can do this is to take the nvme_id_ns_cs_indep id that we got
=66rom calling nvme_identify_ns_cs_indep and pass it along to
nvme_alloc_ns. Let me adjust this for V3.

>=20
> > -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> > +	if (nvme_init_ns_head(ns, nsid, ids,
> > +			      (cs_indep ? indep_id->nmic : id->nmic) & NVME_NS_NMIC_SHARED))
>=20
> This is pretty ugly.  I think if there is no command set idepdent
> structure supported, we should probably just fake one up based on the
> legacy Identify Namespace.

Do you mean that ns->head should be "faked" with a call different
than nvme_init_ns_head which is based on the legacy Identify Namespace?

>=20
> > +	if (cs_indep)
> > +		ret =3D nvme_update_ns_info_cs_indep(ns, indep_id);
> > +	else
> > +		ret =3D nvme_update_ns_info(ns, id);
>=20
> And here we should do a switch on ids->csi ala:
>=20
> 	 switch (ids.csi) {
> 	 case NVME_CSI_NVM:
> 	 case NVME_CSI_ZNS:
> 	 	ret =3D nvme_update_ns_info_block(ns, id);
> 		break
> 	default:
> 		nvme_update_ns_info_generic(ns, iid);
> 		break;
> 	}
>=20
Will adjust for V3

Joel

--7g7nbb2c2kgv3766
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmKpwGYACgkQupfNUreW
QU/zuAv9FEFlac3MMM4wKLV2UWFRZRAiOeZNu1hZpRhoYLbjels8aPllYCiP0QuQ
NiJ9tngB30xK6FZFToxpFiQifdiIDgdLTiAzCmIY4/7FOVHzzokNsh5vTEcrOmLx
HkEUSJNe0peH7XzTCvC+Xt4lyP5tB32UQAPxTqNB8oPvZ3DBnnLxt4CH/sfzgRP2
mgb3hqyY8XbX2RsvhWDF405GFYIdK0qybyjBMR/wrbz8R5LV5AeI94GscIhjMzEy
bKcBMYBn8fod8bHBnH/LdqrICXLfdTqGDjr1fJ+jeqADJcNdtRBthPa8WVsWu4S4
4ACYYnqd8CMcpfyJtKcAduXIdllQePePjXIQ4dGM/lRCMxtkcqAcqHWpNCV1hDiU
KQ+V/5Kd7ty2LTTGm0wYtHB4qrZ0QdZjRCZm2+k6VmzGReQNMy9OUW44MY4fCEdg
G/98F5QohybbuwIuhtRY3/CsCPOCDYU52WqyWmjR8b3illAHPkNL5doGPWHyX7HQ
LZIdkgcj
=DAgp
-----END PGP SIGNATURE-----

--7g7nbb2c2kgv3766--

