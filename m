Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D0FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v2Q1geij+EWsHkQOd0OOlbY8cvBwMNkdetroYG7uZJg=; b=k6/PsgYC9znEpd
	gAJVoGRVZXDcwCQuv03nbHBVb2OajJzJKTOvappioKVGyBiOak3FuntPlQ8p3Rn0moErPeOmcEDS2
	5eW2x332rfeDCgxxB7eSo6EA4XHN48XsgURoAWEYezm5OENNYmSB4QE3Ag9Ex31TLm0q1QqUAoRCD
	2lkh00+9CztH5iIZco9++LGuYfvTkcXPbHZZEpVtzlrj8k3e1hS9YIN+OLXrHP2sZXYl+4psae5ca
	TRMoKBSpceeXWigX8GYCZeGoFdhs0zO3h/TJ9Cm4Nai4tA68VfNvaC2l8I6Wks9vdFy4hrqdP+Y1r
	pujDZAKiM4AENyuPHQOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmAXJ-009bWZ-S9; Wed, 04 May 2022 08:39:05 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmAXF-009bRj-Bk
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 08:39:03 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220504083855euoutp0224c8e4b551cce9f24b5fac42d14386bb~r2iOxXxuT0547705477euoutp02H
 for <linux-nvme@lists.infradead.org>; Wed,  4 May 2022 08:38:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220504083855euoutp0224c8e4b551cce9f24b5fac42d14386bb~r2iOxXxuT0547705477euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651653535;
 bh=v2Q1geij+EWsHkQOd0OOlbY8cvBwMNkdetroYG7uZJg=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=YW9QSpF+LY5814YFBYaAFZ0J6CeHjAUOz5P2wSJlydoyiZmFle2mWnPRkwea7tmoa
 PuAJchCGGyRk2HZHY64SAzqA9BC+ub53NXme9jdknXzpOGmLXsUQv6jViqj7AtGIed
 dMxJxMk3qBPQZQa8OPTlG4deVAylgeUlmYevK9HE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220504083854eucas1p10fc4f0885aa39652e7f66eedb7c8b3b7~r2iOaQegh0678506785eucas1p1F;
 Wed,  4 May 2022 08:38:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 66.C2.10260.E9B32726; Wed,  4
 May 2022 09:38:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220504083854eucas1p27a878ea3b3c156361b1985e011e789d7~r2iOAxaSx2524025240eucas1p2_;
 Wed,  4 May 2022 08:38:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220504083854eusmtrp24bc4a1c830349bf68a4ceea515e48c11~r2iN-TlXb3001530015eusmtrp2j;
 Wed,  4 May 2022 08:38:54 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-d4-62723b9e95b5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.3E.09522.E9B32726; Wed,  4
 May 2022 09:38:54 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220504083854eusmtip13d9e6e9508fba46e708446cb1e14ed62~r2iN0ADCm1508715087eusmtip1I;
 Wed,  4 May 2022 08:38:54 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 4 May 2022 09:38:51 +0100
