Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21C0C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZHStD4d2duLOrKC5jnq/o9AsnwLvvHTrv48zeV3r7E=; b=kLtvBVhBtE4piW8sdmjTXd2Hrn
	h6uwlApWeIHhz2tErsZ7AkTPis2wf7pi4vGkY85FdC/dQZNeo4hVG3toOpoTaJ5ltJM7M3kE79Myl
	O+RBb9Ge7C5PZ3gZBj0U5ZpO4lkf/amsj3quwu4EzkxrAAqILwG1f7SGi9LXhLC3Ec1whYda8Kuj3
	bTdjpc19+2NLx7DAqokCn5Gx2cNRbrk/PrPWlkq3VTnvHjKuLXSdwlB797v2mq7eMOgZS1Xgn5//K
	mQwNiDAuqJtUFX/e9eU44J/b8YsDC9serqU/wnE6RahVCeT2PxefDq0qKuOxc7K0nOTk/zVaGBOhq
	O/bDCuDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmwg-0090YR-3U; Tue, 19 Jul 2022 13:07:26 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmwX-0090R7-R6
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 13:07:24 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220719130710euoutp0258323c6a41778577772f042ea91e8c45~DPOJi5gSi0146701467euoutp02R;
	Tue, 19 Jul 2022 13:07:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220719130710euoutp0258323c6a41778577772f042ea91e8c45~DPOJi5gSi0146701467euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658236030;
	bh=cZHStD4d2duLOrKC5jnq/o9AsnwLvvHTrv48zeV3r7E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AKSyk6cRla5kZvWyMF0xo1YfjZcpLAzO20ltzWd3ZXAHU4uKi7R8T7O4cXM6qBM6C
	 nVrUgtMJU6kJHp5EBmW3H7z7B+Ph8Ed+idxmVd6ay+4AyfSVAIVmsfnshLqc2nD1AD
	 /7vC9Q0r/lvLx1ANAuQYEsTRgUOGFDxUxqyg5GJ0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220719130710eucas1p18f996c0920523fb154a8de3b87880c29~DPOJWqOtS2871028710eucas1p1p;
	Tue, 19 Jul 2022 13:07:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F4.9E.09580.E7CA6D26; Tue, 19
	Jul 2022 14:07:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220719130710eucas1p23b861ed15ec79c0c0a450f0a2b9b660e~DPOI_ciyB0749607496eucas1p23;
	Tue, 19 Jul 2022 13:07:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220719130710eusmtrp1a4a0ee7720af9f616545f7d01a06aa64~DPOI9kQOK0092300923eusmtrp1J;
	Tue, 19 Jul 2022 13:07:10 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-63-62d6ac7efbdc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C0.50.09038.E7CA6D26; Tue, 19
	Jul 2022 14:07:10 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220719130710eusmtip11e77a71927714f8fc9bb29b76e024db4~DPOI1rx_H2118521185eusmtip1L;
	Tue, 19 Jul 2022 13:07:10 +0000 (GMT)
Received: from localhost (106.210.248.172) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Jul 2022 14:07:06 +0100
Date: Tue, 19 Jul 2022 15:07:05 +0200
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: <kbusch@kernel.org>, <sagi@grimberg.me>, <joshi.k@samsung.com>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<k.jensen@samsung.com>, Javier =?utf-8?B?R29uesOhbGV6?=
	<javier.gonz@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/5] nvme: rename nvme_validate_or_alloc_ns to
 nvme_scan_ns
