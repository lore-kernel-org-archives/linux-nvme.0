Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92653C636CD
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Feb 2023 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7TLnYuW5pZ0W75XM9LgVACjPSYhsxQkUs8CnGk6vrok=; b=tpa6YjuuXZwNUUH69oCAOaYPh3
	M2+iG3OMZAM5dcBrx30XHvuAho1T6ChL4k3FJyRUeyvBY08WnLTPIq6eXs1+7IfRQ0fr9u1D6qdJH
	6NkahBE4SBtWOV0Z2IrPI+vCZRk8o2wgvIqK7nNgXWnOBuo5JoHArB9r9J4AzqjDMT33DeMz5Hbez
	nOmgik3uwJ+/heDY1pG4g9urtzTDhSK2mSiXF+6ApAd/iiTcDXV4/3IFTQ42S6ObYLP9HCwLp8t/L
	ep6l72uaWyLgGfn8WOnsWeWUQ6h64gCAwKFoH5GdSjJ6JpJoYVh5EEQwwuoHXfY6/8bGoyd5ztPpv
	D1qAtmKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPJMM-00BICO-0a; Tue, 07 Feb 2023 08:29:50 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPJMH-00BIBG-Mr
	for linux-nvme@lists.infradead.org; Tue, 07 Feb 2023 08:29:48 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230207082933euoutp01861172b4cf19ae3934dffc7f7eeca210~BfYs-yiSj0550105501euoutp01T
	for <linux-nvme@lists.infradead.org>; Tue,  7 Feb 2023 08:29:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230207082933euoutp01861172b4cf19ae3934dffc7f7eeca210~BfYs-yiSj0550105501euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675758573;
	bh=7TLnYuW5pZ0W75XM9LgVACjPSYhsxQkUs8CnGk6vrok=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mrreuakV0Gc43eIiU/VMoG7+ai+AhSTLSWwT7HdOLe0/g5BChrqy/pMJHwYG84iMZ
	 80IFqVhJtlNaUjt/bgQnGWPWKDAUPbYlzm2clSlyZy2aLmkHygGxgYNuxNM/p/2K+O
	 egIVuBRb5YbJfDnG6pkrLV4jSfFztNFsURzAD8Vg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230207082932eucas1p2dbf3c230b72bdce1691144613c7d92f6~BfYsgkKsr2503425034eucas1p2n;
	Tue,  7 Feb 2023 08:29:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.09.01471.CEB02E36; Tue,  7
	Feb 2023 08:29:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230207082932eucas1p1d2472ef0bef23056df14ae7909878ad4~BfYsKRCIH0775307753eucas1p1M;
	Tue,  7 Feb 2023 08:29:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230207082932eusmtrp210d5ecfc501e9a464dea6a7d49780191~BfYsJX6yp3073930739eusmtrp2M;
	Tue,  7 Feb 2023 08:29:32 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-4e-63e20bec36c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.83.02722.CEB02E36; Tue,  7
	Feb 2023 08:29:32 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230207082932eusmtip2866c08970ef66d3d0593b334077191f7~BfYr9hpnO2104721047eusmtip2Y;
	Tue,  7 Feb 2023 08:29:32 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 7 Feb 2023 08:29:31 +0000
