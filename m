Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123AFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMMo1z7C46XQZBxnUXvMbhCe2tGefAvVFUaMKQ7w+c4=; b=G6XKCa/1FxGlCJ4WG4pW4U/mXw
	qWAHlSe/phQ4Zx9+DsiWg+ziSLM8fs9thYodO11F2DgyDf46Y0UjlxKooQ5rGPSf52xjDh5xkwgLm
	1Q0R13FKx5M4HtvUF+o/fmEstm02ZeSL2q5lShddJV1wouTIbpu4rSeG2bEyLCZWwJnXu1nd1M+vw
	id8rmjAwwyLkzGDlsjlUA0/GrDMl5nn2l6HAeVYEt8H8ixZsCkJxH4g+CSjF+HuWs2Z9ycNa4aqbX
	c0wnM6+qat2+kTeh2k8maHQqkOg/mLGaTNM8KDpAvqDPINIoC75ZNmLz7kqVx+tFvz2DpgnCClJpV
	rn8zYbMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiDoz-0049jz-Dn; Tue, 11 Oct 2022 11:53:17 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiDoq-0049hE-BH
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 11:53:15 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221011115250euoutp022c508d1734eb3f75da89f4ee7e425564~dAZOOHsCS2436924369euoutp02D;
	Tue, 11 Oct 2022 11:52:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221011115250euoutp022c508d1734eb3f75da89f4ee7e425564~dAZOOHsCS2436924369euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1665489170;
	bh=JMMo1z7C46XQZBxnUXvMbhCe2tGefAvVFUaMKQ7w+c4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=K9mTt0T2/4XJViM+LDOHVRMdzAho83H6bo8prlbkD6ByJOFfjs2Tl6PwSS43Bc8BN
	 X5ZXxAefMRrd3c852ej4mK56IPSNjHX3b5vIc0mad/2IZy0/ZCtjIhsJbApHuvSg6A
	 jSq9SbjeMzmHk8hfuJmNpJgW7DlwpX5SrAOcgXL0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221011115249eucas1p1d74f2dc30263a91c83a176500064cb77~dAZNvCL2i1881518815eucas1p1S;
	Tue, 11 Oct 2022 11:52:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.E1.29727.11955436; Tue, 11
	Oct 2022 12:52:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221011115249eucas1p18850640a11cc033e62c43af3144b56fb~dAZNSDu141668116681eucas1p1u;
	Tue, 11 Oct 2022 11:52:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221011115249eusmtrp22c608e0ef32dc5e8b5245ae7ed567e79~dAZNRZ6A60709707097eusmtrp2Y;
	Tue, 11 Oct 2022 11:52:49 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-34-634559112e66
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.63.10862.11955436; Tue, 11
	Oct 2022 12:52:49 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221011115249eusmtip2b34b8140202e55345165b510ec5298aa~dAZNDsqmp2487424874eusmtip2S;
	Tue, 11 Oct 2022 11:52:49 +0000 (GMT)
