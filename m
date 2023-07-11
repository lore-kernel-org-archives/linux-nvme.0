Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D23FEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i2IUdchmfCNhJEFY1g5H9pkgSjJ3brsoF3svBC/GVJk=; b=gwjy6Ny34c3jeJ
	rLjaHHDjYPGCBh4Hci9v5sLw28Jp7uNN7eDsNjxsfAgWZAwN6vuTp1nzp7ceSng381NkdMfrhLeno
	JSQ/JBqPPNAlaeKsVNFmuSeQqvlNYIgsEP/YXV58VmpzdzJcuY2ven1YorRRPI/vsZik7db+uF4+a
	TVtBN1hd6FmsAOnPs8op/DA0QGPsUAamtuSUzcw9ND2IuLzODPs7WhNDNanIplP0gbDW8rH0Mu+rB
	lAjxHqwA1T89zMwkJLzMVurhb8X2SkjqPHsSWbFdNAQ4qXbp3lQKSyCTiXuEV4MOhIHq/ThcOfZnv
	Jy7uwEZnRu/q5VSsn29w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7Gi-00DvTt-30;
	Tue, 11 Jul 2023 06:54:40 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7Gc-00DvPR-0n
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 06:54:39 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230711065425euoutp028a6c3b36ddd85f4bdcaa9234c89dee01~wvbm0u_yH0416604166euoutp02r
	for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 06:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230711065425euoutp028a6c3b36ddd85f4bdcaa9234c89dee01~wvbm0u_yH0416604166euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1689058465;
	bh=i2IUdchmfCNhJEFY1g5H9pkgSjJ3brsoF3svBC/GVJk=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=sdl3zOgou4O6c0GdhZi03TdjXcIxlfaFxMxaFAiCWSPQCYn/WY9HvaOLVwgRQS6Oo
	 XeOA3rhh+SFlK78QoqtnCZs8MIcalRXZF9u7e3AJ9XiHbjg3TwjHZxi7I4HLpzKrqc
	 Xlf5keK3UbOYotpv0xPo7pwiG54KnBY7ak4Stan4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230711065425eucas1p16e7a56990a99a1af3674578db6232866~wvbmpXl1j2305923059eucas1p1X;
	Tue, 11 Jul 2023 06:54:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 1E.B2.37758.1ACFCA46; Tue, 11
	Jul 2023 07:54:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230711065424eucas1p1a4eb8588703875eeda119e5f176d6ff0~wvbmMYMCK2480424804eucas1p1H;
	Tue, 11 Jul 2023 06:54:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230711065424eusmtrp176aa4eb3b0f3df6c681d14007be41ce7~wvbmLf3s31681316813eusmtrp1I;
	Tue, 11 Jul 2023 06:54:24 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-3f-64acfca1c5dc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.67.10549.0ACFCA46; Tue, 11
	Jul 2023 07:54:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230711065424eusmtip2f31a14cba19983b456f3b0187f1d749b~wvbl8VY8t2797827978eusmtip2e;
	Tue, 11 Jul 2023 06:54:24 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.212) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 11 Jul 2023 07:54:20 +0100
Message-ID: <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
Date: Tue, 11 Jul 2023 08:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.11.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To: Keith Busch <kbusch@kernel.org>, Linux regressions mailing list
	<regressions@lists.linux.dev>
