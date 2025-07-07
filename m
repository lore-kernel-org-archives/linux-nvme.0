Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AEFC8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezjQuXHd5Rf3mpNjV8Fq8zwJgH75aSXDhZDfm3b1TCM=; b=uy1srH9564T3TdovFdp06YG45S
	PWJlbmKrlrhNf0Jbyuad+5PJzoR5ue45R0BnsdjebDPrnX5eCDYot6aLflD+Vig3aJC7k1Ma/cpi+
	nEbWOGIinBWG1QYRbQ+MW5GIp3AjkXWBnadyjWEewoxzxpRgafRLoqYFnMDBIZZ0ruWxkbx1roctS
	MnaWck0o0G+NmNu0mbiYGhWDh0DseQK4hJ9OUlciEr7u8tQa3JYsUW2bEZrqHuA89ywBFUJOjeqz4
	pDYfaeQc3vR1Wf9z5TqAOgEgNEyvV94rDg4csRdoG8wHyb2xBc4pvpmLyjfn+Ziy4ANyi0cA9+YFH
	1LKXqrwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYo3s-00000002uwA-1nQ0;
	Mon, 07 Jul 2025 15:47:20 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnwk-00000002tZ5-03wH
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:39:59 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so5206802a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 07 Jul 2025 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751902796; x=1752507596; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezjQuXHd5Rf3mpNjV8Fq8zwJgH75aSXDhZDfm3b1TCM=;
        b=dOIp8uP5X6hKkTlx1DqzScde39/93htq/uaqccJvd1Nuu/oPGsBKOexF5nEiMGPJlO
         JxkHlQALEH4lfSMAmS6NLV2V6gXQAp6ChV3lCKa/1/pCA5HaohIgTMMPMDuweZ+mrX4G
         XVAIUysLLCR/qYS0DgZ2geeNdGWn2wjTB7XdKPkXH+/5EvycuF+p7i39nmhLTm24TrKk
         kXgnbjgWnVzGqa7Fz6B3u8S7p1t/AS4ZHkRiubBxg7gmfMpOaeLOdzKGTN7yf5irsJqN
         KJQTfgcLaQQS6EnZ5Tk/CEBJT0WELHHsd/SoSIqQHxJyNTDU5kuSNJDyNKC27y8e3QHd
         +RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902796; x=1752507596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezjQuXHd5Rf3mpNjV8Fq8zwJgH75aSXDhZDfm3b1TCM=;
        b=d1w8OolP2RQ//pKwecopmEhkh2eHzX7ZgmIlgyZ7dsqpKCf9qLHix2bZ5C6oC35DeD
         BVb+jHcGvbtc7q2lnH53VMmfZvH5dYjAFA/AIv30P5g/DPjAW2ElVNKd4uhXI6ktUb3j
         PQmH+7uHtdeA8YQUlQSU5DNGDVufxBqx6ns3LappCaiH+2/1Fhpmp9TanxM3kungfIxO
         jJK0vZlDkUpOwRV4GmrpJv50LsEKifms2+UYZIy8ta4fnaKxqB74zycFYcSVYwrWImH2
         HEdU6GfpQ5+5Eh1BFckQ7FML8CZxYN593OgxKswU5N90izAqOp9MRGgKnZelRI5D4H4b
         XbUA==
X-Forwarded-Encrypted: i=1; AJvYcCXXOJc4JZHhbrJ3ixu4D0yWRkdIqL/JdZ0SJXbiiVnryL2z7EhwhpvpFiSpIwX/kt4rj2veRnBx9r8e@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2inkbk34LqEC71Catv+9CjKgcvXZOaXItknBKHSG+NCDQL28N
	j3J+GQIG8fjxKRMJKhEiO50RSfNx9BczvHpSJ1R0pXdWpv13xh7fq7+F
