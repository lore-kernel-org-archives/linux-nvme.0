Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15E2C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WKxgUuTqxyNBtYCCA5KPdxK/+iCntRLYfq0Abjln40=; b=h6PfaW8H14Y1vC/Hzxhs0sQzbE
	CIPrr9BhSX5xCDWKHKwChxNqPZoyq6c1UftM3FghtcH0FkRMw0WZnodqeAw7u5MWoB1C9TlfeEv4G
	Gh00LW7crGsoKIAdaQ+IKIiuKd0Yae6t8DQL3HJ9tMUBtLf7Bl9UivKZmhuAFnBiIaXjWhSOLQ4+W
	zfCj25NsXyPZgxVd2GX2om1kB46n4Iahzf/kepXaOrd8jBmx2hcUbkbWQkCblv3eZoAeqkW9xLhu7
	SZmTMkZ9nVX6vmWgTItVQZ2opM/fexSD6Yy7rfsuZUJ5NM+8lgWSnaq7a1iZVL4d/P9eCl3VLgFEb
	ovKYbs+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o414y-00ApGk-20; Wed, 22 Jun 2022 14:11:36 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o414u-00ApDi-Df
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 14:11:35 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220622141129euoutp015b6acae71bf44c44849cc7e97d7cfb4d~69rlo6FN10372503725euoutp01K;
	Wed, 22 Jun 2022 14:11:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220622141129euoutp015b6acae71bf44c44849cc7e97d7cfb4d~69rlo6FN10372503725euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655907089;
	bh=0WKxgUuTqxyNBtYCCA5KPdxK/+iCntRLYfq0Abjln40=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GaZ2IcOZ8+f3YjEb13sSwaVJ4egZKw+jm+JsFPdBFck+ApysZvM9HDd0ik5KyGV5m
	 vh2m0WQ10FzmzfRu2O9/VsSHuU26XE/yRxG1QTAmsY7RcL4aZi3pgYJRjU5hb/gRLx
	 71Hk5w0V6sDQKvtw3DRoxIglplzRhuD6HBu7xTAs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220622141128eucas1p1d28fc5186633b9a637eadbcc5ec813ef~69rlWaiiu1154011540eucas1p1r;
	Wed, 22 Jun 2022 14:11:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 48.E9.10067.01323B26; Wed, 22
	Jun 2022 15:11:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220622141128eucas1p23bb96058739050b7156af0f8b2bbb167~69rk7ShLQ1121811218eucas1p2j;
	Wed, 22 Jun 2022 14:11:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220622141128eusmtrp2ac481fb75b7da49311bb2074e7b5244c~69rk6qXwC0281002810eusmtrp2j;
	Wed, 22 Jun 2022 14:11:28 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-58-62b32310892a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.7E.09038.01323B26; Wed, 22
	Jun 2022 15:11:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220622141128eusmtip183bb8c2ae09847f62a2241a71992d858~69rku0vZh0590205902eusmtip12;
	Wed, 22 Jun 2022 14:11:28 +0000 (GMT)
