Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E04FCA5FC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=; b=Y1UeL2OJVtR38/UPQmA0kP/ytn
	S5vgLo/4rIO7aS/45P/QXbAv7PuWv/5PQnB/ngIGLcwe8hs5fCp16JOKQ34EDr5aLs2mTHpalZHzf
	KZMC+CGqlAr2OrvUrDr1EIYlYxbNw8DDuFN6tU3A5v0U8ucEooKNVJjcgRkNEgGWv3wf5a2HBUegK
	0fNbD1nf99VVCkeHl6TjICVVd3EWVU8h1dkpbRpj38O1DeqqSp823JaAuxUtrSk6svcLBZ/ggrVeA
	ZQ/grdwHDz+sZoKKpR+O3l6IgXHwfkHW/j883J+XIczvQcHILQbMFr26/g2+TbsVtg2I+ZZojyqcJ
	YVN1kD0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBvxG-00000006RA1-2jqA;
	Wed, 30 Sep 2026 15:10:46 +0000
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBtkK-000000063Ta-10xA
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 12:49:17 +0000
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so22696685e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 30 Sep 2026 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790772554; x=1791377354; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=;
        b=bpaYk8GFbHUtl6GNvmT/HFyJxnYWh3FZl+K0qjVwFIGE93wLpvK9AkG8aECCXeajbP
         Ujf+7p7di/XWr4WjKQ4GH3Fl7m2XWCZat0c3vCNFb+EUCWN6JdmW1jztJPjVVK2SeeVp
         QMpOzyhUZtmYQOH66Qk+u0wefkHnAfNhIvFw748+K6a4AXmoXrID76yTemGa8MXRzoHH
         5lUdMe7dZaIa+Zr73C4gKRLf/N4yupkp2gufKjCSpk+CqanWohhXn1TlNJvLQEGXYB8s
         g5FS0qD5v6A2L9QBSvfh5XIWDvH5vrbvlCeXIm6Ld+JdKe+uCLSBpsYVpaPwjJk++lkR
         W3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790772554; x=1791377354;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dhWIKwIs8lapn2MMhEevzHPS2BYYvsR1AqGmdi+y+4=;
        b=vHHOD3i885eCHU/uN5xuC3GUf96qmZdmrPfuUGiLn6uxTyBpiyusRSkNcU/wApd8g/
         8jubVoaDF5E+HABEQT2qv2rm4To30banWZhyggQCHf+mtYjunck8ecgMIYeWSee5YR95
         EUScTOURm5CbZkxYNKMEynBiJOtlf4/Od0y7O0HAgKmuppkzPfQPrQ2U/vaznx1o0/+Z
         bUsB3xhJtchsDPtDsZzgQ6PuF43zKg6/k9btd0B/nl5n3GiPq58hjZrwYVy2vmOODTIR
         mGh3J5t/ADWeXAauM/mUvHrnFnhWey5VvEGxjdTS3cmRXJrEvmf+1WfFKC9PSSRV1nf9
         D2zA==
X-Forwarded-Encrypted: i=1; AKwUvBx6iJt3qn/xe8zI4ezeIkv5cZUFw+3JjZNPOQb0ZjKAPWNK8JXaHBM9FNclOjnFQYCkwF3/ihDznaRp@lists.infradead.org
X-Gm-Message-State: AFuF++ngO0ZFkUZmFTfoh8sR9BIZZq/lVjtIV4KoR+dEpEcu3kRF00rJ
	Hq6EKNitwJNqqeEBiqP8JD+5RSWowGDkObe+VsD7obq/JDZlcPnzCQnE
