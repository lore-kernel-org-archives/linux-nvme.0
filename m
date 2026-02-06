Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F27EE6B45
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xzBXC39VA35TGgzF7BlqtIk0rzDCuWiS//uKoFgvig=; b=HRxpn69YqZkTsWXBObEaixjeRE
	YGKlhfJMrDXru67ppaLRVUHtqde5R6neTINEpbx+IyTYxokDevTEGDa12L/a8lIQJZF8jgnYVx3eS
	xfXo/hItfqdDeORWCY3YsQmzzCi8/FmlP8qCOIuPG4v8Uf4igJi7Q+4Or3JGXlPS/tvNdkJWSfmCd
	oSphatTZ3Py6UdxXTbKKckg9A75ZNsTbMBv+nevAid8+80PQ/rstY0k1o1lSfC3O5K9WgP3yff11d
	U1A/HHsCRJPZheJdq6QUNLw8IrzB1brbjOkTVErQX27AXtKdRTDuhMkfiorCfuScqT6o3rfyMQWoh
	MilR5gyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voQ50-0000000Be3X-3BoG;
	Fri, 06 Feb 2026 17:57:18 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voQ4x-0000000Be38-1ONo
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 17:57:17 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so29376575e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Feb 2026 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770400633; x=1771005433; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xzBXC39VA35TGgzF7BlqtIk0rzDCuWiS//uKoFgvig=;
        b=HVinCXpbtQqi0SDBIdnH3G/gyeOzZh1pAjFG9iH0X4kWeW8mphO9BYXxnraeVdUUhG
         bIV8IQylotdVnhccWw3kyzkXvtoJ1+SxJPXxp+78kjlyKfl2GWQeL1LmvfPxDisAVDpw
         Qagy2p8ZBkK6L5nSeGVTolzhmxXcKms48nBBBlKtmhSnGo+YyuVhVpJfDeqXcxeFGADC
         DKp/HasGM3PR2/SULST6q4/dVbcu+7Il/gWZ78Kx/LG2+VrXyg13GLEkG0q119/MrKhr
         EK2JDe37QmJyvOF4ZhVDbRP4vGB7uX/tbZsUerkNsoECA3VH07HQvVTguswpk6HDGC1f
         Qzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770400633; x=1771005433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xzBXC39VA35TGgzF7BlqtIk0rzDCuWiS//uKoFgvig=;
        b=fjvDlMBuy46SqHm9r3V0alJHE8zPm0DJjwAGASdhphc0HFABk9Zbkw66RgtTc9J2Tm
         dSAD9zIPmpbeIcTKiy2z81JdRnqnnqP4FjCOkHS+PLo2WnpZaZEOephEnij0jTv+w7Jk
         LV6tIspK0Lk0qHcRpl4L7MylqFGgP+wdegdYYm0BNiGls1acCA0kesgEWewmzuJsnLPc
         hCXoUrvd4Tl5d47sAUbb6WEPZjHBsf3VzLid8zcX1u5Hg7uy5bE1BTZdHHeC1Jp2+0Ge
         /svscBNM9TwjlWpwnRHsP9woHDrz/xrhxHEtsDwR7EpJMmIn/tloielWbNnKhtEaXcmp
         Ko7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3LA+OCTQdJCk9XJfyh9UQxCRgd9esqQ+6aHlB7jKZHWWpxDByFAIa365uxmr2t++NrddOb5QBgeQd@lists.infradead.org
X-Gm-Message-State: AOJu0YxhpV5h1XAIGPfM/4iqSoDpmwbfM8IbNb4d8Ku5EzXyPST/lX+P
	Z50bRS4gzDZOQcLTY7+G15VdcCNm1e0qugG+3UFMD8RuIGhS7HsGfHbo
X-Gm-Gg: AZuq6aJnhapQihb7+F2s5KyXZ6cqz56oYMyflP7+Etz4nTRBepnANpGt4IOrzsmuI0w
	s27zmKULAdgom6Secp2gtbye1wa0QzuBrlH6q5DozYi86WXD+6pcco5JVjx+7NBOiOy0dbxdcqK
	+bSQ6QYoRIiJLyBJY+Uv65fzJoik4MHJV6dpeKWtxblRIm12qLgddm7ZCRvez4aqTwZwEPIkguP
	CRk+8qXI4ESeVX+ZD+R5bJPcypjED4o+6TwTcb7q2FyM7MBrHKruxK8PxTLucApghSbYZgasmxB
	0nl7M81c0FVynCO07UXsAyyBzxjj3vFNH8XcESm5cGhF/+yb794lBWpQju2hC8JEviQKPiegt/p
	QYaaoXiyhjaI+U6gnoyQyYrfNphxSUS0Y/mnifWya+aSVSEbxCbYpfvEzehDRcTem0CMPF2qbeM
	pyZ3r4jDRTtoq8SchYuFwoU5eF5O4RwbTSB4RW/ant2IvZOejhq5u9JoocqNITf1UbBxoJ39M2f
	CjlX7rR6fdP8j77ZMoDkOczhO4LK5CkHNwvchaG5XnbxOhZPn535OpvmnKNOOx5Yq7rRnWfWZTm
X-Received: by 2002:a05:600c:1f16:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-4832021fe37mr54462585e9.26.1770400633147;
        Fri, 06 Feb 2026 09:57:13 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c12d74sm38492195e9.2.2026.02.06.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 09:57:12 -0800 (PST)
