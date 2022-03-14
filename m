Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB68C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KIJaCVweHoZjhFIGSZsAjf3T812qqGdYh3qUjM3RdNs=; b=dzPeMqo8ZtrQCb
	AKPRRHkIBFZf49Z0GIFX6b3tystTPVSEsogw4UN9pC+Uky6QRH5yPo24ioFOJB5PYO9tB+QWawRrY
	uZjxpqryHBSLsgDhtb99Hsjmx68XfNTZunlJKUC/zQCFz9syDW23sz2J+Dx3cWgXgwLIPfnsWDoZU
	211cIhODyX79u/jMjA7DLjWKiAA4qJofryZKvmoyd1QsCiFlFnchDSJLjp9wTaUtv3ECscyxURWK6
	6De8KzhANjmZsk04+LJAphUDyVsfhueqyDSOq5T0Yug19pKo/7qgg2Na+QL7+2khwbNDWr8CTvspt
	sQCex8BFw1uvvjMSkCAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTho3-004us7-Fk; Mon, 14 Mar 2022 10:20:03 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nThnz-004upc-M0
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 10:20:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220314101957euoutp02d55ee0d87ea6c4c68bd0ed924d5f524a~cOA4tSNaQ0489704897euoutp02s
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 10:19:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220314101957euoutp02d55ee0d87ea6c4c68bd0ed924d5f524a~cOA4tSNaQ0489704897euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647253197;
 bh=KIJaCVweHoZjhFIGSZsAjf3T812qqGdYh3qUjM3RdNs=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=E+7OdWguuC5C7QnCXr77roV0QmmbgmrXCwBt86IiRoEfSyeyF3JHm6tovPtL50MsY
 s6xy2szEu6tsQ9BDzExpEbsBEOl3wAQSRGR5dQlJRn3HV47Bd2RyvO3h2TPv87+FQd
 Xb1VT4gqQaHz/biqGSf6ZCSsGlB2Hhx9Sdf4GVXU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220314101956eucas1p1a4c478177e1e5e86b1b00270c7f6b1be~cOA4Tr4Yx0126201262eucas1p1q;
 Mon, 14 Mar 2022 10:19:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 8F.5F.10009.CC61F226; Mon, 14
 Mar 2022 10:19:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220314101956eucas1p186805e5613cfcd89693eed5f9e609db5~cOA3zHb0V1212812128eucas1p1d;
 Mon, 14 Mar 2022 10:19:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220314101956eusmtrp1790c3d08a497107e28ab013091e4822b~cOA3yS6jw1125011250eusmtrp1P;
 Mon, 14 Mar 2022 10:19:56 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-84-622f16ccb535
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 50.76.09522.CC61F226; Mon, 14
 Mar 2022 10:19:56 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220314101956eusmtip108396ebb48d47b04562c306802be5ff4~cOA3pBN320207602076eusmtip1z;
 Mon, 14 Mar 2022 10:19:56 +0000 (GMT)
