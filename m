Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6D7C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNU2ULTl0ChHoBmMMoN7qtu5qLqYyEFI2kUe8MWmWMo=; b=QCmwLZzmv6xiojm/mrXpN22HgD
	wh5+XjKLqMb0NlbAjLOXG6MhGzjG6Yzcs5XnR7VtMi80duSyKKaWrP97vX6UOnjzImQtZgWxALOp0
	dq/MsPfxocIP+nTQDes9nXXGIlQ9+Fyh1Gln5arKU5WfJKSOGa2kaN2BLQqVjWR/KD9Av9StmM//N
	CmFRRgSBTU/NhkVIzGFa8WRFyjG1P4S1ZcivKOHFP5ShJIamMTldxD2mWAfGFdx89s7abxxWczEI2
	QKGpBgllGzkwEl32GigCg42Qw/3OLtcpi8odMeHX7ygtq05AEWk2peOoXn32irY12Tv0ejuUq2+Jx
	XbytnENw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ZTL-00GE3G-IJ; Wed, 15 Jun 2022 20:18:39 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ZTI-00GE21-7z
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 20:18:37 +0000
Received: by mail-pj1-f52.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso3082027pjk.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SNU2ULTl0ChHoBmMMoN7qtu5qLqYyEFI2kUe8MWmWMo=;
        b=Bj37wsYnTE287eFtaVmP44qFCTHi44bDlJM5oG7/tvDGDPB9OmGdOi3geUGPmkH4+e
         F7jx0Esgpy1lsmBLECrP/J3/F7PzocNSHRVc+8WA4uWU68wGgLVziqMjvKq5/P2K3fMa
         1gyfn9P8YMQtT8iZiAgk225QPPWVn9SI60pppjVFbPwQz+sWVLR+KHf6OlFe1snoMi/W
         +EOYD6MkoUJhpwDFj/fDEGxkTqK9r8fbgiBRk0Gdm+fiW3K03kgtwHt3UU41bpQBmxOR
         qvNbpu2ZhF7jLl1Yp0GeMIlT6qcuVfqToamb5LzFqVripErvaBgQwcIV0l4BKoBiieWL
         yR8Q==
X-Gm-Message-State: AJIora/whnUVT4/LfSlyY2UsLoMXIm+19JuVTveQ+OMUByqfT2qPnvpN
	BtFuoXBdhSrFoy+fwy0fC90=
X-Google-Smtp-Source: AGRyM1s3xzzOdnqeKw+fkjDbJVScgIu0tZCo++/2yYCKrn2XJapgnfJfEXIAyvKCytnUw+BXN2cYHQ==
X-Received: by 2002:a17:902:9a97:b0:168:a97e:2457 with SMTP id w23-20020a1709029a9700b00168a97e2457mr1297905plp.33.1655324314284;
        Wed, 15 Jun 2022 13:18:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d88900b001663185e654sm8464plz.280.2022.06.15.13.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:18:33 -0700 (PDT)
Message-ID: <c2269e99-b832-1c00-a08b-14af3be4d76b@acm.org>
Date: Wed, 15 Jun 2022 13:18:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH v7 01/13] block: make blkdev_nr_zones and
 blk_queue_zone_no generic for npo2 zsze
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, snitzer@redhat.com,
 damien.lemoal@opensource.wdc.com, axboe@kernel.dk
Cc: pankydev8@gmail.com, gost.dev@samsung.com, jiangbo.365@bytedance.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 jonathan.derrick@linux.dev, Johannes.Thumshirn@wdc.com, dsterba@suse.com,
 jaegeuk@kernel.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec@eucas1p1.samsung.com>
 <20220615101920.329421-2-p.raghav@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615101920.329421-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_131836_363725_3251505E 
X-CRM114-Status: UNSURE (   9.86  )
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

On 6/15/22 03:19, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

