Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDA2C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 23:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t4qis+J9QIOKnM3fbYktt9NFhZKrRI7DhwX8G2bL9zc=; b=F/L9o7LXeTRPFK3dXuM9IR+kZY
	5zJNVKrOe5yzQatJzUl6aP/KDpE2Qv1ErYOY9ZAVUAB4m0CyJEcD9njH8L9Q5cIsbo8zKrYOrYfNm
	NS1RzMJ+HMpVFVcVLUy1sVXKx3sQbX5fYyVUZeHI4WOri/Nw91h5D74qwIDmdEowHkd0LOB/XITQZ
	myKKI94Jeas42VsPh+Ua5GITuhQPtd8+w+/1XSJt5cNCV3HMkiJa3IqLuz/NKsH0kWwPjU9SGgeuB
	rZVa7xRVE+wxg65v/ZnlrNWX+QRxAcudL9H5FBERYfShPFR2n1NFuglolUVONeQA1H/IZBnZH5ife
	J6Yrq2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njrTy-003zy1-Kr; Wed, 27 Apr 2022 23:54:06 +0000
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njrTu-003zu9-4s
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 23:54:03 +0000
Received: by mail-pl1-f178.google.com with SMTP id n8so2913577plh.1
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 16:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=t4qis+J9QIOKnM3fbYktt9NFhZKrRI7DhwX8G2bL9zc=;
 b=zUPhSml1x/ftxylclT/qUjd0XyCCOIypY1NLIjGwStOS+EZCEkxYzaIzWEt09NZtW5
 MZnv6XEVV2J9psNC8HGAh7pExXSJcvvIt88W2vFjm3A1YFu8cCbFW1Bq8wdmwO79hHx8
 GWrzF5M7ZG0BvO0VE083xtnOyvon+bBmiOBhh58GgDkE3NbTvraUcnxtGLhmR7ADiLP4
 otse/HuY3/XHjsx5SMGXkSPRSkzQ5/YuzStbW16XpU6KNn29Gh+DufkbhXt8x8w9QhH/
 iIaLoM0+xsI3gTH9dTvCmLa932aMEUFw3rGsjOovZ6YNB0gAu/mSLxPpSvqKbc45K0Nx
 5I+g==
X-Gm-Message-State: AOAM530vUfgcNaCF4NHgA3vOFpcE3wVSHM/QP+9gYvj8E3v/DsHJDbbX
 obOncAKjXRbGiDDCE0G0BZU=
X-Google-Smtp-Source: ABdhPJzohQgvyNpdAnb7nqeKJuNjp6awQ1YNHqFULIu63hwwYMU72SrE0583NaL55rzyxWBEIH5+Qg==
X-Received: by 2002:a17:902:cf0b:b0:151:9d28:f46f with SMTP id
 i11-20020a170902cf0b00b001519d28f46fmr30536375plg.53.1651103639942; 
 Wed, 27 Apr 2022 16:53:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6cbb:d78e:9b3:bb62?
 ([2620:15c:211:201:6cbb:d78e:9b3:bb62])
 by smtp.gmail.com with ESMTPSA id
 p125-20020a62d083000000b0050d475ed4d2sm10860790pfg.197.2022.04.27.16.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 16:53:59 -0700 (PDT)
Message-ID: <bc18532b-a98f-26f2-4dd1-d189c0415820@acm.org>
Date: Wed, 27 Apr 2022 16:53:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/16] block: add bdev_zone_no helper
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
 <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
 <20220427160255.300418-4-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220427160255.300418-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_165402_238197_8ECDEB4A 
X-CRM114-Status: GOOD (  11.32  )
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
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_zone_no(q, sec);
> +	return 0;
> +}

This patch series has been split incorrectly: the same patch that 
introduces a new function should also introduce a caller to that function.

Thanks,

Bart.

