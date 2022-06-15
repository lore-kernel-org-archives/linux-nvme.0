Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC377C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5GIxW7FFivX3Pk2tJ5NZSauW+JZUb96uHsWS1I/Z36Y=; b=IYPImIoeD6QQ9Bk7yb3wl7RZ8D
	zEEno3Pef9puPLgdakQGhkWrD+V6yvW2OmcUAfRhP35Bm2DqeF9mCi3D0Y9drnlG6+P7VyxebzsXf
	trtnE1A98CPIyLJJRTAOeLc/RN1ZjJ5WH4fnAysLjqk8MFfJ9Ah7xZwoFcMNpIN0jL//+0qN8CB0O
	UgaSZAtZe6J2Xhu9x3wTOGaF6WkdPZEMvW3eE7Rl98D+NcsrmcH7ZqqQo8iNJQEucX39AQSd0UzjW
	S8AWYUa5wnxnEZKPpM5Rn92iWh+vkSdSLIEVc3akeo92U6ZwXN5N7AKbMQgkIhjzYJIqwdQgRA94T
	HGwviqkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1UM3-00F2SH-08; Wed, 15 Jun 2022 14:50:47 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ULo-00F25B-V8
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 14:50:35 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615145028euoutp01e043262d2370b197b78ba8c8e934479b~40sonGkjD0186901869euoutp01Q;
	Wed, 15 Jun 2022 14:50:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615145028euoutp01e043262d2370b197b78ba8c8e934479b~40sonGkjD0186901869euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655304628;
	bh=5GIxW7FFivX3Pk2tJ5NZSauW+JZUb96uHsWS1I/Z36Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GNQPAKLaLWCjff7vplGir8n113P7iISbMpLTGw+wHybz+V7wcwPdmatjDcJ1ePLWX
	 lcqd7Fx30/LHv6+3X3yv7nsdTfXEYs3Yg8pNsc5i/liOHUThnMSi7weSi/0yhEjfVg
	 cHdFsJE4hTRe860mXRSUtsTnuY2XslUPQ3TmlV9A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220615145028eucas1p2a603606d278c7715f014df2c89d16240~40soX6fe42826628266eucas1p24;
	Wed, 15 Jun 2022 14:50:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.2F.09580.4B1F9A26; Wed, 15
	Jun 2022 15:50:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220615145027eucas1p14ad0feb7ef1ccbe60bacd8c60cedd4c8~40snrphkm2643226432eucas1p1l;
	Wed, 15 Jun 2022 14:50:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220615145027eusmtrp1d2d3cfbd24a382b5576970e6c8883f21~40snq-tbK2266422664eusmtrp1R;
	Wed, 15 Jun 2022 14:50:27 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-69-62a9f1b4a6de
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A6.C1.09095.3B1F9A26; Wed, 15
	Jun 2022 15:50:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220615145027eusmtip29bc2f886d9f7c501f040c7c14e96d594~40snhbjW30259002590eusmtip2f;
	Wed, 15 Jun 2022 14:50:27 +0000 (GMT)
