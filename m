Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FA6CDD1C4
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2024 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NhotiqO599QBLdqtH3hSuTecQdZLiaYIXQLaEMyc5a4=; b=CDf6BGILZbPSb0/K11hSvjpDEn
	C5glHBw2xAWhIV8ZeOh2tSi34cm0pBO9mBJAMxrEpacuV/VQiETjQCmnBZ40BEBGixkh28J0011Ua
	/txN2U0gYnYWLJNFTdZ7RhTead+uZOUjLHHQXxP3bSySGRRqwORV8tucR5ndQ+Yrb9W7ZQkzcs3IE
	ZZs4v1YLxxLsemJUO1H95yc3k8SkKn+YmodzhYizjaoipfhV80e6ZaLKK2TNIc+ZtqwfbzkkWJMuh
	2rPsXFw2/Oopm6cwVkp9MzsfgkKPoiWCNSKPUEjLvVruylLWjuO54unSflP/k293NvPVv4NvQRlix
	cUDt4d5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1suDVw-0000000Bexk-2UUB;
	Fri, 27 Sep 2024 16:08:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1suDVq-0000000Bews-2qgL
	for linux-nvme@lists.infradead.org;
	Fri, 27 Sep 2024 16:08:14 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240927160803epoutp02652a853c2a61e99b7ea6f1ade3953941~5JZv3gPLs2089120891epoutp02a
	for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2024 16:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240927160803epoutp02652a853c2a61e99b7ea6f1ade3953941~5JZv3gPLs2089120891epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727453283;
	bh=NhotiqO599QBLdqtH3hSuTecQdZLiaYIXQLaEMyc5a4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SwObf3Z3JilU9DGvXX0+3pyjrF29I57+FbkDLk/WBpwiyq2i7/6fDP6UpoFvG6nWc
	 Zm9YMEyaX1YeTtJ1IQTqn+AOt0cwu6A4z70hi7IC4Y7//2oM5DvIoAdk+907FqVAkj
	 FkMnqh1lRa+exau6DMvAB609e9V4h8yaOESyI/o4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240927160803epcas5p3a86b8e58bf502e8c58d13e59d1404927~5JZvejtgZ1465114651epcas5p3B;
	Fri, 27 Sep 2024 16:08:03 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XFb3P5dNHz4x9Pr; Fri, 27 Sep
	2024 16:08:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.EF.08855.168D6F66; Sat, 28 Sep 2024 01:08:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240927160801epcas5p260ef9a24693c5c34489e559a84243a23~5JZtbv32Z0512305123epcas5p2o;
	Fri, 27 Sep 2024 16:08:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240927160801epsmtrp163d00664a4b0bc0f407ab801a1f27bb0~5JZtY_A1G2294722947epsmtrp1v;
	Fri, 27 Sep 2024 16:08:01 +0000 (GMT)
X-AuditID: b6c32a44-107ff70000002297-2e-66f6d861a75b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.51.08964.168D6F66; Sat, 28 Sep 2024 01:08:01 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240927160759epsmtip2b8b8d5574cb1d800bd0254b42d7111bf~5JZsFK8yQ0994609946epsmtip2h;
	Fri, 27 Sep 2024 16:07:59 +0000 (GMT)
