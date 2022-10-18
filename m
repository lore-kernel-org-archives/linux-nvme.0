Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A71AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aTg2NUipFcYEpC3cCm54R/ToSmcs30WrC0ESx+vq0A8=; b=Gy/BsDsy4g56mv
	pj8lT7jv+4RaLP0aqOhHLb3bDEroxiYDL4PLdXfl17+EvAPV8ed2NpAZTMRh7JAAWG1702101vGPU
	KByoRweihNnM6XKjQhQhPB75+Kzwr9nGujtDd2bJeHjStaxQUf/tcGZsESe40cRZxqn/USSdlz6JC
	XdXVkN9ki1k2oXKZlOa4b9cV62/G2u2EosLeTmYt0aUjI/MnLOJ7mjPjqw9cCgx85GpRzM4btg9N/
	cRV0TJb72FrCd/gkxTkt4Nu+dZeU2jM+5uUZY6ne+V3rOrDIreU4aHWlba+7WdRlWljKZPrcQnSjq
	gEZXSdJ17Sb5BFAnEwxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okpYf-008xcM-0b; Tue, 18 Oct 2022 16:35:13 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okpYa-008xba-Pn
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 16:35:11 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221018163505euoutp02a0ca5d9dbeeb6ea60005798ffa56a0a7~fNwprllNL2095520955euoutp02h
	for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 16:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221018163505euoutp02a0ca5d9dbeeb6ea60005798ffa56a0a7~fNwprllNL2095520955euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666110905;
	bh=aTg2NUipFcYEpC3cCm54R/ToSmcs30WrC0ESx+vq0A8=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=SkN6AAgnkBcMtd3TqqjWAwZ13tI31sUytvAXItMxpMXoZi9vKLmGLIBI8NolKOa65
	 kOAoml3h2V6msqVIk2RnfyCj2QVKeSINtaXnORcaI/E2W5CSqAzz5D4KAKZdqNe8va
	 APCEPP7ZxbR+GRLL+HrszGV/XPGSiEU2KolVXa9Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221018163504eucas1p29985a87f63faa9379d2f67b251c05281~fNwpfF1as3236632366eucas1p2H;
	Tue, 18 Oct 2022 16:35:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 13.FE.19378.8B5DE436; Tue, 18
	Oct 2022 17:35:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221018163504eucas1p15ee8e5eea5c19aa532cfd765d5bae49b~fNwpOcqUr1474414744eucas1p1I;
	Tue, 18 Oct 2022 16:35:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221018163504eusmtrp131d67216a32d92fcd0cb96af291237be~fNwpNzWKH3039230392eusmtrp1B;
	Tue, 18 Oct 2022 16:35:04 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-a3-634ed5b85310
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.4E.07473.8B5DE436; Tue, 18
	Oct 2022 17:35:04 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221018163504eusmtip2d5d226c80a614018efa20178038d60d1~fNwpC_kbg1871318713eusmtip23;
	Tue, 18 Oct 2022 16:35:04 +0000 (GMT)