Message-ID: <622d87eb-f189-a2f0-281e-a0d4c1a04293@samsung.com>
Date: Wed, 4 May 2022 10:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 05/16] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, <jaegeuk@kernel.org>,
 <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>, <mcgrof@kernel.org>,
 <naohiro.aota@wdc.com>, <sagi@grimberg.me>,
 <damien.lemoal@opensource.wdc.com>, <dsterba@suse.com>,
 <johannes.thumshirn@wdc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
 <clm@fb.com>, <gost.dev@samsung.com>, <chao@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <josef@toxicpanda.com>,
 <jonathan.derrick@linux.dev>, <agk@redhat.com>, <kbusch@kernel.org>,
 <kch@nvidia.com>, <linux-nvme@lists.infradead.org>, <dm-devel@redhat.com>,
 <jiangbo.365@bytedance.com>, <linux-fsdevel@vger.kernel.org>,
 <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <1e3afa38-0652-0a6a-045c-79a0b9c19f30@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzved937152zXtBkuekK26VpxIUYvZcphHQ+Z5xUZwJmUVD3kOU
 jbUx0lADAe9cCAOZxCiHScoAmTIEhqC2jiG/mjCgtUJDoHTChANOfpjGftjx3+f7/Xw/3+/n
 89xD4T715GoqWZzGSsXCFAHJIxpM8+ag05ulCa/bjwYhXacJR9VDBSQ6NTmPoy5VD4aKCr7j
 osUeM45aHWUcdHMuC0Pa6jYMjerUOMq7PkmgfxW3lno5wzh6NByCioyDAI0NqDHUagtEfSOV
 XNT34zbU0tpBIEvz9yTSnBvjIuWxWRxZlWMAFbbrOaj2/gMC3bD5h/kzlv73mcc3akimMNvB
 Zcy3LhGMpUfO1FUdJ5kzmSqc0Vd8w1wpn8aYK79nksyJbAfJGHJvc5gHVwdIRlc/QDBK/SUO
 M133wofeu3hvJ7Ipyems9LWtX/D2lo5PAYmWOGDNrsUyQQOuAF4UpDdCRYWBUAAe5UNXAni5
 fIHrLmYAPKb/08NMA1jTksV5Kvnb0YW7ifMANud8i/0/lVvi8BTNAJ4vriMVgKL49FZoOhfg
 VBP0y7DAft+1iU97w47SUcKJn6Pj4Cl1N+nEK+lPYbOtw9XHaT9oG9W4dvrSxRhsVY64TuP0
 TRw+mbFynQdIej3MOs51CrzozVCjmiXd4nUwt3GR68YvwuzLZZ7UL8GT1n7MjQ/DC6ZurhuP
 8uCAJsONI2FJVaEn8kpob6/3zDwPnxg0Hm0GHLMuuvxAOgfAAoPOFRgumcjvTnHPvAvbfpgg
 3O0V0Drh7bazAhY1lOBK8Ip62VOol0VWL0ugXpagHBBVwI+Vy0RJrCxUzH4VLBOKZHJxUvCe
 VFEdWPrYXY/bZ5tApX0q2AgwChgBpHCBLz/iJ0mCDz9RePBrVpoaL5WnsDIj8KcIgR9/T/JF
 oQ+dJExj97OshJU+ZTHKa3UmturNwDv3tsxz+hQWfpjGL38h12oeDe8VzeVcN8g+2VB8cEd1
 VPpwqONq3OB8d/oI7VvGjz8UvGbur5jmkAMhPdHypi/PGvXjv9EbIy1hn0cm3k3cHl70rIUq
 vbOlzVK1wX7C1PhWzcevXlM1jU3GTkb1SzqJqLWH/ni4I+ZhzMSvvdr8k0PP5Grv5e3cF3i0
 9vSsNTYnL+5aAl5/VyuwdcZ/FNQXe2Rn+KYP3kgfXDBHrNtvmBFJPzu7NuTnLvk2r4Vib+Oq
 XnXG7sWKR8ObJsY5ksNlv6h0LalaxTD9nnKoxhJwJO1ix75+Xdg/obejixpLpiOmxLpdGWfK
 L0S/4797TYBtu4CQ7RWGrMelMuF/CvwJpUcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsVy+t/xu7rzrIuSDA7fE7BYf+oYs8Xqu/1s
 FtM+/GS2OD31LJPFpP4Z7Ba/z55nttj7bjarxYUfjUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
 Wh4yW/x5aGgx6dA1RounV2cxWey9pW1x6fEKdotLi9wt9uw9yWJxedccNov5y56yW0xo+8ps
 cWPCU0aLicc3s1qse/2exeLELWkHaY/LV7w9/p1Yw+Yxsfkdu8f5extZPC6fLfXYtKqTzWNh
 w1Rmj81L6j12L/jM5LH7ZgObR2/zOzaPna33WT3e77vK5rF+y1UWjwmbN7J6fN4kFyAYpWdT
 lF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx881HxoKV
 LBU3mtcxNTBuY+5i5OSQEDCRePbuNJDNxSEksJRRYv3Kw6wQCRmJT1c+skPYwhJ/rnWxQRR9
 ZJRYd/cyI4Szi1HiyeXjTF2MHBy8AnYSx5YpgDSwCKhI9L96DTaIV0BQ4uTMJywgtqhAhMSD
 3WfB4sIC0RK7bp0EizMLiEvcejKfCWSmiMAUJom9Ex6DncQscIFZ4v+XG+wQ2z4wSqw53MoM
 so1NQEuisRPsPE4Ba4n5U7+yQUzSlGjd/psdwpaXaN46G+pPZYnJN64wQdi1Eq/u72acwCg6
 C8mBs5AcMgvJqFlIRi1gZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRmOi2Hfu5eQfjvFcf
 9Q4xMnEwHmKU4GBWEuF1XlqQJMSbklhZlVqUH19UmpNafIjRFBhKE5mlRJPzgak2ryTe0MzA
 1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBSVAilemPr2j52pmLFi7XsNpy
 iHn21/UKftuWXVmtLcfCwGrxp4Dv6mIHxoWLInzFlTbsE3xftUV1+92AHcsd2p7cX3s8TWqq
 8sXPMtJXG5TshUyv739kY6q7+pi80sVX91mb/qotVQ/Tv6Js+fborV/5DWl7T07QTG/7l/Po
 nPfb+C93lprc9+N6v6xrrd3BXcs8ty/YmxkbcC79qUeSJaO56HJBlUOHwqTjJxicffp50YSX
 B9imvfR80ResNlv37kx3lgP+xZt/saxaOa163itL+7sa4tsqzXrM+xlCS1U3Vjz3ffNEu+7O
 ucWNR9j6Y8vc/m794Srtt/WBisvqvb+ZVERmGLV6/FR60zLXarYSS3FGoqEWc1FxIgBxSFeX
 /QMAAA==
X-CMS-MailID: 20220504083854eucas1p27a878ea3b3c156361b1985e011e789d7
X-Msg-Generator: CA
X-RootMTR: 20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160301eucas1p147d0dced70946e20dd2dd046b94b8224@eucas1p1.samsung.com>
 <20220427160255.300418-6-p.raghav@samsung.com>
 <1e3afa38-0652-0a6a-045c-79a0b9c19f30@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_013901_787777_226725E4 
X-CRM114-Status: GOOD (  10.98  )
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


On 2022-05-03 18:50, Bart Van Assche wrote:
> On 4/27/22 09:02, Pankaj Raghav wrote:
>> -    sector &= ~(ns->zsze - 1);
>> +    sector = rounddown(sector, ns->zsze);
> 
> The above change breaks 32-bit builds since ns->zsze is 64 bits wide and
> since rounddown() uses the C division operator instead of div64_u64().
> 
Good catch. I don't see any generic helper for rounddown that will work
for both 32 bits and 64 bits. Maybe I will open code the rounddown logic
here so that it works for both 32 and 64 bits.
> Thanks,
> 
> Bart.