X-Gm-Gg: AYBFou0ccOLQzyE5oLIE/+Oq63v5iSkV+TOFN81ZIz2+fY/NRG/Gv67lkpnB1n9yVSQ
	o1cbWsK8qMmxgOrrdwyng7z75Lla+8RoodgsT3quwRlcigeZvPrsBNABz3xOPXXqi1cqh10ED0M
	TnRZ/HHKROiX6VjHpMFHgDR9zghq2gpJA6dGKq2GSY3G7VMAImJN5SJ9LhceRGJR+SD83Mr8OEa
	XO2z94Ewql2YO5J4dXHc9wfl+SHTxXK2Ku/4dIIri7k2WSYxkqa59AFvbleTEC1i4nUGOO7Xsr0
	LZeZMQCcargiCw4yM4ToYfsePeyebThqYBLxLWgc0JqvItTiTWgft3nj2dB+6ZQt0eLKmidqXyK
	WmrthHmMVpBpxixMh8YltRSWVlpCcIcBDkLDJ2wZ5jnvjIeBlEorki9KN99MpVW5HR6r3elEDCC
	JT3oizPcHZo1KnxbGFysM4PbLqhueSjrqdOHfBn0KTED2/Gm7dsI/iFYBX5hoiG/sYoWp9zoz9N
	9t3iQDFc3lF2edZF/tTPMUEybV6voaAAuiQIp8gXj9lB2g9aMpKpdg/AJDUi++DkacgQfU+2Ctj
	Y5zC5KQO66HrwKa/HgduPpXnYUgQKsfYsWna
X-Received: by 2002:a05:600d:864b:10b0:4a0:2dd:7573 with SMTP id 5b1f17b1804b1-4a01b12b666mr16604625e9.33.1790772554145;
        Wed, 30 Sep 2026 05:49:14 -0700 (PDT)
Received: from [10.54.182.141] (82-132-212-25.dab.02.net. [82.132.212.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01cb8abc1sm3766935e9.0.2026.09.30.05.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 05:48:57 -0700 (PDT)
Message-ID: <c07404e0-33f6-4e5f-a80a-e1901b42dc39@gmail.com>
Date: Wed, 30 Sep 2026 13:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
From: Pavel Begunkov <asml.silence@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
 <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Content-Language: en-US
In-Reply-To: <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_054916_378373_31A1EDA5 
X-CRM114-Status: GOOD (  22.72  )
X-Mailman-Approved-At: Wed, 30 Sep 2026 08:10:45 -0700
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

On 9/30/26 11:08, Pavel Begunkov wrote:
> On 9/30/26 04:00, Matthew Brost wrote:
>> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
> ...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>>> +{
>>> +    struct dma_buf *dmabuf = ctx->dmabuf;
>>> +    struct dma_buf_io_map *map;
>>> +    long ret;
>>> +
>>> +    guard(mutex)(&ctx->map_create_mutex);
>>> +
>>> +    scoped_guard(mutex, &ctx->map_mutex) {
>>> +        if (ctx->maps_killed)
>>> +            return ERR_PTR(-ENOENT);
>>> +        /* recheck under the lock in case it has already been re-created */
>>> +        map = __dma_buf_io_get_map(ctx);
>>> +        if (map)
>>> +            return map;
>>> +    }
>>> +
>>> +    dma_buf_io_wait_active_maps(ctx);
>>> +
>>> +    ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>>> +    if (ret)
>>> +        return ERR_PTR(ret);
>>> +
>>> +    ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>>> +                    true, MAX_SCHEDULE_TIMEOUT);
>>> +    if (ret <= 0) {
>>> +        if (!ret)
>>> +            ret = -EAGAIN;
>>> +        dma_resv_unlock(dmabuf->resv);
>>> +        return ERR_PTR(ret);
>>> +    }
>>> +
>>> +    map = ctx->dev_ops->map(ctx);
>>
>> I'm playing around this code now.
>>
>> I think you need the dma_resv_wait_timeout after the 'map'?
>>
>> If a device doesn't support p2p ->map() will typically trigger an async
>> migrate to system memory and data will be moving but the map is valid -
>> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
>> async behavior.
> 
> There is a wait right before because I read somewhere in dma-buf
> comments that I need to do that, sounds a bit odd if I need to
> wait on fences before and after. I can add it, just curious how
> come that other dma_buf_map_attachment() callers don't need to do
> that. Or maybe they wait somewhere else?

I can't find it, so maybe it was the comment below and I mixed
sth up back then. I'll move it after ->map().


* Note that for non-dynamic exporters the driver must guarantee that
* that the memory is available for use and cleared of any old data by
* the time this function returns.  Drivers which pipeline their buffer
* moves internally must wait for all moves and clears to complete.
* Dynamic exporters do not need to follow this rule: For non-dynamic
* importers the buffer is already pinned through @pin, which has the
* same requirements. Dynamic importers otoh are required to obey the
* dma_resv fences.
*

-- 
Pavel Begunkov