Message-ID: <20220719130705.iroaqx4zcdsf6gep@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="m2hgdk3tl3u2x73j"
Content-Disposition: inline
In-Reply-To: <20220718052503.235270-2-hch@lst.de>
X-Originating-IP: [106.210.248.172]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87p1a64lGTQcUrJYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVsXzJPPaCp6IV15fsZmlgPCPUxcjJISFgInF89kymLkYuDiGBFYwSDdPvs0A4Xxgl
	XiyeBpX5zCjx8ukWNpiWe50rWSESyxklji2Zg1B148JuNghnK6PEskNr2UFaWARUJa50TWUG
	sdkEdCTOv7kDZosIKEk8fXWWEaSBWeAXo0TrtaVAozg4hAUCJbZf0Aep4RUwl1i+4SkrhC0o
	cXLmExYQm1mgQuLH7s2MIOXMAtISy/9xgIQ5BQwl3rbcYoK4VFlizusdzBB2rcTaY2fYQVZJ
	CHRzSkw88oUVpFdCwEXi/MdUiBphiVfHt7BD2DISpyf3sEDY2RI7p+yCmlMgMevkVDaIVmuJ
	vjM5EGFHiR/L/kNN5JO48VYQ4kg+iUnbpjNDhHklOtqgoa4msaNpK+MERuVZSN6aheStWQhv
	QYT1JG5MncKGIawtsWzha2YI21Zi3br3LAsY2VcxiqeWFuempxYb56WW6xUn5haX5qXrJefn
	bmIEpqzT/45/3cG44tVHvUOMTByMhxhVgJofbVh9gVGKJS8/L1VJhFek9nKSEG9KYmVValF+
	fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBiam8vQqw6vB6+PbF1oeLJ8h
	Ef1tWeCU5WySJtw9LEvTM+f9j2UtdTO6smpie1Sn1qSPMRdfvWjxXycvWeXhtOR7rKPGWYOW
	R3E14T9WVd48/WPJ20UTbr6erNibvDn/dbLCi6NxrFcyDaLj92gdVjCwVSs69/j+5HTxOyI5
	CVevH5Ux2FuUGOW97tRn3UNrEw++vrr1ww2v1yez7k2Na9fzmB8l/ySR0d2G4SlbkcWhb3Ie
	3BfuPN3r0cRWxsjPIhAWc7pKTOzDk9pzbrduO8/+8GO11ULjYlfX0H99DZcU1oSrOjDvdpm0
	d5d9OY9oqMnUBS8/CPxcuELrlE2XycJnTy4YSPdP2vfo/KmNYdVKLMUZiYZazEXFiQAw7zel
	1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7p1a64lGZxu57RYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcWvHK8aCx6IVi+f5
	NzCeEupi5OSQEDCRuNe5krWLkYtDSGApo8S6xVeZIRIyEp+ufGSHsIUl/lzrYgOxhQQ+Mkpc
	Oh4I0bCVUWLf81+sIAkWAVWJK11TwZrZBHQkzr+5A2aLCChJPH11lhGkgVngF6NE67WlTF2M
	HBzCAoES2y/og9TwCphLLN/wFOqK1YwSZy9vYYNICEqcnPmEBaSeWaBMYl63MYQpLbH8HwdI
	BaeAocTblltMEHcqS8x5vQPq/lqJV/d3M05gFJ6FZNAshEGzEAaBVDAD3bxz6x02DGFtiWUL
	XzND2LYS69a9Z1nAyL6KUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMG63Hfu5ZQfjylcf9Q4x
	MnEwHmJUAep8tGH1BUYplrz8vFQlEV6R2stJQrwpiZVVqUX58UWlOanFhxhNgWE4kVlKNDkf
	mFDySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY1rFk+l84/1ci
	oYDbgI/D5l+AKcve9c2/dQ5OVpidf7H5ctW9l6aPRCztPdIeS3Bob1EseT519luP5h3MDbui
	qi4n3pkf6pj0apUFs+TNc/HhoY2nmlTjJK+mTLwqtqivxfK067OMrK4Nbj5bersnH+766hw7
	8fIB9oezfqnf+9L4vnth8dTXGscvWZdeDpvi05m+6Oti2fp0u8BVaqtd9LS/liz/fbr/DIdi
	qc3T9TXagvubDdx+vTf867JL3bNjc02z7lVOuRubnMxlT3n/YTB1eLDR7+Y+qX0Nuj6rTpYk
	XN/fulnYK5zh77JSlQ+Mn2dP6g/P2/XBOPeQ5oXPernRdXMPXT7DVnunxuerEktxRqKhFnNR
	cSIA1nk+8XADAAA=
