Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75357CD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=; b=gOnkQC+S6qaIETEf0VJFLKA83c
	9hGms206XSSyRtVef7MQkMrt8QeEF75oaSUwG5YCuGM9cjccoyMMqCr+UXpSBDU2d7UXQjYRKdZns
	TTwtivTnwgxFmUrZBdJyTlAv7eAshJEW/33bPY2mZXrME/fB6OM4uBklbOks4JgE3QsBho42gsISA
	z7tiplxUho39CVONKmvTqO8ZEvFL7m4qm5kQlfXqbaPlmZOb/AFOFUasSlrzktwlqDgVi8kJdVzT0
	2Fgbj6yEPdAqwVcXs28cDTiKtS3K1YBR1VcGo+aFtiLuzeqUp1KcJ0cBp4eMqcldCRGrTWVibC0Mr
	VaqTyxBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxGl-0000000FfeL-0oDV;
	Mon, 18 May 2026 12:40:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxGj-0000000Ffdk-27qs
	for linux-nvme@bombadil.infradead.org;
	Mon, 18 May 2026 12:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=; b=ajNLhkPhZEpouiidHtwHYoxiEI
	B7q7wPdtkf8NCyocJtZpV7ZAJB9hAjvu5lI1xPPzCu6wbMJouVHVe0oPB1+EHDpTqC8ogGzsIOEiv
	noxBp9WqusufGpRZe5clr9qYT0jgaQVQvnbMs0Oa2LFi6CU/ZfxHtdmddh2GN1/FnvbZhHBy4FyX9
	LRGFkd4P+zVC9wNDoOmD6W1AkVQ5J6eno1aL1DoSLUtCuKtUCElXHx/WxCKyMfY73vCwdV30fcMBP
	iUw/byUuQCGc5SisEzhbBZjE6NbdpvnqWwIQoZh1K3qbe8v+4TyKz6A6P2EOJFA8zH4kMoM+ApSPy
	aCV/CvkA==;
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxGg-0000000BAT9-0OU8
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 12:40:24 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso16779425e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108021; x=1779712821; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
        b=PGZG460yMP0KlkymA2FTY8Os3Dmahl/3d3WpgQjfBM9h3T7AmZf3keJswcWQwNV4T9
         3rZeV9CW0GHdBxtfnR56RHbK8ZU+m34LH4iym7LyXvL6xbTRG4qlckk3aD8abAlIUHEm
         LGkldFAuxBcghDlMr5DBkJ1mFzOkxDEmG8rGnrSaS4rAWQ0o+Wp5RsdgMlGqLWLmesYd
         6vHK8fdNVPcKROSKDxwbMDphWXLee5ALQdjSDHe4xcQQ86rWSQQydJiEd1Dgay/F5if9
         WrtCNuBxyQjE3pcb4v1xDQnKbXUYQrXjbbLNk3ArsL+Sg/XV2jjV1p67uKSsg6OmAfdc
         mQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108021; x=1779712821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXVLM8myHSCmhmEigozDJCG9BugvlW9svyQsziHjoMk=;
        b=Hx8hL5fTzrATv7+MOaP0LWCIuic4sf0x03JwY1mSXc5UCnsmWIo5hEuuvaVCxu/7vR
         17ORrKXsqfgSODMhD1xqcgzuDiPjkzDQuFQxjYO8FKgpNct/b6BQelheMf6dNz2lBJI8
         U/T1ieEPnenglzh1pKCXBlZCtJFUqLCc55mb2aKt4ocEL3O29b08N5UMWSkimtVn0tal
         RguX7m9m18a1ujIWAOfKMtuUhdOZQpt1PB1FT5UFI2GLcHuA4yZYNKR/DGyJjBAeCSm6
         AlcciyM0xLcB0NJSSJIeq8v6muJ6xXgrEaQmCKHdNkbNGEtkNZvb4Vhu4R17qqIgROBM
         qYNA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ow3QOuZYVahL5N1ZXt2qmOOdCl46XWgea/FxZuSvE4efdh7Qv0p0g5ltuitzYdPD4VdzhPeyk760b@lists.infradead.org
X-Gm-Message-State: AOJu0YzSJ4r3+2Aiwmisf6lWxYpiunHVqvWfd0FYon/BHpIn7w4CAtv2
	ydxZEqgnUb7nWMLdpD2BTKVdld31Ztx7Oy6aIttR9RtAoMRbIiMQ6EV6
X-Gm-Gg: Acq92OGFWV+txP22iZ1/fbvR2QWIUKwrVDnYtgMJPrVQ2wSMTNJfgdSucDOIedCiyYA
	h9PZaT6wvOkZqobEgL6TmdWQ+qBawT3sVvheBso8DKKeoqXGOPX/CSKjX9O4v7Khv6pdq/Va8VR
	UgiNwovCHPSUFTOATubGroR+WHwPWEAeIRB0S6JlQaXhXlei1vfzAsDUjRbbxvyEX1pAsiBxBee
	NBzJwteDcKkKorGUdv4np0fJLIryxnzEg7/Gg6cWxm2t1ujERNot2/fC202Qn7HqdrPejKfRR7W
	tpBn5YmebP46EoJshyOUZd3hUaRHS3lv80/ybQXV9CawqlE+iXOwtgSQcqQYfQtWN1Cj4q580NI
	w/tQeXipGB3SxqYe9eelk4m6+2N9sbaH/X1qD3qU62lJ/ApaPmp03aKsUFGXAZACAKbcOTmB/nF
	IzG3vC7R5i56GCLUdCkyBt+zh4TNVAAtNOKUIBBiEheJdrBuyuNJAQ5OtPcS7xgqWe1BV/HyHbi
	MMQsoh0Egg23nTrv6ypDEn6mHzdNjgCt10oOR+hb2eisRjb/vrlKYa+7q4lrxYSQdeC7CNE5fQq
	baH01Q5QLZoy
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48fe62f8861mr237008575e9.23.1779108020601;
        Mon, 18 May 2026 05:40:20 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm256597555e9.7.2026.05.18.05.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:40:20 -0700 (PDT)
Message-ID: <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
Date: Mon, 18 May 2026 13:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_134022_875939_A043B438 
X-CRM114-Status: GOOD (  16.94  )
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

On 5/18/26 13:22, Christian König wrote:
> On 5/18/26 12:29, Pavel Begunkov wrote:
>> On 5/13/26 09:19, Christoph Hellwig wrote:
>>>> +    if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>>> +        bio->bi_io_vec = bio_src->bi_io_vec;
>>>> +    } else {
>>>> +        bio->dmabuf_map = bio_src->dmabuf_map;
>>>> +        bio_set_flag(bio, BIO_DMABUF_MAP);
>>>> +    }
>>>
>>> This is backwards, please avoid pointless negations:
>>
>> I can flip it, but compilers tend to prefer the true branch. E.g. this
>>
>> if (cond) A; else B;
>> C;
>>
>> can get compiled into:
>>
>> jmpcc cond B
>> A: ...
>> C:
>> return;
>> B: ...
>> jmp C;
> 
> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.

That might be more penalising than placing them in the right order,
and it might be fine as it's new and all that, but it's not a clear
cut as it's definitely not created to be a slow path. TBH, not sure
why we're bike shedding such things, is it somewhere in the code
style?
> What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.
What kind of comment are you thinking about? A "this is not a likely
path" type of comment before each mention of the flag is usually not
very useful.

-- 
Pavel Begunkov


