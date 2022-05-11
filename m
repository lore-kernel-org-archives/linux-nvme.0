Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D371C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EUaYeqrDCZdYIk1QARpzTYuomNghhQ2OqPnaqXtUYXI=; b=t5wU7qYgScJ61P
	Qouk+zUllwgYau8jvmMSn88/THRGSQVumQSNfYIWKxWNNrH2QnwNICtyqRbj5zxcPBo0CqlD5GtnF
	wvCXl1pm/AUuFIUtrfMUYuIXJtB98uPwp+DCG/eJnfPfhAGrA9RdzPDDwN8in9JUewR+2UOZQh/kT
	zWbkHDvJNz3I1V2oZNjwDmiktxDUGMiAAJDPIjF6smbxXSkC5uUGFYArrP9rIeGNFk0l9coN1n5qp
	Pu0DSKe6/NzTXYa0VivCOuE1L8pFQoV9JynWWI/kzn/Sx4dmcUNYCgW0oufHwflYsnLfkImZ/+l5G
	0mo8l2F7QLaV1u0VWPgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nonV5-007GNK-Hb; Wed, 11 May 2022 14:39:39 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nonV0-007GHs-Uc
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 14:39:38 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220511143924euoutp016ff617e0c811d831cdc1f98ad32a1852~uE9_vEfMc1094510945euoutp01r
 for <linux-nvme@lists.infradead.org>; Wed, 11 May 2022 14:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220511143924euoutp016ff617e0c811d831cdc1f98ad32a1852~uE9_vEfMc1094510945euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1652279964;
 bh=EUaYeqrDCZdYIk1QARpzTYuomNghhQ2OqPnaqXtUYXI=;
 h=Date:Subject:To:From:In-Reply-To:References:From;
 b=cckO2daDpiVhFX6qpoQYbYH6llh83054qsmL/8fX4xsl//rh5oxEEQcsIU0wxEzN8
 xPcjDha5le5ZiqVkoxD+PkgW+pYaKSajomW6x4BXGIpo680Bn11YENWOCckJ8aKbi2
 4iFTqaIZqXzehfl096ccaQwYo2n6fkUvKh14nO70=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220511143924eucas1p1114e84104a5c6c0eb50e67f8777969a5~uE9_R-fHL3194531945eucas1p1W;
 Wed, 11 May 2022 14:39:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.2A.10009.C9ACB726; Wed, 11
 May 2022 15:39:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220511143923eucas1p2e3a3e929d5d66bce874b5a9f7d7fd067~uE99xcdbm0496104961eucas1p2y;
 Wed, 11 May 2022 14:39:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220511143923eusmtrp1fc902ac2cae0a49dc35e360306028ac3~uE99wDcd41329413294eusmtrp1g;
 Wed, 11 May 2022 14:39:23 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-24-627bca9c0b1d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.16.09404.B9ACB726; Wed, 11
 May 2022 15:39:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220511143923eusmtip1f71a6b406fa85da0c0332d11c8d4d4aa~uE99juOBx3226832268eusmtip1E;
 Wed, 11 May 2022 14:39:23 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.174) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 11 May 2022 15:39:18 +0100
Message-ID: <d8e86c32-f122-01df-168e-648179766c55@samsung.com>
Date: Wed, 11 May 2022 16:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes
 are allowed
