Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7ECC0218D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7DRdYruLuTGeDOp3T9CApmK93+wgaQobbfK2Y7ArqFM=; b=qeK2HkYoyaIRoiKB1GmYC7jIy9
	WkE+b4T5gjIHpQvd+Ih2GjpjlUyv77iNTzE4c4FTQn9rn/HzFYrcm5P5plooc59XqV9yIc+fIZwAN
	Eyc9uwgm7xGKZY3/8q6VvqM2IeDiSoOyMq9xsIKrdYKENIYdEowVhhA5UXFtuDPQgcdLmwOK4EqUz
	6cIK4rb8SuW6dc3t+xgl+c5DJc3uKq1uPZd4K53lBxjf5Nc0WvAa+ucz1ZUx9IVM3UGFGfuyNpj0w
	oCES0jvuk15yqkbDLNWNWmfPt1CrWVfwjgADm6hqzI0T58ZPPt5XBDmb/wmE9uRVr4jEF0KYhKOi+
	3hYkfGww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdoHF-0000000AOnV-3ThU;
	Fri, 31 Jan 2025 10:29:33 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdoHC-0000000AOmL-3CCD
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 10:29:32 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250131102922epoutp016da1631b0339dbc9f5f184442e64fc5a~fwD-1eXRU2783527835epoutp01S
	for <linux-nvme@lists.infradead.org>; Fri, 31 Jan 2025 10:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250131102922epoutp016da1631b0339dbc9f5f184442e64fc5a~fwD-1eXRU2783527835epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738319362;
	bh=7DRdYruLuTGeDOp3T9CApmK93+wgaQobbfK2Y7ArqFM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Cx3PalL4DiokQv/BPJGipk832nhyfd9Y3+vj5XiSJF5sPnxWK7tPfyIQgpdU1O/fZ
	 BbHASga9V8qTT+E6dzEcYTJpYNXRHhIIZzbp4Rj3YzjS61s58IdxS4lINCTAnpACly
	 Aw/Y9ugfPJ+B2AchuCVFFBwAYDvPB8EizJithdQI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250131102921epcas5p1df271e2a76e61741daf442e23056a996~fwD-Eepfu2151321513epcas5p1X;
	Fri, 31 Jan 2025 10:29:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YksZR6tCPz4x9Pv; Fri, 31 Jan
	2025 10:29:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.5E.19710.FF5AC976; Fri, 31 Jan 2025 19:29:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250131102919epcas5p382301978fa8c4b90b653eb319b7858b6~fwD9ihjw81285712857epcas5p3C;
	Fri, 31 Jan 2025 10:29:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131102919epsmtrp2625fcb350f65b6dfb1f05e1468c7b217~fwD9dfpm90770307703epsmtrp2k;
	Fri, 31 Jan 2025 10:29:19 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-17-679ca5ffef20
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.77.33707.FF5AC976; Fri, 31 Jan 2025 19:29:19 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250131102918epsmtip1b3413b2283500cdaeda4e9539fe6b040~fwD8CEDkU0826508265epsmtip1N;
	Fri, 31 Jan 2025 10:29:17 +0000 (GMT)
