Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B6C3ABC7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XtbBWwz6NU7KDXWphjN/r7QGFbw2cT0V+eu3U10v464=; b=PrH048RyddXPL9lvCFIsJDaYDJ
	LBbcwAiOMELYdrHnCLnsvgl64bDrWk/a8HT3RCIPh0dBiegKTU93LKItFLMKdRA8CYAKC/S/XbS9j
	/bNgB/op7Wj7qkWZXIcyfOCups4NX7yv7VNnHh0d797jMCd7oGfg70Zgv0qG2AkZmxsT3Ptozhf11
	b+FIB2FoLK9Lxs9J/Jgvt1N0eEiYHF+MCs9hirJ9plPVfFGIaLKGyo5WUMrZq+w3XqAxX0lXA6IjG
	V8xyfoWTDOYZlzEPGl2znR+0RrF2PQ7YyNOO7s4Y3Y9foPOE1/1Kymjnd10tWFm7MbTd34AvHFVw6
	cRZgMp7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCRpi-0000000DgWQ-0DKJ;
	Tue, 06 May 2025 23:36:18 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMz7-0000000D68i-0fSV
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 18:25:43 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250506182534epoutp04eb8a24c23deebed8be849b291550d4b0~9A16FarFI0099500995epoutp04l
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 18:25:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250506182534epoutp04eb8a24c23deebed8be849b291550d4b0~9A16FarFI0099500995epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746555935;
	bh=XtbBWwz6NU7KDXWphjN/r7QGFbw2cT0V+eu3U10v464=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TL0aQu4MfL2rdhhcLKE2cWnRBw+Zyr2dEB6Gb4mbRm6UzCEDYgd2ynoa9xZJRYXIz
	 o3etREpsN7/dNiV4qYUDrXPhYfdjqCtvUSk8xXk4zV07yLZ0H+gVyEUTJlGCtnlYFW
	 I5sjeiHJmxtPPmfownwZT0qwcJI1PPFOtY8wcAbw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250506182534epcas5p2342c4de1a2cf9c4158efe4b7c79483ea~9A15tGmtu1660016600epcas5p2F;
	Tue,  6 May 2025 18:25:34 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.177]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4ZsRf56KHYz2SSKX; Tue,  6 May
	2025 18:25:33 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250506182533epcas5p1562536be89ffc018f0e6eedffa71cb47~9A14S_Avz2900429004epcas5p13;
	Tue,  6 May 2025 18:25:33 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250506182533epsmtrp2b20ea010b98f01ad4a5b18deab546764~9A14P2wWi2193121931epsmtrp2I;
	Tue,  6 May 2025 18:25:33 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-e3-681a541c090f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.13.19478.C145A186; Wed,  7 May 2025 03:25:32 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506182532epsmtip2f7379c09567a0c8788971f1000bdd0da~9A13d9rFM0368503685epsmtip29;
	Tue,  6 May 2025 18:25:32 +0000 (GMT)
Message-ID: <d238e89a-3a9d-4807-9634-57fbff4168a0@samsung.com>
Date: Tue, 6 May 2025 23:55:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix incorrect sizeof
To: Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Cc: csander@purestorage.com
Content-Language: en-US
From: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <6ce9274c-db51-4ff9-9d05-9d334caf2206@kernel.dk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvK5MiFSGwfQD5har7/azWfxfOJfV
	YtKha4wW85c9ZXdg8bh8ttRj06pONo/NS+o9tj3sZQ9gieKySUnNySxLLdK3S+DKeHB7AmNB
	F2PFmibzBsb8LkZODgkBE4lbk14ydzFycQgJbGeUmPyujR0iIS7RfO0HlC0ssfLfc3aIoteM
	EhNu32EDSfAK2En823mZGcRmEVCR2Pt8OxNEXFDi5MwnLCC2qIC8xP1bM8AGCQvoS2w+0MII
	YosIhEpc6H8DVs8sIC3RvvoMI8SC/YwSn9dfYoRIiEvcejIfrIhNwFxi+7wzYMs4BWwlFv+Z
	zgxRYybRtbULql5eYvvbOcwTGIVmIbljFpJRs5C0zELSsoCRZRWjaGpBcW56bnKBoV5xYm5x
	aV66XnJ+7iZGcAxoBe1gXLb+r94hRiYOxkOMEhzMSiK89+9LZgjxpiRWVqUW5ccXleakFh9i
	lOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwMU5krBWtLmHki1JRv77NUit+jfUhi7XP
	X74MnbFLYLu16uzmp7s5C/zY96y8MHvmplZeqSjVyE1tPI6ebZPfv673VQxla+01kj/AG5+5
	+Oux/t9LHdu0dv5153WWmPqY96Whw2u1EysTtsx2TKrdWlS0Ldxw68yPqUJeK33/2G8Id9yQ
	uWClYsPhE2Kf+e72fF7uXFvguvq8IsPRS84bGfIDN19rNvRx5Vm4a4kFN+fjW94nr61f/Gab
	voiQmtv5ZTU3jkYm620wuROeHBXxLPfANdk35V6fZ7713LP6oD5TkEq4S/jW3ObldnEXH4l7
	prJe4nqoPXsFR3NXSTjjKqb6N5yHz+722VAUeeiqEktxRqKhFnNRcSIA+LMN7PACAAA=
X-CMS-MailID: 20250506182533epcas5p1562536be89ffc018f0e6eedffa71cb47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506180545epcas5p34d4857f38b838532678728db22df6067
References: <CGME20250506180545epcas5p34d4857f38b838532678728db22df6067@epcas5p3.samsung.com>
	<20250506175656.23151-1-joshi.k@samsung.com>
	<6ce9274c-db51-4ff9-9d05-9d334caf2206@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_112541_828737_C455AE16 
X-CRM114-Status: UNSURE (   8.12  )
X-CRM114-Notice: Please train this message.
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

On 5/6/2025 11:39 PM, Jens Axboe wrote:
> Reported-by: Caleb Sander Mateos<csander@purestorage.com>
> 
> ?

indeed, missed that :-(

