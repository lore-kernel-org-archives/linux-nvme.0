Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A117C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZDFB8d0IFRgVfHdFTYObeZbsf0KsfG0g6SUx4ynBdBc=; b=ASOWxII4vy+L4x
	RUx0xoXSBFQ6IgzXCwqcCpNNmanpWIOAHE5SzB3781U31P19q8l0zOruaRvB0odX0MGfNBYNH86SD
	bOuhLv7E7UFXHwIRqfgz3tE/0VUNzdHZ6PF1HDB9TTd8CHcyQBmD4PTUmgt89g6UkWVaXSDTDrxnb
	J02o6z5VbnuM7HYL8AzJavOtqpgPPi9WZ9i2EeO3AzsuFnagjSNiwOowItFZ89J8BJNt/s3VyQnad
	/VKPqW3ynD1IRNTzTow7MRwtqy/lxgMzCzxwmRp3pIG1V08b/NLFDm5Jieg6cu2AnyX4Slb7eA9bY
	+NlWtBsZAp7AFx/d7zGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTgFK-004YTt-Ff; Mon, 14 Mar 2022 08:40:06 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTgC6-004X5H-Uh
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 08:36:50 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220314083641euoutp02715023ea92d2bd457b1426f4d5940070~cMmuKQ2mh2024720247euoutp02s
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 08:36:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220314083641euoutp02715023ea92d2bd457b1426f4d5940070~cMmuKQ2mh2024720247euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647247001;
 bh=ZDFB8d0IFRgVfHdFTYObeZbsf0KsfG0g6SUx4ynBdBc=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=npcllWd/m6JUPg2ssJbMWXyHv+TPZoh4ERF7m5Aywiql13QE2xBmMygJ2DhaQcrSd
 0wreDxtSVh6Ma8d9ofeAZvahzaDnZSzKRkWCBI8qpUv556p+gzqC52JpQ7PPoTQdVt
 QGWK8Aqy9clutmLQvuNw0+5SF0fbIdzryogncJdA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220314083640eucas1p1b12fb433df9c751b7208579cad20a43d~cMmt2FvE51709617096eucas1p12;
 Mon, 14 Mar 2022 08:36:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E1.A9.10009.89EFE226; Mon, 14
 Mar 2022 08:36:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220314083640eucas1p1b35a57f590b2422c1461f164543d3f49~cMmtXNqGF1709617096eucas1p1z;
 Mon, 14 Mar 2022 08:36:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220314083640eusmtrp2cd9eea52a4671bed2a6c98de45d712a5~cMmtWcAwz0805008050eusmtrp2V;
 Mon, 14 Mar 2022 08:36:40 +0000 (GMT)
X-AuditID: cbfec7f2-68981a8000002719-8f-622efe98bae0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.B4.09404.89EFE226; Mon, 14
 Mar 2022 08:36:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220314083640eusmtip127184f8625eae3f0a0f2119e560c36de~cMmtMeQGW0477304773eusmtip1j;
 Mon, 14 Mar 2022 08:36:40 +0000 (GMT)
Received: from [106.110.32.130] (106.110.32.130) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 14 Mar 2022 08:36:35 +0000
Message-ID: <6929490b-5a73-5dd3-d5a4-afe9d3c9b347@samsung.com>
Date: Mon, 14 Mar 2022 09:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Keith Busch
 <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Johannes Thumshirn <johannes.thumshirn@edc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, Jens Axboe
 <axboe@kernel.dk>
