Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5FBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=npt+AhUr4EnDMpvqyUKW9i3aLCP49ObvZ1boTG4Bu9M=; b=pqcIPPviVkAAjN
	i69yJfl+53zqj7LsgADgXhBYU5l7XyJwoeTnU+S4TAeC3S6uy4HGk2aZDTL9OTNGFnt0tgDN7gTuJ
	fgQo+bxK1xx7+LvNkMHHBnM5d+T5KZAlOvTYrOrsp7CH4xLiskM10bs3GI+FBeMlx2H26bQy4j11V
	0PwRZ63sVVXwS9ZOGrsklPEM7THgzWf8T6DLQezdCkM8LsuXSxhmPcYLwDtoL1xB/nIU18pGW/nkc
	6ZX9IHs4Cv50Ucm4AcxeB4xi6Smmn/runi2wP3vltZhgGCYdDW5ukWpYqUbubjDURD/bBH0TW+hvP
	iQwtdldlPSKQk9BvgTBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUUdm-00DGXu-Ir; Wed, 16 Mar 2022 14:28:42 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUUdi-00DGXL-UT
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 14:28:41 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220316142836euoutp026ea60ba8bbfc6f54000441caa8af1363~c4sjgPHKb2577625776euoutp02v
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 14:28:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220316142836euoutp026ea60ba8bbfc6f54000441caa8af1363~c4sjgPHKb2577625776euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647440916;
 bh=npt+AhUr4EnDMpvqyUKW9i3aLCP49ObvZ1boTG4Bu9M=;
 h=Date:Subject:To:CC:From:In-Reply-To:References:From;
 b=lgvqaJmk7LMW3oz8B0tONbaBHUVLwcT0DDMOHlLfwZeA3EatrUxJXfBG91pssbZza
 Rcy9vGwT91dhzi7RzvrgKOuprsW44LtbI4L2qAm7APMv2ngriN0XW6mwvcpLx9DQuf
 X3K3dqqugyEc9ibWVYh69QM0GednvVD2pMwIofZ4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220316142835eucas1p2d931d4b28263faed879c7503a5477839~c4si7KI5N1291812918eucas1p26;
 Wed, 16 Mar 2022 14:28:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.FD.10009.314F1326; Wed, 16
 Mar 2022 14:28:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220316142835eucas1p2f87c23ebf05380069c03944f181d5e37~c4sigKVU11291812918eucas1p25;
 Wed, 16 Mar 2022 14:28:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220316142835eusmtrp2196ef2c0c87bc9467b7e8cffd5e2db65~c4sifar1c1041410414eusmtrp2T;
 Wed, 16 Mar 2022 14:28:35 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-dc-6231f413c67a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.37.09522.214F1326; Wed, 16
 Mar 2022 14:28:34 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220316142834eusmtip10241ba674b82bc86e455fadc807deddc~c4siTvuj_2533225332eusmtip1U;
 Wed, 16 Mar 2022 14:28:34 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.179) by CAMSVWEXC01.scsc.local
 (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Mar 2022 14:28:31 +0000
Message-ID: <72344561-a6fd-bb61-bed1-3aa12bd8cc02@samsung.com>
Date: Wed, 16 Mar 2022 15:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] nvme: Fix zns drives without append support to
 export correct permissions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, Keith Busch
 <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, Jens Axboe <axboe@kernel.dk>, "Luis
 Chamberlain" <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav <pankydev8@gmail.com>,
 "Kanchan Joshi" <joshiiitr@gmail.com>, <linux-nvme@lists.infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220316105016.GA9393@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.179]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87rCXwyTDFoOSVqsvtvPZvH77Hlm
 i5WrjzJZ/O26x2Rx/u1hJotJh64xWsxf9pTd4saEp4wWa24+ZbFY9/o9iwOXx85Zd9k9zt/b
 yOJx+Wypx6ZVnWwem5fUe+y+2cDmsbP1PqtH+4FupgCOKC6blNSczLLUIn27BK6MLW/OshX8
 EqrYdc64gfEWfxcjJ4eEgInE8Ye/2LsYuTiEBFYwSnRe3ckMkhAS+MIosepYKkTiM6PEsaOL
 2GA6tl9ZygaRWM4osfbABXaIDqCq3R0aEIndjBI/194AS/AK2Elsm7yXFcRmEVCVeHXlOzNE
 XFDi5MwnLCC2qECExMsjf5m6GDk4hAWSJV5ejwUJMwuIS9x6Mp8JxBYRUJJ4+uosI0T8G7PE
 i7cOIOVsAloSjZ1gmzgFtCU+rlgBVaIp0br9NzuELS+x/e0cZoj7lYGefMQEYddKrD12Bux7
 CYH1nBK/Z1+DSrhILNi0G6pBWOLV8S3sELaMxP+dIPeANPQzSkxt+QPlzGCU6Dm8GewBCQFr
 ib4zORANjhIPT1xmgwjzSdx4KwhxEJ/EpG3TmScwqs5CColZSF6eheSHWUh+WMDIsopRPLW0
 ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMweZ3+d/zTDsa5rz7qHWJk4mA8xCjBwawkwnvmhX6S
 EG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqa5fqwhrf0K
 oinpE389ZvPl3d1/Wmy1sdvaC0+uahzZz7u5g3Pegd/qESlHU7KmFbn1v1/Ip+rTFvroqZrT
 n8oLuw+aLwviY51xuW6L/kIZqV+JWxuKOcX4+i/+yHyVpSgxzc//3AMZ7YMLbT58a+6smM0b
 qGz978aOAzE/9Dbf51ut5KBvc5zlcsan9Mj7TZMjLwprm7E/v9/wNTXFLqDJ8k/ToykG8kFX
 W3kLnVhCufVyilw5xd7tMAxbdzw/bIX59uzQ7K2WmUxissfvPeWPmpTQ5ed75u0S/yb+WV/E
 xZJL+yzL7qz4K76u1XLS9LbLR9Z4BYVxdmZflnzMuWrB0mVfOY6+PGxUxeOxVomlOCPRUIu5
 qDgRAJqMiuLNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7pCXwyTDJ78NLNYfbefzeL32fPM
 FitXH2Wy+Nt1j8ni/NvDTBaTDl1jtJi/7Cm7xY0JTxkt1tx8ymKx7vV7Fgcuj52z7rJ7nL+3
 kcXj8tlSj02rOtk8Ni+p99h9s4HNY2frfVaP9gPdTAEcUXo2RfmlJakKGfnFJbZK0YYWRnqG
 lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZW96cZSv4JVSx65xxA+Mt/i5GTg4JAROJ
 7VeWsnUxcnEICSxllFjz5DIzREJG4tOVj+wQtrDEn2tdUEUfGSVudLxhBEkICexmlPjS5ARi
 8wrYSWybvJcVxGYRUJV4deU7M0RcUOLkzCcsILaoQIRE27IpYHFhgWSJVWvPsoHYzALiEree
 zGcCsUUElCSevjrLCLKMWeAbs0TTtSfMEJvXMEqsXHUd6CQODjYBLYnGTrDrOAW0JT6uWMEI
 MUhTonX7b3YIW15i+9s5UN8oS3RefcQEYddKvLq/m3ECo+gsJPfNQnLHLCSjZiEZtYCRZRWj
 SGppcW56brGhXnFibnFpXrpecn7uJkZg3G879nPzDsZ5rz7qHWJk4mA8xCjBwawkwnvmhX6S
 EG9KYmVValF+fFFpTmrxIUZTYCBNZJYSTc4HJp68knhDMwNTQxMzSwNTSzNjJXFez4KORCGB
 9MSS1OzU1ILUIpg+Jg5OqQYmpi1zMnTW3H2+YJHm0Se6r38tLSjxXPSs/PzZ2GjZY0wXP8W+
 nXysR0rk0uyi6YesDyx92DYl5qlQx3RRf3bHe1feKqR+TnnTGL5U5qkg+/+/ZTxKLWm1l8Vr
 76hUSm6c9WjKO9bFiTN9rm/dveRl9cZfG0JjCuKF/LyS41KVJ14+yrfpumT9reacGZMSDsh0
 b36nZKFxxk4vbuYzi+j3t+ROzJea42XLql3P7v0t9McBFSdRuQrOqfvenE5cHv+t79ztG7OZ
 O6e+KfGLnh51I6/K8sHBKKnGBXmcT/b9P6FzuzTdXMemvrUsLTP2HZvjl2nR+97Ib9BinBW0
 VuVst93f+ROOvnEtd1xYK7hRVYmlOCPRUIu5qDgRAG7g7cqEAwAA
