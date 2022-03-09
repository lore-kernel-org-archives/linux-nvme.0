Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39362C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 03:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9WsqfTq04XsDbahuywKi31INBq3/UKgRZ/o2TKQcQ0=; b=tPivNKKMSIvUCdqHsJaiH1ksEr
	Gg3jzaagWy03UspbLuVE3HxZjb6gwy9KawunYKTG4Ex99EQi4IhIB6LruCkNarESPGhYYUe9nbAhb
	DEgQXJvlSqDzzzYDWmRBXmULqNCObmKwP/ownoF4wVvPQMBUaBmnmokjx0l2UE7RXgUws/omoWhI1
	TAPDlpnBNQDv/GBL3mc2ubBKjgN37bcDVN0J8Sw13tfFsABh3W37xvDSOC0zVDVLvPjOxHqZqpaCM
	EdMVGnrynvnMoTdBhEuKzhYSc4ZW+H2o7914VctM1UtfMAu/LUfdywgF0ugTy2LX8+DanT75Oviw5
	CEaxqrpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRnHM-007AYH-WB; Wed, 09 Mar 2022 03:46:25 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRnHJ-007AX0-Mn
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 03:46:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1646797581; x=1678333581;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zNtApz3foCC8So0mUtisC64g+reBs2txhpJweWOmqPc=;
 b=AnZsIFLUxL/thPqvbhBnllKBvwuBvV4l7CyUqNaaini9Sja1+AxiP60G
 tUZhUrrMoj5OONT9Pkp492N0H04ZdXbT7p1LG7R1vURRQ/VmrV6knl+14
 3YyV/W37lgsjSqAyIZM0r9fXSd1Xs/h864cJHaPKLKa2rjCxzUHq7jGnI
 eFxJwW6RlZTRgcKpxVBnxqgG2qs8M0oO0iRDZnVS+apEYGVzpctZhPmgA
 upr0Kmhlpd+tpe8zHyCFA2ImgOvDvEkg//75kiL09k5F2pGiysZT1FGU1
 KbLK2wJCW4u03seklpOobGI1P6a7BeDUw5ufYsPy1GWpWnTIBH8mwhYot A==;
X-IronPort-AV: E=Sophos;i="5.90,166,1643644800"; d="scan'208";a="306776147"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 11:46:20 +0800
IronPort-SDR: oLGYmYD/YZG43cGfLR94ofwat4CplpCsNuMB50BQ5VJA6DSeYMLkgshCW0/9zFXYuooR//c+RT
 MfREodyp+U7f+2WA5/+fvvkGAI0QJ0j7UoLGRIE4YkCqH+2XuYTOwp5AlQVFjaEAaltkgyAswh
 fe7BI2V840lCuqMed9Cpno/gRLYb58IqjaCZ0IXlo3YIEXl4CUPWZOWMcs1P6F9iU3VH3eEVcv
 lEbVJHkakn7cwGXPFmUnkK6ePhdykiXDe5dMOviFg23Z5FyeLFRMB0S7remPd2KRqAqNfkpHjX
 nrNbdXQT7EexaUq7nGg0bucC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:17:36 -0800
IronPort-SDR: o4kFOUi7ij8lfQuqpyBepqFw9pdoihId3TTsBMT9o9ZCTG7rChyLS9dSKCoSywwy2/TUvGzomm
 HvAESU+S5ikVtKzptOwtc7OtYhHQAB+sil3sql8F4dBY48kIclZfes7nI2tb6sttJNiwgfP6PY
 jsGl+XvkYDZLF+yKXn+PmdX+QBXqf+Jm8xuiB1UpnEDJkavqGhc7+xyweDpRJZ16hyk2n7QtIf
 h45XrztEqorqPk/68FTphMgdLp+3ma027Ko6UvBeejb/OYsYzKsp1U6ti6BE/lD9oYiaBxyIXE
 3/4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 19:46:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KCymD1CLDz1SVp5
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 19:46:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1646797579; x=1649389580; bh=zNtApz3foCC8So0mUtisC64g+reBs2txhpJ
 weWOmqPc=; b=iV4wHSmLPcZqZWoDacHmXKv6c0URhDLgWWIhhfrDSTRsiDv1mXo
 fBOUS9povmjjJnx5UfTUXimy2apNPrqw0tJK5uV9ZrZT6ptFO/XKZ3lXMEQwZe89
 0iR/lTgMWvUtTL+6eOosRA+TXPLYMnDGewAnbsvTFJoqAGgLdjdjhBbg5aAMuRvH
 ZAPut2VIYouqGww4L+3DOtgZ8n6WdPQD6y2riNb1736N4l4fPXZVa7UqbPUB9lwc
 An7dEy55yHcmujX8OtXbKkvTX/uTkk6S9w/e1mkZhNdHqV4DP3QeomsUVt/sQCZu
 SX+0Uns0apGRVvJm0n6MpDr8oZ38m0gWgBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id eBS2xcHtvDkD for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 19:46:19 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KCym86Zh6z1Rvlx;
 Tue,  8 Mar 2022 19:46:16 -0800 (PST)
Message-ID: <f08307fe-75f0-0c13-04b3-1b5074d32ec8@opensource.wdc.com>
Date: Wed, 9 Mar 2022 12:46:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/6] block: Add npo2_zone_setup callback to block device
 fops
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d@eucas1p1.samsung.com>
 <20220308165349.231320-3-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220308165349.231320-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_194621_789204_4CAC49AE 
X-CRM114-Status: GOOD (  26.11  )
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

On 3/9/22 01:53, Pankaj Raghav wrote:
> A new fops is added to block device which will be used to setup the
> necessary hooks when a non-power_of_2 zone size is detected in a zoned
> device.
> 
> This fops will be called as a part of blk_revalidate_disk_zones.

And what does this new hook do ? You are actually not explaining it, nor
why it should be called from blk_revalidate_disk_zones().

Also, blk_revalidate_zone_cb() uses bit shift but this patch, nor the
previous one fix that.

> 
> The primary use case for this callback is to deal with zoned devices
> that does not have a power_of_2 zone size such as ZNS drives.For e.g,
> the current NVMe ZNS specification does not require zone size to be
> power_of_2 but the linux block layer still expects a all zoned device to
> have a power_of_2 zone size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-zoned.c      | 3 +++
>  include/linux/blkdev.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 602bef54c813..d3d821797559 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -575,6 +575,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>  	if (!get_capacity(disk))
>  		return -EIO;
>  
> +	if (disk->fops->npo2_zone_setup)
> +		disk->fops->npo2_zone_setup(disk);
> +
>  	/*
>  	 * Ensure that all memory allocations in this context are done as if
>  	 * GFP_NOIO was specified.
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a12c031af887..08cf039c1622 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1472,6 +1472,7 @@ struct block_device_operations {
>  	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
>  	int (*report_zones)(struct gendisk *, sector_t sector,
>  			unsigned int nr_zones, report_zones_cb cb, void *data);
> +	void (*npo2_zone_setup)(struct gendisk *disk);
>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
>  	/* returns the length of the identifier or a negative errno: */
>  	int (*get_unique_id)(struct gendisk *disk, u8 id[16],


-- 
Damien Le Moal
Western Digital Research

