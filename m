Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C2C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mZW+Yv+gzOYRSNDklszwlIHrWifnMh3ucu3p7jpxGME=; b=UNS8Aovv4GoqmX
	jVPK56i6Pe4SnFnhYSjgAMVSE4KLZK1iXzvIPxp6GuoYNs7W1jChx1p8N38k6e3ylqqdrTwheNnGq
	eaerqmDTm5BHcAU2NszSZNbu66n5kkSw2Rthq3K3ZmSJ89l4m8Nf6XzsvCQ+Um3WmcfNk3v2/QsiE
	gbrRWv5UwPed3KtqBzT+8v2ZxcrfscCO1he8T4Inzoor22MQvrPBsjbIENAfn16pw5SeEg8yAgjZX
	OolLoEorfuHwZKPKdC4RTtVArECGNGyL7/W0rP7zA+vW9fBO/v9MNixiJKiZMUcSfAWxoePpAFKus
	Le/ZsVCldKox61fLlAqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1mE6-001mFj-D8; Thu, 16 Jun 2022 09:55:46 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1mE0-001mDT-6Y
	for linux-nvme@lists.infradead.org; Thu, 16 Jun 2022 09:55:42 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220616095533euoutp02f2a1de79931d2e7d3220811523b0ddf4~5EUbR3vAD1731317313euoutp02T
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jun 2022 09:55:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220616095533euoutp02f2a1de79931d2e7d3220811523b0ddf4~5EUbR3vAD1731317313euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655373333;
	bh=mZW+Yv+gzOYRSNDklszwlIHrWifnMh3ucu3p7jpxGME=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=JsQlQB0rr+qwJ3YJ64FHIJzxwjrReyaRzHayPNOeUZ1uR49ORsPMdX1UO2xwlPg8f
	 OZ/RYTeKdE4o1FOCurCqGsU7Ffkk8NmhDZHC9q3aRmVAe9TkNbDhxnm3Qm0dwSgPFF
	 baZDgPEBxiL4avBv3nZl8ojfRaTO23lM5DZgPL4E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220616095533eucas1p198f88427d18eac974902dcd6465a3ca1~5EUa8B59n0597505975eucas1p1J;
	Thu, 16 Jun 2022 09:55:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 57.0A.10067.51EFAA26; Thu, 16
	Jun 2022 10:55:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220616095533eucas1p11e0b6e865c36436af0c5961fed68c0bb~5EUafCeto2317623176eucas1p1F;
	Thu, 16 Jun 2022 09:55:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220616095533eusmtrp12668d16e772800c87b383a470d9ee908~5EUad9T0i2661126611eusmtrp1N;
	Thu, 16 Jun 2022 09:55:33 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-93-62aafe15f22f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.24.09038.41EFAA26; Thu, 16
	Jun 2022 10:55:32 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220616095532eusmtip20dfff485048e66a3d699052f99eaeaba~5EUaPlILp0880708807eusmtip2i;
	Thu, 16 Jun 2022 09:55:32 +0000 (GMT)
Received: from [192.168.1.12] (106.210.248.244) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 16 Jun 2022 10:55:26 +0100
Message-ID: <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
Date: Thu, 16 Jun 2022 11:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.9.1
Subject: Re: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
	<snitzer@redhat.com>, <axboe@kernel.dk>