Received: from [192.168.8.101] (106.210.248.178) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 18 Oct 2022 17:35:03 +0100
Message-ID: <e46d3f57-d22c-75f8-5471-3d1922428282@samsung.com>
Date: Tue, 18 Oct 2022 18:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: ignore starting sector while error logging for
 passthrough requests
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>, "Alan
 Adamson" <alan.adamson@oracle.com>, <gost.dev@samsung.com>,
	<linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20221018144535.GA20131@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.178]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7o7rvolG7QsNbDY03+KyeLw40ns
	FitXH2WymHToGqPF/GVP2R1YPTat6mTz2Lyk3mP3zQY2j49Pb7F4bD5dHcAaxWWTkpqTWZZa
	pG+XwJWxecMD9oKpbBX7Lk5mbWD8zdLFyMkhIWAi8XjaXMYuRi4OIYEVjBLHbsxiB0kICXxh
	lPh51RUi8ZlRYtq1G3AdLyc3MkEkljNKXHz8lwmu6uz7djYIZzejxMkbtxlBWngF7CTOrvzP
	DGKzCKhKLPnyjh0iLihxcuYTsLGiAlESlza9YQWxhQUSJL6ea2QDsZkFxCVuPZnPBGKLCChJ
	PH11FuxYZoE1jBILZm8HSnBwsAloSTR2gs3kFNCRmP/4ICtEr6ZE6/bf7BC2vMT2t3OYIV5Q
	lvix4TQbhF0rsfbYGXaQmRICHzgkzn5ZwASRcJG42f0PyhaWeHV8CzuELSNxenIPNCyqJZ7e
	+M0M0dzCKNG/cz0byEESAtYSfWdyIGocJZYdamGECPNJ3HgrCHEPn8SkbdOZJzCqzkIKillI
	Xp6F5IVZSF5YwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzDlnP53/OsOxhWvPuod
	YmTiYDzEKMHBrCTC6/bFJ1mINyWxsiq1KD++qDQntfgQozQHi5I4L9sMrWQhgfTEktTs1NSC
	1CKYLBMHp1QDk8vuX0VPV2TofLRqaX+xZisvn+kas80sc5gObEx6yVKSbn1z123bVZ5mZeGv
	WG5zcvf/1VrxMZB1jZqOjrbPLRaR7zeCIjsuaHF135ux/NHm8wH6P7PW5d1Li77vwXlU22dv
	je9C18r1xbLf2Qx7V9qkKYQvudHaM2/Pnx/nKm13rZraqVSe45nQJVvP6SV1KL/HKPeJ/g3B
	2q2qFx/ZLPJS3bnK9sxTDaN2xpuu+0/Y3InRPXyngyGqdINHk9sz5yIdPd1vvoeWzZZLPX9u
	+68Vgi+Lt1/o25mZkLfutrJyVH6EClOvl7XCPPb0De87pYKLdi+23GVlrtVq9Eko/+q2fXaT
	bZWrrgfGbd2qxFKckWioxVxUnAgA0NaxCagDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7o7rvolG1xcKWOxp/8Uk8Xhx5PY
	LVauPspkMenQNUaL+cuesjuwemxa1cnmsXlJvcfumw1sHh+f3mLx2Hy6OoA1Ss+mKL+0JFUh
	I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j84YH7AVT2Sr2XZzM
	2sD4m6WLkZNDQsBE4uXkRqYuRi4OIYGljBLrfzxmg0jISHy68pEdwhaW+HOtiw2i6COjxJqW
	rawQzm5Gie1P5zODVPEK2EmcXfkfzGYRUJVY8uUdO0RcUOLkzCdg60QFoiSWPu4Bs4UFEiS+
	nmsE28YsIC5x68l8JhBbREBJ4umrs4wgC5gF1jBKLJi9Heq+J4wSl2bsBerm4GAT0JJo7ARb
	wCmgIzH/8UFWiEGaEq3bf7ND2PIS29/OYYZ4QVnix4bTUK/VSry6v5txAqPoLCT3zUJyxywk
	o2YhGbWAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYKxuO/Zz8w7Gea8+6h1iZOJgPMQo
	wcGsJMLr9sUnWYg3JbGyKrUoP76oNCe1+BCjKTCQJjJLiSbnA5NFXkm8oZmBqaGJmaWBqaWZ
	sZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU/vkbxPmZIX9eXfUbsbJdylOUy9Pe/Pf5+KZ
	Od8nCu5au/hAs7JZSg1PZY7oqon1v2b48H++HnzAaIKDEs+rvsQFC5SkJEWNIxIupclm1Bya
	Y/DmUNqtZSlJ4jrqLEeKKmZd7N7QcjbmxLvNa64qTumTWrY4UKf6mFON/7z3Zoc6Kt/uUtGb
	+aqtJM4g6b5ZUqLVhM8pvjMreC+5PZbMKnY45T1RcJPC7BXG0c1hisrZvo+7EkO+955fsuRd
	7uO5b1LuSzFeypn9gPOGbgbnroOJJYpMbr3MJeKTNh491NYjr1f66IMjh8Jfrxfbvi74/n/u
	xA1q3+VsHLznd7gyXN4ffDc0aNph99DzU3kdzZVYijMSDbWYi4oTAe+iGxBeAwAA
X-CMS-MailID: 20221018163504eucas1p15ee8e5eea5c19aa532cfd765d5bae49b
X-Msg-Generator: CA
X-RootMTR: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92
References: <CGME20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92@eucas1p1.samsung.com>
	<20221006091053.36611-1-p.raghav@samsung.com>
	<3f6f41b5-c743-83f7-a8f4-ab3ee2f16b3a@samsung.com>
	<20221018144535.GA20131@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_093509_448576_30B9B676 
X-CRM114-Status: GOOD (  14.07  )
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

>> In that case, should we reconsider this patch to avoid printing a garbage
>> value ((sector_t)-1) while logging error for IO passthrough commands?
> 
> We should probably do this, but it should probably go along with the
> opt-in for I/O commands.

Hmm, I think this patch will be orthogonal unless we put some of the opt-in
logic in the nvme_log_error() function itself.

Currently, we always log the error with the -1 sector value for passthrough
requests, which should be changed to print 0 so that we remain consistent
with the tracing infra. The same behavior should also be applicable when we
have the opt-in support, and the user decides to opt-in to log error for
passthrough requests.

That said, I am fine with this update going along with the opt-in support.

