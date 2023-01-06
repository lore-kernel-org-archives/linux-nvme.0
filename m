Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023A3C54EBD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 22:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ta2lEkN5kGxTKM6DO1j7OMg4sGm8eJ8eSltnioRMtI=; b=LGvy3ttcg2vIacjMwft91rPpNJ
	YaXG6E4DLyXhmopkFJlV97a73QY0y4UHpKukOQZsRkKyhj4af9yeazerHGAp6uzmtIGl46o281h80
	SN0ucc4Pg7IjkEJluLy+NRE8hKrpIIVFIleepakxYCdWIbhmg+AkqjstbykkWzALi9oE3HdUcFje2
	cWACq4dJm0VqPfzf8NS3wnPOqeUYdobXuZ7/zIWTuh0zjn2y8Sz3WgPeR6kE8+ByNNBoSROk+XUcF
	o9Am+EFc1H4NAyxZYtWWZmi4doKlTO4G72/YZp89xyImlfmghKJP9gPr9nYEEAnjSe646xYmk7HnU
	ITbEVMYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDvKg-00FJau-0C; Fri, 06 Jan 2023 22:37:02 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDvKd-00FJZe-Vd
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 22:37:01 +0000
Received: by mail-pl1-f179.google.com with SMTP id d3so3176990plr.10
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jan 2023 14:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ta2lEkN5kGxTKM6DO1j7OMg4sGm8eJ8eSltnioRMtI=;
        b=amxlfHQkZWBDNS5p2NIQkoCWPORhijS9AjsQEn2a083jV/6qZWOhJZ3KmhbDy+tmKf
         iddfrXnVwMPLyaolRAi5R3cxdGR1wNEKE80l0/wzOnTL92g6SYkEz/9lsXp3wNOv4wkG
         OxqpSvsFuYZ8BHYvw4pChq/SOiCa2eDx2djMZ/4ZOgZayzjkHsnRUCjHHoQSgxNdv/2X
         tD6U7WfjDCpTsX9DOkMWg93mi+2aAL68oYKpwOAoet+/3riYcNWwOMaF/CA6MwT6ihms
         EQ/vV7703AW0i+RUwmyoSYjjVRg64YOEJpfxgVuiLkMIpNtceK3Z4Y/WTPJkn6URAVm9
         ZvOg==
X-Gm-Message-State: AFqh2koEkQGH7f/bOcTPpEAMoXdHxGyiczMSmAw40apgPBeSueylJ8IM
	J+j5bzjeeAq1BgrLJUJcaCI=
X-Google-Smtp-Source: AMrXdXvx9hEsKsGVd1MGjXgFFib0cGo/BvdB3EmgdQG2Q+U3IMxgohrZP/fJyOzM+mjRgn5vTXWY8g==
X-Received: by 2002:a17:902:ab8d:b0:192:f45d:92b9 with SMTP id f13-20020a170902ab8d00b00192f45d92b9mr8998981plr.29.1673044617680;
        Fri, 06 Jan 2023 14:36:57 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:23c3:f25b:a19d:c75a? ([2620:15c:211:201:23c3:f25b:a19d:c75a])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902bd9200b00186b7443082sm1384960pls.195.2023.01.06.14.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:36:57 -0800 (PST)
Message-ID: <271c3316-e464-9dc6-f703-26a5986a00de@acm.org>
Date: Fri, 6 Jan 2023 14:36:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/7] block: add a new helper bdev_{is_zone_start,
 offset_from_zone_start}
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
 snitzer@kernel.org, dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
 linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1f8de0c6ecf351738e8f0ee5f3390d94f@eucas1p1.samsung.com>
 <20230106083317.93938-3-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230106083317.93938-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_143700_044217_0F7C7744 
X-CRM114-Status: UNSURE (   9.07  )
X-CRM114-Notice: Please train this message.
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

On 1/6/23 00:33, Pankaj Raghav wrote:
> +static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
> +						   sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +
> +	return sec & (bdev_zone_sectors(bdev) - 1);
> +}
> +
> +static inline bool bdev_is_zone_start(struct block_device *bdev, sector_t sec)
> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;
> +
> +	return bdev_offset_from_zone_start(bdev, sec) == 0;
> +}

A nit: 'sector_t sector' is much more common in the block layer than 
'sector_t sec'. Please consider changing 'sec' into 'sector'.

Thanks,

Bart.