Message-ID: <df7fe4d7-ca28-408e-bed3-bd1fa23e7588@gmail.com>
Date: Fri, 6 Feb 2026 17:57:14 +0000
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
 <3281a845-a1b8-468c-a528-b9f6003cddea@gmail.com>
 <20260206152041.GA1874040@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260206152041.GA1874040@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_095715_423683_44D38E21 
X-CRM114-Status: GOOD (  37.32  )
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

On 2/6/26 15:20, Jason Gunthorpe wrote:
> On Fri, Feb 06, 2026 at 03:08:25PM +0000, Pavel Begunkov wrote:
>> On 2/5/26 23:56, Jason Gunthorpe wrote:
>>> On Thu, Feb 05, 2026 at 07:06:03PM +0000, Pavel Begunkov wrote:
>>>> On 2/5/26 17:41, Jason Gunthorpe wrote:
>>>>> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>>>>>
>>>>>> The proposal consists of two parts. The first is a small in-kernel
>>>>>> framework that allows a dma-buf to be registered against a given file
>>>>>> and returns an object representing a DMA mapping.
>>>>>
>>>>> What is this about and why would you need something like this?
>>>>>
>>>>> The rest makes more sense - pass a DMABUF (or even memfd) to iouring
>>>>> and pre-setup the DMA mapping to get dma_addr_t, then directly use
>>>>> dma_addr_t through the entire block stack right into the eventual
>>>>> driver.
>>>>
>>>> That's more or less what I tried to do in v1, but 1) people didn't like
>>>> the idea of passing raw dma addresses directly, and having it wrapped
>>>> into a black box gives more flexibility like potentially supporting
>>>> multi-device filesystems.
>>>
>>> Ok.. but what does that have to do with a user space visible file?
>>
>> If you're referring to registration taking a file, it's used to forward
>> this registration to the right driver, which knows about devices and can
>> create dma-buf attachment[s]. The abstraction users get is not just a
>> buffer but rather a buffer registered for a "subsystem" represented by
>> the passed file. With nvme raw bdev as the only importer in the patch set,
>> it's simply converges to "registered for the file", but the notion will
>> need to be expanded later, e.g. to accommodate filesystems.
> 
> Sounds completely goofy to me.

Hmm... the discussion is not going to be productive, isn't it?

> A wrapper around DMABUF that lets you
> attach to DMABUFs? Huh?

I have no idea what you mean and what "attach to DMABUFs" is.
dma-buf is passed to the driver, which attaches it (as in
calls dma_buf_dynamic_attach()).

> I feel like io uring should be dealing with this internally somehow not
> creating more and more uapi..

uapi changes are already minimal and outside of the IO path.

> The longer term goal has been to get page * out of the io stack and
> start using phys_addr_t, if we could pass the DMABUF's MMIO as a

Except that I already tried passing device mapped addresses directly,
and it was rejected because it won't be able to handle more complicated
cases like multi-device filesystems and probably for other reasons.
Or would it be mapping it for each IO?

> phys_addr_t around the IO stack then we only need to close the gap of
> getting the p2p provider into the final DMA mapping.
> 
> Alot of this has improved in the past few cycles where the main issue
> now is the carrying the provider and phys_addr_t through the io to the
> nvme driver. vs when you started this and even that fundamental
> infrastructure was missing.
> 
>>>>>> Tushar was helping and mention he got good numbers for P2P transfers
>>>>>> compared to bouncing it via RAM.
>>>>>
>>>>> We can already avoid the bouncing, it seems the main improvements here
>>>>> are avoiding the DMA map per-io and allowing the use of P2P without
>>>>> also creating struct page. Meanginful wins for sure.
>>>>
>>>> Yes, and it should probably be nicer for frameworks that already
>>>> expose dma-bufs.
>>>
>>> I'm not sure what this means?
>>
>> I'm saying that when a user app can easily get or already has a
>> dma-buf fd, it should be easier to just use it instead of finding
>> its way to FOLL_PCI_P2PDMA.
> 
> But that all exists already and this proposal does nothing to improve
> it..

dma-buf already exists as well, and I'm ashamed to admit,
but I don't know how a user program can read into / write from
memory provided by dma-buf.

>> I'm actually curious, is there a way to somehow create a
>> MEMORY_DEVICE_PCI_P2PDMA mapping out of a random dma-buf?
> 
> No. The driver owning the P2P MMIO has to do this during its probe and
> then it has to provide a VMA with normal pages so GUP works. This is
> usally not hard on the exporting driver side.
> 
> It costs some memory but then everything works naturally in the IO
> stack.
> 
> Your project is interesting and would be a nice improvement, but I
> also don't entirely understand why you are bothering when the P2PDMA
> solution is already fully there ready to go... Is something preventing
> you from creating the P2PDMA pages for your exporting driver?

I'm not doing it for any particular driver but rather trying
to reuse what's already there, i.e. a good coverage of existing
dma-buf exporters, and infrastructure dma-buf provides, e.g.
move_notify. And trying to do that efficiently, avoiding GUP
(what io_uring can already do for normal memory), keeping long
term mappings (modulo move_notify), and so. That includes
optimising the cost of system memory rw with iommu.

-- 
Pavel Begunkov


