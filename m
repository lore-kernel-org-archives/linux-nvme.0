Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3476CEE20A6
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+//MQb8s0l4sWUa5GTTqN5W/h3z8UEKAbzUgv3O53tU=; b=gDYYSkyD1rfcKeltpm098iukvo
	PFZZkeMy27FICwMxhOmX/VrRsXuhujdhaY/hW5i+n11jdgOKqzoC7yYCq9u8YfURG1Vumq1zUGw84
	TEsOroEMnVfx9mNnb18Z/rM+K3YcHFQ72bSfQBSWcRRBSmSTwkY4R8wQ/Dxb3H0LSY08Y6Jx7JpVN
	4+eKijLjW5dsW75N7DqgtjQXZbjPXtEoymQe8KBdY7fJPT/gmJexnKEoZczRqamOfURLWXjC4lr1h
	H9gVg2d3U0o8NzT6BBQzvdkp5uZ7TgytyxRFdPshFUbBTUiGGxES6nZqeb/zr8QfYDeqv0mIzBbdV
	jeJWIvZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNRe-0000000BTMW-07yZ;
	Fri, 06 Feb 2026 15:08:30 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNRb-0000000BTM2-2pYe
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 15:08:29 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-658cc45847cso3293323a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Feb 2026 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390506; x=1770995306; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+//MQb8s0l4sWUa5GTTqN5W/h3z8UEKAbzUgv3O53tU=;
        b=Kwh+9c0FKEqGS9P+OxXW4AwIXEtUdLC1kHJgZdJxQSD9wIlNQpruGyQj4aMv+TAbam
         CitM/+kygSHtUPdDRV61qD16x7O8De1YW2jYWbGzAEmwCGhO5EOWSdGHocyk9xervjUQ
         Yzxob/Oy8BY0rneDJX4zeB/8OHlq6jTVEnHD9Azsh16u44R/Iy7Ze0sSCfbpWEAEO5kf
         NKmo1v8LCUU7VjkATcQRu9b5azwkFTxPW0Yic3y9tSSqdPcqnbSp6BiyvQ13wW6VSTjR
         x0yy0OoTuL/NbHO4CVfkbgAkbLzacIk9KZWEVZTMyZ3GW1vdO1ifT8uRzXrYrLV3sR8B
         3/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390506; x=1770995306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+//MQb8s0l4sWUa5GTTqN5W/h3z8UEKAbzUgv3O53tU=;
        b=ju2oUFq0MiEW6VRA6V4OOuNQPcdojs52f4Md5SYALt8n1QYJPbfN+rkH5D9hffWeU/
         CaT/6obsmdPUMpMaLj6l8VN+20JLM8KtOXqTsoYr8InqfeFuI7/mqP3PqicFK4ItNtV7
         LdOUgaz13U4gJQ+uDdXc6e6eXGwOLjkIuC26iGlcMYl17kC2bQmPzxDeYnIacvfJlOxB
         HiwSN+1y2250dbsj7R3sZBT5c5XLJLejUiUY942Avw1itTbeKmseW5u6pECUkXcAaaLX
         nC92x8lKMkUjL+QVZoLRvBsT5uSp3puckwVMBcXAS/kWIrZpT4Sx35gkMC/fZn7IUaDU
         5Pig==
X-Forwarded-Encrypted: i=1; AJvYcCXukUr/UmwlBgGJ5bygeFnLvB2St17PNYNpfUC8hBJWZPEnszY/qOwmWrPoxAkDpSUW76MniLqV2rm4@lists.infradead.org
X-Gm-Message-State: AOJu0Yw3iTq7BCN7T7JQSrrCH5km9tDUe7rfW4d9xyv6oPEShpAajTIN
	jKX5YWQJPkN7CTzWWsn45JpiVWe9egjE1kMPIUpD74oZNiKi4JJNYrTb
X-Gm-Gg: AZuq6aKX1eIUYvp5snqgHZa7zV1MclW5isrXOroR3ODi2YG+w76wBDGZsaiVcD6q+1x
	/0AXp2wlV+euyJ65KUcDsPUOcQqpENkwESIzsXwd3Qh1CA9DLRioJyU+tN6FWIMqdtDxVU5Hruv
	VlDduSBFAD9mj86zLkLotErAQNmxiNJos4FU+rPHJWQFhb3F7qeM45YwsXeLxOx23+oxsqAi20i
	TLdh7wcyp/AIUfi9whK3gpmdcL+imw3P59mWVV8CJQgsLK6xuqRD2ZcNwVNNxUGYbb8lppW0DQ/
	Ja9YsH4Ud06BCzT+vPQsxrSbXtV0h7c8OktgCyLl3z5fMqEF3NmG9hbM+jcdtCEAcjZLdpGpUzo
	1q4qEgY0eKWKyCexnsmjI/x1QhwudI53pxX6OvIYakU3dAjy+logokEjwKyKtt2GerRtp3fbieH
	OHycvMwiuyCTUWNZdNULyA7W6BfCMj49jVTkeaJCn9UFbmZiX8DdRQXiVOEavdSu9aOu7dgXlwa
	q1TUpkL8YAN/BLI9suEoynHftw41jka00/qrd0vs10f7l18xNyGzwAd9Q==
