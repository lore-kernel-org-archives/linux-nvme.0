Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F198C54798
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5j/pXLHwJrI2IKivCKjlpVD9Npcv7jDFr2oBpSGppY=; b=JrCBOtFkkvmSuwFBWA4kmdLHl5
	1xPHu+vRvbtg5TDLncpNni5VS0EqOTX8BeSJ1EhGcxjC8HTVwNkg9r2Npp4ph4bv9PjxYHCPmd6kR
	SUKShtezERVS8v4o6TQmI0MR9Lh0z4snpylT0J2ICSMVI5WHTlDV1042V03bNExe2ugvAGhuC/qoO
	hJ7oULBOk02dmE0c5+MNyclnwWg8NMWHOP48Cl9NtBfoGrMbQ7k3j0GUhB0F/PXIfGgEhN0huTxLL
	Ua5/M9i1pRGPaonuHCWraru/ezp1wJmolEHi7qHNx5SDW713U91e0+Rr1f4KDFYUyktjQYUDsUMky
	aUfIQMjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdUse-00000009O2D-2V2O;
	Fri, 23 Feb 2024 12:42:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdUsU-00000009Nyi-1PmB
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Feb 2024 12:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=H5j/pXLHwJrI2IKivCKjlpVD9Npcv7jDFr2oBpSGppY=; b=K/uDiT9h20H0sVZI97eud87sJT
	mJlE84hz9bGDTDWTA73o+Tt5wyiOClvbmglzkEpEcmzrdPuT6Yb/HeFmrO7k9HORxY4FsWZhISKdY
	nvtuVFjiNkZt2Zc8eAGzvgyafEueKoZvyAdyJWeYYgOgebJkWNB/iq7Gu1moe8FxdAEmfIH1A0yV9
	T54K1DQQ727rsNXUIjg7jxa9L3VExivsqv7Ux8OHDC4/fqxDxsXItbKmSr80z0BQEVSDOKtm6BKLv
	Sfuxut7thWYRRUp34dP/CQ8RniAG9oDHuCT1JmI0Rq8jdvgAF8V35GC3ZZERmu6fXo/T6aCUWKduT
	e6/wURiA==;
Received: from mailout3.samsung.com ([203.254.224.33])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdUsP-000000072RI-2B1X
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 12:42:08 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240223124142epoutp03e77a6efdb53ffe586fc3eccf77e7b23d~2fmoNMEXH1365413654epoutp03P
	for <linux-nvme@lists.infradead.org>; Fri, 23 Feb 2024 12:41:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240223124142epoutp03e77a6efdb53ffe586fc3eccf77e7b23d~2fmoNMEXH1365413654epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708692102;
	bh=H5j/pXLHwJrI2IKivCKjlpVD9Npcv7jDFr2oBpSGppY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sqggnT4bKiZzVXfqJq1hVuKfHRjCFXbdVputE33OhViO35tBuR0JN81vbQd6jPTiH
	 19Ty8sUg98VNs0Tj5feJaoisJ+ECR8TXLM//pCXjALZtqGTKXvNn94xcgEo/sGwkAO
	 rbwyW2+z5eRr/4EQR7XfRyrkYBWxc2Dvood8Sm3w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240223124142epcas5p3ba25f72c49160fa05c845b3cb1eb98f6~2fmn5yL631606616066epcas5p3f;
	Fri, 23 Feb 2024 12:41:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Th8lS0mKvz4x9Pp; Fri, 23 Feb
	2024 12:41:40 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.77.09634.38298D56; Fri, 23 Feb 2024 21:41:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240223124139epcas5p195356ca928b72fa08d679be1c926de4e~2fmlELRwu2625326253epcas5p16;
	Fri, 23 Feb 2024 12:41:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240223124139epsmtrp126438d5d59f4bdfd6251ea25c8b188fa~2fmlDfif30087500875epsmtrp1c;
	Fri, 23 Feb 2024 12:41:39 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-e8-65d89283d1d8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.AC.07368.38298D56; Fri, 23 Feb 2024 21:41:39 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240223124137epsmtip1e12bb3d8192d40628b6c1bf64229d816~2fmjslECY0138701387epsmtip1Y;
	Fri, 23 Feb 2024 12:41:37 +0000 (GMT)