Content-Language: en-US
To: <dsterba@suse.cz>, <jaegeuk@kernel.org>, <hare@suse.de>,
 <dsterba@suse.com>, <axboe@kernel.dk>, <hch@lst.de>,
 <damien.lemoal@opensource.wdc.com>, <snitzer@kernel.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, <bvanassche@acm.org>,
 <linux-fsdevel@vger.kernel.org>, <matias.bjorling@wdc.com>, Jens Axboe
 <axboe@fb.com>, <gost.dev@samsung.com>, <jonathan.derrick@linux.dev>,
 <jiangbo.365@bytedance.com>, <linux-nvme@lists.infradead.org>,
 <dm-devel@redhat.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 <linux-kernel@vger.kernel.org>, Johannes Thumshirn <jth@kernel.org>, "Sagi
 Grimberg" <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, "Keith
 Busch" <kbusch@kernel.org>, <linux-btrfs@vger.kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220509185432.GB18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.174]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHc3pv772tVC4V5QTYw4K4IUMbl+y4KWGZ4M3cdLIQlw03C94U
 YinSFmQSGQ4kBaU8FIQOpStuPidDCA95jFUe5aGCrFpqdDAoTBmFAYsgC85yceG/z+/7+37P
 +f1ODoWJawlPKkapYVVKmUJCCPHqtrnbb5V0JkduSrsvQOWdbRh63tBGoCsPcwhUODmHofyc
 IhLN37qDoUbHd3zUM3uMh8rmn+KowZjPQ5eutPLQcLkeQyebJ3F0KX0QQ/8OStHgjA1H+aZ7
 ANkteh5qtG1Ad4cukqihsQNHfTdKCFT6o51EuRn/YMiaawcor72Sj66NTeDIbPMK9mb6ftvJ
 LJivEkxemoNk7jyqwJm+WwnM9cuZBPN9agHGVJ7/hqnvTyWY7DQHwdQd/53PTDRZCKa8yoIz
 3YYWkqnsSmZyKyv4n4g/F249wCpiElnVxqD9wujTo7fxQwXCJG1xUioooLKAgIL027Be1wKc
 LKYvApj9TJ4FhC94BkBtmQlwxTSAz3s6sJeJoa4eHte4AOCzmw/x/126auNSUQ9gb5txMSKi
 g+C9uQLcyTi9Dp6veQw43Q12FA8v6qvpz2Chvptw8ip6L2xpNSxmMdoD2oZLF69zpy0ETM8f
 4WcBiiJof3gsk3R6BPRmWFd2AnD+N+HxmnmS49dgzXjJ0tg+cGKgCef4KPyprZt0nglpixCe
 mTECrrEdWgqKCI5XwSftVSTH3rDr1MmlcDK0W+cxLpwOYE5dOeEcCNLvQV23gvO8D422PwEn
 r4TWcTdunpUwv/oMxskiqM0Q5wJf/bKX0C/bWL9sG/2ybQwAvww82AR1rJxVS5Xs4UC1LFad
 oJQHRsXFXgcvPnfXQvtULTj75O9AE+BRwAQghUncRb/okiLFogOyr4+wqrivVAkKVm0CXhQu
 8RBFxfwsE9NymYY9yLKHWNXLLo8SeKby+EfMa3CJutPsCKurZ/8aXnst0Pddu4UcKz71h0aj
 CfXzCxo9F+xVu94lYERdK4hXUpuUE1bPiAdePuumzXmZiSvwG7WajDyf9PV5rx+M3N7U2Xr3
 1aLxcNGKV2ZD+VJwelddxH7N4y0LFQNbpURrr3ti/Dths5+eCGkKHUhhV9/coPAt3eVtiOBv
 VlwFMzv9XePcUqa27bN/IHe58GWhJDvkcPCUcsGwRxdsjSLnPp6OfrCn/6PJ9n17A5oVDgbt
 2BYQ0drv4hJ/jnY0z45M7earJ9cwP0SEu255w08X9mtKQMioee0XveXh97XaR+FDPlVHp8a+
 3Sjl53xoD0dP9a4SXB0tk/pjKrXsP9KMJ4lLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsVy+t/xu7qzT1UnGbx+qmSx/tQxZov/e46x
 Way+289mMe3DT2aLSf0z2C1+nz3PbLH33WxWiws/GpksFv/+zmKxZ9EkJouVq48yWTxZP4vZ
 oufABxaLlS0PmS3+PDS0ePjlFovFpEPXGC2eXp3FZLH3lrbFpccr2C327D3JYnF51xw2i/nL
 nrJbTGj7ymxxY8JTRouJxzezWqx7/Z7F4sQtaQcZj8tXvD3+nVjD5jGx+R27x/l7G1k8Lp8t
 9di0qpPNY2HDVGaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPNZvucricWbBEXaPzaerPSZs
 3sgaIBSlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
 lzHl+TmWgqlcFR0zKxoYp3J0MXJySAiYSDw+fYGpi5GLQ0hgKaNE74O/zBAJGYlPVz6yQ9jC
 En+udbFBFH1klJiwZzkzhLMbqKO7kQmkilfATuLaz6ksIDaLgKrEku0vGSHighInZz4Bi4sK
 REg82H2WFcQWFgiXWPN2C1gNs4C4xK0n88HOEBG4yibRMukZK8SG54wS7x+fB6ri4GAT0JJo
 7AQ7iVPAWGLn4m6oZk2J1u2/2SFseYntb+dAvaAs8f7BPhYIu1bi1f3djBMYRWYhuWkWkt2z
 kIyahWTUAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGpbduxn1t2MK589VHvECMTB+Mh
 RgkOZiUR3v19FUlCvCmJlVWpRfnxRaU5qcWHGE2BATORWUo0OR+YXPNK4g3NDEwNTcwsDUwt
 zYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpg4qpNc0ydsyn0tv9U52nlJ4pMJW09kzrB8
 enyejAfDqWt3FF26cs5+OjyJl/PEBPVC/SReEStbr8CsOydXtDpGrL2y7JJEqr9hTKXtrtmG
 E+NeKL9cWBJZn3Q9+8WRwl1+rELmca9LVzprvjJoEPt6rlFk6+84hW/Oxpltcr77t3OmiAlW
 Zv9kmdTooNbYM0vst+e1mMgi/lsbr3+3cFmu8OF1O8fmG2qn5igEHXpcd8Kj8K7JvMO7Tjme
 6AtrOXtV8ZkYY+RRX85TSQ/Te65q/dFeftqJe9LM+h/XTPKWT/i8yz709x4umTCZowc+fcve
 nl06I4uRw3tKkWv2Bof/S7OdtNbUux/X5d1q/EKJpTgj0VCLuag4EQANVqpY9gMAAA==
