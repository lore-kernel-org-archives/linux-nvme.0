Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B160BCAC58F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2024 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmVCRhOac+MYDmIPzTgKY46t/QHaf9fEWdAUffOQcgk=; b=P+Aqu8X78rIPAWkK21OhfHEh4L
	svFN5d6EQCjc1P+lfjo8h57E+fYqg5QcbAaaRWiIN6KjOTQ/E+SnekKzRgoj+yqdJPkais83rOLof
	sFCWBS46TwsTOOlLxpoEQDAmka5S5WiM7H0yR5KcN2vLUdS7a9qmgsSRJNrhRstyxwIWG1up0ZIyC
	hTUHjzuWMey9rLc0ro6SqDmdo55dIJcR6xej8q0veX7Jmzvynd0vxGnK2dt9Qt9cQY6q1urCW0nN1
	zDsKUQw82seu/tf+qqbhyvue8oKnxdCwf6uO75jNpGNlRkRbvwftsX7MBJVj1EziHIZ6xPyaDOYqs
	vRbsBTnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqbZO-00000006YaG-10hg;
	Tue, 17 Sep 2024 17:00:54 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqbZJ-00000006YYi-03JK
	for linux-nvme@lists.infradead.org;
	Tue, 17 Sep 2024 17:00:52 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240917170046epoutp02de2f8d9b00fac65fc18d9d086740184a~2Fq6UZRTT0594705947epoutp02U
	for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2024 17:00:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240917170046epoutp02de2f8d9b00fac65fc18d9d086740184a~2Fq6UZRTT0594705947epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726592446;
	bh=YmVCRhOac+MYDmIPzTgKY46t/QHaf9fEWdAUffOQcgk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RF9zbai+v6LoTnajWp8Rj5JJfFuc4BaeLkHhWVy6sonQg6cqWndBV9PWC+7rcAb42
	 7hITZYMq53feMAeWyfn+kELWu0JTGJ/C4Y+B53Oc3ZTcQrIMTXtW13+9lj5IeX8HM0
	 NTULC8eu5gyJrsHH8//N/TP8fDOWYyOgh2zEqWJM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240917170045epcas5p46d074371c06dae0929b985e3af37b8f4~2Fq5c7pw43173431734epcas5p4H;
	Tue, 17 Sep 2024 17:00:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X7Shq3k39z4x9Pp; Tue, 17 Sep
	2024 17:00:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.DE.09640.BB5B9E66; Wed, 18 Sep 2024 02:00:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240917170042epcas5p35e7cf09a0058a59c555598d334a81fa0~2Fq3IhSBg1471614716epcas5p31;
	Tue, 17 Sep 2024 17:00:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240917170042epsmtrp2e823983f04747879bb98e3cad40c3a11~2Fq3HqBOW2449624496epsmtrp2j;
	Tue, 17 Sep 2024 17:00:42 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-d0-66e9b5bbf51c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.C8.19367.AB5B9E66; Wed, 18 Sep 2024 02:00:42 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240917170039epsmtip2b32eef702379390531969e70e3dfb72a~2Fq0Avebe0319803198epsmtip2S;
	Tue, 17 Sep 2024 17:00:39 +0000 (GMT)
