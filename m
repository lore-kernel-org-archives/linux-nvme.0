Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502CEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JC1ItAosJqxK5KJWop6xtanFugsPBoFSXXvYFLcmSnM=; b=GZTbVTE2iS/AD2
	kfZeaI9D6p+VR8J3Z9na2C6eS3mMAu/tiOMiNtA4wVuWgv0XABfszlhBAtVNFT4OfMXjUp30nboQt
	LJmISFKRNO2vaN4CWpDqE+xRzbBg0ETJdpcleyaRQGTjEqY9xoF1eFDtkIYB2fK2K3OXdmlKJfvap
	A0C69baN2lHPA7Iu0YCzrY56eImeoqGaPrFVWGqh0jWwVA5zePZ+JH/2yhJnEyeD7h5Uo4QSOgJY1
	/zOhPdBpgfhWVobjMqKlrIl4R1UMRxp5kix12YqyiXWrgiV8dz+oxFlwG87NNAC7iRuPf6WSw44qc
	37Wgdk2It1A/JOIDps+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUQmj-00CTh5-Gs; Wed, 16 Mar 2022 10:21:41 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUQmf-00CTgL-P6
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 10:21:39 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220316102125euoutp017ad69a9dddf480dc19134226db379ac5~c1UvfvFEs0344303443euoutp01c
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 10:21:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220316102125euoutp017ad69a9dddf480dc19134226db379ac5~c1UvfvFEs0344303443euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647426085;
 bh=JC1ItAosJqxK5KJWop6xtanFugsPBoFSXXvYFLcmSnM=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=HFrLhQ93KbyehE8EYLZ2A+p19gE4SipeOHdFwoMsxmfy+evX4dK+mDJCP+s0iWg++
 ZVD0fgYVDs/7MhUE1RffGuTKLoWRsBs9+GvqexbC+pX9EKZ55LcHTx4tIP1fMauw4w
 sNvNq+M2TCxyZqWw851YKG0iHy5OKM0QfgJnLnMQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220316102124eucas1p14f5429b5478470ed09aed51fcdce4885~c1Uu52-l00578805788eucas1p10;
 Wed, 16 Mar 2022 10:21:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.AE.10260.42AB1326; Wed, 16
 Mar 2022 10:21:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220316102124eucas1p261ccb1a8027bc6a44decb1ab68457937~c1UufGVnw1275412754eucas1p2i;
 Wed, 16 Mar 2022 10:21:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220316102124eusmtrp13e3694ab1dfff4c785d53ad71d6b0acf~c1UueUftw0616806168eusmtrp1y;
 Wed, 16 Mar 2022 10:21:24 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-48-6231ba245fe3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.7E.09522.42AB1326; Wed, 16
 Mar 2022 10:21:24 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220316102124eusmtip18ce2cd99d4ed21ea09a44f9bc240c499~c1UuS2rXI0549605496eusmtip1M;
 Wed, 16 Mar 2022 10:21:24 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.212) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Mar 2022 10:21:18 +0000
