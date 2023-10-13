Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F8ECDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sAdsrcy47KgvtkQqo+Eoi6qGMV6FSrM+SBH+rU2sZ9A=; b=DXySV69OUAzC+XYNf3sKvKAjnz
	r+arC1E/abaRvesC79OReKAfBYkpeVxeSczPyDgZVHdwqEM1uFZTk3pHwcbNlM4uxk2IB+2A3Z/Uv
	q3fdpuBFyCz8Hh3IfrihE7d3gKWu3KagaVFvmd4VGfx+GxUBJYxmTulm/bOEKoUuzBZt4rK/o7+9o
	TX3Vp8/lCRig1eYyrtbhF1/mQuGJjsF31guHnJwIjwKpOe3ME7Bbwu0ZsmRXKcbMixj7Xt+eWRWNs
	Gf4eIDg6f5Jz9f0n/aRm1oMITV8zN3RokkzBCjgl7g85FeTFm48Xt0M3Z1wr4xZ6FvOSaHxrj9u9J
	HblxDQ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrFC2-00325I-1c;
	Fri, 13 Oct 2023 10:14:54 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrFBz-00323d-0f
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 10:14:53 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231013101445epoutp0195351a419e9071dbfc657b449c8ff7be~NozWnamQk0313703137epoutp01K
	for <linux-nvme@lists.infradead.org>; Fri, 13 Oct 2023 10:14:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231013101445epoutp0195351a419e9071dbfc657b449c8ff7be~NozWnamQk0313703137epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697192085;
	bh=sAdsrcy47KgvtkQqo+Eoi6qGMV6FSrM+SBH+rU2sZ9A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UCNrX41MnEbKCo3Xx55t1c2xCIfVsFS1s04P+nU11ZDOHZLL8wkz43VxYoE5lSKOZ
	 KokTC3f85kkrtOniyHSK50wvt0cK8s6b561CQDdGceI1vv/nDaF7iembM8PRsTWPUh
	 9xiAk4lNamniOPWKOu3Xu54VFfxlr7Wr1DOdmwsg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231013101444epcas5p4be0502dc3f69d9b2699b01b520623ce6~NozVsL3zm1661116611epcas5p4x;
	Fri, 13 Oct 2023 10:14:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4S6MnG3Sk6z4x9Pr; Fri, 13 Oct
	2023 10:14:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.3D.09638.29819256; Fri, 13 Oct 2023 19:14:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231013101442epcas5p3a38926de76ca3720e5a63ad22800ccb9~NozTdR4K73104731047epcas5p32;
	Fri, 13 Oct 2023 10:14:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231013101442epsmtrp1ca4abffbe4275810de738a4cd4ede26d~NozTcjpTc2720427204epsmtrp1x;
	Fri, 13 Oct 2023 10:14:42 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-c2-652918928def
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.D8.18916.19819256; Fri, 13 Oct 2023 19:14:41 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231013101439epsmtip188630c337170fe35772c9012e38a2f5f~NozRgHYgk2167721677epsmtip1c;
	Fri, 13 Oct 2023 10:14:39 +0000 (GMT)
