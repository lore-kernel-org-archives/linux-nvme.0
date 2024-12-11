Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A1E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 06:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vm19+8sOgCyjcKR5yqhjiOJVXNKsya0wck8wtg9WOpM=; b=tUYw+t6trK7MDfMf7eeVWjU6Qg
	e/2HQ0vpAwqsz2fSmE0o20oteEq+gHHyOIRvzu3tvmjQCjMhbERThi1ifm8j+0RCbyuCpczoPFoH0
	4olgxE+QhBV+n9LWV4/wfGqgGJwNXDIoLDhxC9jcZt4cOMXH/4NtNLalWpl/mBcY4EBfmYx5pDnnT
	sp/jExYfTGkcbCZpGCR6hnLqylLDHuUKsLi0AkKnspmCFZ9hjZqZx/Mx9dWKyKfSziA4QWZstWt73
	riSkumD863IbM29GkapaY4sEzs3z+5axez72V+QdutGEiB/nyylRrdfJImRHf9bua1YhbZb/lNdHT
	FeDoA8uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLFqs-0000000DtT2-3pcp;
	Wed, 11 Dec 2024 06:05:38 +0000
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLFqj-0000000DtP6-3KzB
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 06:05:32 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241211060518epoutp01f5d82909739daaacebd9fb7a3e9fd59b~QCj4ewuJc1363913639epoutp01-
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 06:05:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241211060518epoutp01f5d82909739daaacebd9fb7a3e9fd59b~QCj4ewuJc1363913639epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733897118;
	bh=Vm19+8sOgCyjcKR5yqhjiOJVXNKsya0wck8wtg9WOpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucsq29tdHx5dcoWteh5TVMXildanDu5GhhiQht0z+TdjXJd0Aj6aafWlge6iyJl+C
	 o0p34nSj9VmKYdqsJcrNJNQ4ocOk0RyLIOwR6tQ5d7ilEC/aC/Z+3biYkHvb9483ql
	 4nKMnxiWfb3nHXAgKXX1fYz/L7v8qo3CuZV1tWAU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241211060518epcas5p4ef4139564e0b0712747035d944e65bb1~QCj4NAmn23068330683epcas5p4s;
	Wed, 11 Dec 2024 06:05:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y7Q7J4BBrz4x9QH; Wed, 11 Dec
	2024 06:05:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.CF.19956.C9B29576; Wed, 11 Dec 2024 15:05:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241211060149epcas5p4d16e78bd3d184e57465c3622a2c8e98d~QCg1bUOvW1834618346epcas5p4_;
	Wed, 11 Dec 2024 06:01:49 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241211060149epsmtrp296e709724194137f267d2e9faf7ed067~QCg1aWPr_1301813018epsmtrp27;
	Wed, 11 Dec 2024 06:01:49 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-da-67592b9c33aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.6D.33707.CCA29576; Wed, 11 Dec 2024 15:01:48 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241211060146epsmtip1e124f3dc0500e8c37c58f735158b5ae7~QCgzfbfBH1931819318epsmtip18;
	Wed, 11 Dec 2024 06:01:46 +0000 (GMT)
Date: Wed, 11 Dec 2024 11:23:54 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv13 05/11] block: expose write streams for block device
 nodes