X-CMS-MailID: 20220511143923eucas1p2e3a3e929d5d66bce874b5a9f7d7fd067
X-Msg-Generator: CA
X-RootMTR: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
 <20220509185432.GB18596@twin.jikos.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_073935_298049_A5C78D7B 
X-CRM114-Status: GOOD (  14.19  )
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

Hi David,

On 2022-05-09 20:54, David Sterba wrote:>> diff --git
a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>> index 3e7b1fe15..27dc4ddf2 100644
>> --- a/drivers/md/dm-zone.c
>> +++ b/drivers/md/dm-zone.c
>> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>>  	struct request_queue *q = md->queue;
>>  	unsigned int noio_flag;
>>  	int ret;
>> +	struct block_device *bdev = md->disk->part0;
>> +	sector_t zone_sectors;
>> +	char bname[BDEVNAME_SIZE];
>> +
>> +	zone_sectors = bdev_zone_sectors(bdev);
>> +
>> +	if (!is_power_of_2(zone_sectors)) {
> 
> is_power_of_2 takes 'unsigned long' and sector_t is u64, so this is not
> 32bit clean and we had an actual bug where value 1<<48 was not
> recognized as power of 2.
> 
Good catch. Now I understand why btrfs has a helper for is_power_of_two_u64.

But the zone size can never be more than 32bit value so the zone size
sect will never greater than unsigned long.

With that said, we have two options:

1.) We can put a comment explaining that even though it is 32 bit
unsafe, zone size sect can never be a 32bit value

or

2) We should move the btrfs only helper `is_power_of_two_u64` to some
common header and use it everywhere.

Let me know your thoughts.


