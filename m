Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81734C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N35IlqLKRrslZIjxRi5FIgTNrdBSdEWJsfZyIzTDGlI=; b=OS4rQ/ZAg/rLT6
	uzgLxz4QdD5OaJ4eWLLLXVbhGbgN50uFHoGNTM0t39xWmrCZch+UtSmOu+nruH102okW7DQJ82wRK
	R9+toxMwTaO2iebtend0LvhWgbq/gxE6j1J7ScyhkMnRgYz5CkXgtsyUT422hsqDVh9UnVkufzEJ9
	Zz3CN9iOkXSnTL5DBMIu5KvgfQ/67WOJa3TXtY9vnXF/zXdAti50Y+GuuKwiK2R1wbzOiZAyG7Xw5
	NI59xigKdAjuGp7ZT0J0C9PZah/7C6505kgiPdi4g6DSD5pSLNq0uMaKmQs8xi9+MXjXAWPVmBDMk
	lZWQpCot5Ht3/Rfnvrig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSIMt-00CqyE-Du; Thu, 10 Mar 2022 12:58:11 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSIMp-00Cqw2-LN
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:58:09 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220310125805euoutp028db32494001da0e41e204ba03e0f07f9~bBl0G3xsX0364903649euoutp02J
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 12:58:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220310125805euoutp028db32494001da0e41e204ba03e0f07f9~bBl0G3xsX0364903649euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646917085;
 bh=N35IlqLKRrslZIjxRi5FIgTNrdBSdEWJsfZyIzTDGlI=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=ggoEePayTuO1h9keO211/7cLmn7kVyS4YzOE5seo7G9J3Q0/HQ6t6FmkhZI53oZ4Q
 qlWAKCj7qdNkD9KwXjWBTiV9VWEXyi0rkOwqZmb6a+NOYqKJ9/pqVo4FWKmJe7wr9+
 z0llwT+8buhCh2buayIotqerlnrBiG+4YFdrf8vk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220310125804eucas1p2de33289e5874d5a4cae987749d68ccef~bBlzqwGbp3209332093eucas1p2I;
 Thu, 10 Mar 2022 12:58:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.A7.10260.CD5F9226; Thu, 10
 Mar 2022 12:58:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220310125804eucas1p15d910568be986b2636b31f475cff891b~bBlzGBn2q1229012290eucas1p1j;
 Thu, 10 Mar 2022 12:58:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220310125804eusmtrp25ea510e27d00544e9932d55af2da5ace~bBlzFInZK2916829168eusmtrp2G;
 Thu, 10 Mar 2022 12:58:04 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-48-6229f5dcb123
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.F4.09404.CD5F9226; Thu, 10
 Mar 2022 12:58:04 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220310125804eusmtip11b2448d11fd62a8a9e9eaabd7e1060b6~bBly4q-oI2308923089eusmtip1f;
 Thu, 10 Mar 2022 12:58:04 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 10 Mar 2022 12:57:59 +0000