Received: from [106.110.32.130] (106.110.32.130) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 14 Mar 2022 10:19:52 +0000
Message-ID: <0da3c802-33eb-c275-bfd6-70aff6860f6a@samsung.com>
Date: Mon, 14 Mar 2022 11:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Johannes Thumshirn
 <johannes.thumshirn@edc.com>, Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com>, Jens Axboe <axboe@kernel.dk>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>, "kanchan
 Joshi" <joshi.k@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>, "Kanchan
 Joshi" <joshiiitr@gmail.com>, <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220314084449.GA5866@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pnxPSTDB5M0LFYfbefzWLW7dcs
 Fr/Pnme2WLn6KJPFlKtLmSzOvz3MZDHp0DVGi/nLnrJb3JjwlNFizc2nLBbrXr9nceD2uPxn
 P5PHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7ZwOaxs/U+q0f7gW6mAM4oLpuU1JzMstQi
 fbsEroz5jRMYC55xV7R3f2RqYLzK2cXIwSEhYCKxaG1dFyMXh5DACkaJY6e/sEE4XxglPj6Y
 xwLhfGaUeN+3krmLkROs4+KRZkaIxHJGiaUvjjLDVe049IMRpEpIYDejxJvrYDavgJ3ErC8P
 mUBsFgFViUltN9kg4oISJ2c+YQGxRQUiJF4e+QtWIyyQIHFo1U0wm1lAXOLWk/lgtoiAksTT
 V2fBNjMLrGSRWPQEZDMHB5uAlkRjJztIDaeAtsSulSfYIHo1JVq3/2aHsOUltr+dwwzxs5LE
 7Mt6EM/USqw9doYdZKSEwH5OiYZjq9khEi4Se9sPskLYwhKvjm+BistInJ7cwwLR0M8oMbXl
 DxOEM4NRoufwZiaIDdYSfWdyIBocJVrfnGWDCPNJ3HgrCHEPn8SkbdOZJzCqzkIKillIXp6F
 5IVZSF5YwMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzCpnf53/NMOxrmvPuodYmTi
 YDzEKMHBrCTCa7VUL0mINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKY
 LBMHp1QDU3iMa5bOpdPnHmz4qcohyb31mZ9tw/PLtaW2C1iMI96pxdvH3viTsM9+wV7O+uP6
 3xsuqhpsrYyJefWs2stfK9WoxtF/aYR5or4XUwATd5PxW+eDBv+VrlewP2j0Wj6/r4Wl47+D
 9w0XTWEvdRcL08xXRqc3sK99fo8z42H5i4WaPZZbhDP2Lgqt+hBwW/f53Qf9hXmlEXqJC9ct
 ePTjnoS968WrJi7XGPK1jkVfy1nyXEBS6t2O0qUbxHbGfzx97fj256pHJv7sO2Pawnk7YeIN
 1oT9hiFzNbn/XdnyL0OkJvJrU7PN7dm9uzjDRf601s7z8tUQU2Q8dmtdDMvaux+TV5h21B85
 3HPe/PZPJZbijERDLeai4kQAFcN9z9kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7pnxPSTDDa/5bFYfbefzWLW7dcs
 Fr/Pnme2WLn6KJPFlKtLmSzOvz3MZDHp0DVGi/nLnrJb3JjwlNFizc2nLBbrXr9nceD2uPxn
 P5PHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7ZwOaxs/U+q0f7gW6mAM4oPZui/NKSVIWM
 /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYz5jRMYC55xV7R3f2Rq
 YLzK2cXIySEhYCJx8UgzYxcjF4eQwFJGiT3z9zBDJGQkPl35yA5hC0v8udbFBlH0kVFi1c9p
 rBDObkaJls+NYB28AnYSs748ZAKxWQRUJSa13WSDiAtKnJz5hAXEFhWIkGhbNgWsXlggQeLQ
 qptg9cwC4hK3nswHs0UElCSevjoLdhKzwEoWiUVPjjJDbFvAJDHr9Dmg1RwcbAJaEo2dYOdx
 CmhL7Fp5gg1ikKZE6/bf7BC2vMT2t3OYQcolgIbOvqwH8U2txKv7uxknMIrOQnLeLCRnzEIy
 aRaSSQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEJoNtx35u3sE479VHvUOMTByMhxgl
 OJiVRHitluolCfGmJFZWpRblxxeV5qQWH2I0BYbRRGYp0eR8YDrKK4k3NDMwNTQxszQwtTQz
 VhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgOpjg4Rh1e/kd7b6ub182bZkrPl0tvj//3I1T
 K++kMU09FHv/1gbZJzqfZ/z9GBs/ma3+8c5pjHO6Isw1UyUe3a05XvXFauKJb3lHN15xVEla
 LaP/ucGuPfVIOvO3l80uU44eMgw8dXGfwAFTj/rZxh/W8aYc+nh9SlDUB2GeLTuifXYwlU4P
 ecX6/HDscpVPYaHHJb9devhx5f4/HWYp+4rSjl6axutX/DpK8felbzzzKsUDj65SWzuJI/W9
 pB3TtiNVIWLsScf1VCye3hSVO8gf2ltX3NaRlM4fe+1fsbB249zlHv4h9bGbpi9xKH+lP52J
 IV204Vfn4bvvfr3i/KV3O2GdTvqUd0xMoUfcniuxFGckGmoxFxUnAgAeXQ8tjwMAAA==
X-CMS-MailID: 20220314101956eucas1p186805e5613cfcd89693eed5f9e609db5
X-Msg-Generator: CA
X-RootMTR: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
 <07484796-d692-6247-427f-20d0e9ac6193@opensource.wdc.com>
 <6929490b-5a73-5dd3-d5a4-afe9d3c9b347@samsung.com>
 <20220314084449.GA5866@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_032000_118460_C29E1356 
X-CRM114-Status: GOOD (  16.38  )
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



On 2022-03-14 09:44, Christoph Hellwig wrote:
> On Mon, Mar 14, 2022 at 09:36:35AM +0100, Pankaj Raghav wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 51c08f206cbf..cde33f2a3a5a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1855,8 +1855,7 @@ static void nvme_update_disk_info(struct gendisk
>> *disk,
>>  	blk_queue_max_write_zeroes_sectors(disk->queue,
>>  					   ns->ctrl->max_zeroes_sectors);
>>
>> -	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
>> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
>> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
>>  }
> 
> This creates a race window during revalidation where the zone will be
> set writable here only to be set read-only again a little later.

We call the blk_revalidate_zone after nvme_update_zone_info. So before
we revalidate, the correct permission is already set.

	// sets the disk to ro based on nsattr
	nvme_update_disk_info(ns->disk, ns, id);

	if (ns->head->ids.csi == NVME_CSI_ZNS) {
		// Sets the disk to ro based on append
		ret = nvme_update_zone_info(ns, lbaf);
		if (ret)
			goto out_unfreeze;
	}

	set_bit(NVME_NS_READY, &ns->flags);
	blk_mq_unfreeze_queue(ns->disk->queue);

	if (blk_queue_is_zoned(ns->queue)) {
		// Revalidate is called after the permission is set
		ret = nvme_revalidate_zones(ns);
		if (ret && !nvme_first_scan(ns->disk))
			return ret;
	}

Am I missing something?

-- 
Regards,
Pankaj

