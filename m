Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C92C38A02
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tAv51rpZOKVVMH/XwUYqinmf9dspJUdohujaamXBq5c=; b=THm0xyQ6YkXGKMiSi1WHTsA/Rq
	qCOLabYUVrzwJsVTvfl91jmJbuvOenD/6F2/L0A6LgftboiK5nGQJIAw6iUoZrAAIgBWrwid9dyHb
	xjn+OXVKuoz3t8RNtjZ98WyXGJ6ijFj6QXpNLV0Iv6p/LpMqchXD48ksR5BLg0qDl9I0kyc1nn89C
	hoHOmU6jZWud2FwiB/+gvC+NwgLIgS9Efc90GDNkDwB/89G5ewot3o06ghI0rwKEzrzrqlLYBL3qW
	WiagWigndOb2ot5ao3EN7nKp5rKWeKfo2y90vxXaGdBxO98RL0Yrt1f/sElQCT+/fYZTuEMQ9adGQ
	thXuuRTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opU1X-00BkSb-Hk; Mon, 31 Oct 2022 12:36:15 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opU1T-00BkQh-OJ
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 12:36:13 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221031123608euoutp02b1bfcb9a36bfdd6a1f7c40553f60a8c3~jJ4u6Awu40716007160euoutp02V;
	Mon, 31 Oct 2022 12:36:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221031123608euoutp02b1bfcb9a36bfdd6a1f7c40553f60a8c3~jJ4u6Awu40716007160euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667219768;
	bh=tAv51rpZOKVVMH/XwUYqinmf9dspJUdohujaamXBq5c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=s9INRYkeriaIwl5fn39FdaC2NaxgSKKHLMLIhpTC3oc8jBf1K6xuIZRf5/ZaEFS+S
	 H/GDRiau2wMaw1U8DOvaPH+Zb7rR804dOqsKPjAa6F82H4DwfFnRQ/gd54invxaxgz
	 0cEV6MZmWmEOe9aRSKns/2W2FPwLqtN521vDMhZ4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221031123607eucas1p1c11f52589f98458de6218a3aed8ed5e2~jJ4uokHF_0254402544eucas1p1l;
	Mon, 31 Oct 2022 12:36:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.C5.19378.731CF536; Mon, 31
	Oct 2022 12:36:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221031123607eucas1p1f04c4f6dfa5f37bd5ddcc44f555b691a~jJ4uJ1-U40863508635eucas1p1b;
	Mon, 31 Oct 2022 12:36:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221031123607eusmtrp135737a980706e310e3c424ae9f28938b~jJ4uJIoR43088530885eusmtrp1d;
	Mon, 31 Oct 2022 12:36:07 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-49-635fc137287a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.BB.10862.731CF536; Mon, 31
	Oct 2022 12:36:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221031123607eusmtip22d2421bdbb4e153330906ceb2547af71~jJ4t61Ap_2196921969eusmtip2O;
	Mon, 31 Oct 2022 12:36:07 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 31 Oct 2022 12:36:06 +0000