Message-ID: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
Date: Thu, 10 Mar 2022 13:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier.gonz@samsung.com>, <jiangbo.365@bytedance.com>, kanchan Joshi
 <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Damien Le
 Moal" <damien.lemoal@opensource.wdc.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220310094725.GA28499@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7p3vmomGeyfqG+x+m4/m8Xvs+eZ
 LVauPspk0XPgA4vF+beHmSwmHbrGaLH3lrbF/GVP2S0mtH1ltrgx4SmjxZqbT1ks1r1+z+LA
 4/HvxBo2j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9swEo13qf1ePzJjmP9gPdTAFcUVw2
 Kak5mWWpRfp2CVwZG5Z+Zy5YwVux7MlmtgbGPVxdjBwcEgImErPuSncxcnEICaxglFi/cwMb
 hPOFUWLOlt8sEM5nRomDJ76ydjFygnVMeT0PKrGcUeJ1D0wLUNWfqSeZIZzdjBJb5n5nBmnh
 FbCTOL38LwuIzSKgKrH6yDI2iLigxMmZT8DiogIREi+P/GUCsYUFvCQ63q5lB7GZBcQlbj2Z
 DxYXEVCSePrqLCPIAmaB/SwSC3q6WUG+YBPQkmjsBKvnFNCRmNe/gwWiV1OidftvqDnyEtvf
 zmGGeFpZ4vV6G4hvaiXWHjvDDjJSQuAwp8TkOc3sEAkXiTe3zkO9LCzx6vgWqLiMxP+dIPeA
 NPQzSkxt+QPlzGCU6Dm8mQlig7VE35kciAZHif/fp7FChPkkbrwVhLiHT2LStunMExhVZyEF
 xSwkL89C8sIsJC8sYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZjmTv87/nUH44pX
 H/UOMTJxMB5ilOBgVhLhbQrVSBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7
 NbUgtQgmy8TBKdXAtNFJM+xxyWyX418jTptcnXeevazF0YCRk7W47lOF4WXjtISOxvU+VdpS
 wkc36yzfvl1i1WydJ3PT95pxWie6dn9rfbW254AHR+PfzHlvbWvmb7RZIrXHOKlA3p+JXeqq
 g6eteqLQrM0lqY/nb7i14nHoz51Nc7UPNVmLffDnsAo0joi5w5Yx5crsX2+iJBkVf/HHXol7
 6hDm/Wz2F9Hgqkbn9M9Vxxef3h5VOb024P6vhPTFk/jdp8lKOMSe/7Jdst3+kMS7EJ+Mo90W
 s+94cedeXHe22GvSMvfv/IWnTn4/luuboZkaJrv35SwpZyVH+169wz2nYgKr+iONS5//MXmw
 M75LRjvx5t5IfwclluKMREMt5qLiRABGbVtX4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4Xd07XzWTDPY3cFqsvtvPZvH77Hlm
 i5WrjzJZ9Bz4wGJx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5MeMposebmUxaLda/fszjw
 ePw7sYbNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbADKtd5n9fi8Sc6j/UA3UwBXlJ5N
 UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GhqXfmQtW
 8FYse7KZrYFxD1cXIyeHhICJxJTX81i6GLk4hASWMkqsObCJCSIhI/Hpykd2CFtY4s+1LjYQ
 W0jgI1DRUw6Iht2MEvN2PQBL8ArYSZxe/pcFxGYRUJVYfWQZVFxQ4uTMJ2BxUYEIibZlU5hB
 bGEBL4mOt2vBFjALiEvcejIfbLGIgJLE01dnGUEWMAvsZ5FY0NPNCrFtA6PE3E/rgKZycLAJ
 aEk0doI1cwroSMzr38ECMUhTonX7b6ih8hLb385hBimXEFCWeL3eBuKZWolX93czTmAUnYXk
 vFlIzpiFZNIsJJMWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECEwN24793LKDceWrj3qH
 GJk4GA8xSnAwK4nwNoVqJAnxpiRWVqUW5ccXleakFh9iNAWG0URmKdHkfGByyiuJNzQzMDU0
 MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYNpbf0FG0fWe5P91P1lVvq9ssUz5
 tOBMo/pCp0jGzbMcg/+1hByZ+GrRgxUeU0MmJys/XpZdxC39i01cc90sLZ9rNUk3GEV4XjwK
 unP3uVL4FNVb20+tKzinFzo/JP6wX/nP5ZYHOQPPW4hJCSgefbWk7vmVFeyBLgXmVz7sCvZP
 iWNsXSq3JrIq4eJt88nKtj29W2bdWnIuJGi3oL3gzm5jn1O2ph/d1xtu8dzCKvvB2iT/S+PM
 nT9lP256Xv256+2uu5+cb1+orxKQFl7tBgwJ1yhr1tPf+XsLjyzctXi/scn2jXYpjur8m7bu
 L10qEFi6OKwujj/KhKMjbcX0rf+Lbu++V3VDk3XulJv6uUosxRmJhlrMRcWJACHY9F2WAwAA
X-CMS-MailID: 20220310125804eucas1p15d910568be986b2636b31f475cff891b
X-Msg-Generator: CA
X-RootMTR: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165414eucas1p106df0bd6a901931215cfab81660a4564
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_045808_006243_26C9A80A 
X-CRM114-Status: GOOD (  22.49  )
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



On 2022-03-10 10:47, Christoph Hellwig wrote:
> This is complete bonkers.  IFF we have a good reason to support non
> power of two zones size (and I'd like to see evidence for that) we'll

non power of 2 support is important to the users and that is why we
started this effort to do that. I have also CCed Bo from Bytedance based
on their request.

> need to go through all the layers to support it.  But doing this emulation
> is just idiotic and will at tons of code just to completely confuse users.
> 

I agree with your point to create the non power of 2 support through all
the layers but this is the first step.

One of the early feedback that we got from Damien is to not break the
existing kernel and userspace applications that are written with the po2
assumption.

The following are the steps we have in the pipeline:
- Remove the constraint in the block layer
- Start migrating the Kernel applications such as btrfs so that it also
works on non power of 2 devices.

Of course, we wanted to post RFCs to the steps mentioned above so that
there could be a public discussion about the issues.

> Well, apparently whoever produces these drives never cared about supporting
> Linux as the power of two requirement goes back to SMR HDDs, which also
> don't have that requirement in the spec (and even allow non-uniform zone
> size), but Linux decided that we want this for sanity.
> 
> Do these drives even support Zone Append?

Yes, these drives are intended for Linux users that would use the zoned
block device. Append is supported but holes in the LBA space (due to
diff in zone cap and zone size) is still a problem for these users.
-- 
Regards,
Pankaj