Message-ID: <315f8f38-2cfd-1ef9-3304-d16b9b0b56e6@samsung.com>
Date: Tue, 17 Sep 2024 22:30:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>
In-Reply-To: <b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxz1vvf6AaTLo4JcMWP1bYygo7RaysWBskHcExhjM1myoYEKT2CU
	tulrx7pgwCHgRFDLxK3rhDnBDIJAEeVDEq0yJkqQuakgIIwyM7AOKW4R1K2lOPnv/M49J+f3
	kcvHhSU8f36WSsdoVQolxfUkzl4KDgrpbP1zt2S2GKL6kUNcNH1pFqDKmcc4+nfkHoYGL7Rj
	6Mf6bgx9e6wQQ7ZGE46aD/HRxLCDhx7X1vGQ0XoToK6h9eiXE++g811XCFRVO8lDpbfauOhU
	zzMMnV2owtHp6b8I1P+0h4P6TWZe9Cr6xq/xdP9oM0FXGnu59I0+PW2p+5JLt5zMpzurHRjd
	OVjApR9ODhF0+Zk6QF+rvsyjHZYA2mKzY0mCj7MjMxlFOqMVMao0dXqWKiOKit+eEpMSJpdI
	Q6QRKJwSqRQ5TBQVm5AUsjVL6ZyZEn2qUOqdVJKCZanQzZFatV7HiDLVrC6KYjTpSo1MI2YV
	OaxelSFWMbpNUolkQ5hTmJqd2VTYyNGMCj6rudsFCkCR1wHgwYekDA78dJU4ADz5QrITwKM2
	E89dzALoOG99Ucz+0Yk9twxX2bnuh3YATx80LhV2AHuu9nJdKgG5GU4/KsJdmCAD4ZC5EXPz
	3vDKNzbChX3JXXD+NzNw4ZVkFCwtu7XI46QfHLJVOfV8PpcMhtcr9C7ah6Tg5FQfcGXhZC0B
	ax72c10aD3ILHBj3dltfgefsZtylgeQpD2if6eW5u46F8xfKOG68Ek71nFni/aHjQRfXjbPh
	2O9jhBvnwbaW8iX9Fljw5DbHlYU7+2nsCHVnvQTLFmyLbUJSAPcXC93qtXDUOLnk9IPjX5/k
	uCU07N67emnTOLx8sBgcBiLTsqWYlg1vWjaN6UVwNSDqwGpGw+ZkMGyYRqpicv+/d5o6xwIW
	f8S6bW1gZGxGbAUYH1gB5OOUjyBqYXK3UJCuMHzOaNUpWr2SYa0gzHmdI7i/b5ra+aVUuhSp
	LEIik8vlsoiNcinlJ5gu+i5dSGYodEw2w2gY7XMfxvfwL8DEHWnbiEdP3gwQ/1wy9FS9B7/J
	tBt070/E3plp9spbYwwNuDMsjT0a9Em7d+BM0465Fa9n3Y8TV87LIm4PoKZr7K7EkuTS1uGE
	d+cszWWitwzy0rW24wsN5UVpzV+1jKXsTQ4dlGxYNdegNGRVVuzsbp1K9NYd/mG+dFP+Fws1
	udIGz6SLXvnxscK22sTo3geJHJE5wtobfoKK9w9++2KY2li83suAA2EAL+Y14/Xku2KJI+5v
	3wo/2ZHpyB0xfccU5z4w+PyTHLfH2xx9f/y4oT4uZOJDfjQRnsoEbX85YY048NlYR+q9ncUr
	vvfaP9CSs7EwZF/ue+Y37KrovI9e3dfgRxFspkK6Dteyiv8A5S0NupoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSvO6urS/TDL7NU7VYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWkw5dY7TY
	e0vb4tIid4s9e0+yWMxf9pTdovv6DjaL5cf/MVls+z2f2WLd6/csFuf/Hme1OD9rDruDmMfl
	K94e5+9tZPGYNukUm8fls6Uem1Z1snlsXlLvsXvBZyaP3Tcb2Dw+Pr3F4tG3ZRWjx5kFR9g9
	Pm+S89j05C1TAG8Ul01Kak5mWWqRvl0CV8aG5vWsBfd4K5be38vYwNjK3cXIySEhYCJxZ/5b
	ti5GLg4hge2MEof2NzNBJMQlmq/9YIewhSVW/nvODlH0mlHi+KM9zCAJXgE7iddfW8FsFgFV
	iVtz1jNBxAUlTs58wgJiiwokSey53wgWFxawlejuvQ4WZwZacOvJfKA4BwebgKbEhcmlIGER
	ASWJp6/OMoLsYhZYxiJxcMpbsBohgd3MEl3mICangL3ExYeCEFPMJLq2djFC2PIS29/OYZ7A
	KDQLyRGzkCybhaRlFpKWBYwsqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCk4BW0A7GZev/
	6h1iZOJgPMQowcGsJMJr+/tpmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU
	1ILUIpgsEwenVANT7t3tr45fbZL7ord+Z2aZ2n7XJ3vfnzZbf/XLHOboq6EJETsCxaQ8uvfm
	l1ws+zFtn0tVUmDSzmMHllyV/vnkjITi9NMxej3af64HTNTkTnBx2Khl5/b24z4zydv9ZU5a
	X/bIzf/7g1Xe4NpG1x2yN11MT58MeWtn9P3g7cI1NnMOHapp/Wn8My6u3f1HglpFzwfNh+9U
	1JzsF5xYUMd8ddqa709msDBJPwuYl7P1jv3iqT+Kz6t7R827XMf2vufRiogJXu1bD58/xBmz
	7VLphlMbDgQuZKp9fUBjlXTB2Rshd2sPTaqVC2Y6Nnl9vr1FkNWakPIw4WNSC/1Uri5btZZd
	Q4pBzaI7KDLXRX+1qRJLcUaioRZzUXEiAEVaYZBxAwAA
X-CMS-MailID: 20240917170042epcas5p35e7cf09a0058a59c555598d334a81fa0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com>
	<20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de>
	<e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
	<20240913080659.GA30525@lst.de>
	<4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
	<20240917062007.GA4170@lst.de>
	<b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_100050_557168_E0AF12C6 
X-CRM114-Status: GOOD (  21.19  )
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

On 9/17/2024 9:33 PM, Kanchan Joshi wrote:
> On 9/17/2024 11:50 AM, Christoph Hellwig wrote:
>>>> But if we increase this to a variable number of hints that don't have
>>>> any meaning (and even if that is just the rough order of the temperature
>>>> hints assigned to them), that doesn't really work.  We'll need an API
>>>> to check if these stream hints are supported and how many of them,
>>>> otherwise the applications can't make any sensible use of them.
>>> - Since writes are backward compatible, nothing bad happens if the
>>> passed placement-hint value is not supported. Maybe desired outcome (in
>>> terms of WAF reduction) may not come but that's not a kernel problem
>>> anyway. It's rather about how well application is segregating and how
>>> well device is doing its job.
>> What do you mean with "writes are backward compatible" ?
>>
> Writes are not going to fail even if you don't pass the placement-id or
> pass a placement-id that is not valid. FDP-enabled SSD will not shout
> and complete writes fine even with FDP-unaware software.
> 
> I think that part is same as how Linux write hints behave ATM. Writes
> don't have to carry the lifetime hint always. And when they do, the hint
> value never becomes the reason of failure (e.g. life hints on NVMe
> vanish in the thin air rather than causing any failure).
> 

FWIW, I am not sure about current SCSI streams but NVMe multi-stream did 
not tolerate invalid values. Write command with invalid stream was 
aborted. So in that scheme of things, it was important to be pedantic 
about what values are being passed.
But in FDP, things are closer to Linux hints that don't cause failures. 
With the plain-numbers interface, the similarities will increase.