Received: from localhost (106.210.248.99) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 22 Jun 2022 15:11:27 +0100
Date: Wed, 22 Jun 2022 16:11:26 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>
Subject: Re: [PATCH v2 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220622141126.56q46axktn3m7x7j@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="uml3fnntscrdqjne"
Content-Disposition: inline
In-Reply-To: <20220615112019.ywxmzkiujezgiu24@joelS1.panther.com>
X-Originating-IP: [106.210.248.99]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87oCypuTDO5d1bdYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR3HZpKTmZJalFunbJXBltM9/yFJwRqqidcMe5gbG
	J6JdjBwcEgImEq0rTLsYuTiEBFYwSlx8/ZUJwvnCKDFlyhcWCOczo8S7OWuBHE6wjo/3rjCD
	2EICyxklXs51hStqvr+IDcLZwiixZu0aVpAqFgFVidZ9i8E62AR0JM6/uQNmiwgoSTx9dZYR
	pIFZoIVR4sLpeWArhAWSJM5PeMcIciCvgIPEnRd+IGFeAUGJkzOfgJUwC1RIHF+6nBWkhFlA
	WmL5Pw6QMKeAo8THnR+hDlWSONfQzARh10qc2nIL7DUJgTccEt9+noIqcpE4uW46I4QtLPHq
	+BZ2CFtG4v/O+VDN2RI7p+xihrALJGadnMoGCTtrib4zORCmo8SCvbUQJp/EjbeCEEfySUza
	Np0ZIswr0dEmBDFDTWJH01bGCYzKs5C8NQvJW7MQ3oII60gs2P2JDUNYW2LZwtfMELatxLp1
	71kWMLKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECExDp/8d/7KDcfmrj3qHGJk4GA8x
	qgA1P9qw+gKjFEtefl6qkgivDfeGJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNL
	UrNTUwtSi2CyTBycUg1MRjLrY9mepCT737vyIfiFvWNCqmbde8N/Fw+ETmc9tOJuBWPjnGmJ
	H51/6l5QuLAuyuf4u60n4m59dsqvPdofKfTC2/KMxsUbkz5OfV5yp4w5/YJFzFem+IKz5+Wr
	lr39ouU8t8Z8X82/Gd9yp1o7+D1eqDW57Ft99qU3xUtTmO8aNfs+Yond8eA4P9eO4xY7l2t+
	mCPUznIwzddwWnJbkd/RhpUtT6fdmtvz484V/ws7zpWHPuswmnMsYf31qwLv73NP/CRne/r7
	ByPGFjvVpTqCvU/eRtuu/do0pWizxvGou+uDuxlFEsPu76kz6T8tKmJ+w6dF5uZNh7vdz/jd
	fSxkyqqZU5c/3bY/YcNsQSWW4oxEQy3mouJEAA9uQna+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7oCypuTDCZ/FrJYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehldK/ewlhwSqriRccdtgbGR6JdjJwcEgImEh/vXWEGsYUE
	ljJKvNliChGXkfh05SM7hC0s8edaF1sXIxdQzUdGicUHprBBNGxhlFj50gfEZhFQlWjdtxhs
	EJuAjsT5N3fAbBEBJYmnr84ygjQzC7QwSlw4PY8FJCEskCRxfsI7oAQHB6+Ag8SdF34QC+Yx
	SZz53g+2gFdAUOLkzCdg9cwCZRL/nu5iBalnFpCWWP6PAyTMKeAo8XHnRxaIQ5UkzjU0M0HY
	tRKf/z5jnMAoPAvJpFlIJs1CmAQR1pK48e8lE4awtsSyha+ZIWxbiXXr3rMsYGRfxSiSWlqc
	m55bbKRXnJhbXJqXrpecn7uJERiT24793LKDceWrj3qHGJk4GA8xqgB1Ptqw+gKjFEtefl6q
	kgivDfeGJCHelMTKqtSi/Pii0pzU4kOMpsBQnMgsJZqcD0wWeSXxhmYGpoYmZpYGppZmxkri
	vJ4FHYlCAumJJanZqakFqUUwfUwcnFINTNuCCm907J42p4lvedTRe/2FlvtPLvE86G8nHTwj
	6kT68ROGHhN6t7LNFz0hLq67Si7brk++zzOXX2Pjf7+1U3XvRpxPumW2v5XxQOw6O7mf53Zd
	iIlpfVvxnmt3sFP88rO/z9/R66zYYNm/8MN5jT9btqvUTCx7wDRv6wRjr+mVmW727pbWD32i
	swwMv03V+36vTu9PQtP+if9nT7D/ZHncyOLDpNNfzkQks95ky5LUdlO5Zjm965qszNSDK7vy
	P5cd5piy/66v+uwibk3uhfX/6i3UVgX2KSxLCJ24aLX+8hzmORdfOZwMel3UF7WSu81tUbYN
	G8/21ev/CN3Lt6h3jbRdeqgp+8OrtN3HM5RYijMSDbWYi4oTARsL12heAwAA
X-CMS-MailID: 20220622141128eucas1p23bb96058739050b7156af0f8b2bbb167
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
X-CRM114-CacheID: sfid-20220622_071132_904092_BCD856FF 
X-CRM114-Status: GOOD (  30.06  )
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

--uml3fnntscrdqjne
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

I have posted V3 for this patch
(https://lore.kernel.org/all/20220622135556.2185991-1-j.granados@samsung.co=
m/),
but am still unsure if I have addressed this concern. We can continue
discussing in the V3 thread if you still see that something needs to be
changed

Best

Joel

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
>=20
> Joel



--uml3fnntscrdqjne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmKzIwUACgkQupfNUreW
QU/MygwAlUmqDEkhlMMn5CqcrUkv5ltPOUwTJj1WTH9wyI7uBQvOWcx0D0Bzb9Rx
oPIrgVh8GVCEJatYohe/YByFb+KUSH9dazxlNLyqSf2Wh0fjVwTF/PoFeAtJ/X1z
pE88dh9okAOnArb99DFl0aMX7XSehapxnTp0/Yo7EB1mDo3OIiw+MJfTtgHlTmY+
2WIBPvZGWenppoCdMeeLyqFIZ/56tm8CADJmT1ck6ulwhkRHY8umYsV8Qd1FzB0f
hbQ4Qgp3CnziH1VdsPQtX0crMLh0ud1ceBdShF6tq+XbnojP2Vb+q/kRgng6QBgS
68RVTiFOeKkB5kn9ZYG8mAWV+2AtWf9rnaaTNJwhqA5SAoJ0CsuqYX4ZfBQPXagf
i7LZRV4FQbCSi13kbxndYkz5DSZZlUfMC6u1w8/buMkIlEsJX1ShQicW5lNwuX5M
d9xalNJlv3MVLXj53ET7Zntvu4GGW1+CIuEd8KoTIlK5+9Mty6lt5A97X+YXR2Qm
K2lq9fuL
=8md6
-----END PGP SIGNATURE-----

--uml3fnntscrdqjne--

