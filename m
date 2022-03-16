Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ke3F/QH5LZx+8vzBu9tnS3HmhafDqNbHp36fj6LOXBk=; b=J1dOHfovdocLF1
	mJdgwiTLQkG1MByJFiMDtqVSSN4c0pMQBXyGh3AsQAJqtgBRo0pYJnbs8pfVuJbXuJTHabaTgc3yi
	FC3/5I24ck35ZcWUKl7OHshlzE8W8MQrNAIKUTC+NN1txMBOlbOjDTPVi0vSJWLF9blvS5oNcD4PA
	OnFmDGkbkBAlaBA1u2fWV9zVFo+iBK7PlhpAqiw1p/mPx/zrNi20eFR6X0t8ZLc3NspTGEK4D6X1t
	haAVRzzA5cs5JRkecwywNavK2OqQ8nR5MnwH8OeeCvCpS/yQEifMuwvVjdjJgtTpvY4WfeDCezYT1
	p01DnN5NlijR7deU0ZRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUXwp-00E3ZL-93; Wed, 16 Mar 2022 18:00:35 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUXwl-00E3YY-Ot
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 18:00:33 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220316180027euoutp0120ef20d38d0aeb426459d2441c980073~c7lhwdmbP1319613196euoutp01q
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 18:00:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220316180027euoutp0120ef20d38d0aeb426459d2441c980073~c7lhwdmbP1319613196euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647453627;
 bh=Ke3F/QH5LZx+8vzBu9tnS3HmhafDqNbHp36fj6LOXBk=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=eJKLNvf/9kSv2OKf3+q64IEfmyigvyZ4WaZliEu6Icct1+XjrHEd8exYMDR4hDh1C
 7FOmkqRoR31Vuezs8f0hiT09L6m/lj5Y77WqzvkskMTkoxQqQl86Vew+8FZ/BfYrlb
 abt7vbJCwRhJKiHZwdk6sjroWgOPh6ingzrMFN/M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220316180027eucas1p13313fc15f7e4f7a1ab4bdbc306a6a634~c7lhg1IvY2564225642eucas1p16;
 Wed, 16 Mar 2022 18:00:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.2C.10009.AB522326; Wed, 16
 Mar 2022 18:00:27 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220316180026eucas1p286f197a6ca1f5f351bd54b86635141ce~c7lg-0CRU2042620426eucas1p2h;
 Wed, 16 Mar 2022 18:00:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220316180026eusmtrp1b7e08d22179d4e147705014133f29242~c7lg-Dn2R1991819918eusmtrp15;
 Wed, 16 Mar 2022 18:00:26 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-03-623225bab14f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.51.09522.AB522326; Wed, 16
 Mar 2022 18:00:26 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220316180026eusmtip1938025a3129fb42994831021e79d4f1f~c7lg1AQLn0639506395eusmtip11;
 Wed, 16 Mar 2022 18:00:26 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.179) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Mar 2022 18:00:21 +0000
Message-ID: <808f15f4-c0c0-e436-447b-878f2c76e6b1@samsung.com>
Date: Wed, 16 Mar 2022 19:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to
 export correct permissions
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, "Jens
 Axboe" <axboe@kernel.dk>