Message-ID: <282e9875-31d3-a826-7032-4a43071ac537@samsung.com>
Date: Fri, 23 Feb 2024 18:11:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] Meta/Integrity/PI
 improvements
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Linux FS Devel
	<linux-fsdevel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	josef@toxicpanda.com, Christoph Hellwig <hch@lst.de>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <Zdep1jEY4kFFxxk8@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmpm7zpBupBv8WWlusvtvPZrFy9VEm
	iz8PDS0mHbrGaLH3lrbFnr0nWSzmL3vKbrHv9V5mi+XH/zE5cHpcPlvqsWlVJ5vH5iX1HpNv
	LGf02H2zgc3j49NbLB4TNm9k9fi8SS6AIyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoNiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaT7a0sBW1CFce2z2NpYNzE18XIySEhYCKxafZe
	ti5GLg4hgd2MEuv7prNCOJ8YJQ7u3QqV+QaUOX+EDaZl3/I+ZojEXkaJQweaoKreMkos7XzN
	DFLFK2An8bbxMzuIzSKgKrFg5UKouKDEyZlPWEBsUYEkiV9X5zCC2MICwRILb20EizMLiEvc
	ejKfCcQWEVCWuDt/JthNzAJvmSSu3PgK5HBwsAloSlyYXApSwymgJdF17i07RK+8xPa3c8Cu
	kxBYyyHRc2MyE8TZLhKXD62HsoUlXh3fwg5hS0m87G+DspMlLs08B1VTIvF4z0Eo216i9VQ/
	M8heZqC963fpQ+zik+j9/YQJJCwhwCvR0SYEUa0ocW/SU1YIW1zi4YwlULaHxI/LJ6BhtYlR
	Yv/SbvYJjAqzkIJlFpL3ZyF5ZxbC5gWMLKsYJVMLinPTU4tNCwzzUsvhMZ6cn7uJEZx2tTx3
	MN598EHvECMTB+MhRgkOZiUR3kvZN1KFeFMSK6tSi/Lji0pzUosPMZoC42cis5Rocj4w8eeV
	xBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliSmp2aWpBaBNPHxMEp1cCkrBXpe3674+RX7cce
	GL2v3O6y0MN6St71Dw8uHNeckLxP11uhxSNBpqbf5ayt/9H1AfLbEjTke5dervA55fMv9l1m
	5ZbLjzyP+Ry3Z48qvCWhkXJpsTTrC54fn7k2zlRgXasU7svDWx342OrRv8yld55O1dx7tPpz
	WX1sWOn1oO+9Vq3L3huxfp+6jnlzkPibnhd+/6zcpIoOXkxcfjN1T8aEi1leD7/us7/3ckLz
	Xi6DhOS9y1j2VLCnWfy+yCe5fOmmwGOKk1epP6ifv5o3/+fUBycWh1o1fjv7bf+doHOhHRML
	pf3yFYw3vVjedDW2a+PH+4ttvs167/LDyPqMI3de1feH74V+vNqy4GfwdiWW4oxEQy3mouJE
	AO7TGFJEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTrd50o1Ug+0v2C1W3+1ns1i5+iiT
	xZ+HhhaTDl1jtNh7S9tiz96TLBbzlz1lt9j3ei+zxfLj/5gcOD0uny312LSqk81j85J6j8k3
	ljN67L7ZwObx8ektFo8JmzeyenzeJBfAEcVlk5Kak1mWWqRvl8CV8WR7K0tBm1DFse3zWBoY
	N/F1MXJySAiYSOxb3sfcxcjFISSwm1Fi7qT/7BAJcYnmaz+gbGGJlf+es0MUvWaU2Pj9NQtI
	glfATuJt42ewIhYBVYkFKxcyQ8QFJU7OfAJWIyqQJLHnfiMTiC0sECyx8NZGsDgz0IJbT+aD
	xUUElCXuzp/JCrKAWeA9k8T7D8+hTtrEKHFh3WfGLkYODjYBTYkLk0tBGjgFtCS6zr1lhxhk
	JtG1tYsRwpaX2P52DvMERqFZSO6YhWTfLCQts5C0LGBkWcUomVpQnJuem2xYYJiXWq5XnJhb
	XJqXrpecn7uJERxjWho7GO/N/6d3iJGJg/EQowQHs5II76XsG6lCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MFkZzeRbE6E+V/GM9p/Qr1EN3js27tL3
	W8DpdM/yrMO9Gaq6mvNddnOsv7Xpg4zXfXPXXQ6/+Rd7xNiu9bx9Ijp2L3/0GsvmoJBvt/kt
	wr+xSvzbY+szlWX2c0nlcwWtOn2Hbm18cO7wrh287Odmb5oos3dB3aW3F2QX2xbEnZi7cG3z
	LPUfR4S2feRRvrHEP9IkZ6OxbURF8W2nWTv1Uv7c+Js7oTxKJPbzYsG6kLNcfZud5manpv32
	n5L24rPSC85T3loOutqPLrIuSz0X+Xify9VtP4IEeHdLxv9107mefW7iHeao51y7Fjc9Pik/
	ozGgflHUpuaVdyYzbXy88Cony+8LjzvumSiuqzNxW7VRiaU4I9FQi7moOBEA5Y+AqSADAAA=
