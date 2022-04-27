Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B95BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PnDK63gcXNRgV//CCqerJpeFWxiM6q0NYD5whOcQOd0=; b=fTKVy0/RgUHwuxR3pbz6f/nR4l
	BVFhCV/5PRGTM5lP6fzSuEWYWfiDSY+AcUTeuVoZ3p0LwPFY/4vWGgYTi7YedXwj1/NzZ7gH8b1K7
	suoks6v3IHVffGWCPRaCi60weM/ZqzjPD+xHN944BKXBRvm7iFelOuZ6RWieK548QNTLv0K54OjvA
	7SLv/+m1pN9pJDd68ZVSXFfO5OFNOzBpwid4Tb2mS4v33L3Z35juygpjrW5o+uAyY32XxG2GOZkb3
	cHa/5D4uGYoqFdYPKU+nTlTuO2MJf078OG5KkEqt8oq41f3Bsx9F4hIqi6tKq1nw/3nlW3li1CqbE
	cX94W9FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njr8P-003wO9-Dg; Wed, 27 Apr 2022 23:31:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njr8M-003wLz-3N
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651102306; x=1682638306;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gLrzp6duhkPkV6taMyjQM6C7cL2l+fGNVwimG4CXPYA=;
 b=AEnEHyF44+539+IA4NWRlxR+r4v9VzOmbb5w28WgVoe1oTQBU+IkdNTz
 HlBO4gTsGvMIlEHUS5qGxARcix/GW8Ap1LhEhVA7xsEAUzp4493h1PWhC
 fYfZFYjlFszCM7sf/EfUkk7J/gYcO7vYGF9BQrJ41QND0xNEvJsyvpd9j
 W8bJwam20737O/schrrgtbFZqcXZQHPvG8iNjVO0fvHMyIS3nERtCgS9k
 RiiYvueg+O3h7ulBOBFB4bMJjwXXmFYC3BwVfSmlY7l1WuJ+TsLnPgbRa
 z7ttdAkbHtua6BxhXZzTkoZcDqBwRgrML3/+wmpjxJiKXE4oCdccgM6tX Q==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="199893151"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:31:42 +0800
IronPort-SDR: kY6pecXy07vRFIoY9RE4IrmMQKaA46q/1PZ7j39TDIqYa7zyRCximhoxx6JOuWeuAJaEM6mACd
 tIPTwwqc2a88yuqNaIGrH8jU/KOoxt5gWelv6H/i+DV0BmVYXc7wRer3RRtgA4LiyblNgSID2u
 0vZZp0hY4jRj3lYHQJeb26wrx/jkv+WxH2l07GemLbytZceIbbikfJS7//GZYn7vGrPMkltSsq
 9v9VMs6jTXuGG4UG89jZxAqRn77viyge5b4tzONcrqMo6WN0BCErQMc0Q7ZL0KzOg2QEoVUrHW
 3+nmTnnuZhdX9qWT+pEaiCxu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:01:50 -0700
IronPort-SDR: Qa3skU+xJ6cKZMFvPB9gv0kQJF7JHVskB4XZ4pdvc/w3jjaQuHG5sOcytldsfTOB3P97Dre4Ro
 G7zLz2fcGb2lxk5VNdaYBqM1bfepxfBlj8quPpg18u1AtGN+11oWgeXPaD8sGFYg/Ht8LESouX
 ydF+JqI2Ik1xR17hr4pD1vaBubHRJYzM91IgYxfqL7AYH/F36QcqdVNlEsqiuL87kQe8+gEUyX
 m17UXQLGudS8kXThGLpLBLVKipAfpauJIs9fmtHClBJRdt02T/gsZdhvbybf/5ZMTocylSaU94
 gwU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 16:31:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpZlJ6NRKz1SVny
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:31:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651102299; x=1653694300; bh=gLrzp6duhkPkV6taMyjQM6C7cL2l+fGNVwi
 mG4CXPYA=; b=PdTQSxxj3EOLpYEGcnBYVKUPguXiBCCpr5ymI7+k28TTGz3mfSs
 KbvC8k3lhS5m6XprU6x/phnhFmDH5Zdpl9mtNhPvxWLwoLZA79RJ39tzK0T66DJg
 cQ1J9s5aD6mTMKCIx7SKO/H0j3TVPipsOior8762yACFqgZPSPwSaryNVkrWfY9P
 vFK6Qn1Dlh6ebNdzrLYEPjfHxjH1TIuA8nWpktFuNYhAu/AUjrulRyzZmZH+ftr1
 f82lyX/KB3APT/Gb/yPBy31svE2vEO1vB1f3Yyd5uBMXra+42NUkawZ+Cd66ga7/
 bklmIOigH4dlDMngOOGM9ReZ0ePeHAN6LGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id P1pkrRnbZxQh for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 16:31:39 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpZlB5PzJz1Rvlc;
 Wed, 27 Apr 2022 16:31:34 -0700 (PDT)
Message-ID: <652c33b5-1d85-e356-05b9-7bd84b768143@opensource.wdc.com>
Date: Thu, 28 Apr 2022 08:31:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
 <20220427160255.300418-4-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_163146_234584_F12A90D9 
X-CRM114-Status: GOOD (  22.33  )
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

On 4/28/22 01:02, Pankaj Raghav wrote:
> Many places in the filesystem for zoned devices open code this function
> to find the zone number for a given sector with power of 2 assumption.
> This generic helper can be used to calculate zone number for a given
> sector in a block device
> 
> This helper internally uses blk_queue_zone_no to find the zone number.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/blkdev.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f8f2d2998afb..55293e0a8702 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1392,6 +1392,15 @@ static inline bool bdev_zone_aligned(struct block_device *bdev, sector_t sec)
>  	return false;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)

q is never NULL. So this can be simplified to:

	return blk_queue_zone_no(bdev_get_queue(bdev), sector);

> +		return blk_queue_zone_no(q, sec);
> +	return 0;
> +}
> +
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);


-- 
Damien Le Moal
Western Digital Research

