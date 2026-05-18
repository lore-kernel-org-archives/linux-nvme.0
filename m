Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3666ACD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 09:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZnntFD93TY8/+xleaPVExk6NAT6He9j34KXY+n97WI=; b=w6SeJ1E2QPlENGn4Kr+mkWEfBF
	tLgwKP5Ppzp65jwS3Arafho1t1ixCt+x4iWdTF1h2PbWWWqR8ZE6iOvHfq1t1GxIkghhDRID57mFx
	S3UQwFnETSPA59yZK10hrIEsdLmQ83EykyJHm/j1HCzS8ptwDPPLnOJNRwr//Rk8y3XrBZOVl26Ud
	dWlm1r7134V0EQcPxiIlc5qEc8JhMfb3rDgGwGZbwmAXaZ+ESetiOUB4zX2G7/Q08apHdTDVSwnJH
	ijWnuwF2ghqdJlEcE7kH1kAE5UXOTDQJZHQ7E7SyM9YJCBS5ydZXsWM+SoDFef2Ma9NuCtdfn2U70
	zUhqH3oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuDR-0000000F0Em-0ZvX;
	Mon, 18 May 2026 09:24:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuDO-0000000F0EJ-2XoM
	for linux-nvme@bombadil.infradead.org;
	Mon, 18 May 2026 09:24:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8ZnntFD93TY8/+xleaPVExk6NAT6He9j34KXY+n97WI=; b=PjW46O4gkYFSwd7JB+WbH+Y/39
	6AoX7ADtOUAHcjfp4A8Q86SFKjzTtOmpuD/j0ShMqqfoQ8bZWg8eBM0UsX4JgRNDNy0fJuEGGrWns
	m4PGDbOlE7Yql5kG4Lsk4BjLPQwWPn54UjRRn6U9jGXJ8drsdu22LhPR8OyRwdSGX/Q6kBMBBVHTI
	to7LuzyXuvCaob0ecSJ+YhAppLG8kpWNBKCzJ+md1BmVcW5zXDCw8sLZbNiexIxGxJ2N+j4zGQBha
	c68xNWcqtCQTdhvydkw5aBHuoa45Cg3HfaxCLjlngkSREIcQ8vyYGumdyNytaQh7Kj+dgUOuI1s4u
	Zcj9g29g==;
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuDL-0000000AZ2A-0PXv
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 09:24:45 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso996411f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779096281; x=1779701081; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZnntFD93TY8/+xleaPVExk6NAT6He9j34KXY+n97WI=;
        b=ZCQuIhRQKC9GBOhVW937xZac2j/u6HM1W8WyPnw+DY5guNPWgmWnwIPr/3+XP34XwG
         aT1KqC7/pHp+Rb0DE6rZ4Ok403Awzu+BCEgmuoZVhtKLGCUYPQqTxJdXG7cq0mmeNLTq
         WY9eAqPaM+DFBf9myAJA7u27dzMeavfzpOJIHHK6Ln+CHc9auGUoF3EwXmVfMLGnv8H5
         Umx7fJpZ+qnCiS1sKV3q5qZZlIoX3ratTrvOCjLwalcOgi5zcRPDe5IH6KWFjgwSCuh7
         5suLkbBpTX+j8m6+qSsx27Ogeq036EolDaXIrJdaQbMqwz0gMIrufkM4ky78z2xsYZsu
         WUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096281; x=1779701081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZnntFD93TY8/+xleaPVExk6NAT6He9j34KXY+n97WI=;
        b=kooJfKzwIys7f9OWco1lQDiJwz2NDmqVsiO4wXZqRTYGtzcMJAFTMDefs5KDHz1MNa
         SCfhhIGcsV4TVFo5SWoRSL5UDMgLmUotLXb3ZRGtuUvATvPJ02BuCKAKmLKXaXvxLhJ+
         O9RSiqUzpW5rFGqE6JBjYkA1D6q8vlh4qDdpMyJTVtSZzsRnpfXm96hrj0S/egHcB9M9
         IP1FaASEjvz+Q6AzEeC4fwc5t50ihGvqPp434W8SsLJf0nt1lpBIm6dR0Xp/xz0XUfOM
         SK+dZcCbJf9gz1S1OfnkeKL0l5cGHvvdjDmwqJTzGtpGebdwG5X1fJXSWkTgHt4vA2VX
         EDZA==