CC: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, "Pankaj
 Raghav" <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <07484796-d692-6247-427f-20d0e9ac6193@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7oz/uklGTxbpGex+m4/m8Ws269Z
 LH6fPc9ssXL1USaLKVeXMlmcf3uYyWLSoWuMFvOXPWW3uDHhKaPFmptPWSzWvX7P4sDtcfnP
 fiaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2zgc1jZ+t9Vo/2A91MAZxRXDYpqTmZZalF
 +nYJXBnLT/SyFeyVqPjfotnAuFeki5GTQ0LARGJD0zTWLkYuDiGBFYwSE/9MY4dwvjBKrD30
 jBmkSkjgM6NEUyM7TMffpnZGiKLljBK3jn+HcoCKNn9axgjRsZtR4sNHGxCbV8BO4u2ZS2wg
 NouAqsTaE3PYIeKCEidnPmEBsUUFIiReHvnLBGILCyRIHFp1E8xmFhCXuPVkPhPIAhGBe0wS
 H/ffBbuPWeAto8T36Q+ALufgYBPQkmjsBBvKKeAm0TThBDtEs6ZE6/bfULa8xPa3c5hByiUE
 lCRmX9aD+KZWYu2xM2AjJQT2c0pMbP3KApFwkdg3dTkjhC0s8er4Fqj3ZST+74Q4SEKgn1Fi
 assfKGcGo0TP4c1MEBusJfrO5EA0OEq0vjnLBhHmk7jxVhDiHj6JSdumM09gVJ2FFBazkPw8
 C8kLs5C8sICRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgUjv97/inHYxzX33UO8TI
 xMF4iFGCg1lJhNdqqV6SEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalF
 MFkmDk6pBqZ6nz8z9f5w+ik82/3PeILc+t//pr3s0N2y/m/X42/Lf2/cYZTJE2/XefLvv5n3
 jhzudU38+2Ol9KIWvdwaP6uNh9hXxBjzlpWKc9vW8MXfluOW2vevzTes6ZXwzPmfVhswPpn/
 LTBi/Z/JlwVmztJN/sH8MLT3xcIWHhZFSy4l/52q7LdPts14t9kkcHlwpf+0ri7uuYsYfCaY
 eZxJWmtytz44R2n+od+fjhz4/ebvzN/bjU9FqcbZeNkwiHU5dr4/WGfwSTHCsHlx0zr/7xZL
 P60Wf3qsdcXV+StjLt8/Hljlzz39eLkBK2ON12fPtjtfJ1z59cGGI1LySpv5RXeuN673uwU8
 piempnp1mX9WYinOSDTUYi4qTgQApL51q9kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xu7oz/uklGfzu5bNYfbefzWLW7dcs
 Fr/Pnme2WLn6KJPFlKtLmSzOvz3MZDHp0DVGi/nLnrJb3JjwlNFizc2nLBbrXr9nceD2uPxn
 P5PHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7ZwOaxs/U+q0f7gW6mAM4oPZui/NKSVIWM
 /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzlJ3rZCvZKVPxv0Wxg
 3CvSxcjJISFgIvG3qZ2xi5GLQ0hgKaPEpoVLmSESMhKfrnxkh7CFJf5c62KDKPrIKLF513d2
 CGc3o8TN11eYQKp4Bewk3p65xAZiswioSqw9MYcdIi4ocXLmExYQW1QgQqJt2RSwDcICCRKH
 Vt0E62UWEJe49WQ+mC0icIdJYtmBJJAFzAJvGSW+T3/ACrHtFKPEvl9bgKo4ONgEtCQaO8EW
 cAq4STRNOMEOMUhTonX7byhbXmL72znMIOUSAkoSsy/rQXxTK/Hq/m7GCYyis5CcNwvJGbOQ
 TJqFZNICRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgalg27GfW3Ywrnz1Ue8QIxMH4yFG
 CQ5mJRFeq6V6SUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5iM8kriDc0MTA1NzCwNTC3N
 jJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamGw6KpYHyS5k/NNzpmSLfdzXzaeC799cpxt8
 WUknjPWY8fVmd27emkMz7i86sOvD5fbMTTP9ZXW6Zl48fbfdeo3cb+tXh/+5TVgpJ2iZYM4y
 o/mPwyd+y+tGO1XLLZk+iLtuPu/YETkv70Lzh5rnJpZxqlFilq8tXHw+7o5+fzF3hcR9+00v
 YjZMNzf/uep4k5DcxQcR2+7Pbcjy+XXkYMnMurKz74rWnA9gLl/iyJ17prVnfewFg3n7V/xz
 naFSdnVpiPaq94y7ncw2BHfG8yQ1fbc+82BWdPPfLAfdeUc3TP+tpVq1lPORqoH3nrt8vkmf
 Q9+Fxf275Jhw8mZx1dY5vZzMvkdfMqXzXXOdY6HEUpyRaKjFXFScCABS2NldjgMAAA==
X-CMS-MailID: 20220314083640eucas1p1b35a57f590b2422c1461f164543d3f49
X-Msg-Generator: CA
X-RootMTR: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
 <07484796-d692-6247-427f-20d0e9ac6193@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_013647_366197_F2A472CC 
X-CRM114-Status: GOOD (  22.12  )
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

Hi Damien,

On 2022-03-12 09:14, Damien Le Moal wrote:
> On 3/12/22 05:16, Pankaj Raghav wrote:
>> Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>  drivers/nvme/host/core.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 51c08f206cbf..67a78653b07c 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1913,6 +1913,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>  		ret = nvme_update_zone_info(ns, lbaf);
>>  		if (ret)
>>  			goto out_unfreeze;
>> +		/* nvme_update_zone_info might set the namespace to be marked
>> +		 * as read-only. Call nvme_update_disk_info so that the disk
>> +		 * is updated with the appropriate permission.
>> +		 */
> 
> Multi-line comment block should start with a "/*" line without text.
> 
>> +		nvme_update_disk_info(ns->disk, ns, id);
> 
> It may make more sense to move the "set_disk_ro()" call at the end of
> nvme_update_zone_info() into a different helper (say
> nvme_set_disk_mode()) and call that new helper here to avoid going
> through again all the settings that nvme_update_disk_info() does.
That is a good idea.

Based on a quick check, we don't do NVME_NS_FORCE_NO anywhere except
zns.c, so would it make sense to do the following change then?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51c08f206cbf..cde33f2a3a5a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1855,8 +1855,7 @@ static void nvme_update_disk_info(struct gendisk
*disk,
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);

-	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
-		test_bit(NVME_NS_FORCE_RO, &ns->flags));
+	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
 }

 static inline bool nvme_first_scan(struct gendisk *disk)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7ccdb119ede..b6800bdd6ea9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -607,6 +607,11 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }

+static inline void nvme_set_disk_mode_ro(struct nvme_ns *ns)
+{
+	set_disk_ro(ns->disk, test_bit(NVME_NS_FORCE_RO, &ns->flags));
+}
+
 /*
  * Fill in the status and result information from the CQE, and then
figure out
  * if blk-mq will need to use IPI magic to complete the request, and if
yes do
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..4ab685fa02b4 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -113,6 +113,7 @@ int nvme_update_zone_info(struct nvme_ns *ns,
unsigned lbaf)
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
+	nvme_set_disk_mode_ro(ns);
 free_data:
 	kfree(id);
 	return status;

-- 
Regards,
Pankaj