Message-ID: <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com>
Date: Fri, 13 Oct 2023 15:44:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, stable@vger.kernel.org,
	Vincent Fu <vincent.fu@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231013052612.GA6423@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmpu4kCc1Ug41TJCzWXPnNbrH6bj+b
	xcrVR5kszr89zGQx6dA1Rov5y56yW6x7/Z7FYsHGR4wWj7s7GC02tAk6cHnsnHWX3eP8vY0s
	HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzv
	HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
	Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+P+sbuMBUdZK3o2TmJtYNzA0sXIySEh
	YCKx4uxKIJuLQ0hgN6PEyUeXoZxPjBJtR5cgOKeP9zHBtPSefs0OkdjJKLHm/hMmCOcto8Tt
	57/YQKp4Bewkjv1qYgaxWQRUJd43H2CEiAtKnJz5BGy5qECSxK+rc8DiwgJuElNWLwGrZxYQ
	l7j1ZD7YNhEBJYmnr84yQsTvMUosvG3excjBwSagKXFhcilImFNAW2L37ncsECXyEtvfzmEG
	uUdCYC2HxPwpV9ggrnaROHd/FSOELSzx6vgWdghbSuJlfxuUnSxxaeY5qC9LJB7vOQhl20u0
	nupnBtnLDLR3/S59iF18Er2/QX7nACrhlehoE4KoVpS4N+kpK4QtLvFwxhIo20Nix+bb0ABd
	zSixaMVq5gmMCrOQQmUWku9nIXlnFsLmBYwsqxglUwuKc9NTi00LjPJSy+ERnpyfu4kRnIC1
	vHYwPnzwQe8QIxMH4yFGCQ5mJRHe2XEaqUK8KYmVValF+fFFpTmpxYcYTYHRM5FZSjQ5H5gD
	8kriDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYPJjOXB/5f2pm9fq
	+/JVr/fT/vDRoa7HdN/RFVsTP57fs/Kt7WuHLX96F5SWd7JW/crKTZnqcUY+6/ABLp91DtPP
	7hXmuncp+VRidG3ky9PPn3MLNLYnXavT39ea/+tEfoil7JG5HEmv3l+xviTQ/fltx+q4O6Xp
	9pN+SOU+MXvoc8NAxvejZNWp7UeqJqtreXAcrOAO257wRumpQbB//8MbuzPr9kywUSs/ES//
	Ma5g6nEDV2bG/8a/u5M8TrDNXWP1ap+txuMF19fIei1+dF5gm/EmeW2nWTYTSppmfXxeUV56
	OHDrnqayza3sL3vO7jDItvy42GbxUj2OuVr7Wp5KLz8wd3G1jKUXX97UrnYlluKMREMt5qLi
	RACT3ZKTSQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTneihGaqwe5ZZhZrrvxmt1h9t5/N
	YuXqo0wW598eZrKYdOgao8X8ZU/ZLda9fs9isWDjI0aLx90djBYb2gQduDx2zrrL7nH+3kYW
	j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKuH/sLmPBUdaK
	no2TWBsYN7B0MXJySAiYSPSefs3excjFISSwnVGiceUfZoiEuETztR/sELawxMp/z6GKXjNK
	/Dz0jBUkwStgJ3HsVxNYA4uAqsT75gOMEHFBiZMzn4BtEBVIkthzv5EJxBYWcJOYsnoJWD0z
	0IJbT+aDxUUElCSevjrLCLKAWeAeo8TdLzuhtq1mlLgz7xfQJA4ONgFNiQuTS0EaOAW0JXbv
	fscCMchMomtrFyOELS+x/e0c5gmMQrOQ3DELyb5ZSFpmIWlZwMiyilE0taA4Nz03ucBQrzgx
	t7g0L10vOT93EyM4zrSCdjAuW/9X7xAjEwfjIUYJDmYlEd7ZcRqpQrwpiZVVqUX58UWlOanF
	hxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUxr3jW5anuePzT9yD2zSX++PF2yW7uw
	+NeK2Pgdy4QWpBwtyXxmfzekp3bdl7/VBXy3rjZdYz956VU5w4Gy5XPC84W5eZJd6yJuSdVY
	6dkk/pq9maFTjj3f7fmN1oeMctWfisM4Cx9oy1X/1GW1ntURJlKxae1tr6lffikJTNDbkp/S
	8JN7xgoBX6mlfFP2X3WKP/bpdd/tIMfD1h9Xmt/ZFL9QmeN+8PnWSQGaO+ZOMpc/pfnx1/Fz
	eyd2q315uOn6CZEHtbPE0mNu+xtkbJXccm09V9p3yV7GVWKn5x2WmGzdkzjX/e2PYve3R27X
	22xVWuW9nvPlmduit5YoXZwkmiCT+azk6uGTf9t6n0/8psRSnJFoqMVcVJwIADMlDB4iAwAA
X-CMS-MailID: 20231013101442epcas5p3a38926de76ca3720e5a63ad22800ccb9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
	<20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_031451_825779_C91B93F2 
X-CRM114-Status: GOOD (  17.23  )
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

On 10/13/2023 10:56 AM, Christoph Hellwig wrote:
> On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
>> Changes since v3:
>> - Block only unprivileged user
> 
> That's not really what at least I had in mind.  I'd much rather
> completely disable unprivileged passthrough for now as an easy
> backportable patch.  And then only re-enable it later in a way
> where it does require using SGLs for all data transfers.
> 

I did not get how forcing SGLs can solve the issue at hand.
The problem happened because (i) user specified short buffer/len, and 
(ii) kernel allocated buffer. Whether the buffer is fed to device using 
PRP or SGL does not seem to solve the large DMA problem.


