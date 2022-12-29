Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A204CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 05:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2XnbzUBMsMbjEdzn5kg/X2SW2QCtTgLEyGFWa0T1gk=; b=jOUc4UjdRSx8eAOE6Za4H5UbmE
	CQXJeh8AASLlIKlqoFrQ+9UNsxqVrAqhcCHRLhvVctRj4+GGN3pd4n35ilDNIFO6DLtugwhwHwxB3
	6K9agFRS1E0r9W2NluEClKVZU65ix3iyBnWU/iqmoIeCLJvs91UIW6KzX5ukXRyUN+NJvT+HsTC3q
	2Ig2k+Idk3/LA/gmxaRXEXgEr45jilIZeJ0+VShIyIka51Xhx+WvdviQEhpU4CHhyDcDxaPQp4Kpw
	QxbxaN1Kw4bpUyXLJWDGZNDe6a1tyjfcxteWdKcg5r0e5Pvf9mTsV6V5qhcctQRSFF3zmMCvkb4XK
	0PnbBHVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAlaM-00CMet-JY; Thu, 29 Dec 2022 05:36:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAlZy-00CMNg-60
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 05:35:53 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221229053539epoutp01988c5b87ceeca85371cba14c0c658f92~1LNct6nd70256202562epoutp01a
	for <linux-nvme@lists.infradead.org>; Thu, 29 Dec 2022 05:35:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221229053539epoutp01988c5b87ceeca85371cba14c0c658f92~1LNct6nd70256202562epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1672292139;
	bh=e2XnbzUBMsMbjEdzn5kg/X2SW2QCtTgLEyGFWa0T1gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDKgMW+4PvwtIjm96cXYTWht6w5jmtk0RSDb/PIgLc4ktxoJ8wIvbuTcrv/X2S9L3
	 YumbtsRopU/ioV5pefrSmu5H1ZCEVPSoBDPOE3kwADzPjdI2xOgaetDEzeZOoBSfRg
	 CIIEcjlacV4mqEHLc9+PJci4CP4zc4xnT8ZAqKOY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20221229053538epcas5p4601c266cc3f4255fc75255d1b5f0cf76~1LNcYi9Hq1573115731epcas5p44;
	Thu, 29 Dec 2022 05:35:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4NjHDB1v5zz4x9Pr; Thu, 29 Dec
	2022 05:35:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.28.03362.C172DA36; Thu, 29 Dec 2022 14:35:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20221229053524epcas5p403762bfeb9c5e8bf388549bc05cc2209~1LNPCUq2W1573715737epcas5p4P;
	Thu, 29 Dec 2022 05:35:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221229053524epsmtrp2b55b7f75d0f33e2f98992c0b01ce1e22~1LNO_-YXQ1977019770epsmtrp2g;
	Thu, 29 Dec 2022 05:35:24 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-b2-63ad271caae9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	D3.D4.10542.C172DA36; Thu, 29 Dec 2022 14:35:24 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221229053523epsmtip1ee2f3522f43d20622c646706f7d82231~1LNOLRXv41967019670epsmtip1J;
	Thu, 29 Dec 2022 05:35:23 +0000 (GMT)