Date: Tue, 7 Feb 2023 09:29:30 +0100
From: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "Lewis, Nathaniel"
	<Nathaniel.Lewis@sony.com>, Kanchan Joshi <joshi.k@samsung.com>, Klaus
	Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzned033I+SDRq3GlisXH2UyWLSoWuM
	FvOXPWW3eHLkKLvF4Wv97BbrXr9ncWDzOH9vI4vHplWdbB6bl9R77L7ZwObRPmEncwBrFJdN
	SmpOZllqkb5dAlfGxPnbmQsms1d8uzOBrYHxPmsXIweHhICJxOTnSV2MXBxCAisYJRY9/MEG
	4XxhlPjf9pAFwvnMKPGo5TNTFyMnWMfhByugqpYzSlzumcIIV/Ws7x0ThLOFUWLvxXZWkBYW
	ARWJSU2bGUFsNgFLiY3ve9lAbBEBU4lPze1gO5gF1jFJdJ56AJYQFrCRmP3tIguIzSvgLLH9
	0n1WCFtQ4uTMJ2BxZgEric4PTWBfMAtISyz/xwES5hSIlZhxdCYjxHPKEsun+0JcXStxasst
	sNskBB5wSFxaMIERIuEisahpGjuELSzx6vgWKFtG4v/O+VAvZ0tcPNPNDGGXSCx+f4wZYr61
	RN+ZHIiwo8SJb1eg1vJJ3HgrCHEkn8SkbdOhqnklOtqEIKrVJHY0bWWcwKg8C8lbs5C8NQvh
	rQWMzKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzEC08vpf8c/7WCc++qj3iFGJg7GQ4wS
	HMxKIrymBx4kC/GmJFZWpRblxxeV5qQWH2KU5mBREufVtj2ZLCSQnliSmp2aWpBaBJNl4uCU
	amAKyP1XNcNLZdJGJePIT4UyYg0yWcdWsr15lF5sukHz7vFNZyJXMTvxxkjPX/Vsc/m5z4c1
	nScnnzrtwPK9p0VB/bbdN1nuy+Vx01lKLMosO98+rBG8uZyfe5KdncXOHflaxz4dtNLh4OE7
	/spilmvKviv+B6qPp+u/UTd2v/357tnbIgHX2U8965E72ykndfPHSrWman8fFn+dUy5t/kUr
	589LWfOTyeWFzCOWcq+unFk3PFbWK1d9DFVQfc+YwKb3qZX//bNjLh47fqZwndo/7Z2L2uEZ
	/+Qm5Dl3Bvhve1weEPZKO6S5t/ODcu678KSHoo9El2Ybny/h/Fa3bsG+qrXq5RoTD3r4Zams
	YVBiKc5INNRiLipOBACaZR8QngMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7pvuB8lG7S3iVusXH2UyWLSoWuM
	FvOXPWW3eHLkKLvF4Wv97BbrXr9ncWDzOH9vI4vHplWdbB6bl9R77L7ZwObRPmEncwBrlJ5N
	UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GxPnbmQsm
	s1d8uzOBrYHxPmsXIyeHhICJxOEHK9i6GLk4hASWMkpsPN4DlZCR+HTlIzuELSzx51oXVNFH
	RonF/aeYIZwtjBJdx04wg1SxCKhITGrazAhiswlYSmx838sGYosImEp8am5nAWlgFljHJHH/
	7jQWkISwgI3E7G8XwWxeAWeJ7ZdAbgKZ+opForPvJBtEQlDi5MwnYEXMAhYSM+efB9rAAWRL
	Syz/xwES5hSIlZhxdCZYWEJAWWL5dF+Iq2slPv99xjiBUXgWkkGzkAyahTBoASPzKkaR1NLi
	3PTcYkO94sTc4tK8dL3k/NxNjMBY23bs5+YdjPNefdQ7xMjEwXiIUYKDWUmE1/TAg2Qh3pTE
	yqrUovz4otKc1OJDjKbAoJjILCWanA+M9rySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU
	7NTUgtQimD4mDk6pBqbe5w6f2hPl3Cb1PDlgU6t34WNqz2GJCuOlJRa2876tWHJ4xsHKjGVt
	fj7ti7vTWlq+KEzmz7+mpGn4/OuFvQ7/2zfqd5xp0JnPaqN65mB2/9yfX+ql+5v5BOzLJV/d
	vR8QaV937OanHl+r3/JtSir/Zi9cE/VzR+7//QmTdvAK/F2Rcys2dDbb+dcFgu3pIj/SY5aV
	cycGyZk6y1qVs175IbqM3+lX9J3Q0ovSD7T6/kj3Pwl47T/1dinnkoai+LUL5MpnHeX5m9v4
	s/B0j7HQixKBjMVXLzyWCFry0GC5WfXujcz7ws8cvHrlZs5zk6pt3T2fHu/7uepciE9CfFf8
	1uP2uTETBW4//+kUmqHEUpyRaKjFXFScCAACYTPzPgMAAA==
X-CMS-MailID: 20230207082932eucas1p1d2472ef0bef23056df14ae7909878ad4
X-Msg-Generator: CA
X-RootMTR: 20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a
References: <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com>
	<BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com>
	<CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
	<BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
	<20230206140220.6af2b6k7belue2nh@ArmHalley.local>
	<20230206154218.GA12556@lst.de> <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
	<20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
	<BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_002946_338769_7B67AEE3 
X-CRM114-Status: GOOD (  12.21  )
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

On 07.02.2023 01:51, Grochowski, Maciej wrote:
>I have tried suggested approach, with some modification: pci_device in
>pci_reset_secondary_bus is actually the bridge not NVMe device itself,
>thus I checked devices behind that bridge to see if any has D0 bit and
>base on that logic I run the custom delay.
>
>Unfortunately even with this approach I see the same issue for both
>Samsung drives, and based on kernel logs I can see that wait for
>secondary bus reset get increased.  Thus seems like this quirk don't
>work for some reason. (I tried also increasing delays to different
>values but it didn't work).

Too bad.

I will write you separately to get som dumps from the device. We have
not seen this before, so we need to understand this a bit better.

Regarding the quirk, we are looking into it. Will come with something in
this thread later. Cc'ing Kanchan and Klaus.

Thanks,
Javier

