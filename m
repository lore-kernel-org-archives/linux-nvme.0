Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7C0EB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5mNRhFZGrM/jCIw1auytTkl+lvTLo8hxUrbhfaHevLM=; b=G+cK3LwYVd+eP1
	qkqIOollCIj9lb6+Kf4a+KYHozXvwrwsovQPKNSbS0AGOnGiHqwn4jouRrrzqrl54q/0IGmFMmXqM
	evi20x+6hIoJU2bVvPWQsDBK8ZHrJLk6C87ihkesY8KZ9k1RXjAQ1l6FP3Zb3IwBPhKYnr3of5Hfm
	Wm+dUbwr5CNx7Ix/YYabxnscaYgo+0oTvV9Kbo/KVTluwND4ph/PeSJ3+7lcRbgZseBRVJl9LCsBo
	C4WuBHj4lA40XzyFXhhOZR9vKe5vCiV96ywZGQI+7/Tq2igLmc37SJuKK8O91jFAb1aq9YZgjPCo3
	3X75vvm/+Hj6Mt1IXwbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFGsg-0042JA-0q;
	Fri, 30 Jun 2023 16:21:58 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFGsc-0042IS-21
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 16:21:57 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230630162145euoutp020dba799a7cdd003f5eac21f35a55b229~tfE0WwvZ31116711167euoutp02R
	for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 16:21:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230630162145euoutp020dba799a7cdd003f5eac21f35a55b229~tfE0WwvZ31116711167euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1688142106;
	bh=5mNRhFZGrM/jCIw1auytTkl+lvTLo8hxUrbhfaHevLM=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=WmZttr7wGtqWyYhk+S75D0fybBDlq0NX5t+kwBbiSDLOYaqwCTisR0ogncNmIPukx
	 XeNWo64wnBpNaiI9XacBol7OPDyJUl6poR0a8lOmp0T/RUhv3GpVWJxymO5/takMSm
	 NKB4x74mkeC/fy8pGMS5AUGG2+5zoNRtXaNQv1pA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230630162145eucas1p275608589c79e149ae3d9753b8991ab74~tfE0FM4Fb1947419474eucas1p2g;
	Fri, 30 Jun 2023 16:21:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 79.1A.37758.9110F946; Fri, 30
	Jun 2023 17:21:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230630162144eucas1p1e053b0415f16cf1550df35f5098f5a1d~tfEzgk6pF2514325143eucas1p10;
	Fri, 30 Jun 2023 16:21:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230630162144eusmtrp287b545ca3fa80c1dc17375c345ad4201~tfEzf9r5e1899218992eusmtrp2X;
	Fri, 30 Jun 2023 16:21:44 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-50-649f01196283
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.9D.14344.8110F946; Fri, 30
	Jun 2023 17:21:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230630162144eusmtip14150a2ea9d37ed049d87c7af0d70e41f~tfEzQ-LWT0240702407eusmtip1p;
	Fri, 30 Jun 2023 16:21:44 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.231) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 30 Jun 2023 17:21:40 +0100