X-Gm-Gg: ASbGnctXhZMKbJ/+vq2u+0aaWy/cbJJq0Em5nTOajtz8719WLsDY4AvJt1VlIGzeZgh
	hQ7bt3vwS54kzh+H/xtslix4WbCDkrD7XQcBdzDJMetvwnLiJFYker/8fa7wd3mmuUtnsQ1qYMH
	FGPymssg17is7gmRBnFcN/T0pAE54wuwTA3jxHdFbZ126Sm70x40mehG7Rszwzuh9pY/7WUNJUl
	ekeyv9lUH7SPWE4+b+peNUcvV0bMMZGdHXZz5XOh26HegWdzo51iN9sumJWIqxYeA+wB+aoM+Ii
	i6zQsVvJhU8JgDscD7y9RThmxXw+XDutlso00Tmm1cwSIdUIA9rClROAxfmLs93EW5BclJRSU/8
	VRnbjaU0=
X-Google-Smtp-Source: AGHT+IECUz+0dR+mX/jDHZopafgoqx5arH4cJ6TohfaPi6RZy5DB6VxRs0wsEPpg/JVzP6t3CV7CTA==
X-Received: by 2002:a17:907:c29:b0:ad5:78ca:2126 with SMTP id a640c23a62f3a-ae4109062f9mr811114166b.59.1751902795974;
        Mon, 07 Jul 2025 08:39:55 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c78efsm5939890a12.44.2025.07.07.08.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 08:39:55 -0700 (PDT)
Message-ID: <e210595b-d01f-4405-9b5d-a486ddca49ed@gmail.com>
Date: Mon, 7 Jul 2025 16:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/12] io_uring dmabuf read/write support
To: Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, David Wei <dw@davidwei.uk>,
 Vishal Verma <vishal1.verma@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1751035820.git.asml.silence@gmail.com>
 <aGaSb5rpLD9uc1IK@infradead.org>
 <f2216c30-6540-4b1a-b798-d9a3f83547b2@gmail.com>
 <aGveLlLDcsyCBKuU@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aGveLlLDcsyCBKuU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_083958_057611_3F45D51F 
X-CRM114-Status: GOOD (  18.16  )
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

On 7/7/25 15:48, Christoph Hellwig wrote:
> On Mon, Jul 07, 2025 at 12:15:54PM +0100, Pavel Begunkov wrote:
>>> to attach to / detach from a dma_buf, and then have an iter that
>>> specifies a dmabuf and offsets into.  That way the code behind the
>>> file operations can forward the attachment to all the needed
>>> devices (including more/less while it remains attached to the file)
>>> and can pick the right dma address for each device.
>>
>> By "iter that specifies a dmabuf" do you mean an opaque file-specific
>> structure allocated inside the new fop?
> 
> I mean a reference the actual dma_buf (probably indirect through the file
> * for it, but listen to the dma_buf experts for that and not me).

My expectation is that io_uring would pass struct dma_buf to the
file during registration, so that it can do a bunch of work upfront,
but iterators will carry sth already pre-attached and pre dma mapped,
probably in a file specific format hiding details for multi-device
support, and possibly bundled with the dma-buf pointer if necessary.
(All modulo move notify which I need to look into first).

>> Akin to what Keith proposed back
>> then. That sounds good and has more potential for various optimisations.
>> My concern would be growing struct iov_iter by an extra pointer:
> 
>> struct iov_iter {
>> 	union {
>> 		struct iovec *iov;
>> 		struct dma_seg *dmav;
>> 		...
>> 	};
>> 	void *dma_token;	
>> };
>>
>> But maybe that's fine. It's 40B -> 48B,
> 
> Alternatively we could the union point to a struct that has the dma buf
> pointer and a variable length array of dma_segs. Not sure if that would
> create a mess in the callers, though.

Iteration helpers adjust the pointer, so either it needs to store
the pointer directly in iter or keep the current index. It could rely
solely on offsets, but that'll be a mess with nested loops (where the
inner one would walk some kind of sg table).

>> and it'll get back to
>> 40 when / if xarray_start / ITER_XARRAY is removed.
> 
> Would it?  At least for 64-bit architectures nr_segs is the same size.

Ah yes

-- 
Pavel Begunkov


