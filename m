Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1CFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79AFRdpemBVck+ntzsW/yKNt4PCLDqnjtmYL3oWIWPs=; b=PxVrsQbwyfid+SEBBmU8fTBxVa
	9oKrIYjIpppmpyj0KgU0mGotuCZy3nK8yf8d2/dwyu5g3wGKx2Q68uhTKf3cDW3T9GN8onL+FF7bE
	qdUrGDrKczz0Bs8iOlA4EzyV9Lvh68iIMPVlJpFTjrl66ytUlaB6TByIDA5Kf1A2HJJeGrv3wW4PM
	JIStyoyg4w1pNxq6srhzviw6DhbyUXVAKnaHOYwB3TwE7XRjNIor2jE1ojPVx54RfevqdTR7C25fM
	5uslNKZIg/WlzBL7hHeiheUoIhIqtRFiYshJeg6IhUC5yZrBuDNRdz8lgJ6Zpi4MBBZdGAKmsddkz
	B25fZa5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njrT2-003zlP-VG; Wed, 27 Apr 2022 23:53:08 +0000
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njrT0-003zjl-6u
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:53:07 +0000
Received: by mail-pf1-f172.google.com with SMTP id y14so2826609pfe.10
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=79AFRdpemBVck+ntzsW/yKNt4PCLDqnjtmYL3oWIWPs=;
 b=j5maOOKzhbB2ievoIszVI1UJlk3SjErAifogZdybL9fRMPScUWOOBAvzRnbZDkc7QB
 QLSzVGfSpj6FYOa64S7lR56upBuoU9WSX0kQnbEnsvht3tgR2CmsaCeRy/ua9X5gXskC
 lxyUQXAZzFWK59e4UZOoRu4BcwG+TVjI49n7tnFyp+4Snxzf+ocy/wwKvxZlNos8E9iv
 MlqLp9P+wydI6SYMQc+QT+M7n66rYPX0i2rOGNSBekU949F7qL5JBU9XEWzP0OvvPXq8
 ViJSNg1ypkj9JPLou7mFqjq7h1C2bSWCV8YRURdyYLfaBwNmRGUgX82KYsDrmbxEMi5x
 SNUA==
X-Gm-Message-State: AOAM530gScYqUvt1mvRxKojxTCr+GYJB6V2w4xktH++pO27kpoPsERgF
 Wa6rPeImydwcE1mZeSY91e4=
X-Google-Smtp-Source: ABdhPJwSGv1Za1U51Sy0XzpwyxC0M8/mR/bjHPIzXDoe+MDiEfgeZRKytqp5jH37HlZvkYhAFK/M7Q==
X-Received: by 2002:a05:6a00:a94:b0:4fd:c14b:21cb with SMTP id
 b20-20020a056a000a9400b004fdc14b21cbmr32159218pfl.53.1651103583186; 
 Wed, 27 Apr 2022 16:53:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6cbb:d78e:9b3:bb62?
 ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
 by smtp.gmail.com with ESMTPSA id
 w129-20020a628287000000b0050d4246fbedsm11710895pfd.187.2022.04.27.16.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 16:53:02 -0700 (PDT)
Message-ID: <df8104aa-ca86-4053-5334-3bc4ff786c61@acm.org>
Date: Wed, 27 Apr 2022 16:52:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/16] block: add blk_queue_zone_aligned and
 bdev_zone_aligned helper
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
 <CGME20220427160258eucas1p19548a7094f67b4c9f340add776f60082@eucas1p1.samsung.com>
 <20220427160255.300418-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_165306_300864_3E7D14FF 
X-CRM114-Status: GOOD (  10.55  )
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
> +static inline bool bdev_zone_aligned(struct block_device *bdev, sector_t sec)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_zone_aligned(q, sec);
> +	return false;
> +}

Which patch uses this function? I can't find any patch in this series 
that introduces a call to this function.

Thanks,

Bart.



