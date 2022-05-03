Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DRk7BATbee0He7UZ5VJP77cBX11TJXZ34BYAwZ+8AgM=; b=O5prl4tHTDwGHxPqUio2ieIjNU
	1+tuy4gSm532ICEo4ZZhFjXdI9r/HFN4UmtH6E5xF/Q4Rng+oZbe4K0hSZ81FpiQh67eZaOABtxbG
	djuobqXRFN4gZQzpFEHGZ7nhZN0661NzhliQpWQVVaOW02Hl4RZ3jSxxeFfr8AXdoBhFQWqYRuTjT
	2Ol5i5sFLXPXpqe9qWLA1CsZc7WithHgk8h8Ss84nN5am37VlxAHzIxEbdi9egSX8p8CYfHimz43x
	Cg9KmBmMVvU0nRGeuIutdHet4EGfrzn+8Y7GIVXZayOM8YMItdFxfcPK4oDiKxsZIDiIbXrECQHdB
	BTnS+4rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlvuP-006sFW-9V; Tue, 03 May 2022 17:01:57 +0000
Received: from mail-oi1-f179.google.com ([209.85.167.179])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlvuM-006sDH-8k
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 17:01:55 +0000
Received: by mail-oi1-f179.google.com with SMTP id r8so18806112oib.5
 for <linux-nvme@lists.infradead.org>; Tue, 03 May 2022 10:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=DRk7BATbee0He7UZ5VJP77cBX11TJXZ34BYAwZ+8AgM=;
 b=g5pTBQ4Vt2C0XcsfMjEMkzrpH4+5fZQ+xXfzhVXkEvMJag7tpx3eVRnXJNodBGzE+/
 5DkaF1hA8n9zS2DokX3T3HFsZODffiwsJFwLHwQRyQi+GqhtDseuAvjfTCPRJJQi3880
 qz139w5fQ7MFVtYAkZ7AGNHlK5GI7SACcsMva58fMwX3pmPanKqQgDOzD6BDkwby0lh2
 pWZRRId7UM7YjYXT+s0GKsaUL2fbCqUiu7C2CvpyiMAvEnCTc5UrI4Ddbu70AqBm/Plb
 8osoGFs+1WQZQiZSBJGZGH70oGIIQfXAXCTkXxoNxGlEJxxBjJ3CFhhqGgGuBU0dgoat
 OcFQ==
X-Gm-Message-State: AOAM5311JoQ5An9LyrNY3P2D+yWwKs/6fYzaL3jhhC6VZQc6nI09kZtC
 cIVHfuhaQl0jTLKsuWg+/yA=
X-Google-Smtp-Source: ABdhPJzQ7nN1tdLufKhuqG6pqOb+aTzQGH1sI9Wd1lN/gZWKJGxCZu7MZvXiQsv6VotmI9tLD36qJQ==
X-Received: by 2002:a05:6808:1b10:b0:326:40f5:930c with SMTP id
 bx16-20020a0568081b1000b0032640f5930cmr840804oib.281.1651597309459; 
 Tue, 03 May 2022 10:01:49 -0700 (PDT)
Received: from [10.10.69.251] ([8.34.116.185])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a4ad5c8000000b0035eb4e5a6c6sm5071917oot.28.2022.05.03.10.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 10:01:48 -0700 (PDT)
Message-ID: <1b7f3aac-0941-2554-d966-01a6bf76cc58@acm.org>
Date: Tue, 3 May 2022 10:01:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 13/16] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
 naohiro.aota@wdc.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
 dsterba@suse.com, johannes.thumshirn@wdc.com
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, clm@fb.com,
 gost.dev@samsung.com, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
 jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
 kch@nvidia.com, linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 jiangbo.365@bytedance.com, linux-fsdevel@vger.kernel.org,
 matias.bjorling@wdc.com, linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160310eucas1p28cd3c5ff4fb7a04bc77c4c0b9d96bb74@eucas1p2.samsung.com>
 <20220427160255.300418-14-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-14-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_100154_334300_11A48DFF 
X-CRM114-Status: GOOD (  12.61  )
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

On 4/27/22 09:02, Pankaj Raghav wrote:
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index c441a4972064..82a62b543782 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1931,8 +1931,8 @@ static int null_validate_conf(struct nullb_device *dev)
>   		dev->mbps = 0;
>   
>   	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	    (!dev->zone_size)) {
> +		pr_err("zone_size must not be zero\n");
>   		return -EINVAL;
>   	}

Please combine "if (dev->zoned &&" and "(!dev->zone_size)) {" into a 
single line and leave out the parentheses that became superfluous.

Thanks,

Bart.