CC: Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Clemens S.
	<cspringsguth@gmail.com>, Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux NVMe <linux-nvme@lists.infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Javier Gonzalez
	<javier.gonz@samsung.com>, =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djPc7oL/6xJMdh8Tchi9d1+NoupjYwW
	b3buYrfYs2gSk8XK1UeZLFZfWM9kMenQNUaLp1dnMVlc3jWHzWL+sqfsFudmLWGx2Pi2g91i
	3ev3LA68HpNmzmD22DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwObR2/yOzeP9
	vqtA8dPVHp83yQXwRHHZpKTmZJalFunbJXBlLDvzgqngpVDFm4t3WBoYJ/N3MXJwSAiYSFxe
	b9PFyMUhJLCCUWL5zIfMEM4XRonDexoYIZzPjBINJ16wdzFygnXM3badCSKxnFHi55NvYAmw
	qvNvFSESuxklFnYfZARJ8ArYSaz6MIMZxGYRUJXonviPHSIuKHFy5hMWEFtUIFqiddl9NhBb
	WCBDYv+nC2D1IgLJEt/W32MDGcossJtFYnHvJ7ChzALiEreezGcCeYJNQEuisRNsJqeAvcSF
	eU+gSjQlWrf/Zoew5SW2v53DDPGzssRrkJ9BnqmVOLXlFtgzEgKPOCX6Ftxgg0i4SEzc8B/K
	FpZ4dXwL1PcyEqcn97BA2NUST2/8ZoZobmGU6N+5ng1igbVE35kciBpHieubprNAhPkkbrwV
	hDiHT2LStunMExhVZyGFxCwkj81C8sEsJB8sYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpec
	n7uJEZj+Tv87/nUH44pXH/UOMTJxMB5ilOBgVhLhLTi4KkWINyWxsiq1KD++qDQntfgQozQH
	i5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDU71vp4b78ZSWbf92rlv/8FtwJO/L/Ucnv/az
	vZkcxFpxs+q/ENdkppf7nty7cPXfDGWDtHWn+ZfmrqqaeNw08Y/G65OZrt/zDouILEtg27XS
	c8bVBx9VtETFJmx+V85+dq1gx/9lv5nP2X569SvsSqP748XaVisF/UzYf5X9/hrN8nnif8fo
	uLxM0R6di2+cDpjeKd1hsb/xu0Wh1t65YqeNgit63df29HyS+yuytFZOyW1jqz4H89quxlSu
	WqeI9Qky3DcLcyUnl8/l3tO4r+j9xCJz7SVtPya+dP5os2KeBP++5/5TQk9eidiSmqWZFxvD
	c2qSx6Q63tJbMoV5qWdj1i1L3XGfVaOG0ezYMyWW4oxEQy3mouJEADURdTfuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xe7oL/qxJMVh7SMdi9d1+NoupjYwW
	b3buYrfYs2gSk8XK1UeZLFZfWM9kMenQNUaLp1dnMVlc3jWHzWL+sqfsFudmLWGx2Pi2g91i
	3ev3LA68HpNmzmD22DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwObR2/yOzeP9
	vqtA8dPVHp83yQXwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTm
	ZJalFunbJehlLDvzgqngpVDFm4t3WBoYJ/N3MXJySAiYSMzdtp2pi5GLQ0hgKaPEwZ/fmCES
	MhIbv1xlhbCFJf5c62KDKPrIKPF4/n6whJDAbkaJtt2OIDavgJ3Eqg8zwJpZBFQluif+Y4eI
	C0qcnPmEBcQWFYiWWP35AlivsECGxP5PF8DqRQSSJb6tvwe2gFlgN4vE4t5PjBDbNjJJLLrX
	CFbFLCAucevJfKBbOTjYBLQkGjvBFnAK2EtcmPeEEaJEU6J1+292CFteYvvbOcwg5RICyhKv
	19tAPFMr8fnvM8YJjKKzkJw3C8mCWUgmzUIyaQEjyypGkdTS4tz03GJDveLE3OLSvHS95Pzc
	TYzAtLHt2M/NOxjnvfqod4iRiYPxEKMEB7OSCG/BwVUpQrwpiZVVqUX58UWlOanFhxhNgWE0
	kVlKNDkfmLjySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYlqeL
	z3pRvd5Wb8+H00k+hY83BGZVByo+Lns3ryUqlm1B3kMTr5915Yp+F+NWqJS+3rU75Y1m8dtO
	lxl5nw9ypr68odLZyaYrfIZp23+dz0rXr55/sWjO49lX5daKHiqbavNd4ULXgmU/jt5q5XrR
	oO+uNr8rI1VeouLSwx/P11jVPYpMvzj967PICyJegeUys76mmO3ckTj9THnvjZzPEo8uL5p9
	9sv7zA/silvW5cbu/W35ae7ZBcbz+notWBbtkzddcWBa9eGiSQZKK3TknXcwfLtvpBKwdIpw
	dcw//+kPJlU+/PHm7otvWbEOB/9O+PAqLSr79cbNfPm5QVsjjVfLMhq4+O++94/94MpzeUeV
	WIozEg21mIuKEwFwuQCXpAMAAA==
X-CMS-MailID: 20230711065424eucas1p1a4eb8588703875eeda119e5f176d6ff0
X-Msg-Generator: CA
X-RootMTR: 20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
	<ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
	<6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
	<CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
	<ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_235435_699968_91CC91E8 
X-CRM114-Status: GOOD (  24.27  )
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

>> I understand that, but I think we need middlemen for that, as I or Bagas
>> don't have the contacts -- and it's IMHO also a bit much too ask us for
>> in general, as regression tracking is hard enough already. At least
>> unless this becomes something that happen regularly, then a list of
>> persons we could contact would be fine I guess. But we simply can't deal
>> with too many subsystem specific special cases.
> 
> I'm not asking the Linux regression trackers to fill that role, though.
> I'm asking people who experience these issues report it to their vendor
> directly because these device makers apparently have zero clue that
> their spec non-compliance is causing painful experiences for their
> customers and annoyance for maintainers. They keep pumping out more and
> more devices with the same breakage.
> 
> This particular vendor has been great at engaging with Linux, but that's
> not necessarily normal among all device makers, and I don't have
> contacts with the majority of the vendors we've had to quirk for this
> issue.
> 
> We did complain to the NVMe spec workgroup that their complaince cert
> suite is not testing for this. There was a little initial interest in
> fixing that gap, but it fizzled out...
> 
>> Another request came in today, even with a pseudo-patch:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217649
>>
>> To quote:
>> ```
>> As with numerous NVMe controllers these days, Samsung's
>> MZAL41T0HBLB-00BL2, which Lenovo builds into their 16ARP8 also suffers
>> from invalid IDs, breaking suspend and hibernate also on the latest
>> kernel 6.4.2.
>>
>> The following change restores this functionality:
>>
>> File: root/drivers/nvme/host/pci.c
>> Change:
>>
>> -	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
>> -		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>>
>> +	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G, 512G and 1TB */
>> +		.driver_data = NVME_QUIRK_BOGUS_NID |
>> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> Panjaj, okay with this one too?

This looks a like a new device that might have a firmware update. I will ping
internally first.

As you mentioned, the recent addition of globally unique ID check
is breaking a lot of devices because of non-compliant firmware. I will try to create
some awareness about this issue internally as well.

--
Pankaj