Received: from localhost (106.210.248.101) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 15 Jun 2022 15:50:26 +0100
Date: Wed, 15 Jun 2022 16:50:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>
Subject: Re: [PATCH v2 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220615145024.botqgyuar2wmyxmy@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="i2p3x3gmhzhgcitd"
Content-Disposition: inline
In-Reply-To: <20220615112019.ywxmzkiujezgiu24@joelS1.panther.com>
X-Originating-IP: [106.210.248.101]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7pbPq5MMrg+UcJi5eqjTBaTDl1j
	tJi/7Cm7A7PHplWdbB6bl9R77L7ZwBbAHMVlk5Kak1mWWqRvl8CVcXrfMbaCK5IVre/nMTcw
	/hPpYuTgkBAwkfjwVaiLkYtDSGAFo8Tjl5PZIZwvjBJ/+w+yQTifGSWm/9zJDtNxfqIuRHw5
	o8Sy52eY4IoefPjHAuFsZZTYdeEnaxcjJweLgKrEx8nTmEFsNgEdifNv7oDZIgJKEk9fnWUE
	aWAWaGGUuHB6HgtIQlggSeL8hHeMIDavgIPE9smf2CFsQYmTM5+A1TALVEjcvvyMEeQkZgFp
	ieX/OEDCnAKOEh93fgQrkRBQlph16hwzhF0rsfbYGbDfJAQ+cEhc6J7PBpFwkZh9ZA6ULSzx
	6vgWdghbRuL05B6oQdkSO6fsghpUIDHr5FQ2SFBYS/SdyYEwHSUW7K2FMPkkbrwVhDiST2LS
	tunMEGFeiY42IYgZahI7mrYyTmBUnoXkrVlI3pqF8BZEWEdiwe5PbBjC2hLLFr5mhrBtJdat
	e8+ygJF9FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmAiOv3v+NcdjCtefdQ7xMjEwXiI
	UQWo+dGG1RcYpVjy8vNSlUR4zYJXJgnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7ckCgkkJ5Y
	kpqdmlqQWgSTZeLglGpgWrj2SYpZ14qK58nLvOeo3qt6vCSE/1Heau9dvEeWiTbIHfM6s2RP
	97znYWefi5StjbR0uf1zR1dATurUiVs2bLNZElXpnnHZUXeqh1Quv8IMec48y09m7zwY5O+m
	M8m3zZloVpywuNVxm+U154WC2ksUH+32rLCqMTeq2t4cnrLK7olwFkPWzOXNXlqByq2VzhPN
	Z6Z2WC45mmpzXF/nj/Gjoy5cqVtm3Lkhu+gnQ235Nt5HL+XdWus81DLmdXmJ37Z2emB4hyvx
	ed9xnqnB/l9VGIOkd5pvbmK6fu7nzZMhJ6KibVv9b3fbnfPUfis0f3NL6aR/v++obNcK/m8W
	d+H+mf6iz6lyc1qn97EqsRRnJBpqMRcVJwIA6jsh9r8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7qbP65MMtj1Td1i5eqjTBaTDl1j
	tJi/7Cm7A7PHplWdbB6bl9R77L7ZwBbAHKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
	bB5rZWSqpG9nk5Kak1mWWqRvl6CX8X7fd/aCS5IVx7/8Z29g/CPSxcjBISFgInF+om4XIyeH
	kMBSRolPp41AbAkBGYlPVz6yQ9jCEn+udbF1MXIB1XxklLjw4DszhLOVUeLO+k6wKhYBVYmP
	k6cxg9hsAjoS59/cAbNFBJQknr46ywjSwCzQAtR9eh4LSEJYIEni/IR3jCA2r4CDxPbJn9gh
	ps5jkjjzvZ8NIiEocXLmE7AGZoEyiTMv77CAnM0sIC2x/B8HSJhTwFHi486PLBCnKkvMOnWO
	GcKulXh1fzfjBEbhWUgmzUIyaRbCJIiwlsSNfy+ZMIS1JZYtfM0MYdtKrFv3nmUBI/sqRpHU
	0uLc9NxiQ73ixNzi0rx0veT83E2MwKjcduzn5h2M81591DvEyMTBeIhRBajz0YbVFxilWPLy
	81KVRHjNglcmCfGmJFZWpRblxxeV5qQWH2I0BQbjRGYp0eR8YLrIK4k3NDMwNTQxszQwtTQz
	VhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg8jLU8eZdF2HN/WJd49RIycZtha4/BEQvfVsp
	cdVy6RKzNbMMeRI3izAkmlzMZbc64yZocfutxAalS04eE4uuXc74yn/XpeGcplOoaITJv0Nd
	EdK6EhIfHRfM7/xr9HrF055M+4/BHXF1xt3uZ1S8Z6vsX2bUPu9yhavc5fla+rfurTh7zGXj
	873CU1KK1bnzM0VDr5UdbtGdO9lZyqvl7S/b+kXN9t088oKKsVPuRJ06pR+9NMJAQddkw7sp
	N9TuPmU49GtbW3W70rL9k4SSLpVOOne/58syxsMPFEpWxk/gPTFrlci8B/tfcC/imtEceFr4
	+3S3N0xritwSZD9IfpoXxM0jnbuI+XFaRmyGEktxRqKhFnNRcSIAqAKFHF8DAAA=
X-CMS-MailID: 20220615145027eucas1p14ad0feb7ef1ccbe60bacd8c60cedd4c8
X-Msg-Generator: CA
X-RootMTR: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7
References: <20220607134055.1742162-1-j.granados@samsung.com>
	<CGME20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7@eucas1p1.samsung.com>
	<20220607134055.1742162-3-j.granados@samsung.com>
	<20220613182439.GA16349@lst.de>
	<20220615112019.ywxmzkiujezgiu24@joelS1.panther.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_075033_486710_77C54F43 
X-CRM114-Status: GOOD (  29.96  )
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

--i2p3x3gmhzhgcitd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 01:20:19PM +0200, Joel Granados wrote:
> On Mon, Jun 13, 2022 at 08:24:39PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 07, 2022 at 03:40:55PM +0200, Joel Granados wrote:
> >=20
> > >  static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
> > >  		struct nvme_ns_ids *ids)
> > >  {
> > > +	int ret =3D 0;
> > >  	struct nvme_ns *ns;
> > >  	struct gendisk *disk;
> > >  	struct nvme_id_ns *id;
> > > +	struct nvme_id_ns_cs_indep *indep_id;
> > >  	int node =3D ctrl->numa_node;
> > > +	bool cs_indep =3D nvme_ns_indep(ids);
> > > =20
> > > -	if (nvme_identify_ns(ctrl, nsid, ids, &id))
> > > +	if (cs_indep)
> > > +		ret =3D nvme_identify_ns_cs_indep(ctrl, nsid, &indep_id);
> > > +	else
> > > +		ret =3D nvme_identify_ns(ctrl, nsid, ids, &id);
> >=20
> > nvme_validate_or_alloc_ns already does the nvme_identify_ns_cs_indep, so
> > we should be able to reuse it or move it here.
> One way we can do this is to take the nvme_id_ns_cs_indep id that we got
> from calling nvme_identify_ns_cs_indep and pass it along to
> nvme_alloc_ns. Let me adjust this for V3.
>=20
> >=20
> > > -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED=
))
> > > +	if (nvme_init_ns_head(ns, nsid, ids,
> > > +			      (cs_indep ? indep_id->nmic : id->nmic) & NVME_NS_NMIC_SHARE=
D))
> >=20
> > This is pretty ugly.  I think if there is no command set idepdent
> > structure supported, we should probably just fake one up based on the
> > legacy Identify Namespace.
>=20
> Do you mean that ns->head should be "faked" with a call different
> than nvme_init_ns_head which is based on the legacy Identify Namespace?
>=20
> >=20
> > > +	if (cs_indep)
> > > +		ret =3D nvme_update_ns_info_cs_indep(ns, indep_id);
> > > +	else
> > > +		ret =3D nvme_update_ns_info(ns, id);
> >=20
> > And here we should do a switch on ids->csi ala:
> >=20
> > 	 switch (ids.csi) {
> > 	 case NVME_CSI_NVM:
> > 	 case NVME_CSI_ZNS:
> > 	 	ret =3D nvme_update_ns_info_block(ns, id);
> > 		break
> > 	default:
> > 		nvme_update_ns_info_generic(ns, iid);
> > 		break;
> > 	}
> >=20
> Will adjust for V3

