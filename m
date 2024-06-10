Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F7C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ID7xE6PKTyY1iZGHMlK6KYdBRob24oFk3TSqKjBSBc=; b=Nbkh3Zgq/WYIvB8ApKOK9Md1wR
	TAnkXJrp+tQeR9ypd3lBAthghiX9d8H2aKhJxl4JRChsGkR6/rEvNo4KANhBpPWqsruw+trVpt1HM
	mUmvkpXt+/Bva4GJkAMBx//dqEABbM5nB8DXovuC7SK2CTuv+VbgZ0qeYBCTJSwnXuOONVUccS5Pi
	voPSp09iKEWbzU6sBTAaFoYpDIbgIZ9aRjb5UmEwXrnIgwZcQMLj2rGXIJUT5DakuJBWcW8DQsKmi
	aELQqR3yMqtTnySDoCUHwU1JQyFI+D//rHt2ijMDG315In57fC4xnhNEeslG8A7dPd7rtEs5FeHvA
	5TXpCvYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdan-00000004sRi-2Q8g;
	Mon, 10 Jun 2024 11:53:41 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdai-00000004sR3-42Hd
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 11:53:39 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240610115333euoutp02f3725de666a532c8d6cb35dc1eca1ec6~Xonaul3Vp1589515895euoutp02X
	for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 11:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240610115333euoutp02f3725de666a532c8d6cb35dc1eca1ec6~Xonaul3Vp1589515895euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718020413;
	bh=8ID7xE6PKTyY1iZGHMlK6KYdBRob24oFk3TSqKjBSBc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gNO4Wk9YLece/HsrXePd8vGx1R1Y/A7ndMD8cAHYLsRjDdEmblXFnH8ysSXxFkXxV
	 CvxVZIzd3XAJqR6z6M5u8nzZ9sSvWN/cKc5kM1AP7LcuzDAoD634J/BsT0yhni5Rai
	 KP9bF/VH/q8RJlRchIduPljnVfDMjhG15pdtC02w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240610115333eucas1p21c8528f1d243b4878d40231848a55e88~XonabyPUT0527805278eucas1p2P;
	Mon, 10 Jun 2024 11:53:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1D.D7.09624.D39E6666; Mon, 10
	Jun 2024 12:53:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240610115332eucas1p146d2e7c4b22258ff7d065afe0a3b7c9a~XonZ-FC8r2128921289eucas1p1R;
	Mon, 10 Jun 2024 11:53:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240610115332eusmtrp2205cc47a67136f6e6fc90b084379b83f~XonZ_XL5o1170111701eusmtrp2i;
	Mon, 10 Jun 2024 11:53:32 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-fc-6666e93d4b3a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.9A.08810.C39E6666; Mon, 10
	Jun 2024 12:53:32 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240610115332eusmtip1c86af94dbc0537b696f67e56ceb3659a~XonZxoM851437214372eusmtip1z;
	Mon, 10 Jun 2024 11:53:32 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 10 Jun 2024 12:53:31 +0100
Date: Mon, 10 Jun 2024 13:53:30 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <bvanassche@acm.org>,
	<gost.dev@samsung.com>, Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: Re: nvme: enable FDP support
