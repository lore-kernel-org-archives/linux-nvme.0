Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD66BC4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yZbUxRO3Zcmnt7WyYgas9RrUMhCGfA3ShsH1Hycpevk=; b=yFvYGsnTueJphV3fFyGlgTJWCG
	c5u3MpiUzfOXK4tk5NDRs4B922aAZN5VwFEnJ5zV3twGs0pDZQssKNfbleEBL2ObKbL6tcmKRsWLB
	S+oMX8faPyVpyfwwNkeHQZKLg+I9fAVmVQfLIIfF68Do5RBMEvk6ekOfruZiHpTw9YqyMlJjBvyqu
	ZnzN6Aw3B9cit9fFQ6edQhRwe5dDvBFUy/Bo2KxkAzU3tMWErAeRBSBFKtdVKdnMbYeYw3HWPy3OA
	hSuje7JIHOmRxwWFop5DUaTCsHPDE4N5Quk1MxjNqZ5AZY8YzMcWSqxZS1wN1ZAcJ2RFLFZ5YPgrj
	cXxiRJXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2rbn-0000000GLw7-1dFp;
	Fri, 03 May 2024 12:01:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2rbi-0000000GLtW-2kA9
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 12:01:46 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240503120135epoutp02b8f1152ec01997e1be6d0fd79648793f~L_NlpNsW-1726417264epoutp02W
	for <linux-nvme@lists.infradead.org>; Fri,  3 May 2024 12:01:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240503120135epoutp02b8f1152ec01997e1be6d0fd79648793f~L_NlpNsW-1726417264epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714737695;
	bh=yZbUxRO3Zcmnt7WyYgas9RrUMhCGfA3ShsH1Hycpevk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZRuDE/vvevOuelo3PqwM/uhJ2O4xX05cvtSkwMhmKSITp9Gm6612wiOk4wRzizBa9
	 XmshWnZMcftEynA37zSRIp9agELYEG+Uk1ObCHYRG0U0jeMwOXTgU/NkWeecGTq0xn
	 c+W7VDblmYiPNurGIyOpY6I539swxtg4JfrjFMSs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240503120134epcas5p1b530901e6c8e6e97018c8a8a362e97fb~L_NkRKyXV1236812368epcas5p1B;
	Fri,  3 May 2024 12:01:34 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VW8Xr4kZCz4x9Ps; Fri,  3 May
	2024 12:01:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C5.CE.08600.C12D4366; Fri,  3 May 2024 21:01:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503120132epcas5p125b2e601d193d11756a1d005d2e1a429~L_NiYLymP1236812368epcas5p19;
	Fri,  3 May 2024 12:01:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240503120132epsmtrp19754256807b3711ebbdb93a81b8c424f~L_NiXG-Sk2608826088epsmtrp1P;
	Fri,  3 May 2024 12:01:32 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-b5-6634d21c5253
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.A3.08924.C12D4366; Fri,  3 May 2024 21:01:32 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240503120130epsmtip1930bf82902c1909b6a2e9b3b1c7753a4~L_NglACbP0818808188epsmtip1k;
	Fri,  3 May 2024 12:01:30 +0000 (GMT)
