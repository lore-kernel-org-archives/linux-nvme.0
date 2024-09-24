Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42ECCF9C77
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujjozdZ0S6smtIOf2Eo64izQZAki0Dpgi2fL4KYD0eo=; b=BQeKc7g8OR9hXZIrsmrfkE74rH
	NMh7ldD1F3QI/+ut9QMUyPwl1X6eaYz4T7gLNkWhYWvi38lbnCsdVch3sRiQlFBaqgCQoCZ9x4MJK
	mWnmazaBKpWgICNRIuMf0H2RrDRDmM3IxZ5P0Vcr6IfwcRIRPm3ebGD9yTNg+ft/XQi/M/lBLXeQl
	Mxa+JfGxFV/oe/HGRQJ0WSsLNQaBdZZubX8V62czaHCBEpH6/R0YP3Upo1ZUPSSMquE+UU5nIchbQ
	IEwogOn5emRbyjyRU5eS10hcFXVKXdVW04LskSwZfJDuvOkrHeAlJ2zpXhzJMAAYWb2dWZhZ3MGjk
	mMxYCCfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st1uC-00000001oUI-0akE;
	Tue, 24 Sep 2024 09:32:24 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st1nC-00000001msP-3r6z
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:25:13 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240924092502epoutp0407d83180f38d5fecba51d842fb4f7a02~4I_AuWica1569015690epoutp04c
	for <linux-nvme@lists.infradead.org>; Tue, 24 Sep 2024 09:25:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240924092502epoutp0407d83180f38d5fecba51d842fb4f7a02~4I_AuWica1569015690epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727169902;
	bh=ujjozdZ0S6smtIOf2Eo64izQZAki0Dpgi2fL4KYD0eo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BwzRx14TxKNqqWxCV80gLdhvlfdc3ZqAyqcv+xSN/70v+VU1BDgpX7Yuq6dY1gHVy
	 ey8Olc4DD3l7lFYt/DEiUZBlmTiFuxpTH6/QCV6O5fmYcYU6ci4DhvRoK/tjGUdkZJ
	 EUzrxFfdKRAF4qrCCMeIX6oz91FYWhRs96A4HH3E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240924092501epcas5p3f637377fab6c1cc78535ad611ec3c268~4I9-tP-SU2625526255epcas5p3P;
	Tue, 24 Sep 2024 09:25:01 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XCZFm1yQRz4x9Q8; Tue, 24 Sep
	2024 09:25:00 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AE.0F.08855.C6582F66; Tue, 24 Sep 2024 18:25:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240924092459epcas5p23e41d7dfa92acf415d9dab1d0e433842~4I9918t0b2825728257epcas5p2N;
	Tue, 24 Sep 2024 09:24:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240924092459epsmtrp2deb043bef0671cc130aa36af932e5811~4I991DpJu0725707257epsmtrp2I;
	Tue, 24 Sep 2024 09:24:59 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-2f-66f2856cb18c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.28.19367.B6582F66; Tue, 24 Sep 2024 18:24:59 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240924092456epsmtip18d685cf23e102be2cbcceaf47e18117b~4I960RNvX2191221912epsmtip1D;
	Tue, 24 Sep 2024 09:24:56 +0000 (GMT)