I see the point of making the command sets more explicit and for
consistency I will also change the other conditionals. Its a bit more
lines, but we gain clarity.

>=20
> Joel



--i2p3x3gmhzhgcitd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmKp8agACgkQupfNUreW
QU8QJwwAgyWqortvB3WNtk876QuycgGB1vZZV5TqOluMkB11BRX8Cd+PKARyLENk
/jLELE6Hf1syJ5BjBF+byneWYVZvwFWIBJnq1q+b+yIAm8xqL9DTmQGpS28N7owD
/QiA+OS8FK3nfZzKUQfecNxH/LUCtXmXFeojdSa4fzpZhCrOGWWi0w19KVsM25E5
SC9h/YrOdU50xR+Gur74Bhvdt8itFHN+8IiMYkfuYFDnFFiJhHRFmx6LugQpFCQF
sHsQVFHR8GM4ZvKTM09PHbDU0FUAg3ua8garaT2GnrnW6hfVNs+tHHbXxHAbCGoJ
F7lM0AhmdtCtoJfoxTx/6+7MSIch/ur039mGIU7E8T8yVcP+Nml1HN4pUf5gd3NN
FJWI38t63RDBNi0lAdsapjGy+7QF2YAZEIS8ll1/2TdxpQNxvvufEwtesi+U1uD9
mYICb0oBVwtLXNNY1KJ6xTiEJTBdifEfSp/PayjmobeNM9dnJ4G6KZdNh7Yh3ux4
GDw1zrvv
=An9x
-----END PGP SIGNATURE-----

--i2p3x3gmhzhgcitd--