Date: Mon, 31 Oct 2022 13:36:01 +0100
From: Joel Granados <j.granados@samsung.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<joshi.k@samsung.com>, <javier.gonz@samsung.com>, <p.raghav@samsung.com>
Subject: Re: [RFC 1/3] nvme: Return -ENOMEM when kzalloc fails
Message-ID: <20221031123601.xnwjiltsbjcqt6me@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="dok4vspay6ncsipm"
Content-Disposition: inline
In-Reply-To: <20221030080236.GG4214@lst.de>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87rmB+OTDS6t0LNYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBmtM48x
	F3TyV5zf8Iy5gbGFt4uRk0NCwETi2/525i5GLg4hgRWMEj1H9zJBOF8YJbYd72MFqRIS+Mwo
	cf4kM0zHvzXfWSCKljNKrP3awQJXtOWLBERiC6PEtcs7wRIsAqoSfx/fA+tmE9CROP/mDpgt
	IqAk8fTVWUaQBmaB/YwS2zteg60TFrCT2Ns8hw3E5hUwl7hxexMThC0ocXLmE7ChzAIVEp8W
	/gCyOYBsaYnl/zhAwpwC2hJrPz2BulRJ4uubXlYIu1bi1JZbYK9JCPzgkJi3dTkbRMJF4tvs
	D+wQtrDEq+NboGwZidOTe1gg7GyJnVN2QQ0tkJh1ciobyF4JAWuJvjM5EKajRGefF4TJJ3Hj
	rSDEkXwSk7ZNZ4YI80p0tAlBzFCT2NG0lXECo/IsJG/NQvLWLIS3IMI6Egt2f2LDENaWWLbw
	NTOEbSuxbt17lgWM7KsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECk9Ppf8e/7mBc8eqj
	3iFGJg7GQ4wqQM2PNqy+wCjFkpefl6okwlt/NjpZiDclsbIqtSg/vqg0J7X4EKM0B4uSOC/b
	DK1kIYH0xJLU7NTUgtQimCwTB6dUA5PeEj2fmuvxfn37TPl8g6bcnqgrVbZ9XmXdFYn/zz/t
	mzVxlngit/+ELxN7Uq1eWwh2/Dtl3lfgne2wTWz6kqu/WlkX7Y9L21qwkuX5mZkfJvce/68e
	uy1/TvG83zo7Fn0N+uP555Pac3lJWZtkVuN7SZoMBQ3dBWHL1h6s5mlhfBK2bNYcmZZ/DfMC
	y10+rq1v2B6kuvHsygPCL987iZ21r5rjl6XXkiFQ8OAMr1BLopL12T+TH31gOvzq75a6hxd/
	umQl9f/9slTs690dWo0MNX+cHCcVveqO9rkd5Leu9VQpl9L1qaI23ybVB13LOTL9bePcj58+
	85z/5pz/K/GbS11D2/O3fNK/3T+HbahQYinOSDTUYi4qTgQAOD9S6skDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7rmB+OTDb595rJYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehn77s5nLGjnr5h4bglLA2MTbxcjJ4eE
	gInEvzXfWboYuTiEBJYySvxY08IEkZCR+HTlIzuELSzx51oXG0TRR0aJnmXvoTq2MEpMajsK
	VsUioCrx9/E9ZhCbTUBH4vybO2C2iICSxNNXZxlBGpgF9jNKbO94zQqSEBawk9jbPIcNxOYV
	MJe4cXsTE8TU2UwSnx8+YIVICEqcnPmEBcRmFiiTePwaZAMHkC0tsfwfB0iYU0BbYu2nJ8wQ
	pypJfH3Tywph10p8/vuMcQKj8Cwkk2YhmTQLYRJEWEvixr+XTBjC2hLLFr5mhrBtJdate8+y
	gJF9FaNIamlxbnpusZFecWJucWleul5yfu4mRmC0bjv2c8sOxpWvPuodYmTiYDzEqALU+WjD
	6guMUix5+XmpSiK89Wejk4V4UxIrq1KL8uOLSnNSiw8xmgKDcSKzlGhyPjCN5JXEG5oZmBqa
	mFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MJUeUawNZTdaKSfg8eiHemJIoIHd
	zv0KEzjW+fCcFv0Ztk7fPi3vk4TQ8QzB24/viYXonQrZLB76dv+9MscdH5UZBc5Lnjxv+Wzp
	ZK2Xd5N0/h6sfqSkFM/p07izbfXXjTtDjn3SvLBk9lPBdROWXRf4+DtsT4TSia2e/RdyL8S5
	b4woU1Nk641PfPCB229rzITaWQr3/s5e6HErnHNu37Fvby9s5f9tbCUosUJCOdvTJeG08bSO
	Txs87I1dJ836zH0rYMlpkXeWsVbLejWDqyUZi7WdmLMVLkxfu/rS+ulqvUanq9JV3b8WV4tZ
	dhpUBVj+Mas7olvnojlz8UUz5fZ3kRlGF98ky79Wdn4ipsRSnJFoqMVcVJwIAB1A9L5rAwAA
X-CMS-MailID: 20221031123607eucas1p1f04c4f6dfa5f37bd5ddcc44f555b691a
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed@eucas1p2.samsung.com>
	<20221027155724.1161670-2-j.granados@samsung.com>
	<Y1qxUXuqDHYi+LO+@kbusch-mbp.dhcp.thefacebook.com>
	<20221030080236.GG4214@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_053612_082892_D7B91999 
X-CRM114-Status: GOOD (  20.29  )
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

--dok4vspay6ncsipm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 30, 2022 at 09:02:36AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 27, 2022 at 10:26:57AM -0600, Keith Busch wrote:
> > On Thu, Oct 27, 2022 at 05:57:22PM +0200, Joel Granados wrote:
> > > In nvme_init_non_mdts_limits function we were returning 0 when kzalloc
> > > failed. This patch corrects this behavior and return -ENOMEM
> > > Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
> >=20
> > I'm pretty sure I had this returning 0 on purpose. We can proceed
> > without this optional structure.
>=20
> Well, we could.  But I don't think it really is a good idea.  Why I think
> failing major resource allocation (e.g. HMB) and just continuing limited,
> doing that for these tiny kmallocs that the kernel basically never fails
> tends to create a lot of confusion and hard to test code pathes.

This seems like a more sound solution to me. Might just take this out to
a separate thread as a new nvme_identify_cs_ctrl function might not be
needed.

Best

--dok4vspay6ncsipm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNfwSoACgkQupfNUreW
QU+a1Qv/YyS3Csm/Z7hDCWXSlHidF0ZUh8BpQMKuIJCrGpPriZL9g1AYXirSK9kl
u0Y9B1DIDIdFtmfgJC0+CtieRrQ2gBf2rk0luscOL0Si2+P1U2WSDVhzAa9e63EM
E2dgjrhTOqOdeqdGORQ9igPcvJsPBeA6LTF901I2mObY2qxftld2RyZ8UrJ1BvyZ
w0E0PWjP6cl8/Of4j5A8guEmYJ+h+a0/Yok/0E5Z6FlT8lNiy1ThjfjHTBt40MNK
3WMjLRCXl8OcgIQnuQHvIjzCiz4iATfIUkM0vvLEe2keO56aD5e9Ev0cH/KC9Li+
+DwdCDgrEjXkUVQObThK8XQzNczXfL0HZE2U13doieaaZ414mJvDOIA1bYJInbmC
fnD9gkCWklRtMqyUH3UKpgoqlp9IB57FP2VnxG3XuP4DLJZv4YcQ40M9SYZmoMAA
ka3CWBBt42KIWkvLvcJ/u1lVH5KbrgrtKlXiuoAWzpyZgw4wNUGc5y+bxOgDq2/J
h4EREF9+
=2eop
-----END PGP SIGNATURE-----

--dok4vspay6ncsipm--

