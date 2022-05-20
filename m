Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F803C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EDj6j9kMtVDfHH3Ex41sLPuCJwXBjQ9MILCkOs8LWTI=; b=yiOmbPTC5AiEAl
	Y8O0EO9bTKh29T0MJ7FkeV1gGfrs8jaG2Q2CZ9VQdiFT+QRSa/vQEfTBK3tt94yHev6fTJwycIv6f
	neaonKiCZ/AL2Ncj/urB92EHeARKfg1hH5U6vZYVwzvvd9DFScg7ZgbDhpOj9CnT6LZ9pvU+0rdbJ
	h06HaVUKdAnkJKKNBg5uH5B4dl/70FFoRRpjaSJfQ35Kg4QXy15DeKNX3n8v8cUE3IbMHzwa0gX/g
	RxKEItCSATK6sDcm16Iv2jXC7Rj17EOvqi17eKP1YlwOBdcKI1vBwW6CXec0Zx6fKJrWPejCL3UBS
	fa4zoLuL1NZb+ZmGaSkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrydX-00BTqv-EN; Fri, 20 May 2022 09:09:31 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrydT-00BTpN-VQ
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:09:29 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220520090926euoutp0196a88a10ff84234741cb6bcd32e7427c~wxRc1n98b1719217192euoutp01V
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 09:09:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220520090926euoutp0196a88a10ff84234741cb6bcd32e7427c~wxRc1n98b1719217192euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653037766;
 bh=EDj6j9kMtVDfHH3Ex41sLPuCJwXBjQ9MILCkOs8LWTI=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=kGUiVKPcItz2XiHZ74bIYNO1u/vpDWI0Yrs43Jnkt/aQ4Z35We7eBY79PHrs7Y2ZB
 C52yHtVoZvofaf2AObEEW4bVtwWzd7jobCP1W4+zoYKp17JETYTOXtBlHaS+fidV3E
 Nbz97JHc9t7yu3Ij6M1+w/UJflMwV4Vwmo9jos9I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220520090926eucas1p1bc12b0a9dc442b78da3af9ddc2202325~wxRcsrHdB0182901829eucas1p19;
 Fri, 20 May 2022 09:09:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id B3.9D.10009.6CA57826; Fri, 20
 May 2022 10:09:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220520090925eucas1p26954f3932778b1e6d579d50095b3f138~wxRcJyMFD2110521105eucas1p2s;
 Fri, 20 May 2022 09:09:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220520090925eusmtrp1b0e8eda967a664f924b0e66aa52a2ca9~wxRcI0pXY2190521905eusmtrp1Y;
 Fri, 20 May 2022 09:09:25 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-49-62875ac6612c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id EC.2D.09522.5CA57826; Fri, 20
 May 2022 10:09:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220520090925eusmtip11d5b71aafeef920d4c670fe714700b5a~wxRb-0jrS1395113951eusmtip1U;
 Fri, 20 May 2022 09:09:25 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 20 May 2022 10:09:24 +0100