Message-ID: <47d71118-5a16-cc28-22ae-0ef6745642d5@samsung.com>
Date: Fri, 3 May 2024 17:31:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 04/10] block: avoid unpinning/freeing the bio_vec incase
 of cloned bio
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240502071221.GA31379@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmpq7MJZM0g9mLVCyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGdUtk1GamJK
	apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0MFKCmWJOaVAoYDE
	4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMRx/TCi4x
	V3TNu8/YwPiDqYuRk0NCwERi9b5lLF2MXBxCArsZJf6c7GWGcD4xSrTfesMO4XxjlNg87R9Q
	GQdYy5fj2RDxvYwSiw8thCp6yyixft9rZpC5vAJ2En1/J7GCNLAIqEg03LKDCAtKnJz5hAXE
	FhVIlvjZdYANxBYWiJHY/no6WJxZQFzi1pP5YOeJCChJPH11lhFkPrPANCaJtT1TwY5gE9CU
	uDC5FMTkFNCRaDrEBNEqL7H97RywByQEznBIvJnYxgbxpovEhjW/oWxhiVfHt7BD2FISL/vb
	oOxkiUszz0GDpUTi8Z6DULa9ROupfmaQXcxAa9fv0ofYxSfR+/sJEyRIeCU62oQgqhUl7k16
	ygphi0s8nLEEyvaQ+PloIjSk2pglTjVeYJ3AqDALKVRmIfl+FpJ3ZiFsXsDIsopRMrWgODc9
	Ndm0wDAvtRwe28n5uZsYwYlZy2UH4435//QOMTJxMB5ilOBgVhLh1Z5snCbEm5JYWZValB9f
	VJqTWnyI0RQYOxOZpUST84G5Ia8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQi
	mD4mDk6pBqatdVevWRvaunQ3HkjlmNHyyVdUo3lbReYtNzHD567CczcKib8IdXo9c/1CefWT
	vrGup/a15vau3TKrsun7TD1po2O75Xp7+U6uZuCrKdIJcSw5u0Fat8HTbG/6YR35p9/+f2Zc
	v+WxcMaJugOvdDkSnkVPe9rBKu+8JOj4wkXv8zjNHnb5nvHK/BQc+nL9NMbiN/ecOVMf3X5b
	ue6ATtG//NX7cqunfa0R8wyJ0HSz8pbwk89Vtbe9V1ejs3z/hFehea57dCVdl+3ReSDyNOPM
	nyeZwnkZPclr+5V/lp9y+lQquS7RMoHxjdjkyXtlNZ7HF2wNubPo4LK5HXE/t3YYRvx0bzrk
	WNSdEJ16TYmlOCPRUIu5qDgRACnDMtFVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnK7MJZM0gz17WSyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGcUl01Kak5m
	WWqRvl0CV8ajj2kFl5gruubdZ2xg/MHUxcjBISFgIvHleHYXIxeHkMBuRomLB3cCxTmB4uIS
	zdd+sEPYwhIr/z1nhyh6zShxdN0msCJeATuJvr+TWEEGsQioSDTcsoMIC0qcnPmEBcQWFUiW
	ePlnItgcYYEYie2vp4PFmYHm33oyH2yMiICSxNNXZxlB5jMLTGOS6P+5mRViWRuzxN01W9lB
	FrAJaEpcmFwKYnIK6Eg0HWKCmGMm0bW1ixHClpfY/nYO8wRGoVlIzpiFZN0sJC2zkLQsYGRZ
	xSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHIVamjsYt6/6oHeIkYmD8RCjBAezkgiv
	9mTjNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MXHse
	HXr+g0toFu9h7r+moie7X+lIxv4/Huc+6532tbMh0yYssa8+Keyy/ZrdFuXuz7OmKfDLlRvd
	2mfzQ2ntxcsvY1PmfCvXvLMoUPN1f8L5KPa/y+60H7wwbbexEXNYSt/TpiaBk5JFLmcman97
	GbrjT1Hd+8S1RbIJDO+dItxsVx891r3rcvTivxWv1q8rOFr1K+hY7LyiXQ+cc7Ls3OfkXTqU
	uLuncd8DNylJr1qzG2Hs0s95JFRmvT06/6vB7OfChodXdM80PFpbdolP02pigezhlIk6s5eu
	n7v47JykD9bPHzv4iD6RWNZpfm9B/q6mje9PHhOYuvPQljtBwd6SjbPUv+gmrws8eLWPRUGJ
	pTgj0VCLuag4EQCgn74JMQMAAA==
X-CMS-MailID: 20240503120132epcas5p125b2e601d193d11756a1d005d2e1a429
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184658epcas5p2adb6bf01a5c56ffaac3a55ab57afaf8e
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184658epcas5p2adb6bf01a5c56ffaac3a55ab57afaf8e@epcas5p2.samsung.com>
	<20240425183943.6319-5-joshi.k@samsung.com> <20240427070508.GD3873@lst.de>
	<03cb6ac3-595f-abb1-324b-647ed84cfe6b@samsung.com>
	<20240429170929.GB31337@lst.de>
	<ebeca5f1-8d80-e4d4-cf45-9a14ef1413a5@samsung.com>
	<20240502071221.GA31379@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_050143_426272_BB6A782B 
X-CRM114-Status: GOOD (  11.04  )
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

On 5/2/2024 12:42 PM, Christoph Hellwig wrote:
> On Wed, May 01, 2024 at 06:32:45PM +0530, Kanchan Joshi wrote:
>> Can you please tell what function(s) in bio data path that need this
>> conversion?
>> To me data path handling seems similar. Each cloned bio will lead to
>> some amount of data transfer to pinned user-memory. The same is
>> happening for meta transfer here.
> Well, everywhere.

Next version will not inherit BIP_COPY_USER for clone bios.