Message-ID: <12ee6895-aafe-491e-8dea-c024a2a34563@samsung.com>
Date: Fri, 31 Jan 2025 15:59:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: Christoph Hellwig <hch@lst.de>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250130125306.GA19390@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmuu7/pXPSDbbvsbBYfbefzWJS/wx2
	iws/Gpksbh7YyWSxcvVRJos/Dw0tJh26xmix95a2xaXHK9gt5i97yu7A5TGx+R27x+WzpR6b
	VnWyeWxeUu+x+2YDm0ffllWMHuu3XGXxmLB5I6vH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2
	St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFcqKZQl5pQChQISi4uV9O1sivJLS1IV
	MvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzjjTMYCnYyVWxaPFDtgbGhRxd
	jJwcEgImEhP3nmTsYuTiEBLYzSgx+cFNJgjnE6PE9l/bEZyV6+cxwrQ8X7SCHSKxk1FiQdMZ
	VgjnLaPEs74/LCBVvAJ2Eq3vW5hAbBYBVYlbV1sZIeKCEidnPgGrERWQl7h/awbQJHYOYQFd
	iR3RIFERASWJp6/Ogp3ELHABaPGeR2BjmAXEJW49mQ9kc3CwCWhKXJhcChLmFNCRePB0JxtE
	ibzE9rdzmEF6JQR2cEg0dr5lgTjaRWLB0ztQDwhLvDq+hR3ClpL4/G4vG4SdLfHg0QOo+hqJ
	HZv7WCFse4mGPzdYQfYyA+1dv0sfYhefRO/vJ2DnSAjwSnS0CUFUK0rcm/QUqlNc4uGMJVC2
	h8SLCcfANgkJNDFJrDriMIFRYRZSmMxC8uQsJN/MQli8gJFlFaNkakFxbnpqsmmBYV5qOTy6
	k/NzNzGCk7CWyw7GG/P/6R1iZOJgPMQowcGsJMIbe25GuhBvSmJlVWpRfnxRaU5q8SFGU2Dk
	TGSWEk3OB+aBvJJ4QxNLAxMzMzMTS2MzQyVx3uadLelCAumJJanZqakFqUUwfUwcnFINTOt7
	Dt8VnNAr/CL86CznpdopfpallpuefNE9zLtgc36te6fAqboJwaWJty9klelGy8RG2G02jXfa
	mbFbgGPdu5CsnVUncl7y+KbNt76w9Jpg/+Z9i1N5vl4qeXGXo4hlXeXStd0HQz5/7nPwr/iz
	WjPylvyDM7ynb2t8r5417QjjvAuGrz7o+/WqCmXaNs08kb3/unpnS/9c5bMXmVcInF90R9Xv
	1u2679u4fX52Hl28y9xwL5Mo25GdaWIby52zm38k8K6KuPz62BVz67SXkYIv/te9ujHxwdI7
	P7WvNX0v9D0UaMq4ecnqxM+PZz5M+zHzhfqDU+cu1YtPXLdNI8H0V0LDrUwBCYN5PcvtHn5T
	YinOSDTUYi4qTgQAsSJ9GUsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnO7/pXPSDZq+yFusvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZXfg8pjY/I7d4/LZUo9N
	qzrZPDYvqffYfbOBzaNvyypGj/VbrrJ4TNi8kdXj8ya5AM4oLpuU1JzMstQifbsErowjDTNY
	CnZyVSxa/JCtgXEhRxcjJ4eEgInE80Ur2LsYuTiEBLYzSjyet5MJIiEu0XztBzuELSyx8t9z
	qKLXjBI/XreygiR4BewkWt+3gDWwCKhK3LrayggRF5Q4OfMJC4gtKiAvcf/WDKBmdg5hAV2J
	HdEgUREBJYmnr84ygoxkFrjAKLHk8hFGiPlNTBL3muaAzWcGOuLWk/lA8zk42AQ0JS5MLgUJ
	cwroSDx4upMNosRMomtrFyOELS+x/e0c5gmMQrOQXDELyaRZSFpmIWlZwMiyilE0taA4Nz03
	ucBQrzgxt7g0L10vOT93EyM41rSCdjAuW/9X7xAjEwfjIUYJDmYlEd7YczPShXhTEiurUovy
	44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpgkRZfm3gg57fHzgVrPi/dL
	sjO0j+SVuaxddcoyxHX2pdXWSysy1+y49a694dLKa66X0g1fx5XvSJ6TFTplpfydV+2HmHg8
	JrC/3fOuKi2aN/5axn0Gxi1Hvxs9uW7Tv2z1dJ0d98zu+7v/mXT5fGiUWZQ5z6Lvll8iDu1w
	XbfJe/VEA95bsk2MquGTq0VeTts9XU5RmnXx1+VX70+sF6hd/+6RlNcE9UvPl9o1RLGLZCXn
	b7x34qHQs729lpknemSUbjR6nFj0Oujz4vg/cX6z/h3UCbx5jG97ZmDEg/2H2cXvrrvwYppW
	5QpNS9/YE7Pe36+skD0oFbxnWlnj09dbavf+PfuIc/k+I6v1IbkrZJRYijMSDbWYi4oTAVnl
	AOskAwAA
X-CMS-MailID: 20250131102919epcas5p382301978fa8c4b90b653eb319b7858b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de>
	<b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
	<20250130125306.GA19390@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_022931_274755_B77B817C 
X-CRM114-Status: GOOD (  20.85  )
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

On 1/30/2025 6:23 PM, Christoph Hellwig wrote:
>> Difference is that FS does not have to attach any PI for offload.
>>
>> Offload is about the Host doing as little as possible, and the closest
>> we get there is by setting PRACT bit.
> But that doesn't actually work.  The file system needs to be able
> to verify the checksum for failing over to other mirrors, repair,
> etc.

Right. That sounds like reusing the existing code on detecting 
checksum-specific failure. So maybe that can be handled iff this gets 
any far.

> Also if you trust the device to get things right you do not
> need to use PI at all - SSDs or hard drives that support PI generally
> use PI internally anyway, and PRACT just means you treat a format
> with PI like one without.  In other words - no need for an offload
> here, you might as well just trust the device if you're not doing
> end to end protection.

Agree that device maybe implementing internal E2E, but that's not a 
contract to be honored. Host can't trust until device says it explicitly.

Since Btrfs already has 'nodatasum' mount option, I assume there are 
deployments that prefer to optimize for checksum. I thought Btrfs will 
be more comfortable to give up (its own checksum tree) and exercise this 
more often if it certainly knows that device is also capable.