Message-ID: <20240610115330.vnbz7jncmkdxboig@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
In-Reply-To: <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87q2L9PSDP6eZLdYfbefzWLah5/M
	FitXH2WymHToGqPF/GVP2S2WH//HZLHu9XsWB3aPy1e8Pc7f28jicflsqcemVZ1sHpuX1Hvs
	vtnA5vHx6S2WAPYoLpuU1JzMstQifbsErozzj3MKjrJWXPg6i7mBcSdLFyMnh4SAiUTbs2uM
	XYxcHEICKxglHj+YygrhfGGU6Hm+GSrzmVHi9KpXbDAtsw6thUosZ5T4cGg+QtX7acvYIJwt
	jBLHmxYDDePgYBFQlbi52Aekm03AXuLSslvMILaIgKnE5E9bweqZBdYySSy+2AuWEAaqb25f
	AHYhr4CtxJkph6FsQYmTM5+A2cwCVhKdH5rA5jMLSEss/8cBYnIKGEus/WoAcaiSxOMXbxkh
	7FqJtcfOsIOskhB4wyHx9O8mqISLxO3/t6BsYYlXx7ewQ9gyEv93zmeCsKslGk6eYIJobmGU
	aO3YCrZXQsBaou9MDkSNo8Skpi3MEGE+iRtvBSGu5JOYtG06VJhXoqNNCKJaTWL1vTcsExiV
	ZyH5axaSv2Yh/LWAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOI5/e/4px2Mc199
	1DvEyMTBeIhRgoNZSYRXKCM5TYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZq
	akFqEUyWiYNTqoFJOPxl1A6XlaLLZvOeqG+dfWBd34tlF+JFDc6Fv3jz7lyOqfBD++AfzeXN
	KrsfOfkYMHp3vVI/vjHq/rRFxvkdjYv+9P7fE/F0Ykz8171Vt56uymp56PCqu2fi+fMXWetK
	ig7zxeRI/296N3OfcGyQyA3To/Md9srP01iw6cQdpQbu43pdhjLL2LvmeOjrZqepf5MRj0uZ
	Z2prlFhWH+E1c63eyhe9/0qyXT+GZLVMNgzeeSradLmyqDZLE6/stJPvuVpO3fpZsk23tOBr
	kuTu+AepZ7Rf805yaOX92rtSYfPjhsIfQiJO+mxTP/BunPbU88ixPXI5SzfHzy27FjyR50bw
	LoknLW98wsJFOAqUWIozEg21mIuKEwE7aGymqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7o2L9PSDDbsUbJYfbefzWLah5/M
	FitXH2WymHToGqPF/GVP2S2WH//HZLHu9XsWB3aPy1e8Pc7f28jicflsqcemVZ1sHpuX1Hvs
	vtnA5vHx6S2WAPYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
	stQifbsEvYzzj3MKjrJWXPg6i7mBcSdLFyMnh4SAicSsQ2sZuxi5OIQEljJK7Lv/iBEiISOx
	8ctVVghbWOLPtS42iKKPjBLnHr9lhnC2MErcm9QHlOHgYBFQlbi52AekgU3AXuLSslvMILaI
	gKnE5E9b2UBsZoG1TBJXFvuB2MJA5c3tC8Cu4BWwlTgz5TALxMyDTBLnvi5jhUgISpyc+YQF
	otlCYub884wgu5gFpCWW/+MAMTkFjCXWfjWAuFNJ4vGLt1D310q8ur+bcQKj8Cwkg2YhGTQL
	YdACRuZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgfG37djPzTsY5736qHeIkYmD8RCjBAez
	kgivUEZymhBvSmJlVWpRfnxRaU5q8SFGU2BATGSWEk3OByaAvJJ4QzMDU0MTM0sDU0szYyVx
	Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJvU2Zz2eddzq/A4nDBdrGlkLWml9qptvzx1etbf/
	en3ZghbJf4L3DOp6A4RqulZ2Lb596tCfF88PO0ycK/Uqy/iVjlnhzeuTbp95seDr6yCf6tYt
	Z+0Cdvt2KM9bocaT+E+toES1yuZyu2LCq/KE9n/v7iy6fWmTp1jOvv9deoFyfea3u+5aX26d
	3bM3XygqKejC0sIzM/lX7tf4smVzt7z1A/Yp2+6ZBITciXaucXQw2B7BeXjn0SP3n3xRFtX9
	8vyH4vaEfMMzHLv/MniqPcj3uvXhVFXAFYW6dWfaxLdnWl1WXljaox99aUmk1V3r0x37c1cE
	6plsKxG2iBTY6Pt08psUHZnyOxlvI/eqKLEUZyQaajEXFScCAMGk9zhIAwAA
X-CMS-MailID: 20240610115332eucas1p146d2e7c4b22258ff7d065afe0a3b7c9a
X-Msg-Generator: CA
X-RootMTR: 20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
	<20240528150233.55562-1-joshi.k@samsung.com>
	<ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
	<20240608051740.GA24010@lst.de>
	<5e686875-21de-869d-4b19-bdd9e272d690@samsung.com>
	<yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_045337_365891_60099EFA 
X-CRM114-Status: GOOD (  11.81  )
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

On 10.06.2024 07:27, Martin K. Petersen wrote:
>
>Hi Kanchan!
>
>> So current plumbing is nearly identical and as simple as SCSI.
>
>I don't have a problem with your implementation, however...
>
>> And TP 4146 author list shows 10 companies. Perhaps good enough for
>> diverse opinions on how to go about things before settling down.
>
>I think FDP and SCSI streams are less than ideal. 10+ years and the
>standards bodies still haven't been able to produce an approach that
>makes sense in the context of a general purpose operating system.

I want to believe that in each iteration we are getting closer to
something that can actually be deployed without major OS and application
changes.