Message-ID: <edcbf69e-9ae9-06df-60c0-47393371fcd8@samsung.com>
Date: Tue, 24 Sep 2024 14:54:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/5] sd: limit to use write life hints
Content-Language: en-US
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
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240918120159.GA20658@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH/d17e1saO69ljB9FgTVqNgasVcAfDIZmZLtuU0gWQ+LcaqUX
	SugrfTCdJMLIUNfBBs2YVATmkM4iMhhBXiXIRthEHg6UR4UAlm2ullcTsw1FW8om/33OOd/z
	O6/8ODj/E7aAk6XSM1qVVCEkuUTL9Z3hkYrTKxmiEQsb1U2dI5Hz+gpAZUsPcfTv1F0MTXS3
	Yeibul4MfXGxAEOOBjOOGs9x0O+/udnoYa2VjUp7fgXINrkL3f7qAOq03SJQVe08GxnHWklk
	6VvDUMtqFY6+cy4SaOifPhYaMlewX9tGj4weooemGwm6rPRHkh4ZMNBN1s9I+lrNx3RHtRuj
	OybySHp5fpKgi5utgP6p+gabdjeF0E0OF5bKeyc7Qc5IZYw2jFGlq2VZqsxE4aEjkn2SmFiR
	OFIch14VhqmkSiZRmHw4NXJ/lsIzszAsR6oweFypUp1OuHtvglZt0DNhcrVOnyhkNDKFJloT
	pZMqdQZVZpSK0ceLRaKXYzzC97LlQ6MuUjPI/WB+roudB7o4Z4AfB1LRsPxKOTgDuBw+1QHg
	iDOP8BkrAA7XL4InRvFAG+txyoVTi5gv0Aagq2WV9Ab4lAvA/AcyL/OovdDoGsa9TFAvwlO2
	i6TP/yy8Ve4gvBxAvQ8f/VIBvOxPJUJj0di6H6cC4aSjCvPyVkoI5+8PrHeBU7UE/Hp5yPMQ
	h0NSO+GwyeDV+FER8I+1ReDLDYXfuypwrx5SFj9ou9C60XUytDknNtgf3u9rZvtYAN0LNtLH
	2XBmbobwcS5svVa8oU+CeX+Ps7x1cU/dhvbdvlpbYNGqA/O6IcWDnxbyfertcLp0fiMzEM5+
	XsPySWjYmx/kW1shAecmb2DnQZh501bMm6Y3b5rG/H/hakBYQRCj0SkzmfQYjVjFnHhy73S1
	sgms/4jw5FYwXrUW1QMwDugBkIMLt/JKJ5Yz+DyZ9MOTjFYt0RoUjK4HxHjOU4ILAtLVni+l
	0kvE0XGi6NjY2Oi4V2LFwkCe8/SXMj6VKdUz2QyjYbSP8zCOnyAPu6t/w3RTYqvr739hPN60
	ULS9Pi05KoNu2HOwpb7/0dlBZ1JpGstwnpVfWddqMpUcGSvY8lffYpkycs+9whS3wGI/2t0u
	LzwccbnT/hJ3ind89s6DHzJudqgGk+yX3vyoqzFn2BTvnzIYvFTC4L1zTWOSSt2BJSLtyvPJ
	RdxdRMIzIfaoqw72ytsdx6dn7sVlPXXMOPFtMGkNKrB0GizD7bWjEe6COvaCQL6tDTydItDu
	mJ2qoHszjLhAeSnnas3+fQG5K7f77gDn2csDq9VH/1zrzrX/XBJUFiIKbh4PPtHy+sBYEbeT
	KGXsb6W8W2yrPBaaayzpPHlwh7UsIC30uXohoZNLxeG4Vif9D9ch+QCaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCSnG5266c0gxeflC1W3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbbfs9ntlj3+j2Lxfm/x1ktzs+aw+4g5nH5
	irfH+XsbWTymTTrF5nH5bKnHplWdbB6bl9R77F7wmclj980GNo+PT2+xePRtWcXocWbBEXaP
	z5vkPDY9ecsUwBvFZZOSmpNZllqkb5fAlXH+ylu2gnNcFU8f7WNvYNzH0cXIySEhYCIxtek9
	UxcjF4eQwHZGiUlTGtghEuISzdd+QNnCEiv/PWeHKHrNKLH/wkqwBK+AnUT32wvMIDaLgKpE
	097pbBBxQYmTM5+wgNiiAkkSe+43MoHYwgK2Et2918HizEALbj2ZDxYXEVCSePrqLCPIAmaB
	ZSwSB6e8hTqpjUXi/bKjQA4HB5uApsSFyaUgDZwCOhIv/71nhBhkJtG1tQvKlpfY/nYO8wRG
	oVlI7piFZN8sJC2zkLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iRGcCrSCdjAuW/9X
	7xAjEwfjIUYJDmYlEd5JNz+mCfGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5N
	LUgtgskycXBKNTAxZTk/npb9vf5JxJxFZb9sdj2UtDTnCmw+l8dk8PN8MC+T9RfWPctrZj9S
	PX7t0yQ1jUUFqyMD9z5PDMopqF18XUXtz88XHkqdcqLX5XY/eOIh21hXIX36RapCxrUlBx12
	MvA+qUg40M7/dIqBwcGpefNPVjzysw+7Y375/MlQhsXC1jv41+3i/HvW7W1SOvfJpwxdZzr9
	95642n47dO0pn8n6f176ZOY2tFSHhOi8Dexm7V5YyXpQ6dHEbfl35D6dneP0b7uBi6Qov5tM
	xJS3vfHv+G05uzawr63p3fv/2DbLYJ0Fi2/yN9rmbjtamu4e9ObqQ7uj8q5Lfp37G+FuW/D1
	9Lu9U19esHq+otJFiaU4I9FQi7moOBEAityLA3QDAAA=
X-CMS-MailID: 20240924092459epcas5p23e41d7dfa92acf415d9dab1d0e433842
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c
References: <CGME20240910151057epcas5p3369c6257a6f169b4caa6dd59548b538c@epcas5p3.samsung.com>
	<20240910150200.6589-5-joshi.k@samsung.com> <20240912130235.GB28535@lst.de>
	<e6ae5391-ae84-bae4-78ea-4983d04af69f@samsung.com>
	<20240913080659.GA30525@lst.de>
	<4a39215a-1b0e-3832-93bd-61e422705f8b@samsung.com>
	<20240917062007.GA4170@lst.de>
	<b438dddd-f940-dd2b-2a6c-a2dbbc4ee67f@samsung.com>
	<20240918064258.GA32627@lst.de>
	<197b2c1a-66d2-5f5a-c258-7e2f35eff8e4@samsung.com>
	<20240918120159.GA20658@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_022511_760879_EBEC3DC8 
X-CRM114-Status: GOOD (  19.62  )
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

On 9/18/2024 5:31 PM, Christoph Hellwig wrote:
> On Wed, Sep 18, 2024 at 01:42:51PM +0530, Kanchan Joshi wrote:
>> Would you prefer a new queue attribute (say nr_streams) that tells that?
> 
> No.  For one because using the same file descriptors as the one used
> to set the hind actually makes it usable - finding the block device
> does not.  And second as told about half a dozend time for this scheme
> to actually work on a regular file the file system actually needs the
> arbiter, as it can work on top of multiple block devices, consumes
> streams, might export streams even if the underlying devices don't and
> so on.
> 

FS managed/created hints is a different topic altogether, and honestly 
that is not the scope of this series. That needs to be thought at per-FS 
level due to different data/meta layouts.
This scope of this series is to enable application-managed hints passing 
through the file system. FS only needs to pass what it receives. No 
active decision making (since application is doing that). Whether it 
works fine or not - is application's problem. But due to the simplicity 
it scales across filesystems. This is for the class of applications that 
know about their data and have decided to be in control.

Regardless, since placement-hints are not getting the reception I 
imagined, I will backtrack.