Message-ID: <fc015adb-4b18-a144-7859-cfe434b74166@samsung.com>
Date: Fri, 20 May 2022 11:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Content-Language: en-US
To: Naohiro Aota <Naohiro.Aota@wdc.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "damien.lemoal@opensource.wdc.com"
 <damien.lemoal@opensource.wdc.com>, "pankydev8@gmail.com"
 <pankydev8@gmail.com>, "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de"
 <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, "jiangbo.365@bytedance.com"
 <jiangbo.365@bytedance.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "gost.dev@samsung.com"
 <gost.dev@samsung.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220519075926.6h4ka3qbo3vv26ve@naota-xeon>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87rHotqTDPrnylusvtvPZvH77Hlm
 i73vZrNaXPjRyGSxcvVRJoueAx9YLPbe0ra49HgFu8WevSdZLC7vmsNmMX/ZU3aLicc3s1qs
 ufmUxYHX49+JNWweO2fdZfe4fLbUY/OSeo/dNxuAIq33WT3e77vK5rF+y1UWj8+b5DzaD3Qz
 BXBFcdmkpOZklqUW6dslcGXcm3KbraCVu+Laut9sDYwnOLoYOTkkBEwk7p+Zw9TFyMUhJLCC
 UWJd32NWCOcLo8T5teegnM+MEl+vnGaFabl3cjk7iC0ksJxRYts6NbiiJyd/QM3aBeQsfccM
 UsUrYCcxf9NZJhCbRUBVYur1TlaIuKDEyZlPWEBsUYEIiWmzzrB1MXJwCAukSOxYWQQSZhYQ
 l7j1ZD5Yq4iAusTHp0fZQOYzCxxmldh0FuQ8Dg42AS2Jxk6wgzgFLCVOHj/MDNGrKdG6/Tc7
 hC0vsf3tHGaQcgkBJYltv0wgfqmVWHvsDDvISAmBc5wSp950sUMkXCSuX25nhrCFJV4d3wIV
 l5E4PbmHBcKulnh64zczRHMLo0T/zvVsEAusJfrO5EDUOEpc+vYZai+fxI23ghDn8ElM2jad
 eQKj6iykgJiF5ONZSD6YheSDBYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKT3el/
 xz/tYJz76qPeIUYmDsZDjBIczEoivIy5LUlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQK
 CaQnlqRmp6YWpBbBZJk4OKUamNxCf7tJ1t2s1Hz+7jrnPw6zY7nP1Gae4nZ7Ut5V97hxi/xt
 27a+6Ac71q7fGzmfObXL7nrh1pVLb86TrPi3trps1Ylt+lOUTh4wmu3361fuzrtdTxuZRX3Y
 fu/uz5ti8PP+lKT5Gz5sWim9368tN3BK7VS1qP0Xvky5eyMzsknr+TbnrNDtLHdf+tWybRe7
 F3m5h8nw+qXApDlRq9bElXze7jD39oOz755tF5omKL3n+gz5ae2P/x3/cDetnbtBpkk4XVxo
 YkR0+UGW2R4Wz9YuMHxaXjhj5elFk4uTWG9/PJrH9DLlW0VmyaYrHauP37d7qqvsbx4iFLvV
 5Vm0q16nyIUcjfNh8132sHHPktRTYinOSDTUYi4qTgQAS/3CwuUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42I5/e/4Xd2jUe1JBucOm1usvtvPZvH77Hlm
 i73vZrNaXPjRyGSxcvVRJoueAx9YLPbe0ra49HgFu8WevSdZLC7vmsNmMX/ZU3aLicc3s1qs
 ufmUxYHX49+JNWweO2fdZfe4fLbUY/OSeo/dNxuAIq33WT3e77vK5rF+y1UWj8+b5DzaD3Qz
 BXBF6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXc
 m3KbraCVu+Laut9sDYwnOLoYOTkkBEwk7p1czt7FyMUhJLCUUeLjl1lsEAkZiU9XPrJD2MIS
 f651sUEUfWSUeHh+GZSzi1Hi/u+zzCBVvAJ2EvM3nWUCsVkEVCWmXu9khYgLSpyc+YQFxBYV
 iJB4sPssWFxYIEXi0afZYDazgLjErSfzwXpFBNQlPj49ygYRP8wqsWuJOMSyd4wSO3Z+Zuxi
 5OBgE9CSaOwEu45TwFLi5PHDzBD1mhKt23+zQ9jyEtvfzmEGKZcQUJLY9ssE4plaiVf3dzNO
 YBSdheS6WUiumIVk0iwkkxYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQITBLbjv3cvINx
 3quPeocYmTgYDzFKcDArifAy5rYkCfGmJFZWpRblxxeV5qQWH2I0BQbRRGYp0eR8YJrKK4k3
 NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgCgrZYGzEus/cpDohxXPx
 v2V7X3GsE+/ekbPvwL6G0oeTjlxzVRP+u1l1XvtrR7G+PRbrJh1WUDDzfBnhuTdlM3Privfm
 JtwuDMJexpctXa/0TtZY9eqnxclNTFyHuZcH/W/Jcm+Ya74y5J3l1Y0R1/gWvGtc/0O9vHYr
 7yfzkt8pDJnBKvfyYj5MKzE7uFTrfOX/1W5XE6+YX+tlMTtnfcyc2/cSp1uG5YKSvZ+OqzK4
 PhF8evlhzyGHuglXWur4VfY1zLLX4LxYqTk7fXKzrKCp0AvvL+fydE6IS86Wf82QL+FTuDk+
 T+tS/8UHe6tPn1t52vTqn/UMgpY3d37ez73sB+O/+Nh/jUf1RBR1lViKMxINtZiLihMBGIST
 t5sDAAA=
X-CMS-MailID: 20220520090925eucas1p26954f3932778b1e6d579d50095b3f138
X-Msg-Generator: CA
X-RootMTR: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
 <20220516165416.171196-9-p.raghav@samsung.com>
 <20220519075926.6h4ka3qbo3vv26ve@naota-xeon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_020928_337661_63523E3C 
X-CRM114-Status: GOOD (  13.62  )
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

On 5/19/22 09:59, Naohiro Aota wrote:
>> +
>>  static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>> -			   int rw, u64 *bytenr_ret)
>> +			   int rw, int mirror, u64 *bytenr_ret)
>>  {
>>  	u64 wp;
>>  	int ret;
>> +	bool zones_empty = false;
>>  
>>  	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>>  		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
>> @@ -775,13 +808,31 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>>  	if (ret != -ENOENT && ret < 0)
>>  		return ret;
>>  
>> +	if (ret == -ENOENT)
>> +		zones_empty = true;
>> +
> 
> I think, we don't need this. We need to issue the zeroout when
> zones[0]->cond == BLK_ZONE_COND_EMPTY && !is_power_of_2(...) after sending
> ZONE_RESET if necessary. No?
> 
Yeah. I added this extra check to cover all the cases possible. But you
are right that it is enough to issue zeroout only for this condition:
zones[0]->cond == BLK_ZONE_COND_EMPTY && !is_power_of_2(...) as both the
zones empty is not likely to happen.
>>  	if (rw == WRITE) {
>>  		struct blk_zone *reset = NULL;
>> +		bool is_sb_offset_write_req = false;
>> +		u32 reset_zone_nr = -1;
>>  
>> -		if (wp == zones[0].start << SECTOR_SHIFT)
>> +		if (wp == zones[0].start << SECTOR_SHIFT) {
>>  			reset = &zones[0];
>> -		else if (wp == zones[1].start << SECTOR_SHIFT)
>> +			reset_zone_nr = 0;