Message-ID: <165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
Date: Fri, 27 Sep 2024 21:37:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Chinmay Gameti
	<c.gameti@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmlm7ijW9pBs/6tC1W3+1ns/i+vY/F
	4uaBnUwWK1cfZbKYdOgao8XeW9oW85c9ZbdYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDm8fHpLRaPvi2rGD0+b5IL4IjKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
	1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCS
	U2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3R9uklY8ELzor7i1YxNTB+Z+9i5OSQEDCRuPzp
	BZDNxSEksJtR4vTGuUwQzidGiVmvVzGDVAkJfGOUmHLeAqZje9s5ZoiivYwS1z82QnW8ZZR4
	9/si2FxeATuJFw9OgXWzCKhKnJq0lw0iLihxcuYTFhBbVCBJ4tfVOYwgtrBAkMSWxz1MIDaz
	gLjErSfzwWwRAWWJu/NnsoIsYBY4yyjxcdY2oAYODjYBTYkLk0tBajgFtCT2Pj7ECNErL7H9
	7Ryw6yQEVnJIfNvWwghxtovEzaetbBC2sMSr41ugASAl8bK/DcrOlnjw6AELhF0jsWNzHyuE
	bS/R8OcGK8heZqC963fpQ+zik+j9/YQJJCwhwCvR0SYEUa0ocW/SU6hOcYmHM5ZA2R4SDz+2
	s0HCagOTxJ+Jm9gnMCrMQgqWWUjen4XknVkImxcwsqxilEwtKM5NT002LTDMSy2HR3hyfu4m
	RnDa1XLZwXhj/j+9Q4xMHIyHGCU4mJVEeK3OfU0T4k1JrKxKLcqPLyrNSS0+xGgKjJ+JzFKi
	yfnAxJ9XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAPTA2XxNKWp
	n25M7Vy9eoFXRvnt0H/75r83UP20P0zDsu276fNs9ZUnCno2VeZKHRTgZ9r0JlDoGYOg+dGP
	NdePnl+2ceU11sp9t3/JrbpsxjjLNOpEArur2j37zadUj3e+faHw97/enhaOpcYMyff+i/Sm
	PQ1165zqly7tWeIrky3kf39q0ItwtzY7Vb25JRxn+PzXBa7TvNu3/330xStm2yfy7GRnqVyx
	/VWa6h2m751bLr17InVPzeDMZCFeTrNXH42un9Bt60jnE2bNnO4Qwf/k8t1O4f1sYX/2edn/
	6X2Tt85285d9/OL8vH2q8x/oHnG5sSV52bkHc+wsxC+FJr6u63vr9vDaue5lNlOOK7EUZyQa
	ajEXFScCAN2EHhJEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXjfxxrc0g8drOCxW3+1ns/i+vY/F
	4uaBnUwWK1cfZbKYdOgao8XeW9oW85c9ZbdYfvwfk8W61+9ZHDg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDm8fHpLRaPvi2rGD0+b5IL4IjisklJzcksSy3St0vgymj79JKx4AVnxf1Fq5ga
	GL+zdzFyckgImEhsbzvH3MXIxSEksJtRYv67e1AJcYnmaz+gbGGJlf+es0MUvWaU2HXzAQtI
	glfATuLFg1PMIDaLgKrEqUl72SDighInZz4BqxEVSJLYc7+RCcQWFgiS2PK4B8xmBlpw68l8
	MFtEQFni7vyZrCALmAXOMkpM6pzBBLFtA5PEm8NbgTIcHGwCmhIXJpeCNHAKaEnsfXyIEWKQ
	mUTX1i4oW15i+9s5zBMYhWYhuWMWkn2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5x
	aV66XnJ+7iZGcJRpae5g3L7qg94hRiYOxkOMEhzMSiK8Vue+pgnxpiRWVqUW5ccXleakFh9i
	lOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpg0nLeuen17dXSf1x2+Iub7gzVc0oIy972
	pPN/hNVKbfabi+NX+5oE5s2+rRg9aWPO7EkWWzrNEn68fryY3fBqVdimy66xdhndjPH2BqKC
	UTZMYoEuky/tjXbXsdvX/PifQemCW99Ofv395ELSSXMf9ZNG0qdKN57m+lMX8l9oldGqiJxu
	1qLva6osHgRFSE+z/3q2yveY95s1c2bYfXFbvSdMsyOFL+SYxb3k2uS42YXiloUWzaYXsn8t
	8fRKOB1uHvIv/tLvXYd+/fjNUbRwncSLt0bNMbWv0y6FCzUt8yk03fXwZ7CtpbWCuFTLwf8u
	bDtX8T9hMm2qmaR50uzkF4FtL3Ui95SfsZxtXxauxFKckWioxVxUnAgAAL5/+SEDAAA=
X-CMS-MailID: 20240927160801epcas5p260ef9a24693c5c34489e559a84243a23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
	<20240201130126.211402-3-joshi.k@samsung.com> <ZvV4uCUXp9_4x5ct@kbusch-mbp>
	<8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
	<ZvWSFvI-OJ2NP_m0@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240927_090812_124652_3715B62B 
X-CRM114-Status: GOOD (  16.80  )
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

On 9/26/2024 10:25 PM, Keith Busch wrote:
> On Thu, Sep 26, 2024 at 10:08:09PM +0530, Kanchan Joshi wrote:
>> But there are kernel knobs too. Hope you are able to get to the same
>> state (as nop profile) by clearing write_generate and read_verify:
>> echo 0 > /sys/block/nvme0n1/integrity/read_verify
> 
> It's not the kernel's verify causing the failure; it's the end device.
> For nvme, it'll return status 0x282, End-to-end Guard Check Error, so
> the kernel doesn't have a chance to check the data. We'd need to turn
> off the command's NVME_RW_PRINFO_PRCHK_GUARD flag, but there's currently
> no knob to toggle that.

Indeed.
I spent a good deal of time on this today. I was thinking to connect 
block read_verify/write_generate knobs to influence things at nvme level 
(those PRCHK flags). But that will not be enough. Because with those 
knobs block-layer will not attach meta-buffer, which is still needed.

The data was written under the condition when nvme driver set the 
pi_type to 0 (even though at device level it was non-zero) during 
integrity registration.

Thinking whether it will make sense to have a knob at the block-layer 
level to do something like that i.e., override the set integrity-profile 
with nop.

