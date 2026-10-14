Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D7CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=; b=ImuQ5d6ix59kHMEyQIKT3pII1O
	8S4Lr/+eJja/hvQHdi2cbEdMcCoa7thJrzftMM9cX4Czsw6XNbMNTCi96hL/eUisnVy1fIZ0ZRxl4
	8GX1e2g2r+j9kIeFIO8xfyc59IDzAfsf3pVy0CF8hOPhggFMB6wqBRpc9wE3s7jHxKyZU+sbRc9GI
	iJLLv6XS0TjGPVh2EZPv1J23rRP5y+rKoLnaKAYhY/899218YT0C0riFg/B+ac0F0qp0cQ0gOOB4z
	kKf+3UGGYr0psLJ8Ma0oAdO/ay+8oAoBNZeH3AcvDUjewkAkoRGF2AmL/DqxilkNwbPZ+xWL5S3Qa
	2ygAh6dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyhG-0000000FXJG-1JBc;
	Wed, 14 Oct 2026 13:07:06 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGyhD-0000000FXIi-2hVK
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 13:07:04 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so35042445e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791983222; x=1792588022; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
        b=Zq7qmJWMhVU8Tr2O59y39my6q6Fa0El9Qt+l3RijT4AXx1Bi2d2ck3EcxfTEzogKCp
         wVj5fWXitaKNuuU6RizgTt+I2seZ0MuV8HLOWw+GDRZIkKCdo9yVcTWisMtI2+cdpowj
         V6Wdmo6S7E+vgr4GiEzUmkCa+/aE1SVBmEvODVqOC5A2rhMKcDdahDo8FDot+J5o/YHV
         39opkQwCjS0Rc7QemnowE7t5Eurh81AvJ+Gi+PG9UHFD7Vayw05iN1PRwEeWqQq7GA8i
         jl3V+NiRyzKk82g0ksRFYpzx3uGKkCdpyrJZuNr8rWnSII2kfeJ2lH8/eRaP6Ex0HfCU
         EgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983222; x=1792588022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5Xx2GBklmLYql9VZXZ+CeE2dU9lwoFm77pkgYHcd38=;
        b=lrKA+ENASXsHwuDzaK+2+/CPjWeEih0NPKM15W48b6R8syAB+OkwioPefUVHIq4A5l
         jj+u7qjyoC82O0n+PzsoC5bj4O4BmSI9Ty3uMSeHMm5FWvPk8RKwbJ5M/fUgzvVBML/b
         vopZKgyobt5Grn62Nl35wbSO1tcKol4zBAR5MsogpET2jp1Ri00fpv9BWYlX2prPXs2X
         0rtkoXuy4+lkrIXz6utVA4VaWqLRaBtsAvBz334eWKnA54bO7hQL1tf+ZVuK3TSwD2Ov
         TqcSCiCRHTRc15Q9ZcCe6CuPZdoHxs4if0MQqIqcu10uh7TtygHgy4rZPaAZPxqhRzlC
         YTbA==
X-Forwarded-Encrypted: i=1; AKwUvBzvxKO7sfiH8gvWqIPLXbdRMWdJPSQcds9qpa1zXRqtcGHva+uGkU/JqiYGnbUpR71kAq/UvFolO4QW@lists.infradead.org
X-Gm-Message-State: AFq9FYIB/fi6qahIeXxuWSUErG3kgaremZ2Pj0icbABM3HufIc47EeG5
	w9woAggT5+6yXhjYI16+n+BM4B2mmG0oLsqoe8fK86bOOlNbeqMilNPN
X-Gm-Gg: AYBFou2BAtNLWkxa8j4dNZyVJhV1SJBOje49FdwO7QeOLxw0VTuq/u4jRJLtk3Jykg0
	xZCZd5Eo6e06GoqJeTQuDLqpXwBM+bwXUG1jpyCcysKZAIYMaP6ZA2jS+YYJGH7xS9sR9p/T5ph
	oh60wNNEs9u7hIYs++WPg4vBIVQA8DaMBYy3oBenYVs/01eHH+f22w/M65UmLq0gouUKtVDdO7J
	lXHNf/ox0stUDGts7M4zxpeXuBPSNLcPP1RP/xAR0iODLOMrblM5VLRRpMQpBaRQ4OnNOuP5fUj
	xN6KOyPB95x1Cc6KYWyTyCUHPCMrxlZyR3Tt+fCvWmH+pyPSkI4wyx2Wy2+P/t+jbwu0X6/OsRk
	T7lhfnqjuQY6WbqkgHYtOtP4EL/KTkIiV21sKIrQYM9VVgSz1zMxMAQ1nK5l6qwtoEB6xSoQxSv
	fxVdK8xCHa5PVYOjmnrbppn/nJxp5pxcYpuR0DG2d/JTvlFlSGSvW1aK9Z9huOM8UJVpNpsttnr
	cfM6f9wsPdAGZWkjH3/kHSqV1maqG8D+4fmiwOfjas2rgFjOpsLdsXtGbxKrPIn/GWxoH2AqkY+
	udCTCKins088DGLsbWibs6WJyBSo/1HBuDQWQVMv/Cg5yoQ4ag==
X-Received: by 2002:a05:600c:6994:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-4a18e446f3bmr313643615e9.2.1791983221508;
        Wed, 14 Oct 2026 06:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b3602990sm52779585e9.0.2026.10.14.06.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:07:00 -0700 (PDT)
Message-ID: <8d0e7d1e-086b-413a-87de-20e21f519daa@gmail.com>
Date: Wed, 14 Oct 2026 14:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, dm-devel@lists.linux.dev
References: <cover.1791975048.git.asml.silence@gmail.com>
 <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
 <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b461d367-8965-4798-b7ac-cffd4301cd1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_060703_772736_276D8431 
X-CRM114-Status: GOOD (  10.81  )
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

On 10/14/26 13:30, Christian König wrote:
> On 10/14/26 13:01, Pavel Begunkov wrote:
...>> +static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf_io_map *map;
>> +
>> +	dma_resv_assert_held(ctx->dmabuf->resv);
>> +
>> +	map = rcu_dereference_protected(ctx->map,
>> +				dma_resv_held(ctx->dmabuf->resv));
>> +	if (!map)
>> +		return;
>> +
>> +	rcu_assign_pointer(ctx->map, NULL);
>> +	percpu_ref_kill(&map->refs);
>> +	/* make sure the map is not visible via ctx->map */
>> +	synchronize_rcu_expedited();
>> +	wait_for_completion(&map->drained);
>> +	dma_buf_io_map_release(map);
>> +}
>> +
>> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
>> +			struct sg_table *sgt)
> 
> You somehow forgotten the kerneldoc I asked for here.

Ah yes, missed that function. I'll add it but perhaps in a separate
patch, if you don't mind, depending whether we queue it for 7.4.

> Apart from that still looks good, but I had only time to skim over it.
-- 
Pavel Begunkov