Message-ID: <20241211055354.ozous6df7gpgjcpp@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20241210194722.1905732-6-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmlu4c7ch0g3Mb5S2aJvxltpizahuj
	xeq7/WwWexZNYrJYufook8W71nMsFkf/v2WzmHToGqPFmasLWSz23tK22LP3JIvF/GVP2S3W
	vX7P4sDrsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB5nLtY4dG3ZRWjx+bT1R6fN8kF
	cEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHa6k
	UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAyBSpM
	yM54dsivYC1bxZ81zg2MJ1m7GDk5JARMJGZsmc3WxcjFISSwm1HiZudfFgjnE6PErWmzEZxX
	jasYYVqaPyxihkjsZJT4d/MQVNUTRon7N9axg1SxCKhKPJiyHWgwBwebgLbE6f8cIGERAUWJ
	88DAAKlnFtjMJPGxsx/sEGGBIIntRz4zg9TzAm3YuqkaJMwrIChxcuYTFhCbU8Bc4uWy/2C9
	EgJbOCRe7WmEushFYvatW0wQtrDEq+Nb2CFsKYnP7/ayQdjlEiunrIBqbmGUmHV9FlSzvUTr
	qX5mEJtZIEPi6+LPLBBxWYmpp9YxQcT5JHp/P4FawCuxYx6MrSyxZv0CqAWSEte+N4I9LCHg
	IfFqYR0kULYzSny9v49xAqPcLCQPzUKyDsK2kuj80MQ6C6idWUBaYvk/DghTU2L9Lv0FjKyr
	GCVTC4pz01OLTQuM81LL4XGcnJ+7iRGclLW8dzA+evBB7xAjEwfjIUYJDmYlEV4O79B0Id6U
	xMqq1KL8+KLSnNTiQ4ymwPiZyCwlmpwPzAt5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeW
	pGanphakFsH0MXFwSjUwXW0KnlIju/HZtrqfOdc8OwtlZ3+f+UlMvPRwf/jFPYrSJtO8Feff
	M+EILE56KL4qSal0/uuLKtyct91u+83S/bpj504Hft10J9mldz/cbj7R/mRV8wyjeaY8Crr7
	uH0OPzP2/XGzYc8b55+3pYu4T0W9nHZS8pzkmXs1x5V0b6zgjJb9uDS8j2nZ72klfa9L56Sf
	CzO3NS/53j87mWOJaPGyBL9n5xtu267//8jdgVNym0D0RLa7u8RSbp6eZs1V7DshYf7flFKO
	3/FxzisWpQkpzt4XmNgVd1DjyIQ+bx5BnXObH73YZp08e5/p0x/5e3gjd7W9U6v33H7FbrPS
	Gz2NA4VXjyXfcV/g6G5kr8RSnJFoqMVcVJwIACLN3OVTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnO4Zrch0gwPfzSyaJvxltpizahuj
	xeq7/WwWexZNYrJYufook8W71nMsFkf/v2WzmHToGqPFmasLWSz23tK22LP3JIvF/GVP2S3W
	vX7P4sDrsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB5nLtY4dG3ZRWjx+bT1R6fN8kF
	cEVx2aSk5mSWpRbp2yVwZTxac5G94D5zxZunIQ2MU5m7GDk5JARMJJo/LAKyuTiEBLYzSnTs
	XAOVkJRY9vcIlC0ssfLfc3aIokeMElNnXWICSbAIqEo8mLKdrYuRg4NNQFvi9H8OkLCIgKLE
	eaCLQOqZBTYzSezt/c8CkhAWCJLYfuQzM0g9L9DmrZuqQcJCAskSH/Z/ANvFKyAocXLmE7By
	ZgEziXmbH4KVMwtISyz/BzaeU8Bc4uWy/2wTGAVmIemYhaRjFkLHAkbmVYyiqQXFuem5yQWG
	esWJucWleel6yfm5mxjBMaQVtINx2fq/eocYmTgYDzFKcDArifByeIemC/GmJFZWpRblxxeV
	5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgskycXBKNTBZrZLWUNvobnFnmyWv/Dvr/rXz
	FszaZqmxK1/2TFzlikUbqm+cer5CP+vMye9zruxR/f1bL7E8Ocn3Ae/y9O2t81+aPHczf9/o
	/+Vg/Ey759rC5o1SKctsPy2Wq9t05X/hrpieVVc/ByS4sF7ervWva2ZsrZn2TnbplIedyUpr
	GYPCkze22f068s0p+ZLe8n9XbGc8ip/ntV6+Y5/o3GN5FX2P+Z58tNBeEy4ubaxy/x3X5D1m
	Nkmd/A++9VcGnmtc4Ptsy4S8nb2VF/MLVD9/qovy+sDuyjjpx/EJMsInotbI9ptEih2eVu56
	wb/z7D2mW5wMV+MvFtiu03YUS5X6rHwi9VNTFp9qMNeGcDclluKMREMt5qLiRAB/NER6EAMA
	AA==
X-CMS-MailID: 20241211060149epcas5p4d16e78bd3d184e57465c3622a2c8e98d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_75e31_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241211060149epcas5p4d16e78bd3d184e57465c3622a2c8e98d
References: <20241210194722.1905732-1-kbusch@meta.com>
	<20241210194722.1905732-6-kbusch@meta.com>
	<CGME20241211060149epcas5p4d16e78bd3d184e57465c3622a2c8e98d@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_220530_160895_C7067916 
X-CRM114-Status: GOOD (  11.61  )
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

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_75e31_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 10/12/24 11:47AM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Use the per-kiocb write stream if provided, or map temperature hints to
>write streams (which is a bit questionable, but this shows how it is
>done).
>
>Reviewed-by: Hannes Reinecke <hare@suse.de>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>[kbusch: removed statx reporting]
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_75e31_
Content-Type: text/plain; charset="utf-8"


------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_75e31_--