CC: <bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
	<jiangbo.365@bytedance.com>, <hare@suse.de>, <pankydev8@gmail.com>,
	<dm-devel@redhat.com>, <jonathan.derrick@linux.dev>, <gost.dev@samsung.com>,
	<dsterba@suse.com>, <jaegeuk@kernel.org>, <linux-nvme@lists.infradead.org>,
	<Johannes.Thumshirn@wdc.com>, <linux-block@vger.kernel.org>, Luis
	Chamberlain <mcgrof@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.244]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djP87qi/1YlGbz4LGmx+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLCz8amSz2LJrEZLFy9VEmiyfrZzFb9Bz4wGLxt+seUKzlIVDdLW2Ly7vm
	sFnMX/aU3eLGhKeMFmtuPmWxaNv4ldFB0OPyFW+PfyfWsHnsnHWX3ePy2VKPTas62TwWNkxl
	9ti8pN5j980GoFzrfVaP9/uusnms33KVxWPz6WqPz5vkPNoPdDMF8EVx2aSk5mSWpRbp2yVw
	ZUxc/Y25oJWromvaTLYGxnvsXYycHBICJhK/tvcC2VwcQgIrGCWmNd5hhHC+MEqsPH2eDaRK
	SOAzo8TtOdFdjBxgHVvvi0DULGeUWD1tBlQDUM3u92tYIZxdjBIP9kxlAunmFbCTOLZ5NguI
	zSKgKnHpwnlGiLigxMmZT8DiogIREitb34DZwgLJEi8nbAarYRYQl7j1ZD4TyGYRgTyJef+S
	QOYzCzQxS5w99YEdJM4moCXR2An2DqeAm0TvvKXsEK2aEq3bf0PZ8hLb385hhnhAWeLfTmaI
	72sl1h47A/a9hMA/Tolnk7pZIRIuEm97P0PZwhKvjm+BBpeMxOnJPSwQdrXE0xu/mSGaWxgl
	+neuZ4NYYC3RdyYHosZR4mj/HhaIMJ/EjbeCEOfwSUzaNp15AqPqLKSAmIXk4VlIPpiF5IMF
	jCyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAtPm6X/Hv+xgXP7qo94hRiYOxkOMEhzM
	SiK8ZsErk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUw
	OVY/375N7tLD1XNCn10yfz8j7OH3zp9qGR+aZs1ccI5ziWh4+iFu609VzivmmH38bZN4VezL
	lTrjQ2pzokyOMUn1mwhpLlblaFYVc/uRF7Dg9ntvRkemdYcd+6/6XMkP9L7zWLRI1+OanvbE
	3xNDWjfVe/gsmfPDYrbN9G9cDS3ztn5YVGuYu7HdJ/qWf9v/1u59J//M4urWVrltpKh73PaC
	WKKMCHMxb4lh3tzLOkLa0xQ1ApYuD1Vay7vvbiTPz1PTX8f5rNOUnZ+q53NV/n+53qstGaub
	uKRWa7A7bwiVMWd5LqK5sObP56JNRt5v2GX2qocKfGCWY/3rf8vDaE8sw6QJFo6LTm/sYLmu
	xFKckWioxVxUnAgAiLYCoAoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsVy+t/xe7oi/1YlGdz5Zmqx+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLCz8amSz2LJrEZLFy9VEmiyfrZzFb9Bz4wGLxt+seUKzlIVDdLW2Ly7vm
	sFnMX/aU3eLGhKeMFmtuPmWxaNv4ldFB0OPyFW+PfyfWsHnsnHWX3ePy2VKPTas62TwWNkxl
	9ti8pN5j980GoFzrfVaP9/uusnms33KVxWPz6WqPz5vkPNoPdDMF8EXp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUxc/Y25oJWromvaTLYGxnvs
	XYwcHBICJhJb74t0MXJxCAksZZSYsbabtYuREyguI/Hpykd2CFtY4s+1LjaIoo+MElfXrWKE
	cHYxShxY85cRpIpXwE7i2ObZLCA2i4CqxKUL56HighInZz4Bi4sKREh8WjYBbIOwQLLEywmb
	wWqYBcQlbj2ZzwRykYhAnsS8f0kg85kFmpgl/i87DrXsD6PE05YpYEVsAloSjZ1g13EKuEn0
	zlvKDjFHU6J1+28oW15i+9s5zBBfKkv828kM8UytxKv7uxknMIrOQnLdLCRXzEIyaRaSSQsY
	WVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEppttx35u2cG48tVHvUOMTByMhxglOJiVRHjN
	glcmCfGmJFZWpRblxxeV5qQWH2I0BQbRRGYp0eR8YMLLK4k3NDMwNTQxszQwtTQzVhLn9Szo
	SBQSSE8sSc1OTS1ILYLpY+LglGpgkk3knntiWlrb1iMnch5XL8vb/0b5561+hQjzeimJ/Yr8
	3RPO2v0TnBfYIBH8873+EdUtb/Xt2CfO/3OjofJVvMjNC69vrbS9nbrtdv+1W9qfWYt2Nk+u
	FL6//bqk2uXGcHkJS1s1H/F22UT9lIzcOmm7nY7RpYn/js2aPGG+pu6xzx+efpJs2Vu1rfFA
	4mTu10p19ccdF51/PM842V4iYZ6LY2bUghRfZ46d+301l9o9cTvjlPuZ6+GSuf8TdviVzXDb
	oLnz5eFs6UN/3sru3LeQh4/Pyy3zbKH5h4/qnypvZqxZLFNvvrTisaSrz5kLSV4LpeO5P+5v
	kS/JFF2ycN3ahvtMsQ+nX3tQobPOXImlOCPRUIu5qDgRALbxfBzAAwAA
X-CMS-MailID: 20220616095533eucas1p11e0b6e865c36436af0c5961fed68c0bb
X-Msg-Generator: CA
X-RootMTR: 20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498
References: <20220615101920.329421-1-p.raghav@samsung.com>
	<CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
	<20220615101920.329421-11-p.raghav@samsung.com>
	<064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_025540_727421_E4AB9897 
X-CRM114-Status: GOOD (  14.09  )
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

drivers/md/dm-table.c
>> +++ b/drivers/md/dm-table.c
>> @@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>  	if (bdev_is_zoned(bdev)) {
>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>  
>> -		if (start & (zone_sectors - 1)) {
>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
> 
> This is wrong. And you are changing this to the correct test in the next
> patch.
> 
Yeah, I think I made a mistake while committing it. The next patch
should only have the removing po2 condition check and these changes
should have been only in this patch. I will fix it up!
>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>  			       dm_device_name(ti->table->md),
>>  			       (unsigned long long)start,
>> @@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>  		 * devices do not end up with a smaller zone in the middle of
>>  		 * the sector range.
>>  		 */
>> -		if (len & (zone_sectors - 1)) {
>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
>>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>>  			       dm_device_name(ti->table->md),
>>  			       (unsigned long long)len,
> 
> 