X-CMS-MailID: 20240223124139epcas5p195356ca928b72fa08d679be1c926de4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222193304epcas5p318426c5267ee520e6b5710164c533b7d
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<Zdep1jEY4kFFxxk8@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_124206_146120_44E1DC71 
X-CRM114-Status: GOOD (  21.16  )
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

On 2/23/2024 1:38 AM, Keith Busch wrote:
> On Fri, Feb 23, 2024 at 01:03:01AM +0530, Kanchan Joshi wrote:
>> With respect to the current state of Meta/Block-integrity, there are
>> some missing pieces.
>> I can improve some of it. But not sure if I am up to speed on the
>> history behind the status quo.
>>
>> Hence, this proposal to discuss the pieces.
>>
>> Maybe people would like to discuss other points too, but I have the
>> following:
>>
>> - Generic user interface that user-space can use to exchange meta. A
>> new io_uring opcode IORING_OP_READ/WRITE_META - seems feasible for
>> direct IO. Buffered IO seems non-trivial as a relatively smaller meta
>> needs to be written into/read from the page cache. The related
>> metadata must also be written during the writeback (of data).
>>
>>
>> - Is there interest in filesystem leveraging the integrity capabilities
>> that almost every enterprise SSD has.
>> Filesystems lacking checksumming abilities can still ask the SSD to do
>> it and be more robust.
>> And for BTRFS - there may be value in offloading the checksum to SSD.
>> Either to save the host CPU or to get more usable space (by not
>> writing the checksum tree). The mount option 'nodatasum' can turn off
>> the data checksumming, but more needs to be done to make the offload
>> work.
> 
> As I understand it, btrfs's checksums are on a variable extent size, but
> offloading it to the SSD would do it per block, so it's forcing a new
> on-disk format. It would be cool to use it, though: you could atomically
> update data and checksums without stable pages.
>   

Yes, variable extents but it computes the checksum for each FS block 
size (4k-64K, practically 4K) within each extent.
On-disk format change will not be needed, because in this approach FS 
(and block-integrity) does not really deal with checksums. It only asks 
the device to compute/verify.

Am I missing your point?

>> NVMe SSD can do the offload when the host sends the PRACT bit. But in
>> the driver, this is tied to global integrity disablement using
>> CONFIG_BLK_DEV_INTEGRITY.
>> So, the idea is to introduce a bio flag REQ_INTEGRITY_OFFLOAD
>> that the filesystem can send. The block-integrity and NVMe driver do
>> the rest to make the offload work.
>>