Message-ID: <50723e0c-370b-7e4f-338c-401998739fba@samsung.com>
Date: Fri, 30 Jun 2023 18:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
	Thunderbird/102.11.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To: Clemens Springsguth <cspringsguth@gmail.com>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"Christoph Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Martin
	Belanger <martin.belanger@dell.com>, Chaitanya Kulkarni <kch@nvidia.com>,
	"John Meneghini" <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, Linux
	Regressions <regressions@lists.linux.dev>, Linux NVMe
	<linux-nvme@lists.infradead.org>, Kanchan Joshi <joshi.k@samsung.com>,
	Jinhwan Park <jh.i.park@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Javier Gonzalez <javier.gonz@samsung.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <CABfnBFoZ=gh2rkY_oYWzjkGcu8HPQ2FqnrnushH0DZFSi8cwOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87qSjPNTDOZMl7NYfbefzWJqI6PF
	m5272C32LJrEZLFy9VEmi9UX1jNZTDp0jdHi6dVZTBaXd81hs5i/7Cm7xblZS1gsNr7tYLdY
	9/o9iwOvx6SZM5g9ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTe48XmmYweu282sHn0Nr9j83i/
	7ypQ/HS1x+dNcgE8UVw2Kak5mWWpRfp2CVwZ8w7eYik4zlTx9tNelgbGX4xdjJwcEgImErce
	X2XvYuTiEBJYwShx4u4pJgjnC6NEw6RdUJnPjBJvD3bCtdyY2cQGkVjOKDFx/ltmkARY1aED
	shCJ3YwSG2ddZQNJ8ArYSWz71gtWxCKgKnFjxSGouKDEyZlPWEBsUYFoidZl98HiwgIZEvs/
	XQCrFxEwkDj66CwjyFBmgScsEuf2bwBLMAuIS9x6Mh/oWA4ONgEticZOdpAwp0CgxMzpZ9gg
	SjQlWrf/Zoew5SW2v53DDFIuIaAs8el5AsQztRKnttwCe1lC4B6nxM3pj1ghEi4Sj6a9ZoOw
	hSVeHd/CDmHLSPzfCbIWxK6WeHrjNzNEcwujRP/O9WwQC6wl+s7kQNQ4Suzet5ERIswnceOt
	IMQ5fBKTtk1nnsCoOgspJGYheWwWkg9mIflgASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k
	/NxNjMAEePrf8a87GFe8+qh3iJGJg/EQowQHs5II7+03s1OEeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MMmkn9lwL/iLWiSfdKFizKFTusE9XdmnOi9M
	m3n+3+7bnpOVnhvX5Ga3zg9qDOvWbm0tdWgwso3Zs77te7XVR7HCcIfSskLRaEerwNCKM7YC
	wUy2mhv/8bD/ZMh+seHH8dknS3zTX1sfS8g94bXqQh/rNqvwmYcXfNn9+d/3RRkTdf2Z5n01
	8T36fMLa2xsqiqO3TWep/PCNIab+yAJTkXY7ZUPGiRWP1vCrFx99ZHL8jv375d/kWB+a+VmG
	xCVLhOgWbnGPXtiXHLrQV+7WP65k2V9eeRv3zfm2jfFF/uTYB5GL5K4VXZukk8R37FNf591T
	zKICbyZ85a7yuqwmq8T9amdNheC79dz6kzbUK7EUZyQaajEXFScCAB9UIaDvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsVy+t/xu7oSjPNTDJ60GFqsvtvPZjG1kdHi
	zc5d7BZ7Fk1isli5+iiTxeoL65ksJh26xmjx9OosJovLu+awWcxf9pTd4tysJSwWG992sFus
	e/2exYHXY9LMGcweO2fdZfc4f28ji8fls6Uem1Z1snlsXlLv8WLzTEaP3Tcb2Dx6m9+xebzf
	dxUofrra4/MmuQCeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSc
	zLLUIn27BL2MeQdvsRQcZ6p4+2kvSwPjL8YuRk4OCQETiRszm9i6GDk4hASWMkpc4oUIy0hs
	/HKVFcIWlvhzrQuohAuo5COjxLv2NewQzm5GieV7msEG8QrYSWz71ssMYrMIqErcWHGIDSIu
	KHFy5hMWEFtUIFpi9ecLYFOFBTIk9n+6AFYvImAgcfTRWUaQocwCT1gkmid0s0JsOMgk8Xvp
	HiaQKmYBcYlbT+YzgZzKJqAl0djJDhLmFAiUmDn9DBtEiaZE6/bf7BC2vMT2t3OYQcolBJQl
	Pj1PgPimVuLz32eMExhFZyE5bxaSBbOQTJqFZNICRpZVjCKppcW56bnFRnrFibnFpXnpesn5
	uZsYgUlj27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHe229mpwjxpiRWVqUW5ccXleakFh9iNAWG
	0URmKdHkfGDayiuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYKrk
	9Zrhddy1e8m/y9PMJgX927xy1ebXYqsnNN0KTJ9wunpvcZucTNe/OO2E7SWONWz9c/xkpGt6
	OJgcHDdZJXp4/GUOK5KeEc7J03+JuUDNUCt88yUt/5/Cu54VupvkH3v8ceoLqYjfe86X8dRn
	hf8Q9RRauuHa9w5t86IpJ/WZOzrcK+5W5c9/rpcf4VGSNfvTsean942lGCfcenu2Uk1h/qev
	XceeTrquv5E1P+N1snPO4ZcXJC1Y2O8f/7ntpYauCBfLtBW5e6d1uFp+ZLkY84nBZluBaZva
	HL/qhgufHnnpOsrczfkyXWz+QX3WTZPl2Y88NS354976ULfw6NPatEWBOppSt0slOfM6lViK
	MxINtZiLihMBZ4upLqMDAAA=
X-CMS-MailID: 20230630162144eucas1p1e053b0415f16cf1550df35f5098f5a1d
X-Msg-Generator: CA
X-RootMTR: 20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
	<CGME20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5@eucas1p1.samsung.com>
	<ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
	<9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
	<CABfnBFoZ=gh2rkY_oYWzjkGcu8HPQ2FqnrnushH0DZFSi8cwOg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_092154_930958_8CD33F06 
X-CRM114-Status: GOOD (  11.50  )
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

On 2023-06-30 17:18, Clemens Springsguth wrote:
> Hi Pankaj,
> 
> i would be very very grateful if you would create and submit the quirk
> as a proper patch.
> 

No problem. I will send something soon, but could you test it and
give me a tested-by tag when I send the patch? I don't have that
model at my disposal.