X-CMS-MailID: 20220316142835eucas1p2f87c23ebf05380069c03944f181d5e37
X-Msg-Generator: CA
X-RootMTR: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180
References: <CGME20220316093439eucas1p27c2a31849e9dec6c6bc217c5f1b26180@eucas1p2.samsung.com>
 <20220316093423.17906-1-p.raghav@samsung.com> <20220316105016.GA9393@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_072839_367318_C089813F 
X-CRM114-Status: GOOD (  19.28  )
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

Hi Christoph,

On 2022-03-16 11:50, Christoph Hellwig wrote:
> On Wed, Mar 16, 2022 at 10:34:23AM +0100, Pankaj Raghav wrote:

>> -		test_bit(NVME_NS_FORCE_RO, &ns->flags));
>> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO));
> 
> This will now set a namespace that was read-only due to unsupported ZNS
> features writable during revalidation.

>>  	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
>> +	nvme_set_disk_mode_ro(ns);

> And this will set a disk that is read-only due to NVME_NS_ATTR_RO
> writable if the controller supports all essential ZNS features.
You are right, this is not the right way to fix it.

What do you think about setting the disk permission after the disk info?
That won't introduce any race and also makes sure all parameters are
correctly set:
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51c08f206cbf..b047fc4e311a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1854,9 +1854,6 @@ static void nvme_update_disk_info(struct gendisk
*disk,
 	nvme_config_discard(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
-
-	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
-		test_bit(NVME_NS_FORCE_RO, &ns->flags));
 }

 static inline bool nvme_first_scan(struct gendisk *disk)
@@ -1915,6 +1912,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns,
struct nvme_id_ns *id)
 			goto out_unfreeze;
 	}

+	nvme_set_disk_mode(ns, id);
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7ccdb119ede..fc75564fb0d1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -607,6 +607,12 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }

+static inline void nvme_set_disk_mode(struct nvme_ns *ns, struct
nvme_id_ns *id)
+{
+	set_disk_ro(ns->disk, test_bit(NVME_NS_FORCE_RO, &ns->flags) ||
+				      (id->nsattr & NVME_NS_ATTR_RO));
+}
+
 /*
  * Fill in the status and result information from the CQE, and then
figure out
  * if blk-mq will need to use IPI magic to complete the request, and if
yes do

The only issue I see with this approach is we are breaking the
encapsulation of updating disk related stuff outside nvme_update_disk_info.
-- 
Regards,
Pankaj

