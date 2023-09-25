Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F97CE79A1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Sep 2023 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j/qoBank0fJZyXTjpvDfBTolj60ngBj0wYpKKJK/nWA=; b=c+VJXnTPMdGXFV0WLGYqhC/SCY
	L+it33t8HoosgzvFiF7VPCPCqH74ceWHKlh8oDb3hH/2l50ecQXXeiEoH3T/HwxADiLc3AwLRY4+P
	7PUTGjBFVQy7ERhN4F59KD84dWI5pCoupVNnyg+4rlWlYqi7vDuqYbcp89HbZWKq444AhGDxUJ/iF
	/qgqYKdjkuZd+7vWqSqUW2n9gdFamd1lPfmNQAYXPboXgXCEQpULxxnHDSVV2qpLqy8ToeCkgSQPZ
	A1iNm0i/Bl+p5hA2ZiT7sFBist2zLn/VhID6sgXkSliAly12ZxiRICKwgIWTb/Bvdc70y0b3UNSQh
	sd0EF2HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qksd8-00F14W-1e;
	Mon, 25 Sep 2023 20:56:34 +0000
Received: from mail-ot1-f54.google.com ([209.85.210.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qksd5-00F13c-04
	for linux-nvme@lists.infradead.org;
	Mon, 25 Sep 2023 20:56:32 +0000
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6c4e7951dddso1631929a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 Sep 2023 13:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695675388; x=1696280188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/qoBank0fJZyXTjpvDfBTolj60ngBj0wYpKKJK/nWA=;
        b=mGvMtWD9ldViYCKtRh+tg7ARWO+ck+x6shsE6RKtDksOvommp4VDNu49ytSmEYL4uB
         5Gh6FSlsCzz1faPO3WHfYoVJgSa4bHL3W3K6M8IvD2meXWVGGAsmqCjGvQxxjDWb2Goj
         m0WnMaX4mw0jDZi81gi/XVcBsM4LaZ/mfOeALQRw7l2dBRCiEl0Pu63dpSkBrzBJoupW
         a/h9NYmmNBhXTmZW5g9BCS59FZRBmekdV68IRN6L3qZzlA/ZDq8LTY3Loq3MBDfxUc7A
         5z5xFBBohRC9J1nr384NkeRYEN1NCWktuwYoIKMeDr2Pr5VB7BLlRUZ3KcaS9qQfh6tf
         MvYw==
X-Gm-Message-State: AOJu0YyDIF8BBgrTyKMlT3c5G6kZ9u9ivai+LrfZbZNKztnlR2ERI1BC
	XlBpkKqK/G1Cm4NSoTzzC3Q=
X-Google-Smtp-Source: AGHT+IH0/jleEOHnJidWS4kRFhUO6aZDnO5MHTboU/wNUHzIRR0XA5MkNTbojrseZKXwVdW5hogKHg==
X-Received: by 2002:a05:6358:618c:b0:141:162:b0cd with SMTP id w12-20020a056358618c00b001410162b0cdmr10711933rww.19.1695675387526;
        Mon, 25 Sep 2023 13:56:27 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b00690d1269691sm8465183pfn.22.2023.09.25.13.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 13:56:24 -0700 (PDT)
Message-ID: <e0bdbbf8-83a6-4ce8-b313-80eab6809b34@acm.org>
Date: Mon, 25 Sep 2023 13:56:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Content-Language: en-US
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230925163123.16042-2-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_135631_085161_6190D407 
X-CRM114-Status: GOOD (  11.17  )
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

On 9/25/23 09:31, Ewan D. Milne wrote:
> +static inline unsigned int blk_mq_queue_nr_active(struct request_queue *q)
> +{
> +	unsigned int nr_active = 0;
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		if (unlikely(blk_mq_is_shared_tags(hctx->flags)))
> +			return atomic_read(&q->nr_active_requests_shared_tags);
> +		nr_active += atomic_read(&hctx->nr_active);
> +	}
> +	return nr_active;
> +}

The above function should never be called from any command submission
code path. Hence, I think it should be added in a .c file instead of
include/linux/blk-mq.h.

Thanks,

Bart.