Date: Thu, 29 Dec 2022 11:05:05 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <20221229053505.GA1573@green5>
MIME-Version: 1.0
In-Reply-To: <20221228151255.GA32138@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTQ1dGfW2ywZoVZhYrVx9lsph06Bqj
	xdOrs5gs5i97ym6x7vV7FgdWj/P3NrJ4bFrVyeaxeUm9x+6bDWwevc3v2AJYo7JtMlITU1KL
	FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
	lfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM15d3sleMI+1
	YsHqFsYGxr0sXYycHBICJhL9/e/Yuxi5OIQEdjNKvNn1hAXC+cQocaHtCBOE85lRom9PK1zL
	vaWvGCESuxgl5l99wAbhPGGUaL1/kgmkikVAVWLb/5NAHRwcbAKaEhcml4KERQSUJJ6+OssI
	YjML9DBK7D1bAGILC0RJzJv7ig3E5hXQkph14x0zhC0ocXLmE7DFnAI6Envn7wSLiwooSxzY
	dhzsOgmBj+wSc/p3MoLskhBwkfh1TwTiUGGJV8e3sEPYUhKf3+1lg7CTJS7NPMcEYZdIPN5z
	EMq2l2g91c8McVuGxPmPR9kgbD6J3t9PmCDG80p0tAlBlCtK3Jv0lBXCFpd4OGMJlO0hcXz5
	f2jAXWOS+LtpP9MERrlZSN6ZhWQFhG0l0fmhiXUW0ApmAWmJ5f84IExNifW79Bcwsq5ilEwt
	KM5NTy02LTDOSy2Hx3Fyfu4mRnBy1PLewfjowQe9Q4xMHIyHGCU4mJVEeDXOrk4W4k1JrKxK
	LcqPLyrNSS0+xGgKjJ2JzFKiyfnA9JxXEm9oYmlgYmZmZmJpbGaoJM6bunV+spBAemJJanZq
	akFqEUwfEwenVAOTpiFf6up85gALm6pNl8V8vj09aOzi17HjyxeOzxt8V61qlz/2VGG+jHH4
	jdD8e42ZkrKHkyWfnFvxp3VW8ouFC7/k8C+3MPjjJHLL8sv5Ox5X9r356fIsIGVt06Er9jln
	Sqdc5srtVT/9feYEzdsLyj7qry9jPXEhn6P/vxVn3avFk/4c9xR+v+zQkx8bdoRW/9q8yj2W
	u2fulMvXFSW3N06bEcz05Q/XgX/p/7Nin7o+528Kl+GIL/rtKsmRNYGjtPyx38QbVR6T56cy
	RYbVlTNWvDdUccor7jqW2r5HIUet/kji0f87jgfPf1q7dllQM19NtBqH8JmjrYJRJV1GsewP
	dU12++Yxqu3ZWLxLiaU4I9FQi7moOBEAJEpDAhcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSnK6M+tpkg2nHFSxWrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRnHZpKTmZJal
	FunbJXBlLF5yibngAlPF59UXmRsYO5m6GDk5JARMJO4tfcXYxcjFISSwg1Fi8ZU/zBAJcYnm
	az/YIWxhiZX/nrNDFD1ilPj2dzILSIJFQFVi2/+TQDYHB5uApsSFyaUgYREBJYmnr84ygtjM
	Aj2MEnvPFoDYwgJREvPmvmIDsXkFtCRm3XjHDDHzGpPEiilrWSESghInZz5hgWg2k5i3+SEz
	yHxmAWmJ5f84QMKcAjoSe+fvBLtTVEBZ4sC240wTGAVnIemehaR7FkL3AkbmVYySqQXFuem5
	xYYFRnmp5XrFibnFpXnpesn5uZsYweGupbWDcc+qD3qHGJk4GA8xSnAwK4nwapxdnSzEm5JY
	WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD05XWZ54Gr+YefM2b
	tHSfOfPk7gM5N3/LOv652PvftmC549SqvrXs7wpk1smqtM7ccCBsX4/luiW2jA84Iy3W+s+8
	csUmo2HqhWjfpN9ynp8d928xfcw+pTDwy2Pdedv/2q9lMNkYs9SN69X1gCyT9gV/wko09HvS
	d0pLPynwKuy99fFBuk3dmRqmjxcZ5dMPts1zEPfTqtgaGHVwxbYHR4tPPrOaWfEz/OgmrtKG
	VdIZvHbdZd7CtUEO3lVcSgpc0843Witnd+xrPhk7UzB4toWT0ZkOxz3p9TqicQ8Mvi14X3fr
	4ad3m9cZzgzonPLWK5WvI9EjI27ni8eZGSk3vu47o5Tt2ORxS/lgYOFmJZbijERDLeai4kQA
	ekOjwuYCAAA=
X-CMS-MailID: 20221229053524epcas5p403762bfeb9c5e8bf388549bc05cc2209
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_686b9_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221228151749epcas5p3fba6d56dbe6571e4c876677999881591
References: <20221223071814.43564-1-hch@lst.de>
	<20221223071814.43564-6-hch@lst.de>
	<74cdb20e-2f38-f001-0b82-cca2b3046df9@grimberg.me>
	<20221227165754.GA7716@lst.de>
	<013abe7a-99a6-4ccd-cb62-ed28bbbc61e8@grimberg.me>
	<CGME20221228151749epcas5p3fba6d56dbe6571e4c876677999881591@epcas5p3.samsung.com>
	<20221228151255.GA32138@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_213550_905584_6BA2B03F 
X-CRM114-Status: GOOD (  15.72  )
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

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_686b9_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Dec 28, 2022 at 04:12:55PM +0100, Christoph Hellwig wrote:
>On Wed, Dec 28, 2022 at 03:49:59PM +0200, Sagi Grimberg wrote:
>> That's fine, No need to hold this for 6.2
>
>Thanks.  Keith, Kanchan - any comments on this version of the series?

This continues to look good. I am all for having this in.
Thanks for the fix.

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_686b9_
Content-Type: text/plain; charset="utf-8"


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_686b9_--

