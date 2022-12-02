Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D32FC4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 09:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+EPsCxM0AH1oxLQYaGbC2YKQGiG5/e8gepDmOAVmy5Y=; b=VWZo8cMwVz6VUB
	cJLLCkzi5AavRcszatnx43QENfuRfIQHmg2NDmS6mxj2vH7hcit/L15pTq/+Rl2D3jFG5gBKaKFaf
	6s/dWR8vI9yX7C6SxR4Wm2SyS0KTNv3AIahO2XCnUanZrsvMgJd0txYlydvxgoT5uWA0UjStNdrWE
	tEztsNyN5G/S863fNvKaETiTvlTNytgxTwIUXQ8GPx480sMtoMOvz2/Y+O3PEa23jSB8WZ81vvtpI
	P41SJi5UYzQnOfvF+RvWfixbdfyZjBfAwOEoJSPLFLAtQ7zqZOPfmn3oQ/C1/1MtRPchgdz0xu0bj
	KoGAdZ7VC+IdGgKn4HZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12kl-00FAfq-Aj; Fri, 02 Dec 2022 09:54:43 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12kh-00FAWa-2n
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 09:54:41 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221202095431euoutp02333b1cffa510d7bef6cea60c199cd499~s8UxR54jC1066810668euoutp02J
	for <linux-nvme@lists.infradead.org>; Fri,  2 Dec 2022 09:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221202095431euoutp02333b1cffa510d7bef6cea60c199cd499~s8UxR54jC1066810668euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1669974871;
	bh=+EPsCxM0AH1oxLQYaGbC2YKQGiG5/e8gepDmOAVmy5Y=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=Vo5+Ey68l84TeB4AmjDbngF1QFBiRuyu83BSgtpADj6TTQ7aJ1K1VUkiOJOa7/elf
	 ZVvbBchhVm+qSfuTwatG8/fzQ0e4XuewA8BOYedleaUarEFMfFz+niP+J0En2Weo8N
	 rI5fVr6uity85h+wHSxpuYwJyr6JSy6UGkWCDybM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221202095431eucas1p1f2ed8613f508b2df393d013ad0114b13~s8UxIQLnF0767907679eucas1p1m;
	Fri,  2 Dec 2022 09:54:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.8F.09561.75BC9836; Fri,  2
	Dec 2022 09:54:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221202095431eucas1p1b3af03a41e446271fc259bec54c9527b~s8Uwudc7g0774207742eucas1p1I;
	Fri,  2 Dec 2022 09:54:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221202095431eusmtrp16f6429736e8bb1a6f21d7db589ecf786~s8Uwt4UmQ2765527655eusmtrp1c;
	Fri,  2 Dec 2022 09:54:31 +0000 (GMT)
X-AuditID: cbfec7f2-8c7d8a8000002559-56-6389cb57b998
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.DD.09026.75BC9836; Fri,  2
	Dec 2022 09:54:31 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221202095431eusmtip27e3660330a8382ca41c3a48c00cdf2c8~s8UwlGKis1908319083eusmtip2s;
	Fri,  2 Dec 2022 09:54:31 +0000 (GMT)