X-Forwarded-Encrypted: i=1; AFNElJ+gSreogw8Fs8ECSDpKeZh/xauW3obYIMCFNi9ay3UpZCe1kf2wyv9Grg/pTm2d2VlFiGsv/Yx9GQ0y@lists.infradead.org
X-Gm-Message-State: AOJu0YyUIACg/+ExwVkNDHc0SEImZ/B3GdbMDkQgxS1kKlBlgwDe+g4x
	XO1Z8QhhofdoWk4oF48X0SKe7N9QtbnD8FCbtQY2GIRT9+o3IEHTRVyT
X-Gm-Gg: Acq92OFpi7/ML6gsKbMWa2hOPpNglPLlH9jFdW51Nnt2OxDv9S8EpTy4OefSy16xZqd
	qrk1iHg6l7Kenl99b7s7UgDJbNY5IM+iJ1OHd9S/R9z7VCbZYMY1uEDBhzWgM8LsuVBilZzKjox
	kglOHzr9bYerT7NyWzR99Xebk9HwXKarWAIPgDpKVavj9jfaPOHX3eTX+c40lBr2rkrwu3Szfww
	AdS4NVL4ya9KsMnYFWZDDpyrzhJc/gNx858HkfmcpYXvD5oCN1uZbYkAYLSuTkL9R3V4G8PGm3L
	7PUMSyLFNgSEHA7yNeA5RKjheGZCGprJp+C1mhOcdVGpAT9KdcYL4ygzMxHGj6hlUh7BVlOQkM2
	7Kcx4B1NkumfISuZMflA/CCtpLnM3sv3oXYvhOvtVknpOtu3H+N3Jlx7Diy4Wk8FI1pWn46BT8I
	zHeQU8Q09IwfuzAzvgRevfjx80A9vn/g68jPj/spE/Fh8tVjkBNyM8535sQpGm6vXRXhcz9KHcG
	bobVPJjmQfqLwlyUVqmd82uUYKPsgZt3SQADjm9Itk1sObPlCOLJvZputE=
X-Received: by 2002:a05:6000:288c:b0:43b:962b:5314 with SMTP id ffacd0b85a97d-45e5c372a9cmr22814328f8f.19.1779096280750;
        Mon, 18 May 2026 02:24:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm17325957f8f.27.2026.05.18.02.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:24:40 -0700 (PDT)
Message-ID: <4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
Date: Mon, 18 May 2026 10:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
To: David Laight <david.laight.linux@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
 <20260513110557.705bdeed@pumpkin> <20260513142909.03ae6c2b@pumpkin>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513142909.03ae6c2b@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_102443_762172_F94CE7BF 
X-CRM114-Status: GOOD (  13.93  )
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

On 5/13/26 14:29, David Laight wrote:
> On Wed, 13 May 2026 11:05:57 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> ...
>>> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>>>   {
>>>   	if (unlikely(i->count < size))
>>>   		size = i->count;
>>> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
>>> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
>>> +	    unlikely(iov_iter_is_dmabuf_map(i))) {
>>
>>
>> Doesn't the extra check add more code to all the non-ubuf cases?
>> This could be fixed by either making iter_type a bitmask (with one bit set)

Not going to do that. It was specifically converted from bitmask
before, and the check optimisations like this were voiced back than.

>> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
>> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'
> 
> This seems to DTRT:
> 
> #define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
>      ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
>          (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
>          (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
> #define ITER_IS_ONE_OF(iter, t, ...) \
>      _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)

We definitely don't want that, using them directly would've been
much cleaner.

if (get_type_mask(i) & (TYPE1 | TYPE2)) ...

-- 
Pavel Begunkov