CC: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, "Johannes
 Thumshirn" <johannes.thumshirn@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <2d52a62b-209f-e68c-c2f9-dd56af17a18c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.179]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djP87q7VY2SDPp1LFbf7WezeH/wMavF
 77PnmS1Wrj7KZPG36x6Txfm3h5ksJh26xmgxf9lTdosbE54yWqy5+ZTFYt3r9ywO3B47Z91l
 9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm0dv8zs2j52t91k92g90MwVwRnHZpKTmZJalFunb
 JXBlLPpymq2gi7Vi4skVbA2Mf5i7GDk4JARMJNr/cXUxcnEICaxglHjWvJ4FwvnCKDHn1z8m
 COczo8S0Nd/Zuxg5wTp+rexghEgsZ5RYuessC1zVrnkboVp2M0rsXLqDEaSFV8BOYv36NhYQ
 m0VAVeL7jkssEHFBiZMzn4DZogIREi+P/GUCOUpYIFni5fVYkDCzgLjErSfzwWaKCKxgkli1
 ZyEriMMscJBJ4uqZ9awgDWwCWhKNnWDncQLtmre4gQWiWVOidftvdghbXmL72znMEC8oS3Re
 fcQEYddKrD12Buq1/ZwSL37GQ9guEvOnd0DVCEu8Or4FqkZG4vTkHrCPJQT6GSWmtvxhgnBm
 MEr0HN7MBAlWa4m+MzkQDY4SD09cZoMI80nceCsIcQ+fxKRt05knMKrOQgqKWUh+noXkhVlI
 XljAyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMKmd/nf80w7Gua8+6h1iZOJgPMQo
 wcGsJMJ75oV+khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5O
 qQYmS37nlChO6W4lL9mjcuIJbLW1qxhE5k8/ptg6dbp+5fbgJ+I9zxbPP9q5870r+8VTXQ8u
 Mq6ZOduqTSvxUNP2QLU76xJ59fU+eH687/Bx59I/u5+zGs5b/2fXF6nHb9Ybflzk6rZDa3rD
 8+72pbd+8KR1JF35Fm16JGlaR9ah71ebWVbP3nDmGlsQd8MEiU1vDPp0HqZHnslmzbqhlBYR
 0xDxyFrg3jmb+L5nE7aGP/76/pT/6ZdtfTpLHwRcl9+6faPznJNuT43tpq8LDTp7ocs48PuN
 M1tTTFcISqy5vy7q/xeLZq6N8rq1MkUzfzenKSQHZn7jjhbIOPL9oY/ztMP34yctFTUsd7tr
 IHVSX4mlOCPRUIu5qDgRAJW2/+nZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7q7VI2SDL58lLBYfbefzeL9wces
 Fr/Pnme2WLn6KJPF3657TBbn3x5msph06BqjxfxlT9ktbkx4ymix5uZTFot1r9+zOHB77Jx1
 l93j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwevc3v2Dx2tt5n9Wg/0M0UwBmlZ1OUX1qSqpCR
 X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7Hoy2m2gi7WioknV7A1
 MP5h7mLk5JAQMJH4tbKDsYuRi0NIYCmjROfOl0wQCRmJT1c+skPYwhJ/rnWxQRR9ZJSYf+oR
 G0hCSGA3o8TJE4EgNq+AncT69W0sIDaLgKrE9x2XWCDighInZz4Bs0UFIiTalk0B2ywskCyx
 au1ZsDnMAuISt57MZwJZICKwgkli1Z6FrCAOs8BBJomex4+YIFYfZJT4Nfc4UAsHB5uAlkRj
 J9h5nECb5y1uYIGYpCnRuv03O4QtL7H97RyoP5UlOq8+gnqtVuLV/d2MExhFZyE5cBaSQ2Yh
 GTULyagFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAtPBtmM/N+9gnPfqo94hRiYOxkOM
 EhzMSiK8Z17oJwnxpiRWVqUW5ccXleakFh9iNAWG0kRmKdHkfGBCyiuJNzQzMDU0MbM0MLU0
 M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYCr7IKDCHSjBmJez6+C+iKc+czm23Fbbuz/g
 cNy5Ocvqjt5mO2IVl7TjxM9fNYHtjT8KlWIvzNrnFmkVX6llvN1FSuiS0bN5fy/u5zl4PFwu
 eIYtv+hp1rLLtzYfuWU3x/d6se0fq4aX7za/dyuQCJMz+M21XWnOt+mvJ6n6KN47KHq1g+3l
 c69NavIXOLujjjPxGZs9YzOQd99zKurOlqpYJ93PjRZSSxJuTfrxmSn1hv1rf6t7d0MU95yP
 yZxfFRCzq2Hx7z06BRfUzc5MjNDL6l3Y7P3E0OdSyNHLi1/fWXHUe9rE2YYfTBUiHt0yWFad
 ocxfseTh6RVeMi0KHI/c1P836EhUCj/OEvsQw6rEUpyRaKjFXFScCABTsfqlkAMAAA==
X-CMS-MailID: 20220316180026eucas1p286f197a6ca1f5f351bd54b86635141ce
X-Msg-Generator: CA
X-RootMTR: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
 <2d52a62b-209f-e68c-c2f9-dd56af17a18c@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_110032_211104_F1E55702 
X-CRM114-Status: GOOD (  13.85  )
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



On 2022-03-16 17:52, Chaitanya Kulkarni wrote:
> On 3/16/22 02:34, Pankaj Raghav wrote:
> 
> what kind of testing you have done on this patch ?
It was tested on a real HW. QEMU also does not expose any option to
disable append to this path. The only way is either have a real HW that
doesn't support append or patch QEMU.

> do you have blktests which addressed this behavior ?

I thought about adding a blktest but there is no way AFAIK to disable
append on a HW via any block interface. We probably need some sort of HW
specific handling for different zoned devices. Let me know if you have
some ideas there.

-- 
Regards,
Pankaj

