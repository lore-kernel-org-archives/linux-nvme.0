Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0975CEB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nf0M7Edq+VFotEM7gYvE+FLANmT2ox35VhKqjXzsPM4=; b=LiExqUS3WBXQJY
	vQrEQtRjkSgAJJPZr+5Rt4ZjwZSt5ixeSQen4OJRlXQA8VfROedz+6PD3QXzoi+6Uyfg3QKIr7OIW
	CZHcd17Db0JMD/L3sFLBUvi26qHkNx8Ys2gQAJ6hTSf78RQ1sLs6WJ3Hs+cFKpmjpRFzd44sur+xt
	hHavTq2F7RfFIW6TE4UcpIPjXn22XrI5/8a1wFC9uaUHo6Q/nomQZloJAi97no96HxXqvs4N21OZk
	Zv0Eg7x/9DfTVXe6J5ppiAO3ACuHdyrIdy+Vy6uzQ7VSVt1hI9ZzZzdF6QKyHkBeds32u4n5hBtHc
	m+c0mOzLBFQahDj5sRDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9gI-003DHi-0m;
	Fri, 30 Jun 2023 08:40:42 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qF9g8-003DBc-1l
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 08:40:41 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230630084028euoutp014c7e20a931d65a59df9320cb47b43af3~tYyDZOjWn1928319283euoutp01Z
	for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 08:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230630084028euoutp014c7e20a931d65a59df9320cb47b43af3~tYyDZOjWn1928319283euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1688114428;
	bh=nf0M7Edq+VFotEM7gYvE+FLANmT2ox35VhKqjXzsPM4=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=UXZWEHcn8Xijtkg1CAWNPic3BFjrEFZDnlsLmcdKbZ35gLg5aDnBt6HTmv4Lyt9dx
	 q5iDHfCdbRON8z6KlJR4CzAOMPP5i10zt3ZYGR8s+42yzcgW1DiPBsiVBraCSh2ucC
	 e8asE9sAZ3QfOp61CADsfJSa0we3EXPM0QWIGd+s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230630084027eucas1p211bd7ea42996b1917eded5fb7a104d24~tYyDAlCUR2909929099eucas1p2r;
	Fri, 30 Jun 2023 08:40:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.B4.42423.BF49E946; Fri, 30
	Jun 2023 09:40:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230630084027eucas1p1f1d2061f14bfc58bd4ea76c9fab5f30b~tYyCirSej1032710327eucas1p1z;
	Fri, 30 Jun 2023 08:40:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230630084027eusmtrp29c1f9f78edbcf29cf94925134b7ca894~tYyChhCWD0527805278eusmtrp2l;
	Fri, 30 Jun 2023 08:40:27 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-00-649e94fb21a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.5B.10549.AF49E946; Fri, 30
	Jun 2023 09:40:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230630084026eusmtip1f80abab786bf8b7e1513e03016fdc25d~tYyCT2yet1344713447eusmtip1a;
	Fri, 30 Jun 2023 08:40:26 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.231) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 30 Jun 2023 09:40:22 +0100