Received: from localhost (106.210.248.183) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 11 Oct 2022 12:52:45 +0100
Date: Tue, 11 Oct 2022 08:50:02 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<javier.gonz@samsung.com>, <gost.dev@samsung.com>, <joshi.k@samsung.com>
Subject: Re: [RFC 0/2] nvme : Add whitelist for admin commands in passthru
Message-ID: <20221011065002.4tplqzxejbkiyxvk@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="n3w72udtjwe5fdpw"
Content-Disposition: inline
In-Reply-To: <Y0BvbFxg5in8H31o@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.210.248.183]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87qCka7JBtdnG1msXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsEroxz5zcy
	FyzgrtjQ+J2lgfE7ZxcjJ4eEgInE3DtL2LsYuTiEBFYwSjReWc8C4XxhlFgz7SiU85lRYs/j
	d0xdjBxgLTsPhUDElzNKXHuwmxmuaE57J5SzlVHizbceVpAOFgFViV3bPUH2sQnoSJx/c4cZ
	xBYRUJa4O38mK0g9s8AkRolH51axgSSEBbwkjs3uZwexeQXMJZ6tvcoKYQtKnJz5hAXEZhao
	kJjwtpEZZD6zgLTE8n8cIGFOAXuJqy8Os0L8piyx/Ok2Zgi7VmLtsTNgf0oINHNKHDh4Byrh
	IjFr8yYoW1ji1fEt7BC2jMT/nfOZIOxsiZ1TdkHVFEjMOjmVDRIS1hJ9Z3Igwo4Ss299ZocI
	80nceCsIcSWfxKRt05khwrwSHW1CENVqEjuatjJOYFSeheSvWUj+moXwF0RYR2LB7k9sGMLa
	EssWvmaGsG0l1q17z7KAkX0Vo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYHo6/e/4px2M
	c1991DvEyMTBeIhRBaj50YbVFxilWPLy81KVRHgZ5zslC/GmJFZWpRblxxeV5qQWH2KU5mBR
	Eudlm6GVLCSQnliSmp2aWpBaBJNl4uCUamDKT/zzU/atlOklE3H/qO3J099JJcnK1QWX/dl2
	acqeRJ9Of5Fuk9thvBYHLRySYkoDGD0i90/bdWaPyeSz73bxpt3Z0Shs+VZqoamxnvmFi4KL
	Zkruvi1XJr/ZyfhpSuW5RcwyEtfuXL9z3vaE0aMUptVHn/8JF815/uDy3/uRCy4dqg34zCDA
	18GvmPRAQIPfehW/99Un0SckVta867LV2sX1IlNgSeWUV0Y7XTlftiy5uCO2oHV5pN6U+0vm
	zGX+ddKp6Waqd6Uve2He/IpnM/fcbOLcxH8yff7uCffDxdT2rNjr9eA4p+COgzdMA6VbK8U+
	Ly736jDeEc+w9fO96Lv/zrspMmeqmz7c6H9IiaU4I9FQi7moOBEADTnNs8oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7qCka7JBvNWCVusXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoPZui/NKSVIWM/OISW6VoQwsj
	PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYy267tZC+ZxV7zc8ZmlgfErZxcjB4eE
	gInEzkMhXYxcHEICSxklGqceZexi5ASKy0h8uvKRHcIWlvhzrYsNougjo0TTmnWsIAkhga2M
	Ev9a80AGsQioSuza7gkSZhPQkTj/5g4ziC0ioCxxd/5MVpBeZoFJjBKPzq1iA0kIC3hJHJvd
	D7aAV8Bc4tnaq6wQC44xSqw9PokFIiEocXLmEzCbWaBMYsPdVywgy5gFpCWW/+MACXMK2Etc
	fXGYFeJQZYnlT7cxQ9i1Eq/u72acwCg8C8mkWUgmzUKYBBHWkrjx7yUThrC2xLKFr5khbFuJ
	devesyxgZF/FKJJaWpybnltspFecmFtcmpeul5yfu4kRGKfbjv3csoNx5auPeocYmTgYDzGq
	AHU+2rD6AqMUS15+XqqSCC/jfKdkId6UxMqq1KL8+KLSnNTiQ4ymwFCcyCwlmpwPTCB5JfGG
	ZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mq1bz+j3/6p25711l/Jr9
	Qjsl9io71bzZZG15kUPK7vyKEnOHuNb960I/GFd+2rTiyyTRCbY/5mSJPBIT36fLNrfxcuLO
	0GlpHVqfvKo763+y5l+fzG7X/mANf7l70tFX+xmdDrH/7EisVWXUu7jpqTiTmvqk+/N8NZ+a
	n3U4M9/MQCid/4yt2fXFf7nym9ZfPn1lbWt2zP5NPV6Wr6XUX6Y+rLMxlX/4dm/FfN3Lh7xu
	LnEU3lzWWmKVsCBXcV12/7y8pGT3S4oK+75GPmo8PLuXW/t0Y6la1uv8exVLK22VZ5gyH+x/
	5VHTY8ArJbvLVHmy6b+eTxeV+V/9X8C6jTU9KfiOpsq8rds1ffOVWIozEg21mIuKEwFQ0P5n
	aAMAAA==
X-CMS-MailID: 20221011115249eucas1p18850640a11cc033e62c43af3144b56fb
X-Msg-Generator: CA
X-RootMTR: 20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758
References: <CGME20221007132636eucas1p207b5f2e42f831bd7cb4c15f6e6ae4758@eucas1p2.samsung.com>
	<20221007132256.2543136-1-j.granados@samsung.com>
	<Y0BvbFxg5in8H31o@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_045310_591793_1D870267 
X-CRM114-Status: GOOD (  12.48  )
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

--n3w72udtjwe5fdpw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Keith

Thx for the initial feedback.

On Fri, Oct 07, 2022 at 12:26:52PM -0600, Keith Busch wrote:
> Just fyi, Documentation/process/coding-style.rst recommends against
> using the term "whitelist" and has alternative suggestions.
I was not aware of this. Maybe allowlist is what fits more in this case.

>=20
> I'll try to make time to provide more techincal feedback on the patch in
> the next week, though I am travelling for much of it, so no promises.
looking forward to it

Best

Joel


--n3w72udtjwe5fdpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNFEgcACgkQupfNUreW
QU9B0Av+NM0GOEiAVjlRhPtzXE8lRiMqielPgOQE49a0fHMHmSkkHm7C/t1m5/vW
M8G2fHBYF0ErjUPYVnPTLj4T9FlRBM6LTl1BSXfc18sU/zU6tDThtafnJAPaay6V
Pxu3eXp0ThtogWDLt3jtk9GDyPbGUlHckiXazUupMVmEoG8HFjfjsmj5ORrUC3Ru
2Q4XAAw64f/XnoQrwouierNRNyMVqhv7vQ95qMfFI4nEk7Q+1Gj4EXsmk3Ye5EXl
LO8kocZoLU0ezNXlMzH6igIj3O1NUkrzzn4seJ1WFrzB1Us/ZuXHXxYqrwsIiE+5
jzgZ++ykmKIvMUH69UNbUCkU8sEgtcYl0kszL8pqPE2h/m6gRfcQQ2m+3nmhWQjL
RLfZoRvLDL3RwNztV54x9dLMkdgZ+aUdLHFfRfa0vZAeliOcCCpOSOA/512G5d3E
kcpOwCtS86RJnnqBJw8AOkg5j3OlKAOTUMpx/xfLEvnXqvnS3DJy/w1Jz9dOpsJY
yHaKOpSb
=4JZv
-----END PGP SIGNATURE-----

--n3w72udtjwe5fdpw--