Message-ID: <093f80d1-580a-11c5-057f-a231ecf99bae@samsung.com>
Date: Wed, 16 Mar 2022 11:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to
 export correct permissions
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens Axboe
 <axboe@kernel.dk>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier.gonz@samsung.com>, Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Christoph Hellwig" <hch@lst.de>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <6e19b134-3ba1-432f-092d-ea526f09ef35@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.212]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7oquwyTDF5ONLFYfbefzeL9wces
 Fr/Pnme2WLn6KJPF3657TBbn3x5msph06BqjxfxlT9ktbkx4ymix5uZTFot1r9+zOHB77Jx1
 l93j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwevc3v2Dx2tt5n9Wg/0M0UwBnFZZOSmpNZllqk
 b5fAlfFg3Wn2gr0sFQ9+HmZtYDzJ3MXIySEhYCLx50gzexcjF4eQwApGiT2zXzBDOF8YJTZs
 +M4E4XxmlJh24T8LTMvPtx/A2oUEljNK7H/rCmEDFfWsyYJo2M0ocfLWHKAiDg5eATuJ5jsF
 IDUsAqoSC3v72UBsXgFBiZMzn4DNFBWIkHh55C8TSLmwQLLEy+uxIGFmAXGJW0/mM4HYIgJ6
 Eldv3QC7lFlgJ4vEwZnPWEHq2QS0JBo72UFqOIE2LT05jRmiV1OidftvdghbXqJ562ywayQE
 lCVer7eB+KRWYu2xM2AjJQR2c0q8PjOXHSLhIvH52Ww2CFtY4tXxLVBxGYnTk3tYIBr6GSWm
 tvxhgnBmAP1+eDMTxAZrib4zORANjhIPT1xmgwjzSdx4KwhxD5/EpG3TmScwqs5CColZSF6e
 heSFWUheWMDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwoZ3+d/zrDsYVrz7qHWJk
 4mA8xCjBwawkwnvmhX6SEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalF
 MFkmDk6pBiblumyRJVfWPzedor/d5fqJ/1+jkk7uN+BjK5nvuGrXs8S7eyflMX2fsfOcWmSe
 lLSWcqpO25/JK1SvRXuKpXO1BnzP/PpwqnuHkXnlBM48158slloHmrs556pUsKlViVyKa0xN
 l6lx+yBlY/DxTsAOzmPCOqHNrMqFC6XCbaY8PmTUcvtCjMWuE28fpLOqc79cXNV/2iHk0Xne
 5TzZR4/fePLYKc3aSk9s+t3Pacp+8pOWqq2a6PFwAXfycecbMU9dg841MsSeC135/1LA0ZL0
 T/OjLiaYrI5nstzJJLgqccGmnLf531Ubbz7W/bX34yaDryZcP5pzrNo93f8o7ONb6Kz0P+7r
 n/rSCzPac5VYijMSDbWYi4oTAffxL0nXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsVy+t/xu7oquwyTDB4uErNYfbefzeL9wces
 Fr/Pnme2WLn6KJPF3657TBbn3x5msph06BqjxfxlT9ktbkx4ymix5uZTFot1r9+zOHB77Jx1
 l93j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwevc3v2Dx2tt5n9Wg/0M0UwBmlZ1OUX1qSqpCR
 X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/Fg3Wn2gr0sFQ9+HmZt
 YDzJ3MXIySEhYCLx8+0HIJuLQ0hgKaNEY88kVoiEjMSnKx/ZIWxhiT/XuthAbCGBj4wSP3uL
 IBp2M0qcOnedsYuRg4NXwE6i+U4BSA2LgKrEwt5+sHpeAUGJkzOfsIDYogIREm3LpoAtFhZI
 lli19ixYDbOAuMStJ/OZQGwRAT2Jq7dusEPEd7JIvJgYArHrK6PEn6lzwHaxCWhJNHaC1XAC
 rV16chozRL2mROv231C98hLNW2czg5RLCChLvF5vA/FKrcSr+7sZJzCKzkJy3SwkV8xCMmkW
 kkkLGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBKaBbcd+bt7BOO/VR71DjEwcjIcYJTiY
 lUR4z7zQTxLiTUmsrEotyo8vKs1JLT7EaAoMoonMUqLJ+cBElFcSb2hmYGpoYmZpYGppZqwk
 zutZ0JEoJJCeWJKanZpakFoE08fEwSnVwCT3pPWgi1dDkM6R+60qahMcprzguXv24+/mDZxO
 h14yzpbvE1Yxjy+fMzHoe19TNsfdyMl1wlu0Y2K6V54qmVu2s3eN5untsm0KJxLN/X/d//x1
 wSn71xvrzS7ZuL9d9KZBVHMnd2PrX0FWxRPdH37MlZv67mlQ39dQgf8cRvG9oQdmiT8K+a8i
 9GGuO+fFgisVFle4k4+LXrwQu+XklybFRB6jxUvneq7O3XbnrOyaU601P2+ctD5Sa+G5O+tv
 +SS+jJ8iB5r/ztKdFuDQnCvJF1+fVWLW1npas7d/Gs9Uxudf98zM8LP+t37V3y0Hzpn1536W
 zWEzPqe/au8N7xtv/z0z9r+s/PEz3/m6pw5KLMUZiYZazEXFiQBxDDinjAMAAA==
X-CMS-MailID: 20220316102124eucas1p261ccb1a8027bc6a44decb1ab68457937
X-Msg-Generator: CA
X-RootMTR: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com>
 <9498d380-0172-dae0-9354-bd4d725fff5c@nvidia.com>
 <6e19b134-3ba1-432f-092d-ea526f09ef35@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_032138_095663_F6556FC5 
X-CRM114-Status: GOOD (  12.56  )
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



On 2022-03-16 10:56, Chaitanya Kulkarni wrote:
> On 3/16/22 02:54, Chaitanya Kulkarni wrote:
>>
>>> +static inline void nvme_set_disk_mode_ro(struct nvme_ns *ns)
>>> +{
>>> +    set_disk_ro(ns->disk, test_bit(NVME_NS_FORCE_RO, &ns->flags));
>>> +}
>>> +
>>
>> Do you have a second caller for above function ?
>>
ATM, no. Open coding them is an option but I don't know if it will be
nice sprinkling the call to set_disk_ro in nvme_update_zone_info.
>>
> 
> Is this function in the fast path ?
> 
No, this is called during init.

-- 
Regards,
Pankaj

