Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F4AC07E9D
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Sep 2022 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TWVzC21c5d2NqQztqHDFwpjqSWsHdjN9DLlu20PUWx8=; b=fN4GfIlSHrSTqjzOpNDkbHTPI8
	giVDt6aMwMDBR9By0oSbfu7ojXRIoQO3BWNoJRGdo9nGjmmv9eegwy8iaZ2r3gtxolcZI+EjhUopI
	Nc93X+h9FCOdxodeUHFz9doxagC8g1OKzT7gKlEJofh/AzK3cXN4tnUdb9h/O03M1ll+/JE7nIhJk
	YUOvae0vS36bVjeK7PZCuAY5xxH1qbcncFTYRpSwnuwexUQo6pkW7xqSkjKvqvDnpN6rdF7Rp5hUL
	3myEHukb6SM/rO6dja3mqbV9RrLHtNcB4WwAqbFRQuioXAUGg9lzbA4LYWo2LKYU2jmkiIz9yV9uG
	GfF1erWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc6Oq-007RwD-Ks; Sat, 24 Sep 2022 14:45:00 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc6Oo-007Ru1-11
	for linux-nvme@lists.infradead.org; Sat, 24 Sep 2022 14:44:59 +0000
Received: by mail-pg1-x52c.google.com with SMTP id c7so2759111pgt.11
        for <linux-nvme@lists.infradead.org>; Sat, 24 Sep 2022 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TWVzC21c5d2NqQztqHDFwpjqSWsHdjN9DLlu20PUWx8=;
        b=ItptfoELiWkjEYFyiIX8hiMBoKNuUQuAttg1trY0mIsImaGVH6DszeMst6K1KS82Ii
         RYcaDEQYT4udFeskrHRVLQBjIPsgGAwataX5FrZjrMJrWrhUy3ObhDyqrTOM4r45HVC7
         hIeQADVq0iMjiNc3W+HNI7oYYHaL3EEz8CN7pUF+iHdnkyFOlMSs8hZ/Wy6VzqfZFngG
         3qt8F8cL+rhqMPIzlR07lX4i6l7xZUDTq9piUxD2M/MuryShRm4Wd1f0ynPhoTi9B3v0
         J0BBuYTqDODOiZW6/5VN73NY/VqfCGSNgTlULGIdVwixeiFgUnCBre7OxFs1X4cmtxJs
         31xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TWVzC21c5d2NqQztqHDFwpjqSWsHdjN9DLlu20PUWx8=;
        b=ffUFzOS1MtOHFDbmyO0VCpgs2P7S0l4gaAfxtmzFKx2oJdcxZxquAM8mwdEvicbFtv
         l1iaqK9+ynkT6m3fiaNwG/aFu3TLRrIidNbNBo9BCCQa/brqRv11pl3t6aY7LFWafT1B
         hVMd/JnxQLHmSDUFhzTdOVHOXGgVPDgrJc91v08WJPeLv8F/YvTyvD+eMtABNvAbMvKo
         nywft7wP9nM8E43LPBU59+9zqvS3bb1RB52TZMhU116DKvQtpnduBD8e+E2BQA+ctU21
         tZ+jvDnGS29eGXJ4lHBGZMMEWA3Igyffp01OEzPWTnhjKOwCX14M+MFEA/IB1wBsGcRZ
         guFg==
X-Gm-Message-State: ACrzQf3v1ZbsyU7NUx7qf8p6n9gNhgxOCJ7nthDVP4zem46BW9n6QWCh
	EHxY8HmTCQw8Cqqkmfpm/BGo1Q==
X-Google-Smtp-Source: AMsMyM6sTGXP7jWsSWvUC/oEVRP7gnuPS1ZqAwV7Y99Dd6a0eEpjvNDQkMDyFA16cKFF1Y1vfMSfSw==
X-Received: by 2002:a05:6a00:18a1:b0:542:5e3a:3093 with SMTP id x33-20020a056a0018a100b005425e3a3093mr14288143pfh.18.1664030695771;
        Sat, 24 Sep 2022 07:44:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001769ee307d8sm7920782plb.59.2022.09.24.07.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 07:44:55 -0700 (PDT)
Message-ID: <3048caf9-3f67-d198-225e-6c7efc8aa373@kernel.dk>
Date: Sat, 24 Sep 2022 08:44:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
To: Pankaj Raghav <p.raghav@samsung.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, joshi.k@samsung.com,
 Pankaj Raghav <pankydev8@gmail.com>, Bart Van Assche <bvanassche@acm.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-2-axboe@kernel.dk>
 <CGME20220923145245eucas1p107655755f446bb1e1318539a3f82d301@eucas1p1.samsung.com>
 <20220923145236.pr7ssckko4okklo2@quentin>
 <c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
 <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
 <59e40929-bc1e-5d1e-3dcf-b9ba39b3d393@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <59e40929-bc1e-5d1e-3dcf-b9ba39b3d393@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_074458_334247_EFCE7FD4 
X-CRM114-Status: GOOD (  11.88  )
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

On 9/24/22 5:56 AM, Pankaj Raghav wrote:
>>>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>>>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>>>> devices:
>>>>
>>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>>> {
>>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>>>> 		return NULL;
>>>> ..
>>>
>>> Thinking more about it, even this will not fix it because op is
>>> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
>>>
>>> @Damien Should the condition in blk_mq_plug() be changed to:
>>>
>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>> {
>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
>>> 		return NULL;
>>
>> That looks reasonable to me. It'll prevent plug optimizations even
>> for passthrough on zoned devices, but that's probably fine.
>>
> 
> Do you want me send a separate patch for this change or you will fold it in
> the existing series?

Probably cleaner as a separate patch, would be great if you could
send one.

-- 
Jens Axboe



