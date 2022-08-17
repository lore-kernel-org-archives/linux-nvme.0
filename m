Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D644BC25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 07:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a1B6QBU92IfBgEiYWUxub5bQWgdRQ520Ci1+QX1ZX3g=; b=F6ytI05AT+/ohG
	8pJr8Ox5Z0onXKjRxkQlTQilsXM0MnXXl/VyKJ1tURWkhl8JSPJGYtbjvy341RbindPaIC8xaSbt+
	4eXJK7A5jjGqhGOdIBNI+OsGOGlvMjwxYtzS5OyaSH7yKT0eVAieFor+L/ceABcHNotLmh1beOp5D
	iQny15YIAy+zRTyvD8u5cqMEIlymzjBGk4WpsA/5OHn1B1rWVMDMZ7la5PHIjB33O/YFkNXVm8TXR
	v78dzNLP4dbDWgayyYQRKsaOinkN3K8FMBs+NKb5V0CS0SCt5DvdcV55LeYLO1jZ4TdbuiKMJGdu+
	M6x5fTJNZEOX/3MJMokA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oODUE-00DGcR-9u; Wed, 17 Aug 2022 07:29:10 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oODUA-00DGTT-ID
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 07:29:08 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220817072855euoutp01558bf54e67ee9ffa0062274ea6853caf~MEUGU_8-61959719597euoutp01d
	for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220817072855euoutp01558bf54e67ee9ffa0062274ea6853caf~MEUGU_8-61959719597euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1660721336;
	bh=a1B6QBU92IfBgEiYWUxub5bQWgdRQ520Ci1+QX1ZX3g=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=NzKC5Iykk+NP4BGfN80lQHB8KnSo5mpWDL0vTrc2MqA1Z/enTXQdeFSsgCi0Ntcf9
	 2Z5wyr/R9okS14D6fUx6hncHsLWTv/PL3GiWvtpzyqqdIqmBL7ETSLWyE1hJDyqFeU
	 q4qG80Ca7IjWBvuuyp4776t+gGmPuG7ew/lsSVlI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220817072855eucas1p2acc0819c2c8862ae7eeacae34c59d1eb~MEUGAaUIp0668506685eucas1p2h;
	Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 01.57.09580.7B89CF26; Wed, 17
	Aug 2022 08:28:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220817072855eucas1p1d63c062dfaa56968a50d2572c7d31b0e~MEUFllKjs0374303743eucas1p1c;
	Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220817072855eusmtrp26a7f38ee68b50b05b3161b2c6d0e6279~MEUFkjNoF3100331003eusmtrp2g;
	Wed, 17 Aug 2022 07:28:55 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-fd-62fc98b770e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.81.09038.7B89CF26; Wed, 17
	Aug 2022 08:28:55 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220817072854eusmtip2106bd6d4c9bfba353efa9be2336c3b63~MEUFa5wJD1646316463eusmtip21;
	Wed, 17 Aug 2022 07:28:54 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.74) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Aug 2022 08:28:53 +0100