X-Received: by 2002:a17:907:9413:b0:b7a:2ba7:197e with SMTP id a640c23a62f3a-b8edf25c528mr163107566b.29.1770390505211;
        Fri, 06 Feb 2026 07:08:25 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:4691])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacf1488sm84857466b.51.2026.02.06.07.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:08:24 -0800 (PST)
Message-ID: <3281a845-a1b8-468c-a528-b9f6003cddea@gmail.com>
Date: Fri, 6 Feb 2026 15:08:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <20260205174135.GA444713@nvidia.com>
 <dbcc2912-e1df-491d-b1e0-7812279297de@gmail.com>
 <20260205235647.GA4177530@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260205235647.GA4177530@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_070827_745675_2426B825 
X-CRM114-Status: GOOD (  29.20  )
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

On 2/5/26 23:56, Jason Gunthorpe wrote:
> On Thu, Feb 05, 2026 at 07:06:03PM +0000, Pavel Begunkov wrote:
>> On 2/5/26 17:41, Jason Gunthorpe wrote:
>>> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>>>
>>>> The proposal consists of two parts. The first is a small in-kernel
>>>> framework that allows a dma-buf to be registered against a given file
>>>> and returns an object representing a DMA mapping.
>>>
>>> What is this about and why would you need something like this?
>>>
>>> The rest makes more sense - pass a DMABUF (or even memfd) to iouring
>>> and pre-setup the DMA mapping to get dma_addr_t, then directly use
>>> dma_addr_t through the entire block stack right into the eventual
>>> driver.
>>
>> That's more or less what I tried to do in v1, but 1) people didn't like
>> the idea of passing raw dma addresses directly, and having it wrapped
>> into a black box gives more flexibility like potentially supporting
>> multi-device filesystems.
> 
> Ok.. but what does that have to do with a user space visible file?

If you're referring to registration taking a file, it's used to forward
this registration to the right driver, which knows about devices and can
create dma-buf attachment[s]. The abstraction users get is not just a
buffer but rather a buffer registered for a "subsystem" represented by
the passed file. With nvme raw bdev as the only importer in the patch set,
it's simply converges to "registered for the file", but the notion will
need to be expanded later, e.g. to accommodate filesystems.

>> 2) dma-buf folks want dynamic attachments,
>> and it makes it quite a bit more complicated when you might be asked to
>> shoot down DMA mappings at any moment, so I'm isolating all that
>> into something that can be reused.
> 
> IMHO there is probably nothing really resuable here. The logic to
> fence any usage is entirely unique to whoever is using it, and the
> locking tends to be really hard.
> 
> You should review the email threads linked to this patch and all it's
> prior versions as the expected importer behavior for pinned dmabufs is
> not well understood.

I'm not pinning it (i.e. no dma_buf_pin()), it should be a fair
dynamic implementation. In short, It adds a fence on move_notify
and signals when all requests using it are gone. New requests will
be trying to create a new mapping (and wait for fences).

> https://lore.kernel.org/all/20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com/
> 
>>>> Tushar was helping and mention he got good numbers for P2P transfers
>>>> compared to bouncing it via RAM.
>>>
>>> We can already avoid the bouncing, it seems the main improvements here
>>> are avoiding the DMA map per-io and allowing the use of P2P without
>>> also creating struct page. Meanginful wins for sure.
>>
>> Yes, and it should probably be nicer for frameworks that already
>> expose dma-bufs.
> 
> I'm not sure what this means?

I'm saying that when a user app can easily get or already has a
dma-buf fd, it should be easier to just use it instead of finding
its way to FOLL_PCI_P2PDMA. I'm actually curious, is there a way
to somehow create a MEMORY_DEVICE_PCI_P2PDMA mapping out of a random
dma-buf? From a quick glance, I only see nvme cmb and some accelerator
being registered to P2PDMA, but maybe I'm missing something.

-- 
Pavel Begunkov