Message-ID: <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
Date: Fri, 30 Jun 2023 10:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.11.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Clemens S. <cspringsguth@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Regressions
	<regressions@lists.linux.dev>, Linux NVMe <linux-nvme@lists.infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Jinhwan Park <jh.i.park@samsung.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Javier Gonzalez
	<javier.gonz@samsung.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87q/p8xLMTh2QNli9d1+NoupjYwW
	b3buYrfYs2gSk8XK1UeZLFZfWM9kMenQNUaLp1dnMVlc3jWHzWL+sqfsFudmLWGx2Pi2g91i
	3ev3LA68HpNmzmD22DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwObR2/yOzeP9
	vqtA8dPVHp83yQXwRHHZpKTmZJalFunbJXBlTHnwi63gC0dF86GprA2Ms9m7GDk5JARMJF4e
	b2PuYuTiEBJYwSjRuGEhK4TzhVHi0OylUJnPjBIvW7qZYVqO9Z4AaxcSWM4o8eSkIoQNVLRp
	nShEw25GibdnljOBJHgF7CSe/N/ICmKzCKhKPPz9nxkiLihxcuYTFhBbVCBaonXZfTYQW1gg
	Q2L/pwtgNcwC4hK3nswHmyMi4CFx5H03O8gCZoH9LBJHzh0ESnBwsAloSTR2gh3EKWAvMf/m
	eSaIXk2J1u2/2SFseYntb+cwg5RLCChLfHqeAPFLrcSpLbeYQEZKCNzjlPj2/zbUky4S71dd
	YYOwhSVeHd8CDS8Zif87Ie6REKiWeHrjNzNEcwujRP/O9WwQC6wl+s7kQNQ4Suzet5ERIswn
	ceOtIMQ5fBKTtk1nnsCoOgspJGYh+XgWkg9mIflgASPLKkbx1NLi3PTUYsO81HK94sTc4tK8
	dL3k/NxNjMD0d/rf8U87GOe++qh3iJGJg/EQowQHs5II7+03s1OEeFMSK6tSi/Lji0pzUosP
	MUpzsCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MPFKbzyuckK5/GIr93G+ne+td22a+dBA
	ZTdjHndZ/iTp+7JMtRa3ppUKS/yz311x4Uq71GzZmZ87rQ+ca5PfMXGqVccC5iDRlpn/xc/G
	hnhufnzwruXav5fN3nPMmSVpPS+rZbn4/uSeTQ+3NctcPyWYevGP/c243UfPerRp/+LnT7mY
	2BTw4CvTHd1bmhnJBfNnX4m9cu/pncUPddaImGl+9xCv5F95eLpJldbKYAElWY2vN9T0RPpC
	bMI63qxepnm8tsdSoe5G5G6ZVPNS0bQtPiXiJ77ZHHd/E2txkDHGX6PGLctoY4hlu0OsUvue
	VxuEg/7FiFwRD7ZOe/I0QySm4qPOpOVsZ7gqr3H7KrEUZyQaajEXFScCAOzB/nzuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xu7q/p8xLMbi7hNFi9d1+NoupjYwW
	b3buYrfYs2gSk8XK1UeZLFZfWM9kMenQNUaLp1dnMVlc3jWHzWL+sqfsFudmLWGx2Pi2g91i
	3ev3LA68HpNmzmD22DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwObR2/yOzeP9
	vqtA8dPVHp83yQXwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTm
	ZJalFunbJehlTHnwi63gC0dF86GprA2Ms9m7GDk5JARMJI71ngCyuTiEBJYySixruM0MkZCR
	2PjlKiuELSzx51oXG4gtJPCRUWLFfAOIht2MEvsvHwVL8ArYSTz5vxGsgUVAVeLh7//MEHFB
	iZMzn7CA2KIC0RKrP18AqxEWyJDY/+kCWA2zgLjErSfzmUBsEQEPiSPvu8EuYhbYzyJx5NxB
	JohtR4G2PboG1M3BwSagJdHYCfYCp4C9xPyb55kgBmlKtG7/zQ5hy0tsfzuHGaRcQkBZ4tPz
	BIhnaiU+/33GOIFRdBaS82YhOWMWkkmzkExawMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cT
	IzBtbDv2c/MOxnmvPuodYmTiYDzEKMHBrCTCe/vN7BQh3pTEyqrUovz4otKc1OJDjKbAMJrI
	LCWanA9MXHkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwxWkv2
	SGbsXrNP9cZT2TcZ0u6nIzeeSzZ+/qTUZ3rQpOMJ/n6bFu2cH3DKZ9FHCVse8SQ5+39CbtWr
	16zb+PepvOtF5pQj9dKNvDqcxhb2VjJnk2Ye+P62PfH5VdPW0inKydscu37rn/C5xckqsWJG
	b7uoiZoik2kYs9CvaRv3rzNn37nqpVzwiffLHfa8U39VKq7O/j3J5WTmFTb5e5Lcu49NnL5J
	PMUzVj378cqJgRlZ3lbyGg68u4LS7k9nCmo6/V52Xd6sV3nrut45rNZKDP20qvag6pRp0Rv2
	9NjEnjSbZlDBcGhS+hOJhMXPSvkMw2oias/s6ph6ie/oj4c1pzQuZkYJxSxetE+LY6YSS3FG
	oqEWc1FxIgBbhSe7pAMAAA==
X-CMS-MailID: 20230630084027eucas1p1f1d2061f14bfc58bd4ea76c9fab5f30b
X-Msg-Generator: CA
X-RootMTR: 20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
	<CGME20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5@eucas1p1.samsung.com>
	<ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_014032_864949_07146837 
X-CRM114-Status: GOOD (  17.33  )
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

On 2023-06-27 18:10, Keith Busch wrote:
> On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
>> See Bugzilla for the full thread.
>>
>> The reporter had a quirk (see above) that fixed this regression,
>> nevertheless I'm adding it to regzbot to make sure it doesn't fall
>> through cracks unnoticed:
>>
>> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_bug.cgi?id=217593
>> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCGL-000MV
> 
> These bug reports really should go to the vendors that created the
> broken device with non-unique "unique" fields. It's easy enough for me
> to write the quirk patch, but it's not the ideal solution and may harm
> devices/firmwares with the same VID:DID that don't have this problem.
> Not being the vendor, I'm not in a postition to know that, so CC'ing
> some Samsung folks.

I got a reply from our team internally. There is no plan on releasing
a new firmware for this model and the related models with the same VID:DID
pair. We can add a quirk.

@Clemens: Let me know if you want me to send the quirk as a proper patch.