Received: from [192.168.8.105] (106.210.248.221) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 2 Dec 2022 09:54:30 +0000
Message-ID: <8fe0dcb4-a00d-7019-c353-5d41e170fd75@samsung.com>
Date: Fri, 2 Dec 2022 10:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.4.2
Subject: Re: [PATCH] nvme:core: initialize core quirks before calling
 nvme_init_subsystem()
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>, Monish Kumar
	<monish.kumar.r@intel.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20221202092322.GB14667@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.221]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd3w053JBvNna1qsXH2UyWLSoWuM
	FvOXPWW3aL0VarHu9XsWB1aP8/c2sngs3vOSyWPTqk42j81L6j1232xgC2CN4rJJSc3JLEst
	0rdL4Mr4uredseA3e8WT2+ENjBvZuhg5OSQETCRe7NvB2MXIxSEksIJRYt3h2cwQzhdGiaNX
	GlggnM+MEpt2TAZyOMBazj/3A+kWEljOKPF1RylczZY5KxghErsYJf6fMQSp5xWwk/jzsQ4k
	zCKgIrGwu4EZxOYVEJQ4OfMJC4gtKhAl0XThJ5gtLBAr0TJrLiuILSKgJPH01Vmw65gF1jBK
	rNhzFuxsZgFxiVtP5jOBzGcT0JJo7GQHCXMK6EhsXP6ZCaJEU6J1+292CFteYvvbOcwQ5ytL
	LP1ZDfF8rcSpLbeYQMZLCHzhkGh5cIYJIuEi8eb2XRYIW1ji1fEt7BC2jMTpyT1Q8WqJpzd+
	M0M0tzBK9O9czwaxwFqi70wOhOko8eOsDYTJJ3HjrSDENXwSk7ZNZ57AqDoLKSBmIflrFpIH
	ZiF5YAEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzANHP63/FPOxjnvvqod4iRiYPx
	EKMEB7OSCG/auo5kId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwrpgClBNITS1KzU1MLUotgskwc
	nFINTNlms+o//1wYbHM72eugRlrNTSc5cf0O7r/NxW+1Y1lmOZp+imCRP5pU9NWAnZmhx7yp
	TqzAYPmObXPSlTJ+ntMus7/PtKVc+MSDqnWN+7zv6itnLu0yvDAt/dGHdDGL+O075Ddud7zT
	urTQU3nFMwajrc4Xda916K669Sbu3H4OO5dojvtLMk5U/FnC0qe4JDl9pe5R78W/fEX+/5w+
	cQH/vBxlqYn9hQdeHk/1m6x+Nf3d06e3hf3b57fdi1Wtei0zO+WV/a7Pr3K7L3MyHdx1TmTj
	fVf+WyF1jyrOLDjcetPu+bxPU+OVPLrLVr2zmvLlwD/TbN+U5WnvlikI9YlvPLT/h57vYmUx
	nf8+JUosxRmJhlrMRcWJABy7eEaiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7rhpzuTDQ4tFrJYufook8WkQ9cY
	LeYve8pu0Xor1GLd6/csDqwe5+9tZPFYvOclk8emVZ1sHpuX1HvsvtnAFsAapWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxdW87Y8Fv9oont8Mb
	GDeydTFycEgImEicf+7XxcjFISSwlFHi2/x9rF2MnEBxGYlPVz6yQ9jCEn+udbFBFH1klLi7
	7jdYkZDALkaJTes4QAbxCthJ/PlYBxJmEVCRWNjdwAxi8woISpyc+YQFxBYViJK4ef4hE4gt
	LBAr0TJrLtgYEQEliaevzjKCzGcWWMMosWLPWahlaxklpu3ZywZSxSwgLnHryXwmkGVsAloS
	jZ1gx3EK6EhsXP6ZCaJEU6J1+292CFteYvvbOcwQTypLLP1ZDfFLrcTnv88YJzCKzkJy3iwk
	C2YhmTQLyaQFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiN027GfW3Ywrnz1Ue8QIxMH
	4yFGCQ5mJRHetHUdyUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5gi8kriDc0MTA1NzCwN
	TC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamISmcS30XybLGjwlQnre+2mTOQv+nvs0
	VWXLBYvXirdbnVg45+eo6OtXfjeUP7lr+u/57w775Gw34ig5vLbLivNY3U5dW5eamEOvMzjq
	Yg0umliWhm1d5SFu8ECQI4PR1U5T8oDaifO2FRJfXeekfKo5Y9XqNftc164UpuBlMU9ulRz1
	sVZ6nPzpIteNKb4Rrxk4zTNOX1G1Sfui7Lphp9ZbA/mrpdwvN2xYOj/wXvVWtwkZG2yV/y/I
	Euhkusm36KWJWnSOqd3Bqes+bNBZU3y1b2JN7F/dwEcH/pXv/aDhcH6Tea5NbNohszmv92b+
	lbF12F8Y6vf5VjwLw/kN8VsnfX2cr8VlX1N4lHn/XyWW4oxEQy3mouJEAC6TioNZAwAA
X-CMS-MailID: 20221202095431eucas1p1b3af03a41e446271fc259bec54c9527b
X-Msg-Generator: CA
X-RootMTR: 20221201125412eucas1p17da85d566e9786dba7d76230f396eb57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221201125412eucas1p17da85d566e9786dba7d76230f396eb57
References: <CGME20221201125412eucas1p17da85d566e9786dba7d76230f396eb57@eucas1p1.samsung.com>
	<20221201125233.41094-1-p.raghav@samsung.com>
	<20221202092322.GB14667@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_015439_760721_7E1852F6 
X-CRM114-Status: GOOD (  16.08  )
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

On 2022-12-02 10:23, Christoph Hellwig wrote:
> On Thu, Dec 01, 2022 at 01:52:34PM +0100, Pankaj Raghav wrote:
>> A device might have a core quirk for NVME_QUIRK_IGNORE_DEV_SUBNQN(such as
>> Samsung X5) but it would still give a warning "missing or invalid
>> SUBNQN field" as core quirks are filled after calling nvme_init_subnqn().
>>
>> Fill ctrl->quirks from struct core_quirks before calling
>> nvme_init_subsystem().
>>
>> Tested it on a Samsung X5:
> 
> Yes, this looks reasonable.  But it won't help with the CSTS

You are right. I don't think this will help with the CSTS issue, but I
discovered this error message popping up while investigating that issue,
even though I remember the patch you sent that added a quirk to suppress
this message.

> corruption reported by Monish, so it seems like the SSD doesn't actually
> show that issue in all systems?

Yeah, I am not able to reproduce that error in my setup. I am discussing it
with their team to find out the possible root cause.


