Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0854C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7jAUFNzzdASfv0kC6gDPmZTF+BtCSUHVXx7AeXUuUN8=; b=mE9PX4ZYeRCRDu1GPlXT8R/Bm/
	z5JHsIIXjFy25x/StwbjxOKfMS1YPKIDUuSuD7sVlCI+K0+lg9ZHDa0cVrLb8RyF9+sZ+tlf70Uqv
	kSAKMczzXi5m2Vs2jqr7h1odDuykVSkXYDGr/PxAUNfOINmmPkKxl+TnlsC2mrTb/qj3+IqsIhays
	Kb+14e7JIu/Ex2G7FxQnTTA1KvUtmRXjFG38Wn/xQ2Vfr9wMGmv51cC3nPkmFnHK5c4SPNP8NU5F1
	PEp7ovprz5oJjC6xfucLMkUIDowBp+KJB3MX50lR7Dds8Wca8QR5WKRTLwTEtIoIQu2QmAOSsPV+0
	WtUksJOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvz1C-00000006NMv-1AcH;
	Mon, 17 Aug 2026 15:12:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvz18-00000006NLU-2QUs
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 15:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786979569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jAUFNzzdASfv0kC6gDPmZTF+BtCSUHVXx7AeXUuUN8=;
	b=C2xn3t4Oy7xIspcQMdc2mJuN+Bz8JyaDKbq/sMmzSh7wFvIJD+MDHcEraQeWRjn64DEwDg
	5TwEnUPg9M8NlO1sMhUVhDSa+kSbQBvv0AIB6eDFAcyodMqmyLLL05039mN5aWOK+AuHmp
	zyHZzn7aWvYwn++1FCx44muy0314hik=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-NW_EWFsvO7SLrnp5zBLuMA-1; Mon, 17 Aug 2026 11:12:42 -0400
X-MC-Unique: NW_EWFsvO7SLrnp5zBLuMA-1
X-Mimecast-MFC-AGG-ID: NW_EWFsvO7SLrnp5zBLuMA_1786979561
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so34395585e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 08:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979561; x=1787584361;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jAUFNzzdASfv0kC6gDPmZTF+BtCSUHVXx7AeXUuUN8=;
        b=h9C8vSI6AyFM6c176GLBRUTfyDp0X/TcezV1SCJNmSg15OC2k1Lvu7m7opWmB+LJ3x
         s0pXCn+l/AF5TTtWhcAFOMQb7aXiNUDIrKlyQ/ec8SQhND5vW5pPESP6z1XjAmXvL3zk
         DxAOK0xDYq3canhIsrFXVeMVAhKx05o3EJKi0+6Dqus9LFQBEQPFevfmOzPfgbRKXDPV
         IK4aaDIteE6WzXppp1MtSC6+IoTWpNgIrZRAPJmUlaXopLmf+U60+AmPEAI9NYjXQBFQ
         WY7FYJPGG9GwimwMrLcCG5oufdr7H2PEhNd4GXU/2yDLBZ7wYJ+2saOcFNNDmXDGuWNQ
         DOgw==
X-Forwarded-Encrypted: i=1; AHgh+RrvWC4uNg1e0KZcgtLc66U6SLp5ZAEJsQm0aKpXUa0tZi/49XxTGVz/8yKGhqgHh6esj55ht385ULBN@lists.infradead.org
X-Gm-Message-State: AOJu0YxzSVyqWgWZ7/O6KXyIVCfAXG9Pie7E81uN80SjadDXmmRAgskD
	YsdbPrdDw3uIlOGjFIzjJm5ud301FeLtCyDZrkcs6KopIg9vPBmUyQy3g5JW4DiimBxPwZC7pj3
	lAlBBK3p3BKRGdFh90sO/Sp3fc1NjBme77EjFL45lvJoyXIAbVJaGiptpU+q1gbGUv2Bc
X-Gm-Gg: AR+sD10ZvWcr1D2HE8cQQu3G7Tgmnm6SSYaFPqtg0MiHzZfPRAI4hvnwi1ICkZd3JbX
	IIvNLEcorPc59Qk9tQ0lnLVT4g3Ark/izS7HJTN2dl5HT85201Y+L0u82XVtpEMVn8T0LF92xc9
	8zbHbsDaK/Fk/eJtDR5C6wuFJkplchT3bou/+oEPlD0fRgSb9cPqdR+B56W4dZwsUpjeQOQl/Mf
	d8EijiCB1rMOLJqOWra1z6mRvMuut/X0WQMRUzo4+EvV4f5CEzJvA32XAS0fQKk460hSqrFmlYA
	rUXbB5ZTJoyY24O61ucqsIG03E7yKDzO+R8sGTxOXLIc0UEoBDZTncnJ5F63ttM8TicBAq4NyBq
	tMefMtTs2qhDd1tVdnlTCmv3QTZNGtElnW61irrIfLzI=
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id 5b1f17b1804b1-499878ca13bmr462810415e9.0.1786979561505;
        Mon, 17 Aug 2026 08:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id 5b1f17b1804b1-499878ca13bmr462809155e9.0.1786979561050;
        Mon, 17 Aug 2026 08:12:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c5dcsm5028724f8f.17.2026.08.17.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:12:40 -0700 (PDT)
Message-ID: <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
Date: Mon, 17 Aug 2026 17:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
 <aoMi6y2qsnRVembg@kbusch-mbp>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <aoMi6y2qsnRVembg@kbusch-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NwtfoM0MCXU7r0HVdpfFFqvU1o7Xe_kaF3d1SQrNKVc_1786979561
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_081250_697155_24C05905 
X-CRM114-Status: GOOD (  13.87  )
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

Hi Keith,

On 8/17/26 5:04 PM, Keith Busch wrote:
> On Mon, Aug 17, 2026 at 03:23:14PM +0200, Eric Auger wrote:
>>>  
>>> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
>>> index 449950029872a..94d3461b5bc8e 100644
>>> --- a/block/blk-mq-dma.c
>>> +++ b/block/blk-mq-dma.c
>>> @@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
>>>  static inline bool blk_can_dma_map_iova(struct request *req,
>>>  		struct device *dma_dev)
>>>  {
>>> -	return !((queue_virt_boundary(req->q) + 1) &
>>> -		dma_get_merge_boundary(dma_dev));
>>> +	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));
>>
>> I observe a regression on RHEL due to that change in
>> blk_can_dma_map_iova() with a 64kB host. This also occurs with upstream
>> (7.2-rc7).
>>
>> For an NVME device blk_can_dma_map_iova() now returns trues while it did
>> not before. And it seems it shouldn't because it then causes some errors
>> on the dma_iova_link() path due to unaligned iova:
>>
>> [ 4486.655564] iommu: unaligned: iova 0x14c34000 pa 0x000010764d790000
>> size 0x1d0000 min_pagesz 0x10000
>>
>> It occurs when launching a 4kB guest with virtio-blk.
>>
>> I traced:
>> nvme 0015:01:00.0: req_phys_gap_mask=0xffffffffffff0000,
>> queue_virt_boundary+1=0x1, get_merge_boundary=0xffff
> 
> The first thing that looks odd to me here is the page offset in the iova
> isn't reflected in the pa, so I think something in the construction
> isn't setting it up the first vector correctly.
> 
> Thanks for the notice, I'm looking into it.
Please let me know if you want me to trace some stuff specifically.

Thanks!

Eric


> 


