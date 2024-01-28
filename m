Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1ACC47DDB
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CCpOX+eVqL1Q4NSGNGjhENwjH4eu1N22wi+8Wiglz6U=; b=zv8UWjc1Ev9Fv5JIG2BD9gJ+1Q
	WbCH4+XS3HgIfyM56y+nk5g+fhDwJZQJKMbzF/esr9OnpjfqSwldsW9wZeHCxUGEsewIx6Sj/Y2aZ
	ySGIcbf7Wby7warQJWQiAAh07hctgsZwRjP+YQmCQS9gbfg5KVeW4UmCXDAuJiEEcNjB6BbbLjS4v
	Oj1+uHDoBOgUSqOp8jK/bud4BDsR7kzdx1379HRL7ABNfeI1KZlohhhhC4HzoNbKRuYF1TvSpuzZK
	NciODbyqU/OMdUklEpK/eRGLuXs/bn666MWqRr9hGBrNVEhL18hmGOSxKAd0mDHOJEmsJXbOginr9
	8HG+RCew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUEdl-0000000Aku9-2OI7;
	Sun, 28 Jan 2024 23:32:41 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUEdh-0000000AkrV-2EUH
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jan 2024 23:32:38 +0000
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8d747a3bcso2500755ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jan 2024 15:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706484756; x=1707089556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCpOX+eVqL1Q4NSGNGjhENwjH4eu1N22wi+8Wiglz6U=;
        b=Yes0iL9epMNVpAC8caRIfhMDU0Zz4QbXVch6FiGxQ5UK1KDVH2SjQEDm8L+bQtxqpW
         4oYHNPP72XJgKT6mXGlN5/EnXYSi+nN7Tj2lD9idNpdhekQPjcWzIOM07MYH92VCoAkW
         KeiT1yAfJEBJMTUj7JEuGlIJWgBkIf20WeOe9kN25Vh8t2uyTW8V1OZ4XtlWnKohUV66
         qCTJLbDGu3n8QyGdRDSLTx+inu2pQOTMCYZ7OWranSon52x+goM841ySbJlm0oQnUe9e
         eolhr5MZjZUBvi77O0WrZQXZbcfzoomm2RecpTN0oClylRc2n9K2qsu5V+OpJIcg9guz
         3e8g==
X-Gm-Message-State: AOJu0Yx3UuH9RnprxozPSnCjpkka5WNixRZzNcqyv+myxj6Qw+7hjRWU
	vyMqxfOdUMMYfCT03j6fRhCp/CIpPsq5NtI2VJNKRDNffmWJ3XNx
X-Google-Smtp-Source: AGHT+IFJ3QolskO8gZmMl8WqCUtF2qXopukrScYYsgKVaoX4rF5d94P45b/pYv2WAynpqKyF/TT5uA==
X-Received: by 2002:a17:902:8206:b0:1d7:7277:8adf with SMTP id x6-20020a170902820600b001d772778adfmr4844562pln.22.1706484755837;
        Sun, 28 Jan 2024 15:32:35 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d8dedeb0casm744723plc.180.2024.01.28.15.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 15:32:35 -0800 (PST)
Message-ID: <a0d499e7-ec2d-44f8-9b13-b1ef857e4c14@acm.org>
Date: Sun, 28 Jan 2024 15:32:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] block: move max_{open,active}_zones to struct
 queue_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
 Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-2-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240128165813.3213508-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_153237_634956_A4715234 
X-CRM114-Status: GOOD (  12.26  )
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

On 1/28/24 08:58, Christoph Hellwig wrote:
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 99e4f5e722132c..4a2e82c7971c86 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -189,8 +189,6 @@ struct gendisk {
>   	 * blk_mq_unfreeze_queue().
>   	 */
>   	unsigned int		nr_zones;
> -	unsigned int		max_open_zones;
> -	unsigned int		max_active_zones;
>   	unsigned long		*conv_zones_bitmap;
>   	unsigned long		*seq_zones_wlock;
>   #endif /* CONFIG_BLK_DEV_ZONED */
> @@ -307,6 +305,8 @@ struct queue_limits {
>   	unsigned char		discard_misaligned;
>   	unsigned char		raid_partial_stripes_expensive;
>   	bool			zoned;
> +	unsigned int		max_open_zones;
> +	unsigned int		max_active_zones;

Not all struct queue_limits instances are associated with a gendisk. Do we need
a way to separate the limits that apply to all request queues from the limits
that only apply to disks in struct queue_limits, e.g. a comment that separates
the two?

Thanks,

Bart.


