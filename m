Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCBCC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8/XljWZrmcL2YdcuWDBrkYF7wQr7RHmdlPcVPREXheY=; b=CoimJrpGs/6UtsA3WC/jKNESCe
	J/IoqPUkJ6cV8kxPtq4EpPyy8ofXzU5ur6J7QrQRAqCgRKQNnGqJRK3W/kbS0zQ5Gwx21RKZUQTvH
	h+fZWNzOPZlCXKWmIbQqTsAkddlOM/eaIL/rW5ywIjD4Ps8f95QnG777ehwvpyS8Bs1vqAIj//cuU
	4K6+KTHdviedN4UjlmdqUhr5BNQMC4EF5Ms4AeA1p1cbUt9Q8B206Cy9uqA4R4x4BHKLozbnstaAs
	XyOsvtyp4VH4rgYph1UkhG+qFla5pCvPDm6vxRdle40NflT+vCZD2uRLpfwRJ6ft5EiUzUGsViXPR
	uYmyAIiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Z6j-00G9II-Gp; Wed, 15 Jun 2022 19:55:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Z6i-00G9IA-Da
	for linux-nvme@bombadil.infradead.org; Wed, 15 Jun 2022 19:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8/XljWZrmcL2YdcuWDBrkYF7wQr7RHmdlPcVPREXheY=; b=Smg02axWWFOzSLkQ1MAheC7JEP
	SJ/CKjft9dSD4tgHQ/prrWKSi+UjVmSJukWNZvgcLeZ/4NRVD8QwO2fI5+rqTGoVNHHl7MMcIFhTk
	dz/zDpWCjZ0e1FaJLuJqP1ulojg090QLnCsRWhfPkBlUFFzQXA+8eb0P8fIbDIIXo+G6zIsXoGemo
	WKfbIpKoBvMosBfiHcZxiVbHhLd6ObgW6JD27G+xQCaZ3LFBCollqX4w7j7tBIy0gVmCLEyaW1DZr
	bW8e7xcWBrjUAPUnlP/bI3E2i3CGj3pak2Bvy1I3Q1YsOwF9mQEMr4Cf+rWPDsmiw86SrXTzsf+Lo
	ENCq9NQw==;
Received: from [2601:1c0:6280:3f0::aa0b]
	by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Z6S-008D8F-P3; Wed, 15 Jun 2022 19:55:03 +0000
Message-ID: <0480d917-94e5-20ab-514c-bb1374a8d9c4@infradead.org>
Date: Wed, 15 Jun 2022 12:54:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 damien.lemoal@opensource.wdc.com, axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
 jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
 dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
 dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
 Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220615101920.329421-14-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi--

On 6/15/22 03:19, Pankaj Raghav wrote:

> ---
>  drivers/md/Kconfig                |   9 +
>  drivers/md/Makefile               |   2 +
>  drivers/md/dm-zone.c              |   9 +
>  drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
>  4 files changed, 288 insertions(+)
>  create mode 100644 drivers/md/dm-zoned-npo2-target.c
> 
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 998a5cfdb..773314536 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -518,6 +518,15 @@ config DM_FLAKEY
>  	help
>  	 A target that intermittently fails I/O for debugging purposes.
>  
> +config DM_ZONED_NPO2
> +	tristate "Zoned non power of 2 target"

	         "Zoned non-power-of-2 target"

> +	depends on BLK_DEV_DM
> +	depends on BLK_DEV_ZONED
> +	help
> +	A target that converts a zoned device with non power of 2 zone size to

	                                           non-power-of-2 zone size to

> +	be power of 2. This is done by introducing gaps in between the zone
> +	capacity and the power of 2 zone size.

All help text should be indented with one tab and 2 spaces
according to Documentation/process/coding-style.rst.

> +
>  config DM_VERITY
>  	tristate "Verity target support"
>  	depends on BLK_DEV_DM

[snip]

> +
> +MODULE_DESCRIPTION(DM_NAME " non power 2 zoned target");

                                non-power-of-2

> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
> +MODULE_LICENSE("GPL");
> +

-- 
~Randy

