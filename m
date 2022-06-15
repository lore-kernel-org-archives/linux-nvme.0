Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675ADC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 20:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tCKjUEEB/O98mq0HYBwtkHqa14AHHAARD8/Yh00PhZE=; b=4e7PtitkptC3bQvmelwsk2lC7f
	6x2oQRCLlRnOzDyBmqusg2Fw9+sUuiS7+YbrHmyjOWCaUYg9RdaOzCJgbr9ebvUkSN2s4KW50gjQF
	Jwkyd/9fErY2aSJHZq05KOMmmnGl/2ggb6rgunSt0xnLTkoSWmc/nz9H7oCCyf+xT3jhc2utAKpKQ
	T0Fa6hNMdmp5r9xCoX6UHEEMPCZ1xeJgfFWscmY55PCe3Wfa+TllVzVrYx4x++dqB73kldqBqM5a9
	spE3VFCuO7sNhSVEsGqzQradFE35fQJBIRNGqFcPfLlUPjpPG4lQMnfoGQ9RsCohJJQ4vbzIckPrG
	GsKLTNYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Zcc-00GFEt-MB; Wed, 15 Jun 2022 20:28:14 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Zca-00GFCx-Bl
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 20:28:13 +0000
Received: by mail-pj1-f50.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3203071pjl.5
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 13:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tCKjUEEB/O98mq0HYBwtkHqa14AHHAARD8/Yh00PhZE=;
        b=16ibb3gJIBSoufj22oHY8EUGLDtf8yBnvnl9Do7AfCxob7jASZLWILozkhHRgjg13v
         BNzlAgFOSLv3f5fQxgS13VobXeGS/KfMxeQ0dp6aCkeZP20k5auhBdZ/V3XR/rr4+4ey
         jhcxUhb3tSSz+CRzONK9xrlIXBsGQ4C10SvuPvP3jbdsje8P63WHiZY7qiDfGnLutL/J
         kAReMTIokP6rklM8RiN75M0m0OzjbXF4EJ7zRXWs7PhnW232kRSHE7Lq2hi/weelNWSf
         NajAVMPihMV6NNDrIrlTGzCzKmdH2TOz0ThQZJSrf25NbfUs2j+PdzSBt4fhSFlTYrfk
         W6iA==
X-Gm-Message-State: AJIora/ciXyQfKyCP1+PZcPTwnc9UYDnjuQQtVPQMLoQYdMkaSsCvkeJ
	j3MZj1rzj553eHIxCNz8wd8=
X-Google-Smtp-Source: AGRyM1ssYRY17vRnuP2ETISK730/klJkF/7+lw/tAz1SHcUNuW29npshKuTZX6r5VdStdPt6uTHY9Q==
X-Received: by 2002:a17:90b:358d:b0:1ea:4718:82b8 with SMTP id mm13-20020a17090b358d00b001ea471882b8mr12165746pjb.244.1655324890558;
        Wed, 15 Jun 2022 13:28:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001676f87473fsm8523plk.302.2022.06.15.13.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:28:09 -0700 (PDT)
Message-ID: <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
Date: Wed, 15 Jun 2022 13:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 damien.lemoal@opensource.wdc.com, axboe@kernel.dk
Cc: pankydev8@gmail.com, gost.dev@samsung.com, jiangbo.365@bytedance.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 jonathan.derrick@linux.dev, Johannes.Thumshirn@wdc.com, dsterba@suse.com,
 jaegeuk@kernel.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615101920.329421-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_132812_453481_02CC83D7 
X-CRM114-Status: GOOD (  18.91  )
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

On 6/15/22 03:19, Pankaj Raghav wrote:
> @@ -489,14 +489,27 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>   	 * smaller last zone.
>   	 */
>   	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zone size", disk->disk_name);
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * Don't allow zoned device with non power_of_2 zone size with
> +		 * zone capacity less than zone size.
> +		 */

Please change "power_of_2" into "power-of-2".

> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
> +				disk->disk_name);
>   			return -ENODEV;
>   		}

The above check seems wrong to me. I don't see why devices that report a 
capacity that is less than the zone size should be rejected.

> +		/*
> +		 * Division is used to calculate nr_zones for both power_of_2
> +		 * and non power_of_2 zone sizes as it is not in the hot path.
> +		 */

Shouldn't the above comment be moved to the patch description? I'm not 
sure whether having such a comment in the source code is valuable.

> +static inline sector_t blk_queue_offset_from_zone_start(struct request_queue *q,
> +							sector_t sec)
> +{
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +	u64 remainder = 0;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return false;

"return false" should only occur in functions returning a boolean. This 
function returns type sector_t.

Thanks,

Bart.