Message-ID: <fd82adec-1e06-d539-7718-2e08f4999b98@samsung.com>
Date: Wed, 17 Aug 2022 09:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH v10 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <agk@redhat.com>,
	<damien.lemoal@opensource.wdc.com>, <linux-block@vger.kernel.org>,
	<Johannes.Thumshirn@wdc.com>, <bvanassche@acm.org>,
	<matias.bjorling@wdc.com>, <hare@suse.de>, <gost.dev@samsung.com>,
	<linux-nvme@lists.infradead.org>, <jaegeuk@kernel.org>,
	<pankydev8@gmail.com>, <linux-kernel@vger.kernel.org>,
	<dm-devel@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <YvwIvrToFYMDwQoj@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.74]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djPc7rbZ/xJMph1Xd5i/aljzBar7/az
	WUz78JPZ4vfZ88wWe9/NZrXYs2gSk8XK1UeZLJ6sn8Vs8bfrHpPFpEPXGC323tK2uLxrDpvF
	/GVP2S0mtH1ltrgx4SmjxZqbT1ksTtySdhD0uHzF22PnrLvsHpfPlnpsWtXJ5rF5Sb3H7psN
	bB47W++zerzfdxUodLra4/MmOY/2A91MAdxRXDYpqTmZZalF+nYJXBlHui6wF7RwVby5eJCt
	gbGfo4uRk0NCwESibek+NhBbSGAFo8TTPyVdjFxA9hdGiXtr5rBDOJ+BnNaTLDAdf1sWMUEk
	ljNKnGl5wwJXdWXadTYIZxejRP+kPewgLbwCdhK9568xgtgsAqoSb7f+ZYSIC0qcnPkEbKyo
	QKTEmt1nweqFBeIl5nTcBrOZBcQlbj2ZzwRiiwgoS9ydP5MVZAGzwF5miUXn3wNt4+BgE9CS
	aOwEq+cUsJf48KSZEaJXU6J1+2+oOfIS29/OYYZ4QUni6qkT7BB2rcTaY2eg7E+cEqvPhELY
	LhIX7+5ig7CFJV4d3wJVIyPxfyfEPRIC1RJPb/xmBrlHQqAF6OGd68HukRCwlug7kwNR4ygx
	a+VNqDCfxI23ghDn8ElM2jadeQKj6iykkJiF5ONZSD6YheSDBYwsqxjFU0uLc9NTi43zUsv1
	ihNzi0vz0vWS83M3MQJT4+l/x7/uYFzx6qPeIUYmDsZDjBIczEoivIIvfiQJ8aYkVlalFuXH
	F5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYKquefGgzL6HZdtJ694aoUs6
	Dxd0za6L8DMMV6jUj1veE3dsWohgc99WHfvmK5avNjska/xsaE7XXPtTf6n/yy75tro1+fZ/
	+74KWh38u9hNMX3/thPz7tyXnvDres/Ups9vG5o+X023nxh6kdPpa83ECRb9PHud477H2edK
	Pumdcf/s3W/KAutNn0nHWiVV/jrO1vjuo1FX9i/7v8+Ntr5849B20Kjw5pWZQpza8zanyPyd
	eGZNSmNb/u/CKoNw5kUXLC0dOqeeecIqX/Dz7qEzGdxen+Zw/J9szT91oodkmsfiu28Vryw2
	U7A+yLGzNTqDZ1XLxCtmCjrL7h6svfX4362s1EnuNrsWHf363U2JpTgj0VCLuag4EQChxcGd
	/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7rbZ/xJMujax2qx/tQxZovVd/vZ
	LKZ9+Mls8fvseWaLve9ms1rsWTSJyWLl6qNMFk/Wz2K2+Nt1j8li0qFrjBZ7b2lbXN41h81i
	/rKn7BYT2r4yW9yY8JTRYs3NpywWJ25JOwh6XL7i7bFz1l12j8tnSz02repk89i8pN5j980G
	No+drfdZPd7vuwoUOl3t8XmTnEf7gW6mAO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9
	Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwjXRfYC1q4Kt5cPMjWwNjP0cXIySEhYCLxt2URUxcj
	F4eQwFJGiabNvSwQCRmJT1c+skPYwhJ/rnWxQRR9ZJQ4NWkqI4Szi1Hi5Kq3rCBVvAJ2Er3n
	rzGC2CwCqhJvt/5lhIgLSpyc+QRsqqhApMTDZU1MILawQLzEnI7bYBuYBcQlbj2ZDxYXEVCW
	uDt/JivIAmaBvcwScz6dARskJPCFUeJ6M28XIwcHm4CWRGMnWC+ngL3EhyfNjBBzNCVat/+G
	mikvsf3tHGaID5Qkrp46AfVNrcSr+7sZJzCKzkJy3iwkZ8xCMmoWklELGFlWMYqklhbnpucW
	G+kVJ+YWl+al6yXn525iBKaUbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4BV/8SBLiTUmsrEot
	yo8vKs1JLT7EaAoMo4nMUqLJ+cCkllcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpa
	kFoE08fEwSnVwDT9Xfuh3+JFou+m7rt0zyzPVG23xL7rLs37p39/ZGHqsud9RdzBu1O1iiS/
	MfEce7qi0Gv/f9/Ex6IR/4qzhOd5iHovTNFlsW0y4kkTT5kTZ8U+zeDva6FJ3Z/+6D1oOihp
	s12TYeXuxqY5pu9i2O7Ihd6NttrssvpewZl5P2pa577c/WHRjUUH+HS0nE/UnNu3TuPLMotL
	V5N8Fme8b5i65s2jwBc8W95eOtI/TUF9Sicj6ywx9Q3dTWKdx21nh5+yF7i7UDxq1fZ1lQJB
	q855KYimhTo3u/x05Jt9blL7kpMlb+SWbWz6bTsn1uW6YuVEltJZKyPZWNpL5/+LbvmrGf40
	P+Xrr4nfftkv2fFZiaU4I9FQi7moOBEA39Cu9bIDAAA=
X-CMS-MailID: 20220817072855eucas1p1d63c062dfaa56968a50d2572c7d31b0e
X-Msg-Generator: CA
X-RootMTR: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9
References: <20220811143043.126029-1-p.raghav@samsung.com>
	<CGME20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9@eucas1p1.samsung.com>
	<20220811143043.126029-6-p.raghav@samsung.com>
	<YvwIvrToFYMDwQoj@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_002906_936878_1DB2A521 
X-CRM114-Status: GOOD (  17.15  )
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

Hi Keith,

On 2022-08-16 23:14, Keith Busch wrote:
> On Thu, Aug 11, 2022 at 04:30:35PM +0200, Pankaj Raghav wrote:
>> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>>  	}
>>  
>>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
>> -	if (!is_power_of_2(ns->zsze)) {
>> -		dev_warn(ns->ctrl->device,
>> -			"invalid zone size:%llu for namespace:%u\n",
>> -			ns->zsze, ns->head->ns_id);
>> -		status = -ENODEV;
>> -		goto free_data;
>> -	}
> 
> We used to bail out early if the format wasn't supported, which wouldn't create
> the namespace.
> 
> Now you are relying on blk_revalidate_disk_zones() to report an error for
> invalid format, but the handling for an error there is different: the namespace
> still gets created. I'm not sure if that's a problem, but it's different.
That is right but it is not a problem. Once the block layer supports the
non-po2 zone sizes, we don't need to bail out here because it will be
compatible. If unequal zone sizes are found, block layer will report an
error during blk_revalidate_disk_zones() which is the current behavior anyway.

Other checks such as zone operation support are still in
nvme_update_zone_info() resulting in an early bail out if violated.

