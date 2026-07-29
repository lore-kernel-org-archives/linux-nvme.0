Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C61FC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=; b=yhGLBMyWzgpbQCCBmw9XxXLNqE
	aVYZT7rUMW7FWPQELG7A6cfkNNlmKBhwcuF5/ZXT63tLERyIOgPMK+4kGxZOZg+jBokOWZIDVjiNF
	M1Pzfq4iEMqSN4zUkN8qa82Q/jzZ0dN1ByQ/H03S8VGx1tTZ/fL+knIcZC/Xlv+7CtgPOQBcQ/YO1
	yg3mCNa7SjyGJ7pLM7hSad5pbB/BBUEbJH6YP8g+GRD3pyfre/sci5ZjYnpaHO65oSmRTu+K2N923
	2kKmDWk80e+MT9RelS/VOyWOaLDNYbKV+c6ZHJv0xKH60BRnbC1OHUB49xrmzJMOtHuSDKpnB9zAG
	GiIDA+Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2tR-00000007nk1-02k5;
	Wed, 29 Jul 2026 11:56:13 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2jh-00000007m4z-43y9
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:46:11 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-495590dde14so8779575e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325568; x=1785930368; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
        b=YEc5qh4NBCsmp9jXKruB1Mdxevjp0fT80cFyKWf9H6m6I6MQHe/ltVNS1dE93agGSZ
         Tv6pFTe1oGFhR5EbMPue1jFXeqesVbHFnPesQUzginnyUwvN9pYV6FwXcAT7nOC7x2JC
         LWus6LRi869UhBn5stFbqJObX4d7ArLXkvjgVtehjtgM256jSXfSgYEd3fPO/RXGWADw
         osynnFZbkGf8rzIzdaCYlXpQj8QmqM7ZAdUMDBAtWRtmRvm6FjYzHb/ClfcP8T3qT/2B
         2a3f+0OkSUknednEStV+gFQSJOWdegDBOGqSU1R64hHdosQaMdQ7LtuvWSxzAf7xVo0L
         xAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325568; x=1785930368;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
        b=qX9vVxNfQdSZpwd5q9eh37Fs8Ul5jOVlm8xY1aQEaI9Z1ArZUmsRBpRT9+9F8FjbiQ
         UB3AxoBpU2F6W7YbLRs9JRR8KRfT7AYeWsUonqxVneSgQ/YJC6Fq4FVBk6LmfVJYiusS
         IbZlt4KJft6/dDan/YEXDxI3pqbxdmQe+JOmgFNzfxmCUqIb6ipXGsYYwD5JgLNPqgdU
         EloS9uOX9VQzEujYCFyM7evR7bZUR5pbHCBMYKqg6ulv39oHzV27MLRMaqoNCQ3rPO/U
         IivJ1fcH83wmGpe1aWe2opotsS9e5IZ/rURlpkhKqJegC+2a7xvK8yH6zkFO+A4ePnI9
         0m0A==
X-Forwarded-Encrypted: i=1; AHgh+RrsZnBeN/APFarOt+16wbQWU/sEJda3ZfKxmA45qIOh5+AJNsNPLBj05zOHT10faW0ypgHwZX2WU4mE@lists.infradead.org
X-Gm-Message-State: AOJu0YzCy1nvMGn892DJQDbaxsAwZGbwInnb2HqC9Mmkyvo4jvE4WyEk
	lKLi52WTXdeL4VoJqjP9bQtY5/nRFSnST9NvnAy+MHoSkhRQssy4GCcp
X-Gm-Gg: AR+sD11Upkxb1fDp5pzc+o5cl5biWpTbzwhMROLOwJ55Y354iGZR2HvI08j2VpvSyLD
	ukQQBKoGcF3x5bkLknJQubhsiMYxSKpLw20iWTOlE6uu9gJKPwJ+IVyuwZzFlGFCXjinIoaL1xQ
	iAALsl8EVeq+vNE/92cOJuZ6flgt5oOf//XhAX6rbbRIMbS6C/N5KVradI7eTE+IpbEwqCwyupi
	MYDR8mYKkSQCk8v3oXDJHBesCCKrmoZ5D8JfhOCRxQ0eMEN+D4RsXrYYitN+MX1MOCIjKAjihhH
	sB7FOAWR+UGBxPaNaR8nFnVM56ffQWPCXZje/y4t4CzuV9uf29KT1/G0Qm4Ki3LkwwknZbMeXlc
	BWerDu7zQXGRZRf8F/MWVGhkySdBZPCfY49wXmoV3OYAKGLriMxod2mLVOec/9+zOi/HpfVe9z9
	dc5fuXxfVvhZlz9RXfJic061UMBztNGoM271Q025q5BCUuJVUGkAwk2BjMhYJhWvcaqGW913zfN
	p/1+hLhTttyZtL5PTnfeiEbexDgoPcYhQhNrnLOBGOpP9MQYpEknqxr41KjN8JAldrCAAvM9aRb
	l7Jr7PaZTpdPYFKvNUL6mDXdUi99zg==
X-Received: by 2002:a05:600c:470d:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-496c6431d1fmr69913135e9.14.1785325567969;
        Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-497fecfccc7sm26554895e9.12.2026.07.29.04.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Message-ID: <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
Date: Wed, 29 Jul 2026 12:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>,
 Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, cpgs@samsung.com
References: <cover.1785274111.git.asml.silence@gmail.com>
 <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
 <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com>
 <20260729072117.GI9534@lst.de>
 <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
 <20260729113108.GA31120@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729113108.GA31120@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_044610_027417_B6DAEBFE 
X-CRM114-Status: GOOD (  20.59  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:56:12 -0700
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

On 7/29/26 12:31, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 03:47:23PM +0530, Anuj Gupta/Anuj Gupta wrote:
>>> But I also don't understand what the use case for this function
>>> is to start with.  struct sg_table tells us how many segments
>>> exist on the DMA side in the nents member, which should be just
>>> fine for the SGL threshold calculation.
>>
>> sg_table->nents covers the entire exported buffer (<=1GiB), while a
>> request only covers a subrange[bi_offset, bi_offset+payload). Using
>> nents would overcount the request's segments.
> 
> Urgg, yes.
> 
>>>> +	if (!entries)
>>>> +		return BLK_STS_IOERR;
>>>> +	if (entries > NVME_MAX_SEGS)
>>>> +		return BLK_STS_AGAIN;
>>>
>>> Given that the block layer enforced data in rw/command and the
>>> max_segments limit, why do we need the extra check here?
>>
>> A dmabuf bio reports nsegs=1 (bio_split_io_at) to the block layer, so
>> max_segments isn't enforced against the SG entries actually spanned by
>> the request. Hence the explicit check.
> 
> We'll need to expose the actual nsegs to the block layer and split
> based on that.  Otherwise I/O might work or fail based on the device
> capabilities.

It was exposed in early version as I was passing a [{dma,len}, ...]
array, but we moved from that. Maybe I should put the minimum
segment size in the map structure, and (possibly over) split using
that for now? Keith had this chunk in his patches:

+		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
+
+		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
+								PAGE_SHIFT;
+		if (bio->bi_iter.bi_size > max_bytes) {
+			bytes = max_bytes;
+			nsegs = (bytes + offset) >> PAGE_SHIFT;
+		} else if (nsegs > lim->max_segments) {
+			nsegs = lim->max_segments;
+			bytes = PAGE_SIZE * nsegs - offset;
+		} else {
+			*segs = nsegs;
+			return NULL;
+		}

-- 
Pavel Begunkov