X-CMS-MailID: 20220719130710eucas1p23b861ed15ec79c0c0a450f0a2b9b660e
X-Msg-Generator: CA
X-RootMTR: 20220718052513eucas1p1ee11c8499b288296313cebb5775a240d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220718052513eucas1p1ee11c8499b288296313cebb5775a240d
References: <20220718052503.235270-1-hch@lst.de>
	<CGME20220718052513eucas1p1ee11c8499b288296313cebb5775a240d@eucas1p1.samsung.com>
	<20220718052503.235270-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_060718_427850_FBE29058 
X-CRM114-Status: GOOD (  23.51  )
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

--m2hgdk3tl3u2x73j
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2022 at 07:24:59AM +0200, Christoph Hellwig wrote:
> This shorter name much better fits what this function does in
> the scanning process.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eabffbc708cd9..88b14fbb7a5a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4283,7 +4283,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, st=
ruct nvme_ns_ids *ids)
>  		nvme_ns_remove(ns);
>  }
> =20
> -static void nvme_validate_or_alloc_ns(struct nvme_ctrl *ctrl, unsigned n=
sid)
> +static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  {
>  	struct nvme_ns_ids ids =3D { };
>  	struct nvme_id_ns_cs_indep *id;
> @@ -4391,7 +4391,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
> =20
>  			if (!nsid)	/* end of the list? */
>  				goto out;
> -			nvme_validate_or_alloc_ns(ctrl, nsid);
> +			nvme_scan_ns(ctrl, nsid);
>  			while (++prev < nsid)
>  				nvme_ns_remove_by_nsid(ctrl, prev);
>  		}
> @@ -4414,7 +4414,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctr=
l *ctrl)
>  	kfree(id);
> =20
>  	for (i =3D 1; i <=3D nn; i++)
> -		nvme_validate_or_alloc_ns(ctrl, i);
> +		nvme_scan_ns(ctrl, i);
> =20
>  	nvme_remove_invalid_namespaces(ctrl, nn);
>  }

Great change to increase readability! I was confused at why it was named
like that in the first place.

LGTM

Reviewed-by: Joel Granados <j.granados@samsung.com>
> --=20
> 2.30.2
>=20

--m2hgdk3tl3u2x73j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmLWrHkACgkQupfNUreW
QU/Dawv/aZwNM6EP2wgeK9ht9Zi6VcVJywjrj1fJC6bTcl+HbwShPrKb/BvFVe65
rSkLB0iLZaGoI/OOnjaPzWi0H6LE6g553hot2sWRQ9f/ym1DP/Mg6WwJjbGqLt5l
CCDxnXoAyzrXYSkmcEQ3UfO0JGBVpgP2QNxREtPwFKEqmpA2Cx0wUKgg0mxxWwEc
fqatKCDnRBxeaETdh5YzVvBNigcAUtyBupLIIhgS0VX5GFWrhWZ2cTYdlMUf4tNI
HYu5aPXiDKvhjHktNY3NHznALgGeG0h0LCvf+VaJID1HkntbncIZavAg7O5NjwTt
BzhGgWOEu5/JbBSxLVKuBk+xDuEBPBPgmzG2pHEVANr+F1vXFspIL04F9TTArH2A
wlHDFmLVAoevsPO3+gPVtWG9HAwrhz5QEub1aIA2qzzZj/5zj0jGuEF2fKv75/qe
geSiv14kzSWITJwSDBbimbSJ7V/2SwzuGZHX+eojWi219W06cdwi3vVUnpStnLZx
O0iEDlWS
=ViSt
-----END PGP SIGNATURE-----

--m2hgdk3tl3u2x73j--

