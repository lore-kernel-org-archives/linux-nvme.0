Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53AEC07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFgIjACJN9ef5+O5Og9/DlD2wJW0SUIxL2QcgPrbsYc=; b=3ZTbpNCud5aibfx1uX5XVWREM0
	faFlK5uoqdw2WtwWBCcfaZjQkao/ZBcnM02HbZhaYTYIoU8nyFZi7Bzk6u5PJZfN+idn6p3dGSDvK
	ZgfflsNUQNR6RuPnWUcrhcvJ8BIt3STcVx/KWiHFUCvx0YGlDUnnzDAN5qLpWz24X0SBYYs83HTeX
	UhhpacFCmyhL03C5s5FjCZtV03RrnxYOAobW7BbUK4umqf2Q9pfmBZrWO/295KNqySUOKFDqkQVF/
	XNyqrDFVbDu2V7T81unnV1Eg6pUmrI2ZRER9a5xVpiEQtYm36FvX+HACvTguRS9o5fmvAbGqXaNPV
	AdNE+PdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpUs-005WPq-7x; Mon, 26 Sep 2022 14:54:14 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpUo-005WNM-4S
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:54:11 +0000
Received: by mail-io1-xd35.google.com with SMTP id q83so5412494iod.7
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GFgIjACJN9ef5+O5Og9/DlD2wJW0SUIxL2QcgPrbsYc=;
        b=O6BuwalmwwYXOzo+C/YM69mwnYKMYr8o+VXsmRvl4i7rwPH1XHeNiAWtZYlhHu3x1k
         ABZI2Iw0Glk+PwbhLkcVqjJy13+aSHZm9s3Za2oqc6nV1K1AmDgOUSWmX+KVKGph4Bsa
         Vtj+9n4D2sLGmdmjZz12dBLj6rklBdCVvkckfXkH3xFBKgBm0ee3A3hFOrrsiu3uqHWL
         QeYHgJscKTg88T8/KrFdITuLCVfqvWVszV2ZOaRIBC4FpVne0XcJSgLpIGqCWMsv2qPj
         EMSpHNc0Vb+ilgIJ+rleGG9DdET7ZoUGxEQYCqREFz0goJgMZzIWRJ5BoAvEDg1n17i7
         1Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GFgIjACJN9ef5+O5Og9/DlD2wJW0SUIxL2QcgPrbsYc=;
        b=zinEycvlxhqYSDuzB5tRR646HmZolDnw3LbJC6KTS9lZTugbT3f7dpE4shD3104Q6x
         e0y6jk+ywT5RxN36Fkq/7IEsGQvLRrO5uEOq4kYqpI1LQf7YMzRJRCYHsTmSjYVGLnUh
         eoAzd5ddYuK0mmruTG3oHUVIjM0IP/b1SLk3EADsiOYvy6S/va0+FVHsYoMjvtpinDVI
         j2uysIQVC7w4YEAkpRy/JSoq7jHx+4RHYM2bFfACfl0czn0tmVvGvNShSZDY/vx2//AE
         ydwLlmCK+4QRgSxw6VewrjN6eaOx9XaO8RdRUElPlC55KJx03HTyjRvSzKVVS1Z9ntTD
         4Fcw==
X-Gm-Message-State: ACrzQf1qN/YZ4euCbug0HoR4V/32dwpJrG7YP4leFLCK2EVVusEyVOR/
	GHrogCt8CyaZy4wXYJIKcaIF3RQweX9SCQ==
X-Google-Smtp-Source: AMsMyM4hzRj1NCt5qjQmyZkoVCT9OWmRSxwmpvJsL6WjnZ+oLf++I8kF1xpoVmAbCJWyaZoIbUOzKQ==
X-Received: by 2002:a05:6602:2b06:b0:67f:fdf6:ffc2 with SMTP id p6-20020a0566022b0600b0067ffdf6ffc2mr9866886iov.111.1664204048218;
        Mon, 26 Sep 2022 07:54:08 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t23-20020a02b197000000b00346e7ca2463sm6868577jah.135.2022.09.26.07.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:54:07 -0700 (PDT)
Message-ID: <f7b92f52-8a33-4cf0-b8b6-328c573ad1bd@kernel.dk>
Date: Mon, 26 Sep 2022 08:54:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk> <Yy3O7wH16t6AhC3j@infradead.org>
 <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
 <YzG5/1zSdiMlMLnB@infradead.org>
 <69598e37-fb91-5b92-bb80-b68457a7b6f8@kernel.dk>
 <YzG6mZhtd/QysvdH@infradead.org>
 <25b9899f-0c60-39f2-179b-789b914e0f0a@kernel.dk>
 <YzG8vsR8j0VIt6Nx@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzG8vsR8j0VIt6Nx@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_075410_211968_6EF18D3A 
X-CRM114-Status: GOOD (  12.30  )
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

On 9/26/22 8:52 AM, Christoph Hellwig wrote:
> On Mon, Sep 26, 2022 at 08:50:41AM -0600, Jens Axboe wrote:
>> Or just the union named so it's clear it's a union? That'd make it
>>
>> pdu->u.meta
>>
>> and so forth. I think that might be cleaner.
> 
> Ok, that's at least a bit of a warning sign.

I'll go with that.

-- 
Jens Axboe



